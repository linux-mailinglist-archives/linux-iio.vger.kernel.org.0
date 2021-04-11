Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8858935B5BC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhDKOyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 10:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233822AbhDKOyP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 10:54:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78AFD60FF1;
        Sun, 11 Apr 2021 14:53:56 +0000 (UTC)
Date:   Sun, 11 Apr 2021 15:54:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, devicetree@vger.kernel.org,
        knaack.h@gmx.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v4 2/2] iio: temperature: add driver support for ti
 tmp117
Message-ID: <20210411155420.318e866e@jic23-huawei>
In-Reply-To: <20210407182147.77221-3-puranjay12@gmail.com>
References: <20210407182147.77221-1-puranjay12@gmail.com>
        <20210407182147.77221-3-puranjay12@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  7 Apr 2021 23:51:47 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> TMP117 is a Digital temperature sensor with integrated Non-Volatile memory.
> Add support for tmp117 driver in iio subsystem.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmp117
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

A few really small things in here that I tidied up whilst applying and
running local build tests.

Note that as IIO is effectively closed for the coming merge window,
I'm queuing this up for the next cycle and it will be in linux-next
after the merge window closes in about 3 weeks time.

Thanks,

Jonathan


> +static int tmp117_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int *val,
> +		int *val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						TMP117_REG_TEMP);
> +		if (ret < 0)
> +			return ret;
> +		*val = sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +					TMP117_REG_TEMP_OFFSET);
> +		if (ret < 0)
> +			return ret;
> +		*val = sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Conversion from 10s of uC to mC
Totally trivial so I'll fix it whilst applying, but comment convention used
in IIO is

/*
 * Conversion

> +		 * as IIO reports temperature in mC
> +		 */
> +		*val = TMP117_RESOLUTION_10UC / MICRODEGREE_PER_10MILLIDEGREE;
> +		*val2 = (TMP117_RESOLUTION_10UC %
> +					MICRODEGREE_PER_10MILLIDEGREE) * 100;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tmp117_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *channel, int val,
> +		int val2, long mask)
> +{
> +	struct tmp117_data *data = iio_priv(indio_dev);
> +	s16 off;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		off = clamp(val, S16_MIN, S16_MAX);

With a C=1 W=1 build (sparse an lots of warnings) this causes problems because
the S16_MIN and S16_MAX are as you might imagine s16 values whereas val is
an int.  I've added casts to force S16_MIN and S16_MAX to ints as well.

> +		if (off == data->calibbias)
> +			return 0;
> +		data->calibbias = off;
> +		return i2c_smbus_write_word_swapped(data->client,
> +						TMP117_REG_TEMP_OFFSET, off);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
...
