Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3A476A97
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 07:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhLPGrP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 01:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPGrO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 01:47:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1BC061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:47:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z6so18686320plk.6
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTit9p8NyKOvTsmw7vrWI4i/VrfsNvd4fgjmxOGm7Bw=;
        b=IpdU/X1fGrKgTQD+G+guDWrb0Hq78lenQ0uCWRyTjfRxHncHOY0uZ1C+ILvtwMxUb5
         /e4h0J1IPg3cpgTQC8L3v77G+w5kmFX8PzOc+JGf7+dDAZnqU3kG4fU4dq3UQ0g+sGjF
         WokRZuPr2u9+JfukaZomU7hzCJMOSZRSdunbvYOV5RZ/CE8mFzfiJ3ksoy9qz/NfWtKu
         1mZwYwiQ2uCWiveJB3DfRo5ut1oHASwE3ck2oMq+GnDPMBjgCA9AbLYmZhv+ArXpLmA0
         Daa/+a0JX3N9ZuCYiEV0ZD0nJdT7JglDF0F8fl6FpUb0tAosg+DNiZY47vpzg6W8ucI3
         gEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTit9p8NyKOvTsmw7vrWI4i/VrfsNvd4fgjmxOGm7Bw=;
        b=5GgG6U1ph88k7ftMZbkHBdFAjL1iE4UM5OPKfiRrU9K83X7pHvHQCtltYytnAYlXGV
         mfRqys8q21XoJCkQyVBzB0wlGZuNH4y/1I2wQhSyvZ0E2NodlZa8ze6Vehp6rvoSDaPC
         mY7iFEa+eZPFgtGEtDFhhYFhEe3Mx38Ixpj51wcKg5a5Uf2ZSgV3fHVUy0M/L/taDrXR
         lMmbRJCCvSaGwM5DdhqCcO2bz0Q+2HXvqmOvlBqSM6BHDdv/mZfMxeMF79qjaAfJ6qaf
         YBrDbZSq4z23EjZhjiXaEHq33PzZySUKLvxmXDupXdcO2h4j2nHUiEvoyxBIr3mVSbwY
         qGkg==
X-Gm-Message-State: AOAM530tG0U6NI+Ab9yWHA75VgKLokekj65gRkyh+zLcxArzV5EiWy7U
        rFC9drv7LZcRfRYlX4YPGAYHziQDxFwqn0qRKsE=
X-Google-Smtp-Source: ABdhPJygj5OcTn39vcEJLKeVLlMxpz7iYeBn04D6lbu0PMAIUV557iE4QFPx0PLrwxZmAL2qAtZWrvd4SjJdq6rY1SQ=
X-Received: by 2002:a17:90a:3d42:: with SMTP id o2mr4381412pjf.150.1639637233593;
 Wed, 15 Dec 2021 22:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-5-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-5-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 08:47:02 +0200
Message-ID: <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This is an internal variable of the core, let's use the
> iio_buffer_enabled() helper which is exported for the following purpose:
> telling if the current mode is a buffered mode, which is precisely what
> this driver looks for.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 1cfefb3b5e56..a3b8827d3bbf 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
>          * In continuous mode, use fast mode configuration,
>          * if it provides a better resolution.
>          */
> -       if (adc->nconv == 1 && !trig &&
> -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> +       if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {

This may become tricky if other modes get added later.
STM does a relatively good job in updating and re-using their drivers
(even if some of them do look quirky sometimes).

So, the question here would be: is "iio_buffer_enabled(indio_dev)"
going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
INDIO_BUFFER_HARDWARE get added?

I'd also ping some STM people for some feedback, acks or testing.

>                 if (fl->flo[1].res >= fl->flo[0].res) {
>                         fl->fast = 1;
>                         flo = &fl->flo[1];
> @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
>                 cr1 = DFSDM_CR1_RCH(chan->channel);
>
>                 /* Continuous conversions triggered by SPI clk in buffer mode */
> -               if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> +               if (iio_buffer_enabled(indio_dev))
>                         cr1 |= DFSDM_CR1_RCONT(1);
>
>                 cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
> --
> 2.27.0
>
