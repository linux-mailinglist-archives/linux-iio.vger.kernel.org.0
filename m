Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7125D28A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIDHkw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDHkv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 03:40:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8BC061244;
        Fri,  4 Sep 2020 00:40:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c142so4145624pfb.7;
        Fri, 04 Sep 2020 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fuEcm2fNtFp25J4z2PSD0ryqyk/BTceR0Y1ATheU+O4=;
        b=cb7cnJo7gCODLFZxZudO4Ir++bBzd2wWe/dGzDWc4qdOTUlT7RdV5WwHPdV9Z/oH3m
         qmEuzyivdjlLGXQFqzRTGQ0MfYWOg5CmFV3sQAhmBvtN/99wy33STueAcXOpHsV+Fskw
         c/ZNI7WN4DDt53qDvpKL/FDU1DsBp2B1nMDGnntxulzpjSJVy7XHvQVO/aosWWJtExsT
         fB+x38Y4X+S3iiKYWLmTd5Fi7zgaaVH+lwnNH+Lgq5qPXR05bU/orbMW1UussOqn2KZ3
         3TOKLjahIAKg8WuDAaiCCENXFxUId7YffE/4diA7fHrqprJm7qVBjtebMk+032+Rhm9X
         ywpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fuEcm2fNtFp25J4z2PSD0ryqyk/BTceR0Y1ATheU+O4=;
        b=PHEDDyI+5cp78KSFD5X/t6pXt4x7grlS4UpDsCPY/OAXdmHXCJJB/7CEHO1rQhWOVi
         ppAsS6ZQVOnKoDdqUs26o/PjrVWMnSv5V5b+Nhdup7ZfXrRcNI2hK6rS/pWW+YCmK2JH
         GXgbVTR6ytmjMLp2lpAZUZhCa0ySBcT2qGRI4JjbK1cSrVmltz6G0I9iA0WwF8STQRH9
         CYMM/k78ZMTiKO8u064TV2ECD3AX6DKCNN+FTdtg+5gFwhbhD6hBF+eEskU5JHFWNakP
         piOP/EEgO77Va/j6rr6/6ABPA4sgdvVYj2xyvcHUixwworux7pRm1u2L1SawijtKA4WX
         4Khw==
X-Gm-Message-State: AOAM533tuWPf2lqmnIsoqtYU06OvAk72Cg/KGCTE57n5O7s7a/SsDwQ2
        1FqKd7VAu3+JTUCh3SWbSeImIQxB02uz4Sxkg6g=
X-Google-Smtp-Source: ABdhPJwLnJ1coRMjvTotgtPiPjxvQe1lbrOc1fgsu4mKUB9JBbXLXDEQ8rBPgkwG49yHFofPyaB749IKRnqMZc2VWOk=
X-Received: by 2002:a62:6083:0:b029:13c:1611:66c4 with SMTP id
 u125-20020a6260830000b029013c161166c4mr5785434pfb.15.1599205248985; Fri, 04
 Sep 2020 00:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
 <CAHp75VeZLPR02xB2XRzec5mSBvq93XYZg56OOODxpFTPva6cXw@mail.gmail.com>
 <CAFv23QmDwcrdxEndH=mKMAomzt9kxG_f1Z6=Fd8iuuvCoY92SA@mail.gmail.com>
 <CAHp75Vcup9LUk0fgjW9T2FK-K5GD3=3ycPHi74Oykc8rq_tJqA@mail.gmail.com>
 <CAHp75VeyFTSc3AY07rFnjvXOcHt79tpRHzs_GZGALQcdqoANjA@mail.gmail.com>
 <CAFv23Qn4sqTZ1Rbr07sw76hk-769y6ra=mHi1x3L962GyorvXQ@mail.gmail.com>
 <CAHp75Vc6fgPmnPOYYvUi7EO7ovq2tLk_kBqqk-=wrr0V3nbcVw@mail.gmail.com>
 <CAHp75VcJp4zCxOUBgYTypv_R47vLAuAF2ZStLpA9mjFjbzWcxw@mail.gmail.com> <CAFv23Qnij-2ycXNqisQDbo9ix41ed1HPRJrOdRoMM2bjU407nw@mail.gmail.com>
In-Reply-To: <CAFv23Qnij-2ycXNqisQDbo9ix41ed1HPRJrOdRoMM2bjU407nw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Sep 2020 10:40:31 +0300
Message-ID: <CAHp75Vcp5ERvTMDob3gUPqi+WPUz_BKoytO5faSbtNeX3LWy_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        William Sung <william.sung@advantech.com.tw>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 4, 2020 at 5:25 AM AceLan Kao <acelan.kao@canonical.com> wrote:
> Here is the updated ads5593r.asl, but I still got some troubles when
> using configfs.
> The modification I made
> 1. add DefinitionBlock() and External()
> 2. align _SB.I2C1
> 3. set _CRS serialized
>
> The issues I got are,
> 1. The ADS5593 is defined in DSDT table, but I can't compile the asl
> code when define it as DSDT table

