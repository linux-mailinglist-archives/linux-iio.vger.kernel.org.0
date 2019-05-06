Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61A15240
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEFRIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 13:08:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40454 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEFRIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2019 13:08:52 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so6017212ita.5;
        Mon, 06 May 2019 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+zAOIWhESqGIGUXIxvhr5jCceYW4d7dPv26f0+6ppZQ=;
        b=FwpGHEEaQHeypZ6YAHiRFR4DLy25S5IYuo/+PhOatl65HSuOM6neo4+oD42BsbKY22
         PE8q+knMcEXRiblfp+jUayBhft3AmqPSCfQnS/AFyPDC1LeScEfaZFiP/b8p23S9wnWQ
         XDEHt29RnBBjFp8AcFZHcV9JRDJnSr3A9mkzCHyKFApkZ+tbAPIIiEmyE6vPcRx6BTKy
         LMLmpwdRpxhCy7RJrSkJAwSSGrdJh6SbrUz7Y5uHlxJnD8WTxaq/sif7JEZSa/oyc/PS
         2pUgDlVyOafIoHUHqVIxTodpMM/BW9ZEf4Y0EDRgG6makqDW5vHA2eC6AL9CN07e0I8y
         aR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+zAOIWhESqGIGUXIxvhr5jCceYW4d7dPv26f0+6ppZQ=;
        b=nZw2vLhsyHvVTLpYTxMm5yxDJ1hEBsdved8q4qbarFq4iiH8cKVwtJN0BuU69ojuMl
         CPwFhNZd7YRiz7Joe+tHErpm0bYTuR93YOkDlaVODOo/Fq0zO/xCEEpXjbEPL5vjLzRC
         xeyIncA18Q19NsG2KGKbVUEM942JDe5cgp8dFSV8xr84H7yV/Mm5c8IldmzrLx/bq5Ri
         owkP+GWY5MyvCCOPCulmVMIjQXk9qEsA0No2lrJMaO5i8aZ2DVw/woBeaAnz1h2e13Uh
         KA+CpkwKe+J6mf0WQss0vmc2lmsbz7AoxaW6wZ5OliEV1UmuUpwg5psQkGdvWedNaMs8
         fD+Q==
X-Gm-Message-State: APjAAAUoF1psoLupfAWlzvARwyyQGB6Z4ZECOeED72sNTYGPxuobWe0A
        B7TUqV2eSxxYrUzGBOLSg/A8vaXpsZoX+9+ObKU=
X-Google-Smtp-Source: APXvYqwzdk3uznrvfpSXElhPh2UUfM29ZywDM63ZfmZvhTlO1uPQKUyZEirrHpdzDW34btdGM9Fpy+0MKV6HS6aBk6k=
X-Received: by 2002:a24:93c2:: with SMTP id y185mr18158143itd.95.1557162531449;
 Mon, 06 May 2019 10:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072813.2719-1-tiny.windzz@gmail.com> <20190503072813.2719-2-tiny.windzz@gmail.com>
 <20190505162215.3594f77d@archlinux> <20190506122807.4u323iys74jddcet@flea> <282ccf0979e6c58effd0e177917bdf824c32f64e.camel@aosc.io>
In-Reply-To: <282ccf0979e6c58effd0e177917bdf824c32f64e.camel@aosc.io>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 7 May 2019 01:08:39 +0800
Message-ID: <CAEExFWusPoxtkGCoA+3gXq69cXZEfjZW+UpHW_0UfrcjpLmaXg@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: adc: sun4i-gpadc: rework for support multiple
 thermal sensor
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        robh+dt@kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 7, 2019 at 12:52 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> =E5=9C=A8 2019-05-06=E4=B8=80=E7=9A=84 14:28 +0200=EF=BC=8CMaxime Ripard=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Sun, May 05, 2019 at 04:22:15PM +0100, Jonathan Cameron wrote:
> > > On Fri,  3 May 2019 03:28:07 -0400
> > > Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > > For some SOCs, there are more than one thermal sensor, and there
> > > > are
> > > > currently four sensors on the A80. So we need to do some work in
> > > > order
> > > > to support multiple thermal sensors:
> > > >
> > > >   1) add sensor_count in gpadc_data.
> > > >   2) introduce sun4i_sensor_tzd in sun4i_gpadc_iio, to support
> > > > multiple
> > > >      thermal_zone_device and distinguish between different
> > > > sensors.
> > > >   3) modify read temperature and initialization function.
> > >
> > > This comment doesn't mention the devm change. If it had it would
> > > have
> > > raised immediate alarm bells.
> > >
> > > I'm also not keen on the web of pointers that this driver is
> > > steadily
> > > evolving.  I can't immediately see how to reduce that complexity
> > > however.
> >
> > So I might be responsible for that, and looking back, this has been a
> > mistake.
> >
> > This driver was initally put together to support a controller found
> > in
> > older (A10 up to A31) Allwinner SoCs. This controller had an ADC
> > driver that could be operated as a touchscreen controller, and was
> > providing a CPU temperature sensor and a general purpose ADC.
> >
> > However, we already had a driver for that controller in drivers/input
> > to report the CPU temperature, and the one in IIO was introduced to
> > support the general purpose ADC (and the CPU temperature). The long
> > term goal was to add the touchscreen feature as well eventually so
> > that we could remove the one in drivers/input. That didn't happen.
> >
> > At the same time, the Allwinner hardware slowly evolved to remove the
> > touchscreen and ADC features, and only keep the CPU temperature
> > readout. It then evolved further on to support multiple temperatures
> > (for different clusters, the GPU, and so on).
> >
> > So, today, we're in a situation where I was pushing everything into
> > that IIO drivers since there was similiraties between all the
> > generations, but the fact that we have to support so many odd cases
> > (DT bindings compatibility, controllers with and without ADC, etc)
> > that it becomes a real mess.
> >
> > And that mess isn't really used by anybody, since we want to have the
> > touchscreen.
> >
> > There's only one SoC that is supported only by that driver, which is
> > the A33 that only had a CPU temperature readout, and is still pretty
> > similar to the latest SoC from Allwinner (that is supported by this
> > series).
> >
> > I guess, for everyone's sanity and in order to not stall this
> > further,
> > it would just be better to create an hwmon driver for the A33 (and
> > onwards, including the H6) for the SoC that just have the temperature
> > readout feature. And for the older SoC, we just keep the older driver
> > under input/. Once the A33 is supported, we'll remove the driver in
> > IIO (and the related bits in drivers/mfd).

a hwmon driver or a thermal driver=EF=BC=9F

>
> I think a thermal driver is better.

This is what I hope to see a few months ago.

>
> Other SoCs' thermal sensor drivers are all thermal drivers.
>
> >
> > Armbian already has a driver for that they never upstreamed iirc, so
> > it might be a good starting point, and we would add the support for
> > the H6. How does that sound?
>
> I think the developer abandoned to upstream it because of the previous
> problem ;-)
>
> Maybe it can be taken and add A33&H6 support.

If OK, I am going to start some thermal driver work this weekend.  : )

Cheers,
Yangtao

>
> >
> > Sorry for wasting everybody's time on this.
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
