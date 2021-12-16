Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD4476A7B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhLPGkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 01:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLPGkY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 01:40:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69264C061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:40:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q17so18645583plr.11
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6quenzJDNisOLjwu8WkmVBNYqVTDVcAhk1dCARKhq2M=;
        b=KFZ30PPlycFxWAXzJBinjRre2kt7mziGSbff6pVIOdckwkaTk1leAqSX9zQdwcCq+f
         8lKqVmRaMyV1wOF+Nk5RE4a5Zp0qak8KEY41vsT9/8HAfNa8fk+c9UqpS9mzrGS/oFAH
         l2tGNbMpXYBw155tp8KyVPBviBoR0UYS+yRWP8OABtUC0k0tuGPnk1N/H5/is02RL7ze
         DwFYRD0qGp9DvE+sM/KOdUtOKbIQ6kKnqiOLWFXs66UsVXQvM0sfymOolELRauI2BqXY
         FHEtGhA49gbksfua/kUXUWwFnyrYaxNjosf7Px9luY+SSrk1fhBH9EHtQXoapOnRBsZc
         acMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6quenzJDNisOLjwu8WkmVBNYqVTDVcAhk1dCARKhq2M=;
        b=BsY6oHwx2kfLxb9gSS8fFIXQq43Zl63xzDg4wQw8zndA13ceOOXKohKNc9JFqgMMls
         AuI18/bjqdOXumfZ8HvVsvqJ2hpEgIJObqAV/qYxlbd3pvwSDZHG57lXOHkhoBhUQwum
         EsWpnm1Fg+KJQqztLs/MEy8qTLN0ezIzL4z9p3gA3bXnaRzpC2LQw5lkKSXgHvMPxUIn
         PrnHkPMcYSEN8tZT5t9TA/WVUW9DBbRbEhs+waOi0PZ9mvwXliRA5xxH3D5Tq3R6u6yw
         SvbHIhyQLsLYO2C0/banMYlD4xP+klPG0vFSGgCrCSyr797lDHLXWJK7Jk1nRphK7Kx5
         Q81A==
X-Gm-Message-State: AOAM532GvsqIzp/0mW+2aPoWbahmYRV4VSimGE1hufSE4XIzWpiwV5U7
        MM1d8ZMNGEKKIK6Cg3ME999kJ5OFQ5q39hE09SI=
X-Google-Smtp-Source: ABdhPJyaOn/LKM/LUAwXhjCpqL5VtZr4yaQrDdyxu7o0/iBnQ5xs8udm4YTybsISPVLS2VH4sGWD+wzL5CZ+dAEjRwk=
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr4274243pjb.81.1639636823835;
 Wed, 15 Dec 2021 22:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-4-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-4-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 08:40:12 +0200
Message-ID: <CA+U=DsrSBP4pd24jSjHg-F5ifQLjkmBPt6VJHDrr1c1f93s5_A@mail.gmail.com>
Subject: Re: [PATCH 03/10] iio: magnetometer: rm3100: Stop abusing the ->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This is an internal variable for the core, here it is set to a "default"
> value by the driver in order to later be able to perform checks against
> it. None of this is needed because this check actually cares about the
> buffers being enabled or not. So it is an unproper side-channel access
> to the information "are the buffers enabled?", returned officially by
> the iio_buffer_enabled() helper. Use this helper instead.

A few comments inline.

>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/magnetometer/rm3100-core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 13914273c999..be0057f82218 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -141,18 +141,10 @@ static irqreturn_t rm3100_irq_handler(int irq, void *d)
>         struct iio_dev *indio_dev = d;
>         struct rm3100_data *data = iio_priv(indio_dev);
>
> -       switch (indio_dev->currentmode) {
> -       case INDIO_DIRECT_MODE:
> +       if (!iio_buffer_enabled(indio_dev))
>                 complete(&data->measuring_done);
> -               break;
> -       case INDIO_BUFFER_TRIGGERED:

This is one of those semantic changes that looks correct, but may end
up getting comments that it should be validated by someone with
hardware [and for good reason].
Especially in places like Ref1 (below).

But I guess the iio_get_internal_mode() helper could still be used.
I guess I'd wait for more opinions on this.

> +       else
>                 iio_trigger_poll(data->drdy_trig);
> -               break;
> -       default:
> -               dev_err(indio_dev->dev.parent,
> -                       "device mode out of control, current mode: %d",
> -                       indio_dev->currentmode);
> -       }
>
>         return IRQ_WAKE_THREAD;
>  }
> @@ -377,7 +369,7 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
>                         goto unlock_return;
>         }
>
> -       if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {

Ref1

> +       if (iio_buffer_enabled(indio_dev)) {
>                 /* Writing TMRC registers requires CMM reset. */
>                 ret = regmap_write(regmap, RM3100_REG_CMM, 0);
>                 if (ret < 0)
> @@ -553,7 +545,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>         indio_dev->channels = rm3100_channels;
>         indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
>         indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> -       indio_dev->currentmode = INDIO_DIRECT_MODE;

This is fine :)

>
>         if (!irq)
>                 data->use_interrupt = false;
> --
> 2.27.0
>
