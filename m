Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE64EEAD4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiDAJ7j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344846AbiDAJ7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 05:59:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4A26D10B
        for <linux-iio@vger.kernel.org>; Fri,  1 Apr 2022 02:57:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c10so4651112ejs.13
        for <linux-iio@vger.kernel.org>; Fri, 01 Apr 2022 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ME1P1OVaPsxsLJKBK1FIyPVS66/NXOmvGf0UviNhLbo=;
        b=cZtR0y8jMeMXwv5FoLYkHYt58MPIIrlf6/UGFp/l98ZgRdNjtji5SBaNs+fpKo39k1
         nyqzkGOcThBJGJwCSNKd/3NAOb/h4Cp0m0hxewBCuCN9cYvfJksAWnQoqKAhgtJkbwAX
         8efBlin0lI6meOfWc6AdaekWj2iiTwYOaRz0Kgz0nfsoRYcIR6qPLFgsQ/yM4qIoS0QQ
         YuB2NE7RLxTHbV1Bc/tkip+G7U3hU+EDdqRLUbSNKAjuB/Jv4JxRqUM4tk0UcJkNtpYv
         eJVf6eUcWTCiEM8BYe7bRfImPgZ08kFvKqHFHsS/1mNOxv5+Av+mCv8bKASzf6VPYhRx
         OwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ME1P1OVaPsxsLJKBK1FIyPVS66/NXOmvGf0UviNhLbo=;
        b=r/fy6Swwm5a+PoNDJG9V0N8ZxyKmI/nKCcDbNfMNbVhLOV5Q/cgJytS0ModUT/hYQE
         ns7bofqd8rGVRBJLrySWwM8tdrElaCImtXje2VqmYeQOQOpxB0+bIdDROg8qiFuKlSk3
         L4/SyeLN1vLqk0q92RVuQ+WNELf8VC9wFN7EEZo6KC4mq3X7DI26/EXVRTSZGuAy8L0I
         kTTNcQW3Lz8pmqwL2yzRynodJphIQtPIOTHPWNO4lsQyPCnkbWQ4HsUrDvVDT1JvQ0Qm
         QkHmui+UEI2mxcYMPJFwV7eqfb7q4WlOQckR4H6FrZzMlhNE9T1r64Y7osThYVbWbiYe
         pmEQ==
X-Gm-Message-State: AOAM530Q2YQ1Fo63uMOGBmUNHlCLN/ozCiuzYFPjTyE73gfrn2A0RH5X
        t0WYtQG/kIb8NnTDhl1JwyR9yGoQMsBpeDaz5e8=
X-Google-Smtp-Source: ABdhPJwFSBf8pUatqD1Z+LtgdQEYw0B3SGfVWaBOFbuaVP42+s4nweKhdbd7IA9cIoJ9FAcgNuFoaupigz6lppEb+vc=
X-Received: by 2002:a17:907:1b10:b0:6e4:bac5:f080 with SMTP id
 mp16-20020a1709071b1000b006e4bac5f080mr4426872ejc.24.1648807063596; Fri, 01
 Apr 2022 02:57:43 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Fri, 1 Apr 2022 10:57:42 +0100
Message-ID: <CAHpNFcPmGicZpXCboh0PWfTsZRqxc-W-qA_cx2+vA+OWb0_A6w@mail.gmail.com>
Subject: VecSR Firmware update 2022 For immediate implementation in all
 operating systems, monitors, TV's & equipment such as Mouses, Audio Systems & Webcams
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

Date: Fri, Apr 1, 2022 at 9:48 AM

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
