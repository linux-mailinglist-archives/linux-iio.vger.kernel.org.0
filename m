Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B72C642D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Nov 2020 13:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgK0MDB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Nov 2020 07:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgK0MDA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 07:03:00 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5FC0613D1;
        Fri, 27 Nov 2020 04:03:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id d18so5433343edt.7;
        Fri, 27 Nov 2020 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljs7bo8+Z6zm1yHWLhCx7KDEBcbP9Ge0LaZUKyJNGgs=;
        b=DhRr2XcILC8y0VpenSUyKTup4ViFnqAM52jo3fZUJ5JsocstR4PnCcuvCX+0x5xkPE
         RF08q+V5kKoL/+4uDQs9yeRHTeuK/0OhEzalUPetlsF4GotBAjaWT+CVOUC/OsaSGaJv
         aXAg6W6BHeOfT1LMxa1R/qIRqUKcOaVBqFX/uy7/v9zeUy/OG0IGSvhYyq7tK2Keh+TD
         fmWI8qJkAoVI0L5fkp0flwz22XL03J24Gb7MF6pfKLUSlp0WOW31zrFc2RRn6VTmP9Nf
         AQTF04UI7bYUeOgmQZR1qp2UhpCtzetXwTQkTfxM5XN8Z33kKSdoUghn8taqifFvkeg4
         pkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljs7bo8+Z6zm1yHWLhCx7KDEBcbP9Ge0LaZUKyJNGgs=;
        b=mB0naX1Ps7C6PNRZoVsPIk9lxlSRs8MAFL2XPpyGOgsuy0ue8f0DNtaC0QKNpYYWWT
         Ci8LlCY7KIYU4aooYH7B5YxlyN/RBKA92nv0J/NOLGsLd6HqzozluTRakS01W6aFtZTk
         tWl6w8de9drq4KVpk7mbedTjNiklMudxkKo1t5BZvEU7CKrVkShu0zkpyi3ncZOV/s4w
         L3yJnTb2xKZUI0FGERvxIJHxxMHpkbg47j36fpWAj8sP2Wl8PnyI5xM00fX64Za52sK7
         jnCc3ICWwy4qXj6GfeUZu8pQf6UGjdvsl8aDWr1Cc99Ey3eSSQtnWiZMBtnbCqWuLFGP
         rKug==
X-Gm-Message-State: AOAM533CQFVTxuyQbi4z6FYsob+1Gc7ZqoAuw+N1h+mnQ3priYeHr8mS
        k0zyYCQAVBLJuwO9GUHjCjJIWjQHrps47QYXgk8AASniQr8=
X-Google-Smtp-Source: ABdhPJwrkjcVEMp4LMksn2e4QTL78DpR25/XfY75r4lYjbQP9VcAhouHNQLeFEWd0MnPBTB2UsEHzwp62291GCJskm4=
X-Received: by 2002:aa7:c80b:: with SMTP id a11mr7282551edt.111.1606478578835;
 Fri, 27 Nov 2020 04:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20201119100748.57689-1-alexandru.ardelean@analog.com> <20201121153653.568c7344@archlinux>
In-Reply-To: <20201121153653.568c7344@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 27 Nov 2020 14:02:47 +0200
Message-ID: <CA+U=DsprS5V5LXROP4m4iuWexH9aZir-+DJKWZ4kcgKLS86+Tg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7887: convert dual-channel mode to DT/ACPI
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 5:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 19 Nov 2020 12:07:45 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change converts the configuration of the dual-channel mode from the
> > old platform-data, to the device_property_present() function, which
> > supports both device-tree and ACPI configuration setups.
> >
> > With this change the old platform_data include of the driver can be
> > removed.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Hi Alexandru,
>
> The set looks good in general, but there is a an oddity in the driver.
> If we don't provide the vref regulator, then the scale is set to reflect
> the internal 2.5V reference.  Fiven the external reference only
> works by overdriving the 2.5V (must be higher than that to have
> an effect) I guess we could in theory clamp it to a minimum of
> 2.5V but anyone wiring up less than that would have built a crazy board
> so we can probably ignore it.
>
> However, as I read the datasheet in dual channel mode it should be set
> to VDD not 2.5V.  Right now you could make it work in a DT file
> by setting VREF==VDD regulator but that's inelegant.
>
> If you agree with my logic, perhaps a follow up patch?

