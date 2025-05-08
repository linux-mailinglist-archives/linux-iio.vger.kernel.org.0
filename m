Return-Path: <linux-iio+bounces-19311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5469AB0022
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5AA1C077EC
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973F2820B3;
	Thu,  8 May 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KfMsQ+kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035342798E2
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721101; cv=none; b=cTQR22tj0HlV1FaCJ3fDTShwogIyICSG+g6eD3M0BVavKrEVu9ZUqZPnKxukKCCFJ5fPIxBem478nTsmDTsxrzohbohONs435uklR5iPbX5ho0RNEFt3gUFGtu/qHMocZ/r5Y/LcCnkEX/xxJO3X+EyPwOdJTRZbOdpTdihfOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721101; c=relaxed/simple;
	bh=95iAkpqgWUsCaFg/nPZXVXeQYGaaeXUojdfwkMj6oF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MivnYWVlDYnWQ/KnoiPIZCX4LLNSH2oOBzDtBoia01ycHLlZakdzmJfMHbhyexvtOWYEab9CFxWy8JoNZlApfgqdTAQKZ61rE4Zn5ZekeRPSkaBGZZKj2HC/d0nn4xASCGqNkkqaHc3axaXe5tf2AaLB6hJFinYiLPFy23ypRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KfMsQ+kf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72ec58e45baso818930a34.2
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746721095; x=1747325895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecUE+2xeVl8wS4a2+a1A9Z46OEauXZuEihSjbq0kVG8=;
        b=KfMsQ+kfAZUiVh7sVgsHHXm3VraufmvpZoTJ6t80jeXj/2g57ysK7hxQ4dpny1o7bK
         V2kVK0cyWqmGhWUYzdoKVnyNrQcwZV1Zh3bC8dDnwczBvFS16JhghpP9Q2pILA7KkO5Z
         v3TtlpRg5TboVdcxbTehveaNcGhk5zcauO8a9yJEQvoK+SV2fypgcfnRJO284sg3VjWx
         UbUHtUGSu7s8SO3TGk6EYNc1jjcdl/It6oz+2MFP84kxz0ESnAj4QbMqkuI7wkV1ACE0
         7fLJN0C3n4MfQqvpRYYxu0irCSBTDB1zpsRKDtf57GbgLsmSNj28pqEkZI9q3CI8yUro
         mcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721095; x=1747325895;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecUE+2xeVl8wS4a2+a1A9Z46OEauXZuEihSjbq0kVG8=;
        b=kvl2XvDVFVRckPiJXYfcAiC64RjtKfrZhg/6Rj54clOdRMsmP6vE+Pzi5vwi7T4ND5
         6DpapXgYTgCmENNf0upW9kVatVwHNrfae+6LmMTIbI9Pd96BT1rYHfokB+1qY6VNG/yI
         YXUdwBpiW6ziCxx/cBuMX+GwMPsbXVuLrtIzzSimlDcao3RUZJwuA7+QBy4v0T0wbibH
         fIWsTAMCZzrcoRPHZYQLRd/5REKQec4iAoYeJosAOvb5GiBtf9CgTaWOmcxqgNOCJxV0
         udaBcHUT9RqfnFgs8YYvyg75kVpQ0NGwpmHJ1Er3ouOAE2NLLvyNRxQsZnDE69cx6zVD
         hPVQ==
X-Gm-Message-State: AOJu0YznPaUCua83ZhAHHyEYaAqzUqj3nWIojOlf34ZVv+1fs+O/DT6K
	1PlFskWskad36m94Jn7tHhHKp7o9HHrsPmKhyhDF8uHwnwGLCrk2Vm4d9NCZnlw=
X-Gm-Gg: ASbGncvYh4QRnpVqKurUZxq00niMsqnjKojKX5Nyb1r9gt27kBp8kJOfDTAdn/s3cNM
	GI/gdU483F1BG8nPH9Plo0uh8VlibYzDupmBSgscN92ufMx8oqyxkrjr1br7KlX2gND0KA6slag
	MHVTlM2CFJaoAgTyahn27fVl89o+RvYKvU9wPo3OcjMNylqSepIdVgp4HRq2Lpw5xqDhj8F9bTN
	dPCt40dG59BsXD29hkUvyNTUaH9u3jg0aAxumD3G4kNSyG5ewZz57Nu0DkDDoz8TPNusxkL87yQ
	CFd8vWiWDFaF1GukaxGm7E2LgJJz0r1p8uG2eQSRxYCMqDJo+le+zp5vtBleYSmlsWXV+qV7BAp
	bm80S+POVT1OfXoSAsg==
X-Google-Smtp-Source: AGHT+IH3ASarxNzR88hdBrG0ZTo0oeA2aFLhbbOkAvhlKMZfmu4PwM2QgUPG24NVoBdVqvNbrOFdoQ==
X-Received: by 2002:a05:6830:7195:b0:72b:a5e0:f76 with SMTP id 46e09a7af769-732269bbf1dmr241491a34.4.1746721094883;
        Thu, 08 May 2025 09:18:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d78fbsm83047a34.32.2025.05.08.09.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:18:14 -0700 (PDT)
