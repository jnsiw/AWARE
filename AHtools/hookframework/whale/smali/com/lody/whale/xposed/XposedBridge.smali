.class public final Lcom/lody/whale/xposed/XposedBridge;
.super Ljava/lang/Object;
.source "XposedBridge.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;,
        Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;
    }
.end annotation


# static fields
.field public static final BOOTCLASSLOADER:Ljava/lang/ClassLoader;

.field private static final EMPTY_ARRAY:[Ljava/lang/Object;

.field public static final TAG:Ljava/lang/String; = "Whale-Buildin-Xposed"

.field static disableHooks:Z

.field private static final sHookedMethodCallbacks:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/reflect/Member;",
            "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 33
    invoke-static {}, Ljava/lang/ClassLoader;->getSystemClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    sput-object v0, Lcom/lody/whale/xposed/XposedBridge;->BOOTCLASSLOADER:Ljava/lang/ClassLoader;

    .line 37
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lody/whale/xposed/XposedBridge;->disableHooks:Z

    .line 39
    new-array v0, v0, [Ljava/lang/Object;

    sput-object v0, Lcom/lody/whale/xposed/XposedBridge;->EMPTY_ARRAY:[Ljava/lang/Object;

    .line 42
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()[Ljava/lang/Object;
    .locals 1

    .line 25
    sget-object v0, Lcom/lody/whale/xposed/XposedBridge;->EMPTY_ARRAY:[Ljava/lang/Object;

    return-object v0
.end method

.method public static handleHookedMethod(Ljava/lang/reflect/Member;JLjava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9
    .param p0, "method"    # Ljava/lang/reflect/Member;
    .param p1, "slot"    # J
    .param p3, "additionalInfoObj"    # Ljava/lang/Object;
    .param p4, "thisObject"    # Ljava/lang/Object;
    .param p5, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 189
    move-object v0, p3

    check-cast v0, Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;

    .line 191
    .local v0, "additionalInfo":Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;
    sget-boolean v1, Lcom/lody/whale/xposed/XposedBridge;->disableHooks:Z

    if-eqz v1, :cond_0

    .line 193
    :try_start_0
    invoke-static {p1, p2, p4, p5}, Lcom/lody/whale/xposed/XposedBridge;->invokeOriginalMethod(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 194
    :catch_0
    move-exception v1

    .line 195
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v2

    throw v2

    .line 199
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    iget-object v1, v0, Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;->callbacks:Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;

    invoke-virtual {v1}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->getSnapshot()[Ljava/lang/Object;

    move-result-object v1

    .line 200
    .local v1, "callbacksSnapshot":[Ljava/lang/Object;
    array-length v2, v1

    .line 201
    .local v2, "callbacksLength":I
    if-nez v2, :cond_1

    .line 203
    :try_start_1
    invoke-static {p1, p2, p4, p5}, Lcom/lody/whale/xposed/XposedBridge;->invokeOriginalMethod(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v3

    .line 204
    :catch_1
    move-exception v3

    .line 205
    .local v3, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v3}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v4

    throw v4

    .line 209
    .end local v3    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_1
    new-instance v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;

    invoke-direct {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;-><init>()V

    .line 210
    .local v3, "param":Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    iput-object p0, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    .line 211
    iput-object p4, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 212
    iput-object p5, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    .line 215
    const/4 v4, 0x0

    .line 218
    .local v4, "beforeIdx":I
    :goto_0
    :try_start_2
    aget-object v5, v1, v4

    check-cast v5, Lcom/lody/whale/xposed/XC_MethodHook;

    invoke-virtual {v5, v3}, Lcom/lody/whale/xposed/XC_MethodHook;->beforeHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    .line 226
    nop

    .line 228
    iget-boolean v5, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->returnEarly:Z

    if-eqz v5, :cond_2

    .line 230
    add-int/lit8 v4, v4, 0x1

    .line 231
    move v5, v4

    goto :goto_1

    .line 219
    :catch_2
    move-exception v5

    .line 220
    .local v5, "t":Ljava/lang/Throwable;
    invoke-static {v5}, Lcom/lody/whale/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 223
    const/4 v6, 0x0

    invoke-virtual {v3, v6}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 224
    const/4 v6, 0x0

    iput-boolean v6, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->returnEarly:Z

    .line 225
    nop

    .line 233
    .end local v5    # "t":Ljava/lang/Throwable;
    :cond_2
    add-int/lit8 v4, v4, 0x1

    if-lt v4, v2, :cond_7

    move v5, v4

    .line 236
    .end local v4    # "beforeIdx":I
    .local v5, "beforeIdx":I
    :goto_1
    iget-boolean v4, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->returnEarly:Z

    if-nez v4, :cond_3

    .line 238
    :try_start_3
    iget-object v4, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    iget-object v6, v3, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    invoke-static {p1, p2, v4, v6}, Lcom/lody/whale/xposed/XposedBridge;->invokeOriginalMethod(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_3 .. :try_end_3} :catch_3

    .line 242
    goto :goto_2

    .line 240
    :catch_3
    move-exception v4

    .line 241
    .local v4, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v4}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object v6

    invoke-virtual {v3, v6}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->setThrowable(Ljava/lang/Throwable;)V

    .line 246
    .end local v4    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_3
    :goto_2
    add-int/lit8 v4, v5, -0x1

    .line 248
    .local v4, "afterIdx":I
    :cond_4
    invoke-virtual {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v6

    .line 249
    .local v6, "lastResult":Ljava/lang/Object;
    invoke-virtual {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->getThrowable()Ljava/lang/Throwable;

    move-result-object v7

    .line 252
    .local v7, "lastThrowable":Ljava/lang/Throwable;
    :try_start_4
    aget-object v8, v1, v4

    check-cast v8, Lcom/lody/whale/xposed/XC_MethodHook;

    invoke-virtual {v8, v3}, Lcom/lody/whale/xposed/XC_MethodHook;->afterHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    .line 261
    goto :goto_3

    .line 253
    :catch_4
    move-exception v8

    .line 254
    .local v8, "t":Ljava/lang/Throwable;
    invoke-static {v8}, Lcom/lody/whale/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 257
    if-nez v7, :cond_5

    .line 258
    invoke-virtual {v3, v6}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    goto :goto_3

    .line 260
    :cond_5
    invoke-virtual {v3, v7}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->setThrowable(Ljava/lang/Throwable;)V

    .line 262
    .end local v6    # "lastResult":Ljava/lang/Object;
    .end local v7    # "lastThrowable":Ljava/lang/Throwable;
    .end local v8    # "t":Ljava/lang/Throwable;
    :goto_3
    add-int/lit8 v4, v4, -0x1

    if-gez v4, :cond_4

    .line 265
    invoke-virtual {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v6

    if-nez v6, :cond_6

    .line 268
    invoke-virtual {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v6

    return-object v6

    .line 266
    :cond_6
    invoke-virtual {v3}, Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;->getThrowable()Ljava/lang/Throwable;

    move-result-object v6

    throw v6

    .line 233
    .end local v5    # "beforeIdx":I
    .local v4, "beforeIdx":I
    :cond_7
    goto :goto_0
.end method

.method public static hookAllConstructors(Ljava/lang/Class;Lcom/lody/whale/xposed/XC_MethodHook;)Ljava/util/HashSet;
    .locals 6
    .param p1, "callback"    # Lcom/lody/whale/xposed/XC_MethodHook;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ")",
            "Ljava/util/HashSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook$Unhook;",
            ">;"
        }
    .end annotation

    .line 178
    .local p0, "hookClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 179
    .local v0, "unhooks":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/lody/whale/xposed/XC_MethodHook$Unhook;>;"
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredConstructors()[Ljava/lang/reflect/Constructor;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-object v4, v1, v3

    .line 180
    .local v4, "constructor":Ljava/lang/reflect/Member;
    invoke-static {v4, p1}, Lcom/lody/whale/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)Lcom/lody/whale/xposed/XC_MethodHook$Unhook;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 179
    .end local v4    # "constructor":Ljava/lang/reflect/Member;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 181
    :cond_0
    return-object v0
.end method

.method public static hookAllMethods(Ljava/lang/Class;Lcom/lody/whale/xposed/XC_MethodHook;)Ljava/util/HashSet;
    .locals 6
    .param p1, "callback"    # Lcom/lody/whale/xposed/XC_MethodHook;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ")",
            "Ljava/util/HashSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook$Unhook;",
            ">;"
        }
    .end annotation

    .line 141
    .local p0, "hookClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 142
    .local v0, "unhooks":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/lody/whale/xposed/XC_MethodHook$Unhook;>;"
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-object v4, v1, v3

    .line 143
    .local v4, "method":Ljava/lang/reflect/Member;
    invoke-static {v4, p1}, Lcom/lody/whale/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)Lcom/lody/whale/xposed/XC_MethodHook$Unhook;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 142
    .end local v4    # "method":Ljava/lang/reflect/Member;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 144
    :cond_0
    return-object v0
.end method

.method public static hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lcom/lody/whale/xposed/XC_MethodHook;)Ljava/util/HashSet;
    .locals 6
    .param p1, "methodName"    # Ljava/lang/String;
    .param p2, "callback"    # Lcom/lody/whale/xposed/XC_MethodHook;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "Lcom/lody/whale/xposed/XC_MethodHook;",
            ")",
            "Ljava/util/HashSet<",
            "Lcom/lody/whale/xposed/XC_MethodHook$Unhook;",
            ">;"
        }
    .end annotation

    .line 161
    .local p0, "hookClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 162
    .local v0, "unhooks":Ljava/util/HashSet;, "Ljava/util/HashSet<Lcom/lody/whale/xposed/XC_MethodHook$Unhook;>;"
    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v1

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-object v4, v1, v3

    .line 163
    .local v4, "method":Ljava/lang/reflect/Member;
    invoke-interface {v4}, Ljava/lang/reflect/Member;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 164
    invoke-static {v4, p2}, Lcom/lody/whale/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)Lcom/lody/whale/xposed/XC_MethodHook$Unhook;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    .line 162
    .end local v4    # "method":Ljava/lang/reflect/Member;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 165
    :cond_1
    return-object v0
.end method

.method public static hookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)Lcom/lody/whale/xposed/XC_MethodHook$Unhook;
    .locals 8
    .param p0, "hookMethod"    # Ljava/lang/reflect/Member;
    .param p1, "callback"    # Lcom/lody/whale/xposed/XC_MethodHook;

    .line 78
    instance-of v0, p0, Ljava/lang/reflect/Method;

    if-nez v0, :cond_1

    instance-of v0, p0, Ljava/lang/reflect/Constructor;

    if-eqz v0, :cond_0

    goto :goto_0

    .line 79
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Only methods and constructors can be hooked: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 80
    :cond_1
    :goto_0
    invoke-interface {p0}, Ljava/lang/reflect/Member;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->isInterface()Z

    move-result v0

    if-nez v0, :cond_6

    .line 82
    invoke-interface {p0}, Ljava/lang/reflect/Member;->getModifiers()I

    move-result v0

    invoke-static {v0}, Ljava/lang/reflect/Modifier;->isAbstract(I)Z

    move-result v0

    if-nez v0, :cond_5

    .line 86
    const/4 v0, 0x0

    .line 88
    .local v0, "newMethod":Z
    sget-object v1, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    monitor-enter v1

    .line 89
    :try_start_0
    sget-object v2, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;

    .line 90
    .local v2, "callbacks":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<Lcom/lody/whale/xposed/XC_MethodHook;>;"
    if-nez v2, :cond_2

    .line 91
    new-instance v3, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;

    invoke-direct {v3}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;-><init>()V

    move-object v2, v3

    .line 92
    sget-object v3, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    invoke-interface {v3, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    const/4 v0, 0x1

    .line 95
    :cond_2
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 96
    invoke-virtual {v2, p1}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->add(Ljava/lang/Object;)Z

    .line 98
    if-eqz v0, :cond_4

    .line 99
    new-instance v1, Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;

    invoke-direct {v1, v2}, Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;-><init>(Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;)V

    .line 100
    .local v1, "additionalInfo":Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;
    invoke-interface {p0}, Ljava/lang/reflect/Member;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v3

    invoke-static {v3, p0, v1}, Lcom/lody/whale/WhaleRuntime;->hookMethodNative(Ljava/lang/Class;Ljava/lang/reflect/Member;Ljava/lang/Object;)J

    move-result-wide v3

    .line 101
    .local v3, "slot":J
    const-wide/16 v5, 0x0

    cmp-long v7, v3, v5

    if-lez v7, :cond_3

    goto :goto_1

    .line 102
    :cond_3
    new-instance v5, Ljava/lang/IllegalStateException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Failed to hook method: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 106
    .end local v1    # "additionalInfo":Lcom/lody/whale/xposed/XposedBridge$AdditionalHookInfo;
    .end local v3    # "slot":J
    :cond_4
    :goto_1
    new-instance v1, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v1, p1, p0}, Lcom/lody/whale/xposed/XC_MethodHook$Unhook;-><init>(Lcom/lody/whale/xposed/XC_MethodHook;Ljava/lang/reflect/Member;)V

    return-object v1

    .line 95
    .end local v2    # "callbacks":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<Lcom/lody/whale/xposed/XC_MethodHook;>;"
    :catchall_0
    move-exception v2

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v2

    .line 83
    .end local v0    # "newMethod":Z
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot hook abstract methods: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot hook interfaces: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static invokeOriginalMethod(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "slot"    # J
    .param p2, "thisObject"    # Ljava/lang/Object;
    .param p3, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/reflect/InvocationTargetException;
        }
    .end annotation

    .line 293
    invoke-static {p0, p1, p2, p3}, Lcom/lody/whale/WhaleRuntime;->invokeOriginalMethodNative(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static invokeOriginalMethod(Ljava/lang/reflect/Member;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .param p0, "method"    # Ljava/lang/reflect/Member;
    .param p1, "thisObject"    # Ljava/lang/Object;
    .param p2, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/reflect/InvocationTargetException;
        }
    .end annotation

    .line 286
    invoke-static {p0}, Lcom/lody/whale/WhaleRuntime;->getMethodSlot(Ljava/lang/reflect/Member;)J

    move-result-wide v0

    .line 287
    .local v0, "slot":J
    invoke-static {v0, v1, p1, p2}, Lcom/lody/whale/WhaleRuntime;->invokeOriginalMethodNative(JLjava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    return-object v2
.end method

.method public static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "text"    # Ljava/lang/String;

    .line 51
    const-string v0, "Whale-Buildin-Xposed"

    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 52
    return-void
.end method

.method public static log(Ljava/lang/Throwable;)V
    .locals 2
    .param p0, "t"    # Ljava/lang/Throwable;

    .line 60
    invoke-static {p0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Whale-Buildin-Xposed"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 61
    return-void
.end method

.method public static unhookMethod(Ljava/lang/reflect/Member;Lcom/lody/whale/xposed/XC_MethodHook;)V
    .locals 2
    .param p0, "hookMethod"    # Ljava/lang/reflect/Member;
    .param p1, "callback"    # Lcom/lody/whale/xposed/XC_MethodHook;

    .line 118
    sget-object v0, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    monitor-enter v0

    .line 119
    :try_start_0
    sget-object v1, Lcom/lody/whale/xposed/XposedBridge;->sHookedMethodCallbacks:Ljava/util/Map;

    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;

    .line 120
    .local v1, "callbacks":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<Lcom/lody/whale/xposed/XC_MethodHook;>;"
    if-nez v1, :cond_0

    .line 121
    monitor-exit v0

    return-void

    .line 122
    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 123
    invoke-virtual {v1, p1}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->remove(Ljava/lang/Object;)Z

    .line 124
    return-void

    .line 122
    .end local v1    # "callbacks":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<Lcom/lody/whale/xposed/XC_MethodHook;>;"
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method