Is it part of DSDT? I think you are trying to make it as separate
table. According to ACPI specification you may have only one DSDT. It
means that additional tables should have SSDT signature. This also
explained in the documentation [7] regarding to ACPI SSDT overlays.

[7]: https://www.kernel.org/doc/html/latest/admin-guide/acpi/ssdt-overlays.=
html


> $ iasl ads5593r.asl
>
> Intel ACPI Component Architecture
> ASL+ Optimizing Compiler/Disassembler version 20190509
> Copyright (c) 2000 - 2019 Intel Corporation
>
> ads5593r.asl      5:     Scope (_SB.I2C1)
> Error    6148 -                       ^ Illegal open scope on external
> object from within DSDT

Again, look at the examples in [4]. You need to attach your device to
the controller and refer to it from I2cSerialBus() resource.


> ASL Input:     ads5593r.asl -    7917 bytes     30 keywords    257 source=
 lines
>
> Compilation failed. 1 Errors, 0 Warnings, 0 Remarks
> No AML files were generated due to compiler error(s)
>
> 2. I got below errors in dmesg if I set it as SSDT
> [  410.220993] ACPI: Host-directed Dynamic ACPI Table Load:
> [  410.221013] ACPI: SSDT 0xFFFF89A4ADDE7C00 00035D (v01
> ADS5593R 00000001 INTL 20190509)
> [  410.221106] ACPI BIOS Error (bug): Failure creating named object
> [\_SB.I2C1.I2CG], AE_ALREADY_EXISTS (20190816/dswload2-326)
> [  410.221324] ACPI Error: AE_ALREADY_EXISTS, During name
> lookup/catalog (20190816/psobject-220)
> [  410.221468] ACPI: Skipping parse of AML opcode: Device (0x5B82)
>
> Do you have any suggestions?

Yes, you need to find proper device node in the DSDT which represents
the I=C2=B2C controller. The DAC device should be subnode of it.

> We may have a chance to convince BIOS to move ADS5593 to the SSDT
> table, do you think it's a good idea?

I'm not sure I understand how BIOS is involved here. If the ADS5593 is
a part of platform and you can change DSDT in the BIOS, just make it
there. If it's an attachable component (like for your development
cycle) SSDT is best approach. Note that amount of SSDT in the system
is limited.

> BTW, the driver set the channels mode while probing, I'm not sure if
> configfs will make the driver probe again when new table is loaded
> If we can't use configfs, is there any other way we could try?

All possible ways are the following (depending on your needs):
 - BIOS provides DSDT with the component reference included
 - Bootloader provides, rewrites or updates tables
 - OS via: a) initramfs, b) ConfigFS
 - EFI keeps it in variable which OS or BIOS sets

> > > > I spent some time studying/reading what you wrote, but I still don'=
t
> > > > understand how to leverage meta-acpi.
> > >
> > > meta-acpi is a Yocto layer to support provided ACPI tables for the
> > > build. My point here is to have it as a collection of ASL examples.
> > > It's what you asked for below in this email.
> >
> > > Also we can collect your ASL example under board (presumably new) fol=
der.
> >
> > Actually it seems Baytrail, so, minnowboard-max is good enough.
> >
> > ...
> >
> > > On the first glance I didn't see any issues with it, but on second
> > > look here is one. Look into this [5] example.
> > > If you noticed it uses the same path in Scope and in the reference in
> > > I2cSerialBus() while in your ASL they are different.
> >
> > Also there is an _ADR value wrong for the second channel (I'm not sure
> > if it affects anyhow the rest).
> >
> > > Do you have issues with loading it (as is and after above addressed)?
> > >
> > > [5]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acp=
i-tables/samples/edison/ft6236.asli
> >
> > Also a link [6] to our Buildroot repository which allows to create an
> > initramfs with ASL compiled. Maybe used as a reference how we created
> > initramfs and compile ASLs.
> >
> > [6]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/comm=
on
> > ...
> >
> > > > > One more useful link is SO answers on the topic:
> > > > > https://stackoverflow.com/search?tab=3Dnewest&q=3Dprp0001
> > > > >
> > > > > > [1]: https://www.kernel.org/doc/html/latest/firmware-guide/acpi=
/enumeration.html#device-tree-namespace-link-device-id
> > > > > > [2]: https://elixir.bootlin.com/linux/v5.9-rc3/source/Documenta=
tion/devicetree/bindings/iio/dac/ad5592r.txt
> > > > > > [3]: https://github.com/westeri/meta-acpi
> > > > > > [4]: https://github.com/westeri/meta-acpi/tree/master/recipes-b=
sp/acpi-tables/samples
> >
> > > > > > > 1. https://www.advantech.com/products/9a0cc561-8fc2-4e22-969c=
-9df90a3952b5/uno-420/mod_2d6a546b-39e3-4bc4-bbf4-ac89e6b7667c


--=20
With Best Regards,
Andy Shevchenko
