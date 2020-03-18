Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75F41898E4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 11:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCRKG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 06:06:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:35820 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCRKG6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 06:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JlYmf2uuN/EFbmIAfkpZr7r0EY762VpXUw3Bfh1KZoE=; b=A3kPisHgUNFIICWVzpXABtvgB3
        vr9DwfcEQLN0JCNDncPblHYTTvTf7y9aSUy/qfkG8e1Epra8kK4jU9+RdrW3/DKCk7vn/zvGpLSTI
        r984hu6njGPRq9dNFUcgbUq1OK6hVMZhySmUEnXYCdJxSxrbHh9s1RMlbWoalRINxcSFZ78T7ntY4
        mWq8Sef8rA1VvvyXZimoysO88ODHzv5aTDX8kCgi2HSfCMqAZbi14Vo7g/QEA6BjAebWCnu79GaEh
        KOGPlTlsUF/E+XAQZTXQW0dTk5+JapaYbN+HWCPNEJzpvKvPjXUatPvfFkfBuLO6ygK7Xr57+gm/N
        3PTfWm5Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEVbE-0006J3-IV; Wed, 18 Mar 2020 11:06:56 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEVbE-0008rh-AI; Wed, 18 Mar 2020 11:06:56 +0100
Subject: Re: [PATCH v3 2/4] iio: accel: adxl372: add event interface
To:     Alexandru Tachici <tachicialex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
 <20200318110958.8621-3-alexandru.tachici@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f2e9b99a-2c6c-7ad3-56e0-bae5256bced3@metafoo.de>
Date:   Wed, 18 Mar 2020 11:06:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318110958.8621-3-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 12:09 PM, Alexandru Tachici wrote:
> Currently the driver configures adxl372 to work in loop mode.
> The inactivity and activity timings  decide how fast the chip
> will loop through the awake and waiting states and the
> thresholds on x,y,z axis decide when activity or inactivity
> will be detected.
> 
> This patch adds standard events sysfs entries for the inactivity
> and activity timings: thresh_falling_period/thresh_rising_period
> and for the in_accel_x_thresh_falling/rising_value.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Hi,

Looks very good.

Since you are sending this from your gmail account there is a mismatch 
between the driver author and the signed-off-by. Either Add "From: 
Alexandru Tachici <alexandru.tachici@analog.com>" to the first line of 
the patch description or sign-off with your gmail address.

> ---
[...]
>   #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
>   	.type = IIO_ACCEL,						\
>   	.address = reg,							\
> @@ -241,6 +271,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>   		.storagebits = 16,					\
>   		.shift = 4,						\
>   	},								\
> +	.event_spec = adxl372_events,					\
> +	.num_event_specs = 2						\

ARRAY_SIZE(adxl372_events)

>   }
>   
>   static const struct iio_chan_spec adxl372_channels[] = {
> @@ -280,6 +312,43 @@ static const unsigned long adxl372_channel_masks[] = {
>   	0
>   };
>   
> +static ssize_t adxl372_read_threshold_value(struct iio_dev *indio_dev,
> +					    unsigned int addr,
> +					    u16 *threshold)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	__be16 __regval;

I'd avoid using the __ prefix for normal identifiers as those are 
supposed to be reserved. Maybe use raw_regval or something like that.

> +	u16 regval;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, addr, &__regval, sizeof(__regval));
> +	if (ret < 0)
> +		return ret;
> +
> +	regval = be16_to_cpu(__regval);
> +	regval >>= 5;
> +
> +	*threshold = regval;
> +
> +	return 0;
> +}
> +
> +static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev,
> +					     unsigned int addr,
> +					     u16 threshold)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, addr,
> +			   ADXL372_THRESH_VAL_H_SEL(threshold));
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
> +				  ADXL372_THRESH_VAL_L_SEL(threshold) << 5);

I think this needs a lock to make sure that the update to the two 
registers is atomic.

> +}
> +
>   static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
>   {
>   	__be16 regval;
> @@ -543,6 +612,27 @@ static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
>   	memcpy(sample, axis_sample, 3 * sizeof(__be16));
>   }
>   
> +static void adxl372_push_event(struct iio_dev *indio_dev, s64 timestamp,
> +			       u8 status2)
> +{
> +	unsigned int ev_dir;

= IIO_EV_DIR_NONE;

Otherwise it is uninitialized and you might send spurious events.

> +
> +	if (ADXL372_STATUS_2_ACT(status2))
> +		ev_dir = IIO_EV_DIR_RISING;
> +
> +	if (ADXL372_STATUS_2_INACT(status2))
> +		ev_dir = IIO_EV_DIR_FALLING;
> +
> +	if (ev_dir != IIO_EV_DIR_NONE)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X_OR_Y_OR_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  ev_dir),
> +						  timestamp);
> +}
[...]
