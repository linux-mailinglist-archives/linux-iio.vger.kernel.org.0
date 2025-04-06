Return-Path: <linux-iio+bounces-17672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8746A7CE29
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAF8188DAA6
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032A21883F;
	Sun,  6 Apr 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BBnYUunA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A91B6D11;
	Sun,  6 Apr 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743946873; cv=none; b=ajc7vPjTPzDmKbFUSCA12m8ZEFR3sLnVyRkHfoa0KoutFLcxKCyFY1xXeWPKAX5v46fo2uTGVyk+PIJl0kM96qlF/n5iya65Xczs1fYsPeXp9b4/LtDG6mFErK3Ls3YtRHZ8CJy1kFDjHExxdZo36k2tTVejRsVECMdtRTpjfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743946873; c=relaxed/simple;
	bh=n3PsmVxpGTJjdiSGMa7V3sbREy1N5myca5jeVf7zXKI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dDPq9PI/SFBCoVN5r1y4tCIHZPvrrpumYeeylRcIUU+xniIT+HfU+C9j1I3MKLL+ouz632F7uTVLv2n/wKlJQRIGXt3o6+GqFlh3TAp312urHkQq5XsXJjXrOlp4zXkoJvZZ2TjkEW7x4WcvoqBstu7mKISne5Jjei2xQ96j7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BBnYUunA; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Si/cVsUGXvzDhtSduZmcG+FZ4Sb8W8QmPh9TxHY2CC4=;
  b=BBnYUunAJ1VZd7AQ5tlrxe0wz5H+gPTLAyjLnMeGm4iLmZkM2Cvm1P5p
   nLb7chfKJ0EHqdRQa7OI0pIRnun5v8FnJHUAq5Krx9EFM1dPBfpmEx9pb
   9i4GoldWfVFlN5qg3eOKE+zMteAtmlJLw+gAj70YmGZ4kZjSTBo8Sd/mo
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="113563630"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 15:41:07 +0200
Date: Sun, 6 Apr 2025 09:41:06 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Brajesh Patil <brajeshpatil11@gmail.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
    linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v1 1/1] iio: dummy: Add 3-axis compass (magnetometer)
 channels to the iio_simple_dummy
In-Reply-To: <20250406133349.50633-1-brajeshpatil11@gmail.com>
Message-ID: <99c44d74-1b8a-939c-d775-e41f8034ceb@inria.fr>
References: <20250406133349.50633-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 6 Apr 2025, Brajesh Patil wrote:

> This patch adds support for 3-axis magnetometer data (X, Y, Z) in the
> iio_simple_dummy driver. It introduces three new IIO_MAGN channels and
> populates them with dummy values for testing and prototyping purposes.

Is this intended as a contribution for outreachy?  It is not working on a
staging driver.

julia

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
> +			*val = 0;
> +			*val2 = 2;
> +			return IIO_VAL_INT_PLUS_MICRO;
>                 default:
>                         return -EINVAL;
>                 }
> @@ -562,6 +625,10 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
>         st->activity_running = 98;
>         st->activity_walking = 4;
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
> +	DUMMY_MAGN_X,
> +	DUMMY_MAGN_Y,
> +	DUMMY_MAGN_Z,
>  };
>
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
> --
> 2.43.0
>
>

