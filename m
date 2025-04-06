Return-Path: <linux-iio+bounces-17679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C8A7CEC0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4C23ADE09
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557B22068F;
	Sun,  6 Apr 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6x0zoLL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7C4A24;
	Sun,  6 Apr 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953959; cv=none; b=jvx2su/9HO/hDqFe/lSP0fAJtjZj08IZ8cWh0dko+aJwfTjlMY2NnuOMmsEp/2bwOy+wE7YBD4bNPflPYO6IuwqkuRiezOYFSz5zHIG+oEe1hMwevy9zMwRJC98Ewsk5c5UFijkeRb7VwXN5Jb1YrkFgPQzikRnJy3PNcZ6JHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953959; c=relaxed/simple;
	bh=qaTOlHXyrdaLUQyAB5aniUKDe97RBKP8b4s4Rj2LP0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqcx9opqq9IeHXzSuCHAA7/EnAdC2H2Z0KcYDin26pFkd4qoQrNrbZfyQhLMdVemSNV1hvhhmqEoAq20+ClcHF7guSYIh1iYpDLxZDEx9GcpKeOlvPaEpmgOZOyHGvOI/CXkBeSJEdonKRiNPu4syNJdutTsyUfEsYANRRTVREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6x0zoLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06313C4CEE3;
	Sun,  6 Apr 2025 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743953959;
	bh=qaTOlHXyrdaLUQyAB5aniUKDe97RBKP8b4s4Rj2LP0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k6x0zoLL7w0SD5juotegtP/HV3nuIw5RxjN92SiUWB95pTvYUqM3jSni1tsDfwJIi
	 tn3Jjzw5T5vJWtylrFl36e4/ipW5X646wbe9CwtylNF28qx9Q5SlHc6h+ngY/HgGwt
	 pPbo4W4DLEEdcEzybdNt6Vjp3wWBpjMP/wfTZkXYl8qfMYSWe5IxGeeBgOkVWtwWa4
	 HYbHSd/Xm14mKOVrOOWuUijU2q7eTfp6jM+43VHpjj2GYssIQhDI2nypwPqcD5T1Xw
	 2mHfilGDgKNuzM4h61LIF6PNqgTCXwUnw05Qf+apIhthh+2VF/ZDDqvJBNqMwYmiTH
	 RDO7NKuj1LkYg==
Date: Sun, 6 Apr 2025 16:39:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v1 1/1] iio: dummy: Add 3-axis compass (magnetometer)
 channels to the iio_simple_dummy
Message-ID: <20250406163913.6a7234fb@jic23-huawei>
In-Reply-To: <20250406133349.50633-1-brajeshpatil11@gmail.com>
References: <20250406133349.50633-1-brajeshpatil11@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Apr 2025 19:03:49 +0530
Brajesh Patil <brajeshpatil11@gmail.com> wrote:

> This patch adds support for 3-axis magnetometer data (X, Y, Z) in the
> iio_simple_dummy driver. It introduces three new IIO_MAGN channels and
> populates them with dummy values for testing and prototyping purposes.

Why?  This needs a description of what parts of the ABI or subsystem this
exercises that were not previously covered by this driver.

I don't want to go down the path of adding examples for all channel types as
that would be a huge and not bring much benefit.

> 
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 71 +++++++++++++++++++++++++++-
>  drivers/iio/dummy/iio_simple_dummy.h |  6 +++
>  2 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index 8575d4a08..713b764c9 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -222,7 +222,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>          * Convenience macro for timestamps. 4 is the index in
>          * the buffer.
>          */
> -       IIO_CHAN_SOFT_TIMESTAMP(4),
> +	IIO_CHAN_SOFT_TIMESTAMP(DUMMY_INDEX_SOFT_TIMESTAMP),
>         /* DAC channel out_voltage0_raw */
>         {
>                 .type = IIO_VOLTAGE,
> @@ -265,6 +265,48 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>                 .num_event_specs = 1,
>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
>         },
> +	{
> +		.type = IIO_MAGN,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = DUMMY_MAGN_X,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,

shift = 0 is considered an obvious default so generally we don't bother
setting it explicitly (it is set by the requirements of the C spec anyway)/

> +		},
> +	},
> +	{
> +		.type = IIO_MAGN,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = DUMMY_MAGN_Y,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
> +		},
> +	},
> +	{
> +		.type = IIO_MAGN,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = DUMMY_MAGN_Z,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
> +		},
> +	},
>  };
>  
>  static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
> @@ -294,6 +336,22 @@ static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
>         case IIO_ACCEL:
>                 *val = st->accel_val;
>                 return IIO_VAL_INT;
> +	case IIO_MAGN:
> +		switch (chan->scan_index) {
> +		case DUMMY_MAGN_X:
> +			*val = st->buffer_compass[0];
> +			break;
> +		case DUMMY_MAGN_Y:
> +			*val = st->buffer_compass[1];
> +			break;
> +		case DUMMY_MAGN_Z:
> +			*val = st->buffer_compass[2];
> +			break;
> +		default:
> +			*val = 99;
> +			break;
> +		}
> +		return IIO_VAL_INT;
>         default:
>                 return -EINVAL;
>         }
> @@ -378,6 +436,11 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
>                         default:
>                                 return -EINVAL;
>                         }
> +		case IIO_MAGN:
> +			// Just add some dummy values
Comment syntax is old style /* Add some dummy values */ for
most kernel code (and all IIO other than SPDX tags in cases where // must
be used).

> +			*val = 0;
> +			*val2 = 2;
> +			return IIO_VAL_INT_PLUS_MICRO;
>                 default:
>                         return -EINVAL;
>                 }
> @@ -562,6 +625,10 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
>         st->activity_running = 98;
>         st->activity_walking = 4;

Something odd going on in email formatting here as your quoted lines are using
spaces not tabs.

>  
> +	st->buffer_compass[0] = 78;
> +	st->buffer_compass[1] = 10;
> +	st->buffer_compass[2] = 3;
> +
>         return 0;
>  }
>  
> @@ -732,5 +799,5 @@ static struct iio_sw_device_type iio_dummy_device = {
>  module_iio_sw_device_driver(iio_dummy_device);
>  
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> -MODULE_DESCRIPTION("IIO dummy driver");
> +MODULE_DESCRIPTION("IIO dummy driver -> IIO dummy modified by Me");
Accidental send?

>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
> index 8246f25db..e05d8b5cc 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.h
> +++ b/drivers/iio/dummy/iio_simple_dummy.h
> @@ -12,6 +12,7 @@
>  struct iio_dummy_accel_calibscale;
>  struct iio_dummy_regs;
>  
> +#define DUMMY_AXIS_XYZ 3
>  /**
>   * struct iio_dummy_state - device instance specific state.
>   * @dac_val:                   cache for dac value
> @@ -39,6 +40,7 @@ struct iio_dummy_state {
>         int steps_enabled;
>         int steps;
>         int height;
> +	u16 buffer_compass[DUMMY_AXIS_XYZ];
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
>         int event_irq;
>         int event_val;
> @@ -107,6 +109,10 @@ enum iio_simple_dummy_scan_elements {
>         DUMMY_INDEX_DIFFVOLTAGE_1M2,
>         DUMMY_INDEX_DIFFVOLTAGE_3M4,
>         DUMMY_INDEX_ACCELX,
> +	DUMMY_INDEX_SOFT_TIMESTAMP,
Look at why we have timestamps at the end...
(start with iio_push_to_buffers_with_timestamp)

Jonathan

> +	DUMMY_MAGN_X,
> +	DUMMY_MAGN_Y,
> +	DUMMY_MAGN_Z,
>  };
>  
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER


