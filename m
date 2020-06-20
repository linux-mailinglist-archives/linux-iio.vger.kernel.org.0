Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54F202534
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFTQZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 12:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgFTQZH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 12:25:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3E123EB1;
        Sat, 20 Jun 2020 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592670306;
        bh=qUtSjUjPvNBnBbSWkg0Yoe4X48Rh2Xe4XKAQk/9Yb20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1wOnCfX4boWny47NBKBLzKJEcTciUV5bhq7YJ4ubdq8i+MMXSdIDfm7ggILXc+3Q
         bSUlvDwG0YXSOAfuXErlpt/WavbGDcQcwlR1Hjrx7NYocBP8ofxtPvnxcBgAb9DR2L
         yOeTvxNF4kenkhFZGmOUWvuUE3v10dcFG5yCs/6s=
Date:   Sat, 20 Jun 2020 17:25:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200620172502.0d532081@archlinux>
In-Reply-To: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
References: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 19:58:09 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Add Sensirion SCD30 carbon dioxide core driver.
> 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>

A few things I'd missed showed up in warnings when I applied this and
ran a sparse check.  Please fix up and send a v6.
Also sanity check the rest with sparse. Note if I'd missed this 0-day
would have sent use these warnings.

Thanks,

Jonathan

> +
> +static int scd30_read_meas(struct scd30_state *state)
> +{
> +	int i, ret;
> +
> +	ret = state->command(state, CMD_READ_MEAS, 0, state->meas, sizeof(state->meas));
> +	if (ret)
> +		return ret;
> +
> +	be32_to_cpu_array(state->meas, state->meas, ARRAY_SIZE(state->meas));

The type of the input to the above has the wrong endian markings.

CHECK   drivers/iio/chemical/scd30_core.c
drivers/iio/chemical/scd30_core.c:123:40: warning: incorrect type in argument 2 (different base types)
drivers/iio/chemical/scd30_core.c:123:40:    expected restricted __be32 const [usertype] *src
drivers/iio/chemical/scd30_core.c:123:40:    got int *

Whilst you could use a cast, it would be tidier to use an array of __be32.
 
> +
> +	for (i = 0; i < ARRAY_SIZE(state->meas); i++)
> +		state->meas[i] = scd30_float_to_fp(state->meas[i]);
> +
> +	/*
> +	 * co2 is left unprocessed while temperature and humidity are scaled
> +	 * to milli deg C and milli percent respectively.
> +	 */
> +	state->meas[SCD30_TEMP] *= 10;
> +	state->meas[SCD30_HR] *= 10;
> +
> +	return 0;
> +}
> +

...

> +
> +static irqreturn_t scd30_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct scd30_state *state = iio_priv(indio_dev);
> +	struct {
> +		int data[SCD30_MEAS_COUNT];
> +		s64 ts __aligned(8);
> +	} scan = { 0, };
should be scan = { {0, }, }; or something like that
as first element happens to be an array.

Actually there is padding in here you need to zero I think.
So memset is a better bet.

> +	int ret;
> +
> +	mutex_lock(&state->lock);
> +	if (!iio_trigger_using_own(indio_dev))
> +		ret = scd30_read_poll(state);
> +	else
> +		ret = scd30_read_meas(state);
> +	memcpy(scan.data, state->meas, sizeof(state->meas));
> +	mutex_unlock(&state->lock);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
...
