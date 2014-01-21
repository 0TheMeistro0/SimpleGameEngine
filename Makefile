TARGET=sge
OBJS= Color.o \
	Content.o \
	Game.o \
	Rectangle.o \
	Texture2D.o \
	Timer.o \
	Vector2.o \
	Vector3.o \
	Window.o

BUILD=build
CXXFLAGS= -std=c++11
HEADERS=$(shell find . -not -path "./$(BUILD)/*" -name '*.h')

all:
	mkdir -p $(BUILD)
	$(MAKE) $(TARGET)

dist: all
	rm -f $(patsubst %, $(BUILD)/%, $(OBJS))
	mkdir -p $(BUILD)/include
	$(MAKE) headers


$(TARGET): $(patsubst %, $(BUILD)/%, $(OBJS))
	$(AR) rvs $(BUILD)/lib$@.a $^

$(BUILD)/%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

headers: $(patsubst %, $(BUILD)/include/%, $(HEADERS))

$(BUILD)/include/%.h: %.h
	cp $< $@


clean:
	rm -rf $(BUILD) $(OBJS) 
