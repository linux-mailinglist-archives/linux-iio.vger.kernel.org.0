Return-Path: <linux-iio+bounces-22114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D82B141E3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C67A3E8A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E5274B49;
	Mon, 28 Jul 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHLw2V5E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73A21CC57;
	Mon, 28 Jul 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726869; cv=none; b=eCp7/kTLKq/B6LEbjBULo+9DqWMlVMGJQEXlLBB5BJ4W2AVBAes7uUj/NoIrb2L5DsrZfelEKdO0RtBnpHcd18u13ksmBTXMQhDgqPWhTs9+SoyIl6J4InIbTAKClLZQCmHIFYLlbjQzXC0uzbap2q+Ab5mKXwmDbdNrMwiqKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726869; c=relaxed/simple;
	bh=YrJErAqAd99EVteUDsatVIYlqWGi+7h8QxiGNhc7PU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtPuW9RPtMw1R2ngZbtjCsA4+wMnvsRBBqvjI71+ESkuERekAphFTxJ2S6+9Y8qfk5Qpfp5UPfNSZBmSq9+HJLnPdXPJTvcu5WCr0xoxRHA91tnfrFBilRc+tEwH861p3qFIuOaPzvbgzm/RiNmoBE80Se2oVoNAuQd2w01Ujg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHLw2V5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6D3C4CEE7;
	Mon, 28 Jul 2025 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753726869;
	bh=YrJErAqAd99EVteUDsatVIYlqWGi+7h8QxiGNhc7PU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHLw2V5EXCoP5wIvcOp10KiCUYS04lFHr+OPksGht/xA6N7tJUyqlZhBENH3YUggA
	 xFUYNBVmRKn2NPsEoZieZg+HhIzLooRpq4vwWwA1bU4srmQpL8lFnSrV3hssL9LLv5
	 CD+AynriGw8BLdQTqSsH5DFAxyUzLUVPD9e+CH62c8MMoG36IErlCYLNbKRJDgrM37
	 o0TZ5HtpC2jyrPEeswZEZtYSrbgxvQOsqKrU15TLKQb2i0ujUIpI/MCk+zTOnHFr6u
	 0kTHVyG0cMtM0dFRxQIwzY0BQmAcOc6lCXzRKGZr6x5hNUNo2Sb1Udbjn0T2eR8rU2
	 xYBAwUAZd1w4g==
Date: Mon, 28 Jul 2025 19:20:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, arthur.becker@sentec.com,
 perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
 muditsharma.info@gmail.com, clamor95@gmail.com, emil.gedenryd@axis.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <20250728192058.4da2f857@jic23-huawei>
In-Reply-To: <20250728075447.338725-3-ak@it-klinger.de>
References: <20250728075447.338725-1-ak@it-klinger.de>
	<20250728075447.338725-3-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 09:54:45 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Hi Andreas

A few things inline, but they are all the sort of thing I'll just tweak
whilst applying, if nothing else comes up. Saves time for both of us!

Given Andy has been active in reviewing earlier versions I'll leave this
for a little while.  If Andy is otherwise happy (or busy!) then I'll pick
this up and tweak some or maybe all of the things commented on

Thanks,

Jonathan

> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 8229ebe6edc4..c0048e0d5ca8 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
>  obj-$(CONFIG_VEML3235)		+= veml3235.o
>  obj-$(CONFIG_VEML6030)		+= veml6030.o
>  obj-$(CONFIG_VEML6040)		+= veml6040.o
> +obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
>  obj-$(CONFIG_VEML6070)		+= veml6070.o
>  obj-$(CONFIG_VEML6075)		+= veml6075.o
>  obj-$(CONFIG_VL6180)		+= vl6180.o
> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
> new file mode 100644
> index 000000000000..adcb849b1c1f
> --- /dev/null
> +++ b/drivers/iio/light/veml6046x00.c

> +static int veml6046x00_get_val_gain_idx(struct veml6046x00_data *data, int val,
> +					int val2)
> +{
> +	unsigned int i;
> +	int it_idx;
> +
> +	it_idx = veml6046x00_get_it_index(data);
> +	if (it_idx < 0)
> +		return it_idx;
> +
> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_it_gains[it_idx]); i++) {
> +		if ((veml6046x00_it_gains[it_idx][i][0] == val) &&
> +		    (veml6046x00_it_gains[it_idx][i][1] == val2)) {
> +			return i;

As below.

> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int veml6046x00_get_gain_idx(struct veml6046x00_data *data)
> +{
> +	int ret;
> +	unsigned int i, reg, reg_gain, reg_pd;
> +
> +	ret = regmap_read(data->regmap, VEML6046X00_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg_gain = FIELD_GET(VEML6046X00_CONF1_GAIN, reg);
> +	reg_pd = reg & VEML6046X00_CONF1_PD_D2;
> +
> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_gain_pd); i++) {
> +		if ((veml6046x00_gain_pd[i].gain_sen == reg_gain) &&
> +		    (veml6046x00_gain_pd[i].pd == reg_pd)) {
> +			return i;

Technically style is no {} for this as only a single statement.
I can see why you did this given the more complex condition, but
I think the difference in indent is still enough to not need it. 

> +		}
> +	}
> +
> +	return -EINVAL;
> +}

> +static irqreturn_t veml6046x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret;
> +	struct {
> +		__le16 chans[4];
> +		aligned_s64 timestamp;
> +	} scan;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_R,
> +			       &scan.chans, sizeof(scan.chans));
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, iio_get_time_ns(iio));

If we spin again, preference for
	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan),
				    iio_get_time_ns(iio));

If not I might tweak whilst applying or might just leave this to get
swept up in a future series moving to that safer interface.

Jonathan


