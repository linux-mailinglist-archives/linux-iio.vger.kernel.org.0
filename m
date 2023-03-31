Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1E6D22C9
	for <lists+linux-iio@lfdr.de>; Fri, 31 Mar 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjCaOku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Mar 2023 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaOkt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2023 10:40:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214251DF91
        for <linux-iio@vger.kernel.org>; Fri, 31 Mar 2023 07:40:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so90453940edb.7
        for <linux-iio@vger.kernel.org>; Fri, 31 Mar 2023 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680273645;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxoCI6+BZAajVY5RGldbiVD7cA7zHiucXSrDGn2ZSLY=;
        b=osA/7nCptfzSE3Zgw+QigQ/P7Bl0tYkJUZb6CKT9tt7i3BaZfNJEdyfDQwUz1+ncdc
         /fyROMiH5ohSKYijhKoMVIDUQdHhH/N2L6T7aZ06qyoDPEpzXGCe8xASb4ng0Mo+op+J
         5DjQa6f5Ho1foOXDIWnD4kojhU61T2a1ZMh7UJIoBatliAz1VgvoZbT8O+WRet0ttiHf
         I7bKf8GxECxHxbzBEnRU+KrDyncLxs43JPceE3wOAY9xhAAWB/b06v/ZtKkdd2gPw78C
         G2+U3XebfOUGysrmHuinI+xlHTLnxBkqKs1yUl0u3EsVzMprTtwhpsVbu/LV9ItBJ6+R
         kQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680273645;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxoCI6+BZAajVY5RGldbiVD7cA7zHiucXSrDGn2ZSLY=;
        b=G9ov0cuj38WVjMShwv1jbV39Cpz7L/TYCAuP4NkzB3Rty00ERQxt4Rpg89f4PUwkdC
         LSi4HOPiN1viUGlMoLb4qEHVjSdh6lN8IZlUo7WSfFmq3MCdYbjnwiwafFqW60+jUUMy
         i+qJ4buSD3N6MjQYSxgzsjDHDGYwPLzJGemZ+yOawuQP7l3J4Lhp7arMYJwcMjDm5qwF
         r7A9s7zG2zdCm9OrmTIcl/U5Y0uDnb2TF1JKG5eFRP/qqsHbPouUQ0KwLbZ3Efyhbv0n
         abVIjyuLfmRwzvlT6VNDgExAnbA1aiwg+VkONf2kUYey8E9MwZ2PvcSdc2lgLNYdpjj0
         PXyQ==
X-Gm-Message-State: AAQBX9fHDrhAWQY7RgFi12Y7Z0PyYNcIX8Pt96tGReXO3tyhRqiBIJL6
        yFdkH3FFvdE49IMrnFiKbvUXojodlQMLeA==
X-Google-Smtp-Source: AKy350YtsYHpXADfQzyjsyQIMMRAJfMyViBZEDm7R/JB29JMspO7f0tmx/5Z5S+N6pvZxNvWawalag==
X-Received: by 2002:aa7:da57:0:b0:4fb:80cf:89e6 with SMTP id w23-20020aa7da57000000b004fb80cf89e6mr27024753eds.8.1680273645461;
        Fri, 31 Mar 2023 07:40:45 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id l2-20020a50c102000000b004fa012332ecsm1136716edf.1.2023.03.31.07.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:40:45 -0700 (PDT)
Message-ID: <dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com>
Subject: adi-axi-adc issues and how to properly support this designs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Fri, 31 Mar 2023 16:40:44 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

There are some major issues with the implementation we have upstream
for the adi-axi-adc driver. The only user is the ad9467 driver. In the
rest of the email I will refer to ad9467 as the converter device and
axi-adc as the IP core.=20

Let me start to state that these designs, in a very a basic way, have a
converter connected to a IP core that typically lives in a FPGA. This
core connects to a DMA core (which is used by the DMA buffer
implementation) so we can keep up with the high rates of these
converters. So there's a link between these devices and we try to
implement that so far looking at them as one single IIO device.

Let's go to the major issues now:

1) There is a circular dependency between the two device. And when
compiled as modules for example, we cannot really rmmod the modules
anymore:

"root@analog:~# rmmod ad9467
rmmod: ERROR: Module ad9467 is in use

root@analog:~# rmmod adi-axi-adc.ko
rmmod: ERROR: Module adi_axi_adc is in use by: ad9467
"

This easy to understand as the ad9467 driver as a direct symbol
dependency on the axi-adc one. And this one calls 'module_get()' as
soon as it attaches to a "client"

2) It's fairly easy to crash the kernel:

