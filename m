Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2811E8017
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgE2OV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2OV3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 10:21:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B186C03E969;
        Fri, 29 May 2020 07:21:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z64so1443263pfb.1;
        Fri, 29 May 2020 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i2QFGWh29ZUALF00mfx4o/ZxSMLC5ZkcuI1KduVl+wQ=;
        b=nqU09D4NemE7v4FNBlXP2caJ1StOzzh2NERyQg7SKIBInwK1B+fy4/xfnBXV+X+iXQ
         53Gy1vJ5yPY41HTl8AYANgq7JEPKWitr3o2yX3rrsm3yEuHE9fZFMuetAV346fhphrPW
         mURvPq3WN8ikwBncYTr0dIOXyni2hsiA2lndijFcMOvg6EOhPGpYGuCHZtVmeA9AHPRE
         wZTwPQDsBdz5yle12v55+T9R8AaBPbTOxXloaGjqxkVTMVI3oUwG0nvRWwgItFSS5uk+
         /697t4uEWUte8e+BU6IgzE3L9TJ9tJ5/QgrWfYKQuqiHgkhyU2zMTpObsGSgnGisZOPh
         Ymhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i2QFGWh29ZUALF00mfx4o/ZxSMLC5ZkcuI1KduVl+wQ=;
        b=nXNIBFRTGGWP5XCYT/67HE0l94DXtnp63YZUw/w8d4jSrtqyFvLsX6/8MzF9in9G3V
         WNqSlR3JYSfgooqOycwoGBOwp3x3vOCkryxTZ+KvDr6B4Spzydtnn7oqgGOdh1HxoaLL
         psPpn+4RU4p9Xnh/3/scE5w/hYqPNUDD5DtOODHS5/IiLvfm6XzAaOVwDQp8f7LSzcsc
         vYZCco63mMIdCCLKCoULo8w7ImuQmAPA7jqByuUlMPgrRFJSFMM/1GjIdRmkXVtsDP9Z
         ee6bWsb/LxVTLZt8V5VD37HeCNtd2bsdt84lGm6B+y6DyN9yz/6XUgJB1QfJetSNb89R
         Q1QQ==
X-Gm-Message-State: AOAM532m8yZMUtVLoX+8FTpfNOk88AgH7jJYjT6USEY5Zrfcosnfr/jR
        FUoHZvmddoBiLI/22EnnnOdQHQd953MKnCfOgLs=
X-Google-Smtp-Source: ABdhPJwoDGZbMMtGZRtMPiDfkFh17T5tUkKfJscQMddHVLNfsjwz8/jQwE+xTcOhHA9XMuN4UggyfLJPxOkrA920JOo=
X-Received: by 2002:a63:c109:: with SMTP id w9mr2153977pgf.203.1590762088929;
 Fri, 29 May 2020 07:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
In-Reply-To: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 17:21:17 +0300
Message-ID: <CAHp75VeDAc9pP16wf10xvJn6t34cTXkPAXHus1aSL_07HN3EAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] SFH: Add Support for AMD Sensor Fusion Hub
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Richard Neumann <mail@richard-neumann.de>,
        Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 29, 2020 at 4:42 PM Sandeep Singh <Sandeep.Singh@amd.com> wrote=
:
>
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
> is part of MP2 processor (MP2 which is an ARM=C2=AE Cortex-M4
> core based co-processor to x86) and it runs on MP2 where
> in driver resides on X86.The driver functionalities are
> divided  into three parts:-
>
> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW and
>                         provide that data into DRAM.
> 2: Client driver :-     This part for driver will use dram data and
>                         convert that data into HID format based on
>                         HID reports.
> 3: Transport driver :-  This part of driver will communicate with
>                         HID core. Communication between devices and
>                         HID core is mostly done via HID reports
>
> In terms of architecture it is much more reassembles like
> ISH(Intel Integrated Sensor Hub). However the major difference
> is all the hid reports are generated as part of kernel driver.
> AMD SFH driver taken reference from ISH in terms of
> design and functionalities at fewer location.
>
> AMD sensor fusion Hub is part of a SOC 17h family based platforms.
> The solution is working well on several OEM products.
> AMD SFH uses HID over PCIe bus.
>

I can't believe this is fifth version.
Guys, you have to do much more work on these drivers.

