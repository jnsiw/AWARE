.class public final Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;
.super Ljava/lang/Object;
.source "XposedBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/XposedBridge;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "CopyOnWriteSortedSet"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field private volatile transient elements:[Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 296
    .local p0, "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 297
    invoke-static {}, Lcom/lody/whale/xposed/XposedBridge;->access$000()[Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    return-void
.end method

.method private indexOf(Ljava/lang/Object;)I
    .locals 2
    .param p1, "o"    # Ljava/lang/Object;

    .line 327
    .local p0, "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 328
    iget-object v1, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    aget-object v1, v1, v0

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 329
    return v0

    .line 327
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 331
    .end local v0    # "i":I
    :cond_1
    const/4 v0, -0x1

    return v0
.end method


# virtual methods
.method public declared-synchronized add(Ljava/lang/Object;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .local p0, "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    .local p1, "e":Ljava/lang/Object;, "TE;"
    monitor-enter p0

    .line 301
    :try_start_0
    invoke-direct {p0, p1}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->indexOf(Ljava/lang/Object;)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 302
    .local v0, "index":I
    const/4 v1, 0x0

    if-ltz v0, :cond_0

    .line 303
    monitor-exit p0

    return v1

    .line 305
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v2, v2

    const/4 v3, 0x1

    add-int/2addr v2, v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 306
    .local v2, "newElements":[Ljava/lang/Object;
    iget-object v4, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    iget-object v5, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v5, v5

    invoke-static {v4, v1, v2, v1, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 307
    iget-object v1, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v1, v1

    aput-object p1, v2, v1

    .line 308
    invoke-static {v2}, Ljava/util/Arrays;->sort([Ljava/lang/Object;)V

    .line 309
    iput-object v2, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 310
    monitor-exit p0

    return v3

    .line 300
    .end local v0    # "index":I
    .end local v2    # "newElements":[Ljava/lang/Object;
    .end local p0    # "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    .end local p1    # "e":Ljava/lang/Object;, "TE;"
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public getSnapshot()[Ljava/lang/Object;
    .locals 1

    .line 335
    .local p0, "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    iget-object v0, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    return-object v0
.end method

.method public declared-synchronized remove(Ljava/lang/Object;)Z
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)Z"
        }
    .end annotation

    .local p0, "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    .local p1, "e":Ljava/lang/Object;, "TE;"
    monitor-enter p0

    .line 315
    :try_start_0
    invoke-direct {p0, p1}, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->indexOf(Ljava/lang/Object;)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 316
    .local v0, "index":I
    const/4 v1, -0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_0

    .line 317
    monitor-exit p0

    return v2

    .line 319
    :cond_0
    :try_start_1
    iget-object v1, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v1, v1

    const/4 v3, 0x1

    sub-int/2addr v1, v3

    new-array v1, v1, [Ljava/lang/Object;

    .line 320
    .local v1, "newElements":[Ljava/lang/Object;
    iget-object v4, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    invoke-static {v4, v2, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 321
    iget-object v2, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    add-int/lit8 v4, v0, 0x1

    iget-object v5, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;

    array-length v5, v5

    sub-int/2addr v5, v0

    sub-int/2addr v5, v3

    invoke-static {v2, v4, v1, v0, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 322
    iput-object v1, p0, Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;->elements:[Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 323
    monitor-exit p0

    return v3

    .line 314
    .end local v0    # "index":I
    .end local v1    # "newElements":[Ljava/lang/Object;
    .end local p0    # "this":Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet;, "Lcom/lody/whale/xposed/XposedBridge$CopyOnWriteSortedSet<TE;>;"
    .end local p1    # "e":Ljava/lang/Object;, "TE;"
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
