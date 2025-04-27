Return-Path: <linux-iio+bounces-18730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCAA9E310
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8421D17287F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4421C32;
	Sun, 27 Apr 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN5UBQxj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175358F6F;
	Sun, 27 Apr 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758087; cv=none; b=p07i12VIO6VYF4VOqFDGLVCDvOVYEOjzpL5+EmEFf5ACEoMSn2rVIhAbBEdW0kHHmX+0k2Am1dhA11D29ePkhKYOHXOq8LsiCT4+h6D8OcN7gn1ixUPkaf5q/NfE/pvEJDYN8U/d4qNzp/6H1YjbPo3rX9JymxzA51dOFynSCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758087; c=relaxed/simple;
	bh=bIlIidDsO0xowRdSDo3kE2LeX1gP7EwYmaZfZJK5Ffo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuYl4NgkJbW6rDpOFY3UFdYhyFUTMAIqccZ39sBKXOUUI5OGXGIGuHmZ0N0arb4BWk0uxI522CnZsAQnXODOwTwC35ptwbrAsXAOAKijgRc2pm8pTTwYNIblyhipfq7uxYH8p7a4zUrx5eFAs0AKmgtLkxw0u9zCbk+GiPWI2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN5UBQxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2415BC4CEE3;
	Sun, 27 Apr 2025 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745758086;
	bh=bIlIidDsO0xowRdSDo3kE2LeX1gP7EwYmaZfZJK5Ffo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kN5UBQxjG+NipQ7Rv4QzVIxiO8FKFCvB7Ga74sN0BReIeSkD3B5dB2r9pMqpLPCtM
	 Zm8fzpkEZfenH5oQzGqeN1F9ndak2osCzFQbING0L2tFuQt23H4yiT19lwkLtscu27
	 fODmXwWKwqQ+236RoEGZZl8xKJgBA90xngSPFLchkeW/9k/1yixgUmJtKPoBKdOAQ3
	 SkJwhP74QRQj1cM21mBhUcJp/o+KPY+Bxr8g10NSF8ZnrNjKMcCYHYpsyEcJBk0kcc
	 a5Av9O1Mu+TflAd+Wxe+Ro9yU6BaBR3ZPeaRkgjNNLdUzgG51XcUqrBVNGzh3ZHSFn
	 2djynBq2THb9A==
Date: Sun, 27 Apr 2025 13:47:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250427134759.3cc3a2a4@jic23-huawei>
In-Reply-To: <20250421220641.105567-9-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold stored in regmap cache. Initialize
> the activity threshold register to a reasonable default value in probe.
> The value is taken from the older ADXL345 input driver, to provide a
> similar behavior. Reset the activity/inactivity direction enabling
> register in probe. Reset and initialization shall bring the sensor in a
> defined initial state to prevent dangling settings when warm restarting
> the sensor.
> 
> Activity, ODR configuration together with the range setting prepare the
> activity/inactivity hystersesis setup, implemented in a follow up patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 217 ++++++++++++++++++++++++++++++-
>  1 file changed, 214 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 80b5b8402ced..680981609d83 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -36,11 +36,16 @@
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
> +#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
>  
>  #define ADXL345_TAP_Z_EN		BIT(0)
>  #define ADXL345_TAP_Y_EN		BIT(1)
>  #define ADXL345_TAP_X_EN		BIT(2)
>  
> +#define ADXL345_ACT_Z_EN		BIT(4)
> +#define ADXL345_ACT_Y_EN		BIT(5)
> +#define ADXL345_ACT_X_EN		BIT(6)
> +
>  /* single/double tap */
>  enum adxl345_tap_type {
>  	ADXL345_SINGLE_TAP,
> @@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time_reg[] = {
>  	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
>  };
>  
> +/* activity/inactivity */
> +enum adxl345_activity_type {
> +	ADXL345_ACTIVITY,
> +};
> +
> +static const unsigned int adxl345_act_int_reg[] = {
> +	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
> +};
> +
> +static const unsigned int adxl345_act_thresh_reg[] = {
> +	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
> +};
> +
>  enum adxl345_odr {
>  	ADXL345_ODR_0P10HZ = 0,
>  	ADXL345_ODR_0P20HZ,
> @@ -154,6 +172,13 @@ struct adxl345_state {
>  };
>  
>  static struct iio_event_spec adxl345_events[] = {
> +	{
> +		/* activity */
> +		.type = IIO_EV_TYPE_THRESH,

Is this a threshold, or a magnitude? I'd expect an activity detector
to be magnitude as it doesn't care which way up the sensor is.

> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
>  	{
>  		/* single tap */
>  		.type = IIO_EV_TYPE_GESTURE,
> @@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>
Jonathan