"
root@analog:/sys/bus/spi/drivers/ad9467# echo spi0.0 > unbind
root@analog:/sys/bus/iio/devices/iio:device2# echo 1 >
buffer0/in_voltage0_en
root@analog:/sys/bus/iio/devices/iio:device2# echo 1 > buffer0/enable
[  132.349133] 8<--- cut here ---
[  132.352193] Unable to handle kernel paging request at virtual
address e0940000 when read
[  132.360333] [e0940000] *pgd=3D0208b811, *pte=3D00000000, *ppte=3D0000000=
0
[  132.366668] Internal error: Oops: 7 [#1] SMP ARM
[  132.371289] Modules linked in: ad9467 adi_axi_adc ad9517
[  132.376609] CPU: 1 PID: 444 Comm: bash Not tainted 6.2.9-dirty #3
[  132.382701] Hardware name: Xilinx Zynq Platform
[  132.387223] PC is at adi_axi_adc_update_scan_mode+0x34/0x88
[adi_axi_adc]
[  132.394020] LR is at arm_heavy_mb+0x1c/0x38
[  132.398212] pc : [<bf0060c4>]    lr : [<c031820c>]    psr: a0000013
[  132.404392] sp : e0929e30  ip : deaddead  fp : c4430270
[  132.409678] r10: c8a0bc18  r9 : deaddeac  r8 : c89b1c00
[  132.414895] r7 : c4430340  r6 : c45db7c0  r5 : e093ffc0  r4 :
000003f0
[  132.421413] r3 : 00010000  r2 : e0940000  r1 : 00000000  r0 :
00000000
"

3) This solution does not really scale. There are designs where we have
multiple instances of the IP core attached to the client (typically if
a converter like this has more than one channel, we have one instance
of the core per channel). The way we have it know, that would not me
feasable.

Issues number 2) and 3) would more or less be easy to solve moving from
of_parse_phandle() and from devm_ (using plain kmalloc() + krefs). The
big issue to me is 1) because, for example, in the driver we have out
of tree for ad9467, we do a tuning on the adc LVDS interface that we do
not do in the upstream version. And why is this problematic? Because
this means the converter driver has to do some configurations on the IP
core device and hence we have a bidirectional link between these 2
devices which, while doable, is far from ideal and can become complex
to keep it sane.

To be fair, what we have in upstream today is inspired a lot in what
ADI has out of tree (likely even better) but I truly think we need to
do it better. As I want to start working on this, I want to share some
ideas that I have on my head and hopefuly get some feedback on the
direction to go. So, here it goes:

1) The obvious one is to flip the logic of the "communication" link.
Right now callbacks are done from the IP core driver to the converter.
As stated, the converter might need to access the IP core to ask/do
some configurations. Well, from what I've seen in other projects we
have, I'm positive everything can be done by being the converter the
"entry point". This effectively means, that IP core devices would
register somewhere (I'm thinking in a tiny interface module that can
likely be reused for the axi-dac counterpart of the axi-adc) and the
converter device would "get" it during probe.

2) With respect to 1), while treating the devices as 1 might look
appealing, I'm not really sure it's the right thing to do. This,
because these devices are effectively two different devices: the
converter is typically a SPI device while the IP core is a MMIO device.
Treating them as 1, makes things like the IIO direct_reg_access not
doable (unless we duplicate some code and manually add the second
debugfs interface). Another thing not ideal with 1) is that the DMA
buffer interface really belongs on the IP core (looking on how the HW
is designed) and not on the converter driver. However, one thing that
I'm not sure it will be ideal with having two devices is synchronizing
accesses to the IP core. For example, the axi-dac driver (that I also
intend to bring upstream as part of this work) also has an userspace
interface so we need to be carefull. But I guess this is no different
for devices which are accessed by the in-kernel IIO interface.

I'm way more inclined to go with 2).

Another thing that I've been thinking is how should we implement the IP
core driver... As stated, there are usecases where we have mulitple
instances of these devices. Well, that is how we've been doing things
in ADI tree but essentially the core is just one big "block/device"
[1]. However, the way we've been doing things is actually ok because
every sub-block on these IPs have their own memory map allowing to
control everything needed by the sub-blocks.

Another option and now that we support output buffers and multiple
buffers per device would be to support these cores as one device
(likely in the addac folder). However, I think that keeping each block
as a standalone device might keep things more simple. But I assume it's
tempting to get a first user to the multi buffer support :)


Now for the big elephant of all the above... Everything that I've been
saying means breaking the current ABI. I'm fairly confident that we
should not have any upstream user for these drivers because it lacks a
lot of features that are only present in ADI tree. So, I think it's ok
to destroy the ABI but of course I cannot guarantee there are no users
:).

So, would it be fine for me to not care about the current ABI while
working on this? Because, it will be very difficult to come up with
something that is compatible with what we have. Well, there's always
the option of coming up with a -v2 (or something like that) for these
drivers keeping the ones we have now, untouched. Ideas?

So... feedback is very much appreciated :)

[1]:=C2=A0https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi_a=
drv9002
https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi_adrv9002
https://wiki.analog.com/resources/eval/user-guides/adrv9002/axi_adrv9002

- Nuno S=C3=A1
