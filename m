Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE22A2501
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgKBHFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 02:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgKBHFD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 02:05:03 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB29C0617A6;
        Sun,  1 Nov 2020 23:05:03 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id o129so3109589ooo.11;
        Sun, 01 Nov 2020 23:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YI54VZZszq4hxY1ZamHtFQZf9ma4Q4Sivjp7d7dM0Rw=;
        b=DP6dVpM7TNLfW3MkeyzGWoON8h54KpEahVTrjHHCs2qeFRfwpoNoUuVO0lvuEamGbT
         po4siHJpaj3SmjDXcANTP9KicXTnIWGS6vhBZona/zJo2vdmsXVPbQvnuY7vqq/G1xX/
         R9ReqECOgRjr8exucPrhn7D6DghsyJagPJ56jL4kj/7UViSPm0bicYX0bmh1BWHLIrN4
         BmJqYjHbTXNfXvdZGABXrNeuWcuD10axUJk4k73lSO7B2PtnpcMS3xsB7plfKetdvbfh
         7GlUHA/ryOGZhZKDeU5vGFszBOMzBUc6LIDF8KpZ4BUKiVitf54KcAXTP83uKt7QftAA
         BKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YI54VZZszq4hxY1ZamHtFQZf9ma4Q4Sivjp7d7dM0Rw=;
        b=MitDIGaMiKtfsBrt2cyDDgU/G2c9r0Xt1MzL7VbF0dbVLR0bPUC89AOEj4barvdSyW
         5NcePGQa2ArCCvM9tuvRv0UQbtbSbi8jX7kU8MhD93qWshK2C1umMDi49nf4gpRy/CNc
         JTYMqXa4t/P+5ApWgWWZblaYuErGvv7kUngFEy9KhlETvAcemdaovHwl1EEKRITYze4s
         QlgB91QySH/Jx3jLO8Fvpb4mT0C9bg+Dnq7ZdJTiEa6+oQHlD4BIjdzNGA4MzBiJZRRu
         ZW8xtopZeybG/k2FtE0eKGxvfG8PqxQ7fOqePnwkO6iZUWUdlM2sNaq0gtFC6AP8WlWi
         t6bw==
X-Gm-Message-State: AOAM532XaxudxSBxi+1YPGESyKhOAD6jAuCwG5r6p92MJZnLQOxGc3PR
        UIKqllFSxwPwqze+BD6m+buzNorqFsflLOjAeJI=
X-Google-Smtp-Source: ABdhPJxjHMlav4PDw19Q5gA4yIpyiRESfLoqVQqCF1hKlnNaBGGKm3VP2YihK7xAtdHujvZ1CchiyVuR+DL4sXVZIwQ=
X-Received: by 2002:a4a:d848:: with SMTP id g8mr11149900oov.35.1604300703108;
 Sun, 01 Nov 2020 23:05:03 -0800 (PST)
MIME-Version: 1.0
References: <1603181267-15610-1-git-send-email-gene.chen.richtek@gmail.com> <20201101154019.39932a2e@archlinux>
In-Reply-To: <20201101154019.39932a2e@archlinux>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 2 Nov 2020 15:04:52 +0800
Message-ID: <CAE+NS34-ayHchKA5Unb=+wHvesox1r9kkyPy09JgBqrA0Gd0Vw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] iio: adc: mt6360: Add ADC driver for MT6360
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:40=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 20 Oct 2020 16:07:44 +0800
> Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> > In-Reply-To:
> >
> > This patch series add MT6360 ADC support contains driver, testing docum=
ent
> > and binding document
> >
> Hi Gene,
>
> Other than that small edit needed in the dt binding this is stalled on
> the label code getting upstreamed into the core.
>
> I've asked Cristian to repost that so hopefully we can resolve that depen=
dency
> and get this merged fairly soon.
>
> For the dt thing I can just drop the description entirely, but would pref=
er
> if you sent a v8 fixing the tags issue Rob pointed out and also fixing th=
at
> description.
>
> Thanks,
>
> Jonathan
>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +description: |
> +  Family of simple ADCs with i2c interface and internal references.
That seems unlikely...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Do you means I should remove this description?
If yes, I will also update PATCH v8 for add tags and fix dt-bindings.

> > Gene Chen (2)
> >   dt-bindings: iio: adc: add bindings doc for MT6360 ADC
> >   Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
> >   iio: adc: mt6360: Add ADC driver for MT6360
> >
> >  Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360                 |  =
 78 ++
> >  Documentation/devicetree/bindings/iio/adc/mediatek,mt6360-adc.yaml |  =
 34
> >  drivers/iio/adc/Kconfig                                            |  =
 11
> >  drivers/iio/adc/Makefile                                           |  =
  1
> >  drivers/iio/adc/mt6360-adc.c                                       |  =
372 ++++++++++
> >  5 files changed, 496 insertions(+)
> >
> > changelogs between v1 & v2
> >  - adc: use IIO_CHAN_INFO_PROCESSED only
> >  - adc: use devm_iio_triggered_buffer_setup
> >  - adc: use use s64 to record timestamp
> >
> > changelogs between v2 & v3
> >  - Rearrange include file order by alphabet
> >  - Set line length constraint below 100
> >  - Add Document for testing adc sysfs node guideline
> >  - Set compiler 64 bit aligned when handle iio timestamp
> >
> > changelogs between v3 & v4
> >  - Fix sysfs guideline description
> >  - Replace iio channel processed by raw/scale/offset
> >  - Add comment of read adc flow for special HW design
> >
> > changelogs between v4 & v5
> >  - Rename dt-bindings aligned to file name
> >  - Aligned sysfs node name with driver and add VBUSDIVX description
> >  - Add ADC channel sysfs node "*_labels"
> >
> > changelogs between v5 & v6
> >  - Memset aligned adc data
> >  - Remove strong casting void pointer
> >
> > changelogs between v6 & v7
> >  - Avoid adc polling infinite loop
> >
>