Message-ID: <4c4c70d9-88d8-433d-a8d0-804b3c718a2b@baylibre.com>
Date: Thu, 8 May 2025 11:18:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iio: magnetometer: qmc5883l: add extended sysfs
 attributes and configuration options
To: Brajesh Patil <brajeshpatil11@gmail.com>, jic23@kernel.org,
 lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
 <20250508120900.114348-2-brajeshpatil11@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508120900.114348-2-brajeshpatil11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 7:08 AM, Brajesh Patil wrote:
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---

...

> +
> +static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
> +	IIO_ENUM("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
> +	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
> +	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),

There is already IIO_CHAN_INFO_OVERSAMPLING_RATIO so we don't need to make this
a custom attribute.

> +	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
> +	{ }
> +};
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
> +static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
> +static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);

As far as I can tell, mode, data_ready and overflow are not standard attributes.
I don't see them in Documentation/ABI/testing/sysfs-bus-iio*. So if these really
are needed, we will need a justification of why these don't fit into any
existing attributes.

In the previous patch standby/continuous and data ready were handled internally
already so I don't think need those.

Overflow sounds like it could possibly be an event, but I didn't really look in
to it.

> +
> +static ssize_t qmc5883l_show_odr_avail(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "10 50 100 200\n");
> +}
> +
> +static ssize_t qmc5883l_show_scale_avail(struct device *dev,
> +					 struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "2 8\n");
> +}
> +
> +static ssize_t qmc5883l_show_status(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, QMC5883L_STATUS_REG, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (attr == (struct device_attribute *)&iio_dev_attr_data_ready.dev_attr.attr)
> +		return sprintf(buf, "%d\n", !!(val & QMC5883L_DRDY));
> +	else if (attr == (struct device_attribute *)&iio_dev_attr_overflow.dev_attr.attr)
> +		return sprintf(buf, "%d\n", !!(val & QMC5883L_OVL));
> +
> +	return -EINVAL;
> +}
> +
>  static int qmc5883l_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
> @@ -275,6 +483,54 @@ static int qmc5883l_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
> 
> +static int qmc5883l_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	int odr, range;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

Since the format for this is set to IIO_VAL_INT, val2 will always be 0 and can
be dropped. Then we can turn this into a switch statemnt.

> +		if (val == 10 && val2 == 0)
> +			odr = QMC5883L_ODR_10HZ;
> +		else if (val == 50 && val2 == 0)
> +			odr = QMC5883L_ODR_50HZ;
> +		else if (val == 100 && val2 == 0)
> +			odr = QMC5883L_ODR_100HZ;
> +		else if (val == 200 && val2 == 0)
> +			odr = QMC5883L_ODR_200HZ;
> +		else
> +			return -EINVAL;
> +
> +		return qmc5883l_set_odr(data, odr);
> +	case IIO_CHAN_INFO_SCALE:

If scale is always an integer value, then we should set that in
qmc5883l_write_raw_get_fmt() and we don't have to check val2 here either.

> +		if (val == 2 && val2 == 0)
> +			range = QMC5883L_RNG_2G;
> +		else if (val == 8 && val2 == 0)
> +			range = QMC5883L_RNG_8G;
> +		else
> +			return -EINVAL;
> +
> +		return qmc5883l_set_rng(data, range << QMC5883L_RNG_SHIFT);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int qmc5883l_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -321,6 +577,7 @@ static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
>  		.storagebits = 16,          \
>  		.endianness = IIO_LE,           \
>  	},                      \
> +	.ext_info = qmc5883l_ext_info,      \
>  }
> 
>  static const struct iio_chan_spec qmc5883l_channels[] = {
> @@ -337,6 +594,18 @@ static const struct iio_chan_spec qmc5883l_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> 
> +static struct attribute *qmc5883l_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_scale_available.dev_attr.attr,
> +	&iio_dev_attr_data_ready.dev_attr.attr,
> +	&iio_dev_attr_overflow.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group qmc5883l_attribute_group = {
> +	.attrs = qmc5883l_attributes,
> +};
> +
>  static int qmc5883l_init(struct qmc5883l_data *data)
>  {
>  	int ret;
> @@ -382,7 +651,10 @@ static int qmc5883l_init(struct qmc5883l_data *data)
>  }
> 
>  static const struct iio_info qmc5883l_info = {
> +	.attrs = &qmc5883l_attribute_group,
>  	.read_raw = &qmc5883l_read_raw,

We can implement .read_avail here to avoid needing custom _available attributes.

> +	.write_raw = &qmc5883l_write_raw,
> +	.write_raw_get_fmt = &qmc5883l_write_raw_get_fmt,
>  };
> 
>  static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
> --
> 2.39.5
> 


