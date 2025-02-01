Return-Path: <linux-iio+bounces-14844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD57A24AFC
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4731885A10
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9501C6889;
	Sat,  1 Feb 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfN/SKuQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45208208A9;
	Sat,  1 Feb 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430261; cv=none; b=QMD5WaJNZC6uyHEDENOyBJW1DnPziU6HzUhzJbg7qXQ3HhMJnBVj55gcTpmKzD+NQcrkReRfwGeiOSntCZ99PWrK5bgkfmHRKwJUV92yAi5If7NQwuKgR+H0m6sY/vnq+C8+v7RU85kFr12v6mJQEckaFpd26O4DVWS9CDuuUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430261; c=relaxed/simple;
	bh=CqYmKkd2JKlcPtiA1vFciDw7/PEmxBNohEmX+VNjuGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otfd6VVsvxzDT2h1y+ppaZ0/nrZwx3+WuWcy0TKiIncNGRQH1Xq5jr0zTH/iP7VdLP7rVjU/aNmAImGqd2nlgqUUFEs69w0V5DfVQYIuHBr71dVQSOmt4POCmRLD2gAa4rl2gbmh7/HHlz9P55ZGGg3neACHZtL9kl82kWz4H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfN/SKuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16487C4CED3;
	Sat,  1 Feb 2025 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738430259;
	bh=CqYmKkd2JKlcPtiA1vFciDw7/PEmxBNohEmX+VNjuGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EfN/SKuQvz1aOof3bOLfHE9SSL/WrDjCH7ltC9qHEvqhzQV8k0qxbFazJglil5HhM
	 a5P3ccDFKbTMRXqikvsc5bV3w4hnnV+R0V8SAXTW67oLkQ2jc8YWzjn2hnH9Zm6mzu
	 F7PBaHOng6jH6vtwMhF6Gz6fy/n+8bsTz7EUvmEHl0Np+y63is5WkBJjtgrMd+L3Hq
	 PpaYEm0CnECt43dDIY3D0n+H+ICj4NZF7KWcuLFREZnU/59NBiT0o9DMZmEpoIwKyu
	 tfuu1ktzJA40yscXY/48JX/GFAQCsydaE1vIkMtrQhjkpFiGhu/0gQN8v3svDv7fg+
	 L/KYI00Q3d/HA==
Date: Sat, 1 Feb 2025 17:17:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 09/12] iio: accel: adxl345: add double tap suppress
 bit
Message-ID: <20250201171734.6677dbad@jic23-huawei>
In-Reply-To: <20250128120100.205523-10-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:57 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the suppress bit feature to make double tap (in)sensitive to the
> configured threshold value for the tap feature. The feature is being
> enabled by a sysfs handle for enabling. This is also needed for further
> features in follow up patches.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Why would you change this?  From that description it sounds like this
should always be enabled or disabled (I'm not entirely sure). Not
something I'd expect a user to actually tweak.

Anyhow, new ABI. docs missing so hard to know what this is.

> ---
>  drivers/iio/accel/adxl345_core.c | 67 ++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index f9e5f47ba303..ef0a12fd59be 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -120,6 +120,7 @@
>  #define ADXL345_INT2			1
>  
>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  
>  enum adxl345_axis {
>  	ADXL345_Z_EN = BIT(0),
> @@ -167,6 +168,7 @@ struct adxl345_state {
>  	u32 tap_duration_us;
>  	u32 tap_latent_us;
>  	u32 tap_window_us;
> +	bool tap_suppressed;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -346,6 +348,22 @@ static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
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
> +	st->tap_suppressed = en;
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
> +				  ADXL345_REG_TAP_SUPPRESS_MSK,
> +				  en ? ADXL345_TAP_SUPPRESS : ~ADXL345_TAP_SUPPRESS);
> +}
> +
>  static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
>  {
>  	st->tap_threshold = val;
> @@ -693,6 +711,52 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +#define ADXL345_generate_iio_dev_attr_EN(A, B)				\
> +	static ssize_t in_accel_##A##_##B##_en_show(struct device *dev, \
> +						    struct device_attribute *attr, \
> +						    char *buf)		\
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		bool en;						\
> +		int val, ret;						\
> +									\
> +		ret = adxl345_is_##B##_en(st, &en);			\
> +		if (ret)						\
> +			return ret;					\
> +		val = en ? 1 : 0;					\
> +									\
> +		return iio_format_value(buf, IIO_VAL_INT, 1, &val);	\
> +	}								\
> +									\
> +	static ssize_t in_accel_##A##_##B##_en_store(struct device *dev, \
> +						     struct device_attribute *attr, \
> +						     const char *buf, size_t len) \
> +	{								\
> +		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
> +		struct adxl345_state *st = iio_priv(indio_dev);		\
> +		int val, ret;						\
> +									\
> +		ret = kstrtoint(buf, 0, &val);				\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		ret = adxl345_set_measure_en(st, false);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		ret = adxl345_set_##B##_en(st, val > 0);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		ret =  adxl345_set_measure_en(st, true);		\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		return len;						\
> +	}								\
> +	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##B##_en, 0)
> +
>  #define ADXL345_generate_iio_dev_attr_FRACTIONAL(A, B, C, D, E)		\
>  	static ssize_t in_accel_##A##_##C##_##E##_show(struct device *dev, \
>  						       struct device_attribute *attr, \
> @@ -738,8 +802,11 @@ ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
>  ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
>  
> +ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
> +
>  static struct attribute *adxl345_event_attrs[] = {
>  	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
> +	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
>  	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
>  	&iio_dev_attr_in_accel_gesture_doubletap_window_us.dev_attr.attr,
>  	NULL