I haven't managed to get around to this one.
Will try next week.


>
> Jonathan
>
>
> > ---
> >
> > I'm wondering if this changeset is what was in mind here:
> >  https://lore.kernel.org/linux-iio/CA+U=DsqF5tu8Be9KXeyCWD2uHvV688Nc3n=z_Xi2J6H6DFJPRQ@mail.gmail.com/T/#mbe72e4da3acea3899d0d35402ea81e52a9bc34e6
> > This driver could have been simplified/reduced a whole lot more, but I'm
> > not sure about it. It's a bit of patch-noise, and later
> >
> > Changelog v1 -> v2:
> > * dropped patch 'iio: adc: ad7887: convert driver to full DT probing'
> >   not adding the device_get_match_data() logic anymore
> > * added patch 'iio: adc: ad7887: remove matching code from driver'
> >   hooking the chip info directly to AD7887
> > * added patch 'iio: adc: ad7887: add OF match table'
> >   this just adds an OF table for DT and ACPI
> >
> >  drivers/iio/adc/ad7887.c             | 10 +++++-----
> >  include/linux/platform_data/ad7887.h | 21 ---------------------
> >  2 files changed, 5 insertions(+), 26 deletions(-)
> >  delete mode 100644 include/linux/platform_data/ad7887.h
> >
> > diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> > index 4f6f0e0e03ee..06f684c053a0 100644
> > --- a/drivers/iio/adc/ad7887.c
> > +++ b/drivers/iio/adc/ad7887.c
> > @@ -23,8 +23,6 @@
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> >
> > -#include <linux/platform_data/ad7887.h>
> > -
> >  #define AD7887_REF_DIS               BIT(5)  /* on-chip reference disable */
> >  #define AD7887_DUAL          BIT(4)  /* dual-channel mode */
> >  #define AD7887_CH_AIN1               BIT(3)  /* convert on channel 1, DUAL=1 */
> > @@ -241,9 +239,9 @@ static void ad7887_reg_disable(void *data)
> >
> >  static int ad7887_probe(struct spi_device *spi)
> >  {
> > -     struct ad7887_platform_data *pdata = spi->dev.platform_data;
> >       struct ad7887_state *st;
> >       struct iio_dev *indio_dev;
> > +     bool dual_mode;
> >       uint8_t mode;
> >       int ret;
> >
> > @@ -286,7 +284,9 @@ static int ad7887_probe(struct spi_device *spi)
> >       mode = AD7887_PM_MODE4;
> >       if (!st->reg)
> >               mode |= AD7887_REF_DIS;
> > -     if (pdata && pdata->en_dual)
> > +
> > +     dual_mode = device_property_present(&spi->dev, "adi,dual-channel-mode");
> > +     if (dual_mode)
> >               mode |= AD7887_DUAL;
> >
> >       st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
> > @@ -298,7 +298,7 @@ static int ad7887_probe(struct spi_device *spi)
> >       spi_message_init(&st->msg[AD7887_CH0]);
> >       spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
> >
> > -     if (pdata && pdata->en_dual) {
> > +     if (dual_mode) {
> >               st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
> >
> >               st->xfer[1].rx_buf = &st->data[0];
> > diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
> > deleted file mode 100644
> > index 9b4dca6ae70b..000000000000
> > --- a/include/linux/platform_data/ad7887.h
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-or-later */
> > -/*
> > - * AD7887 SPI ADC driver
> > - *
> > - * Copyright 2010 Analog Devices Inc.
> > - */
> > -#ifndef IIO_ADC_AD7887_H_
> > -#define IIO_ADC_AD7887_H_
> > -
> > -/**
> > - * struct ad7887_platform_data - AD7887 ADC driver platform data
> > - * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
> > - *   second input channel, and Vref is internally connected to Vdd. If set to
> > - *   false the device is used in single channel mode and AIN1/Vref is used as
> > - *   VREF input.
> > - */
> > -struct ad7887_platform_data {
> > -     bool en_dual;
> > -};
> > -
> > -#endif /* IIO_ADC_AD7887_H_ */
>
