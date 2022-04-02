Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB954EFDB6
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 03:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348921AbiDBBWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 21:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiDBBWG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 21:22:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7D2ED76
        for <linux-iio@vger.kernel.org>; Fri,  1 Apr 2022 18:20:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i16so9164452ejk.12
        for <linux-iio@vger.kernel.org>; Fri, 01 Apr 2022 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IaS1hkvmveC5IBbs3iH06s2bJz4c3BLVqz2F+DTX2Y4=;
        b=DkN2+IoGQRNVn9I3tQluJaEc0MtViO8LRtF2NJ4s7IaMBLZLmCvQWoKwHzIenK2Uvt
         oM6wyR7cpVpw/DP2N18V03yoXgGRVrapdyCInNpevW5rlrzsyvf5gqZL4sA2Rw4B9ZJg
         3UOY3d8SQ47sXetoK5U9iEEGwQTb8Ff0UQw5PtcJEam5PYMgJASsTyuSg/uaNe/g3fMz
         yqwj0iiYgM3HaLEVT5o3TRcIIHaIQnbEZiSbYiR2x9jyWrHznvIUDRuJBO5JN4SX+MQD
         8mzqNLGq4bG6euGysH79oPKXg+fJLacgaCYuRQu3I8s681Fy18Rz98Cx4bqbek74Luqn
         hifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IaS1hkvmveC5IBbs3iH06s2bJz4c3BLVqz2F+DTX2Y4=;
        b=QWE6QYIeoqsUQTI4/WMdfGkRTUvfGEJfpHPfazdRbaPRlTq+71QVkvcTsduFAbEzeI
         YlBMRxU2j8brvTqyLQ8loSmsbfwFRPx6HXIZmOhWTTRXVu3ANwC5ivbKsl/IeknovSB0
         4qY7m7X01ZudQO2Q5NwA9MSUV+pz+25tsYJXj6Fr5PXusAh7YCt87e++eBxLccQ8viTP
         xx35jdnkRn5VMzc6nv4xyWN7SJEUuvUVR8hvFCo0LTTYvUwNl/W11gtt0MM49H4V2Gce
         PcOgTpw8YDR3GrjamwfpE/XK9xNjDc61YbaExCAMGF/4mSMD5ntnJ34a9J6XaUvbGpVm
         xcIw==
X-Gm-Message-State: AOAM531sTlT4+5XESLf/nQ2xYY3HjrDqXRQVpR1BGR+DmlIT2A77fc4O
        R/BT3E8sYAkmOvdiDrenkC4rXqNpYt5VnpR7YaI=
X-Google-Smtp-Source: ABdhPJxdMQmVZLNF+7vq8tj4btDtW9ROcnQCx3SXwX2vXAT2C3lTN7xw3dnuRurNZE+ZiQItXzYYUylWjK6AIFqxWz8=
X-Received: by 2002:a17:907:6e06:b0:6e4:dae7:9574 with SMTP id
 sd6-20020a1709076e0600b006e4dae79574mr2172572ejc.540.1648862413069; Fri, 01
 Apr 2022 18:20:13 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sat, 2 Apr 2022 02:20:14 +0100
Message-ID: <CAHpNFcOpX0JwcqrPSQkP0oV10EFhJmCiMZOYKis+xSQO5C_rDg@mail.gmail.com>
Subject: Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
 Class VESA Console + With Console in VecSR you can 3DText & Audio + VecSR
 Firmware update 2022 For immediate implementation in all operating systems & ROM's
To:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VecSR Firmware update 2022 For immediate implementation in all
operating systems, monitors, TV's & equipment such as Mouses, Audio
Systems & Webcams

VecSR - Vector Standard Render

VESA Standards : Vector Graphics, Boxes, Ellipses, Curves & Fonts :
Consolas & other brilliant fonts : (c)RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts

OT-SVG Fonts & TT-SVG Obviously Rendered in Direct X 9+ & OpenGL 3+
Mode & Desktop Rendering modes

Improve Console & TV & BIOS & General Animated Render

Vector Display Standards with low relative CPU Weight
SiMD Polygon Font Method Render

Default option point scaling (the space) : Metadata Vector Fonts with
Curl mathematical vector :

16 Bit : SiMD 1 width
32 Bit : SiMD Double Width

High precision for AVX 32Bit to 256Bit width precision.

Vectoring with SiMD allows traditional CPU mastered VESA Emulation
desktops & safe mode to be super fast & displays to conform to VESA
render standards with little effort & a 1MB Table ROM.

Though the VESA & HDMI & DisplayPort standards Facilitates direct low
bandwidth transport of and transformation of 3D & 2D graphics & fonts
into directly Rendered Super High Fidelity SiMD & AVX Rendering Vector

Display Standards Vector Render : DSVR-SiMD Can and will be directly
rendered to a Surface for visual element : SfVE-Vec

As such transport of Vectors & transformation onto display (Monitor,
3D Unit, Render, TV, & Though HDMI, PCI Port & DP & RAM)

Directly resolve The total graphics pipeline into high quality output
or input & allow communication of almost infinite Floating point
values for all rendered 3D & 2D Elements on a given surface (RAM
Render Page or Surface)

In high precision that is almost unbeatable & yet consumes many levels
less RAM & Transport Protocol bandwidth,

Further more can also render Vector 3D & 2D Audio & other elements
though Vector 'Fonting' Systems, Examples exist : 3D Wave Tables,
Harmonic reproduction units for example Yamaha and Casio keyboards.

(c)Rupert S

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.html

https://bit.ly/VESA_BT

*

*Application of SiMD Polygon Font Method Render
*3D Render method with Console input DEMO : RS

3D Display access to correct display of fonts at angles in games &
apps without Utilizing 3rd Axis maths on a simple Shape polygon Vector
font or shape. (c)Rupert S

3rd dimensional access with vector fonts by a simple method:

Render text to virtual screen layer AKA a fully rendered monochrome, 2
colour or multi colour..

Bitmap/Texture,

Due to latency we have 3 frames ahead to render to bitmap DPT 3 / Dot 5

Can be higher resolution & we can sub sample with closer view priority...

We then rotate the texture on our output polygon & factor size differential.

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize

Why ? Because rotating a polygon is harder than subtracting or adding
width, Hight & direction to fully complex polygon Fonts & Polygon
lines or curves...

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize.

https://science.n-helix.com/2022/04/vecsr.html