> Sandeep Singh (4):
>   SFH: Add maintainers and documentation for AMD SFH based on HID
>     framework
>   SFH: PCI driver to add support of AMD sensor fusion Hub using HID
>     framework
>   SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
>   SFH: Create HID report to Enable support of AMD sensor fusion Hub
>     (SFH)
>
> Changes since v1:
>         -Fix auto build test warnings
>         -Fix warnings captured using smatch
>         -Changes suggested by Dan Carpenter
>
> Links of the review comments for v1:
>         [1] https://patchwork.kernel.org/patch/11325163/
>         [2] https://patchwork.kernel.org/patch/11325167/
>         [3] https://patchwork.kernel.org/patch/11325171/
>         [4] https://patchwork.kernel.org/patch/11325187/
>
>
> Changes since v2:
>         -Debugfs divided into another patch
>         -Fix some cosmetic changes
>         -Fix for review comments
>          Reported and Suggested by:-  Srinivas Pandruvada
>
> Links of the review comments for v2:
>         [1] https://patchwork.kernel.org/patch/11355491/
>         [2] https://patchwork.kernel.org/patch/11355495/
>         [3] https://patchwork.kernel.org/patch/11355499/
>         [4] https://patchwork.kernel.org/patch/11355503/
>
>
> Changes since v3:
>         -removed debugfs suggested by - Benjamin Tissoires
>
> Links of the review comments for v3:
>         [1] https://lkml.org/lkml/2020/2/11/1256
>         [2] https://lkml.org/lkml/2020/2/11/1257
>         [3] https://lkml.org/lkml/2020/2/11/1258
>         [4] https://lkml.org/lkml/2020/2/11/1259
>         [5] https://lkml.org/lkml/2020/2/11/1260
>
>
> Changes since v4:
>         - Rework done based on review comments by - Andy Shevchenko
>         - changes done based on suggested by -Richard Neumann
>
> Links of the review comments for v4:
>         [1] https://lkml.org/lkml/2020/2/26/1360
>         [2] https://lkml.org/lkml/2020/2/26/1361
>         [3] https://lkml.org/lkml/2020/2/26/1362
>         [4] https://lkml.org/lkml/2020/2/26/1363
>         [5] https://lkml.org/lkml/2020/2/27/1
>
>
> Sandeep Singh (4):
>   SFH: Add maintainers and documentation for AMD SFH based      on HID
>     framework
>   SFH: PCI driver to add support of AMD sensor fusion Hub using HID
>     framework
>   SFH: Transport Driver to add support of AMD Sensor Fusion Hub (SFH
>   SFH: Create HID report to Enable support of AMD sensor fusion Hub
>     (SFH)
>
>  Documentation/hid/amd-sfh-hid.rst                  | 160 +++++
>  MAINTAINERS                                        |   8 +
>  drivers/hid/Kconfig                                |   2 +
>  drivers/hid/Makefile                               |   1 +
>  drivers/hid/amd-sfh-hid/Kconfig                    |  21 +
>  drivers/hid/amd-sfh-hid/Makefile                   |  16 +
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.c             | 196 +++++++
>  drivers/hid/amd-sfh-hid/amd_mp2_pcie.h             | 137 +++++
>  drivers/hid/amd-sfh-hid/amdsfh-hid-client.c        | 256 ++++++++
>  drivers/hid/amd-sfh-hid/amdsfh-hid.c               | 179 ++++++
>  drivers/hid/amd-sfh-hid/amdsfh-hid.h               |  84 +++
>  .../hid_descriptor/amd_sfh_hid_descriptor.c        | 251 ++++++++
>  .../hid_descriptor/amd_sfh_hid_descriptor.h        | 125 ++++
>  .../hid_descriptor/amd_sfh_hid_report_descriptor.h | 642 +++++++++++++++=
++++++
>  14 files changed, 2078 insertions(+)
>  create mode 100644 Documentation/hid/amd-sfh-hid.rst
>  create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
>  create mode 100644 drivers/hid/amd-sfh-hid/Makefile
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amd_mp2_pcie.h
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid-client.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.c
>  create mode 100644 drivers/hid/amd-sfh-hid/amdsfh-hid.h
>  create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_de=
scriptor.c
>  create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_de=
scriptor.h
>  create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_re=
port_descriptor.h
>
> --
> 2.7.4
>


--=20
With Best Regards,
Andy Shevchenko
