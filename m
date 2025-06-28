Return-Path: <linux-iio+bounces-21072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56AAEC95A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EE7189B798
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E641E26528B;
	Sat, 28 Jun 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCSbjjuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE31130A54;
	Sat, 28 Jun 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131639; cv=none; b=Z3Bhvl9DP8bT4TClPoF+Nq5YEynX/+HI+2MhTXhNi1Wwq2+UfSf2SlSlDPpMmJThXWeOjMi0xe+v70f2g6R7nmU1pUp3i+yVnEJ3R+Zzytis2dzTQsqKGzysrREprUCwCe3RykXrawTNqBhw6Js3mk+NlhpV+TjsrEvNgLglGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131639; c=relaxed/simple;
	bh=yFYIVKNfhxqlBRE+8L7T2Wy0v7toZHFWi37nevTIpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQjuGXkTShnR8WSf7YsQ6NiXyiGfdt5g/uHZJdlMy+ibgwJcyf3ZtQNig1GUKzzFFhz7LOFdyLq7B2GD7So6UnL5vMY7Z/04gTnRHtB4G/QavnU/PU8ArEpIa3yOqbhB+khvrPUg9VCVXGAzQ7BpT1bO9lEZ+hOreyqeSEFcOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCSbjjuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01187C4CEEA;
	Sat, 28 Jun 2025 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131639;
	bh=yFYIVKNfhxqlBRE+8L7T2Wy0v7toZHFWi37nevTIpSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCSbjjuSYcBmCRTlqlJtSQ5wh/0x8KvPQNjrpPd0JD/AF8qpFTU92E7Jv4NgE4CtM
	 LhZ3ScxUi2U9k5YAbVE2Yj6kjaCACoBF8paAQkukJC2fhORJKExX6NDjI/i1WaxUxw
	 6ukaZWawVUzJR9zlKAbRfU69yH2m/d6PbFroM6H4uoIs/KUlM90frNvNtPocMb57lw
	 2dpHhpzIZjaLLbj279Dmp740LonucFenwO/5LNBjJFK6QVZlyWUNqHhYrhykQgL/0Q
	 6aUUjHcL+rBECg9/wlZCGt1+kPQ9YZ9yMAVmNYuLlQsH0dOWKvT44Wh7JB3aP2WYHK
	 nX6gJzxYU7dUw==
Date: Sat, 28 Jun 2025 18:27:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] iio: accel: adxl313: add activity sensing
Message-ID: <20250628182706.2af83c1c@jic23-huawei>
In-Reply-To: <20250622122937.156930-5-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
	<20250622122937.156930-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 12:29:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add support for configuring an activity detection threshold. Extend the
> interrupt handler to process activity-related interrupts, and provide
> functions to set the threshold as well as to enable or disable activity
> sensing. Additionally, introduce a virtual channel that represents the
> logical AND of the x, y, and z axes in the IIO channel.
> 
> This patch serves as a preparatory step; some definitions and functions
> introduced here are intended to be extended later to support inactivity
> detection.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar.

I think this is suffering from function naming evolution and we need
to rethink (slightly) what we ended up with.  See inline.
I walked into the same trap recently so was on the look out for it.

> ---
>  drivers/iio/accel/adxl313_core.c | 326 +++++++++++++++++++++++++++++++
>  1 file changed, 326 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index ac4cc16399fc..d2c625f27555 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -13,8 +13,10 @@

> +
> +static int _adxl313_read_mag_value(struct adxl313_data *data,
> +				   enum iio_event_direction dir,
> +				   enum adxl313_activity_type type_act,
> +				   int *val, int *val2)
> +{
> +	unsigned int threshold;
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = regmap_read(data->regmap,
> +				  adxl313_act_thresh_reg[type_act],
> +				  &threshold);
> +		if (ret)
> +			return ret;
> +		*val = threshold * 15625;
> +		*val2 = MICRO;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int _adxl313_write_mag_value(struct adxl313_data *data,
> +				    enum iio_event_direction dir,
> +				    enum adxl313_activity_type type_act,
> +				    int val, int val2)
> +{
> +	unsigned int regval;
> +
> +	/* Scale factor 15.625 mg/LSB */
> +	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return regmap_write(data->regmap,
> +				    adxl313_act_thresh_reg[type_act],
> +				    regval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_read_mag_value(struct adxl313_data *data,
> +				  enum iio_event_direction dir,
> +				  enum iio_event_info info,
> +				  enum adxl313_activity_type type_act,
> +				  int *val, int *val2)
> +{
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		return _adxl313_read_mag_value(data, dir,

Same issue as below for read functions.

> +					       type_act,
> +					       val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_write_mag_value(struct adxl313_data *data,

This has me a little confused. It's called
adxl313_write_mag_value() which seems pretty specific but
then calls another level of _adxl313_write_mag_value.

In the next patch (assuming diff isn't leading me astray) we have

@@ -600,13 +687,17 @@ static int adxl313_write_mag_value(struct adxl313_data *data,
 				   enum iio_event_direction dir,
 				   enum iio_event_info info,
 				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact,
 				   int val, int val2)
 {
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return _adxl313_write_mag_value(data, dir,
 						type_act,
+						type_inact,
 						val, val2);
+	case IIO_EV_INFO_PERIOD:
+		return adxl313_set_inact_time_s(data, val);
 	default:
 		return -EINVAL;
 	}


Which is adding PERIOD to something called write_mag_value()

Whilst I can see why you ended up with naming as:

adxl313_write_mag_value() as the magnitude event specific part of
adxl13_event_write_value()

and indeed

_adxl313_write_mag_value() as the thing that writes IIO_EV_INFO_VALUE
value (i.e. the threshold) for the magnitude events.

Last time I hit a similar naming stack, I spinkled in some _info

So have the inner one called something slightly more specific like

adxl313_write_mag_info_value()


> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   enum adxl313_activity_type type_act,
> +				   int val, int val2)
> +{
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		return _adxl313_write_mag_value(data, dir,
> +						type_act,
> +						val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		return adxl313_read_mag_value(data, dir, info,
> +					      ADXL313_ACTIVITY,
> +					      val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		return adxl313_write_mag_value(data, dir, info,
> +					       ADXL313_ACTIVITY,
> +					       val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

Otherwise LGTM

Jonathan

