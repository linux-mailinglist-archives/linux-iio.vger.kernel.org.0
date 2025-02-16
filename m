Return-Path: <linux-iio+bounces-15600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFBCA37648
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9E51883C06
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F819C574;
	Sun, 16 Feb 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKFf6KH1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98314D299;
	Sun, 16 Feb 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726933; cv=none; b=l+7YH+dEGPHVghXT6wk6Caegpyansc4pt+ic5JJhch1AVj21o2E/vjnxEdXyDJx3lmU3qvfDZ1nkIi7LX7ZxLMcCrmFRm+Y2D8bIJgWNca6WVBskNkt5fE4wSx3Dl3n0aLHLUoWK8KTT4KYHRDiYg6Kk+n4Iorr5srEcLf4XF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726933; c=relaxed/simple;
	bh=sP3RyiLceS4KF4COcqroLs4WQlSl0gvOgk0Juiab5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ai1PosJmu8mzNWKa52tHspTeocIJzVYAayN/sFOWvZJ6/mYigSgKQfzW7zKuubVSsyxt47wHJX9OympbaNzOdKw1e7Vz8izNGetSaO1n+nmV/mb9eYAJcVdQMNR7YrusfH2bkhgizYXHqX3gjuFy24kkiFOLywwKfFyevSPiCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKFf6KH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D23C4CEDD;
	Sun, 16 Feb 2025 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739726933;
	bh=sP3RyiLceS4KF4COcqroLs4WQlSl0gvOgk0Juiab5rA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKFf6KH1pienKT5r0URXcy7urAft+0U2gZtSUwXyHY3eFLXDZYs7LAfGnzYki/JPs
	 La6dQcpES/qatiU4FN3xPp+yXleqbf36Q96GCdJ5EDke2+IUlT3veGreVq6ARAGn2Y
	 Z3jp4UBLsELIJeamJ4OEHOdv6QIYmGrSXB2puoMuiCsWTHkWRHVMZBfbtwBWH5iF2D
	 oxnnJpiHdozOyBsXG7g6JjuPYJ4kcK0hw6gbaFvA5enXem25rg8l+rJw7pgKkx7z+w
	 XRKW+89QVbSunEykO6RZo5KNUS+v1jnw2kIm6AsS71VMbX+vB7DNNlAIIHwI1nQS1V
	 S9jsu7ixIVQcg==
Date: Sun, 16 Feb 2025 17:28:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 07/14] iio: accel: adxl345: add double tap suppress
 bit
Message-ID: <20250216172845.2fe98ea1@jic23-huawei>
In-Reply-To: <20250210110119.260858-8-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:12 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the suppress bit feature to the double tap feature.
> 
> Any tap event is defined by a rising signal edge above threshold, i.e.
> duration time starts counting; and the falling edge under threshold
> within duration time, i.e. then the tap event is issued. This means
> duration is used individually for each tap event.
> 
> For double tap detection after a single tap, a latency time needs to be
> specified. Usually tap events, i.e. spikes above and returning below
> threshold will be ignored within latency. After latency, the window
> time starts counting for a second tap detection which has to happen
> within a duration time.
> 
> If the suppress bit is not set, spikes within latency time are ignored.
> Setting the suppress bit will invalidate the double tap function. The
> sensor will thus be able to save the window time for double tap
> detection, and follow a more strict definition of what signal qualifies
> for a double tap.

Silly question.  Is there a reason this function would ever be
turned off?   Seems like a sensible heuristic that would not stop
genuine double taps being detected.  Maybe we just always leave it on?

Sometimes the best ABI is the one that doesn't exist as userspace
can't use it wrong.

Jonathan


> 
> This brings in a new ABI functionality.
> ---
> Q: Perhaps there is already some IIO ABI for it? If not, please let me
> know which ABI documentation to extend. There will be a documentation
> patch also later in this series.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 82 ++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index cf35a8f9f432..b6966fee3e3d 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -34,6 +34,7 @@
>  #define ADXL345_INT2			1
>  
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -81,6 +82,7 @@ struct adxl345_state {
>  	u32 tap_duration_us;
>  	u32 tap_latent_us;
>  	u32 tap_window_us;
> +	bool tap_suppressed;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -243,6 +245,31 @@ static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
>  	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
>  }
>  
> +static int adxl345_is_suppressed_en(struct adxl345_state *st, bool *en)
> +{
> +	*en = st->tap_suppressed;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_suppressed_en(struct adxl345_state *st, bool en)
> +{
> +	unsigned long regval = 0;
> +	int ret;
> +
> +	en ? __set_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval)
> +		: __clear_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval);
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> +				 ADXL345_REG_TAP_SUPPRESS_MSK, regval);
> +	if (ret)
> +		return ret;
> +
> +	st->tap_suppressed = en;
> +
> +	return 0;
> +}
> +
>  static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 val)
>  {
>  	int ret;
> @@ -616,6 +643,60 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static ssize_t in_accel_gesture_doubletap_suppressed_en_show(struct device *dev,
> +							     struct device_attribute *attr,
> +							     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	bool en;
> +	int val, ret;
> +
> +	ret = adxl345_is_suppressed_en(st, &en);
> +	if (ret)
> +		return ret;
> +	val = en ? 1 : 0;
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t in_accel_gesture_doubletap_suppressed_en_store(struct device *dev,
> +							      struct device_attribute *attr,
> +							      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl345_set_suppressed_en(st, val > 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =  adxl345_set_measure_en(st, true);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_DEVICE_ATTR_RW(in_accel_gesture_doubletap_suppressed_en, 0);
> +
> +static struct attribute *adxl345_event_attrs[] = {
> +	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adxl345_event_attrs_group = {
> +	.attrs = adxl345_event_attrs,
> +};
> +
>  static void adxl345_powerdown(void *ptr)
>  {
>  	struct adxl345_state *st = ptr;
> @@ -899,6 +980,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  
>  static const struct iio_info adxl345_info = {
>  	.attrs		= &adxl345_attrs_group,
> +	.event_attrs	= &adxl345_event_attrs_group,
>  	.read_raw	= adxl345_read_raw,
>  	.write_raw	= adxl345_write_raw,
>  	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,


