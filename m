Return-Path: <linux-iio+bounces-10729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C39A40A3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBE61C25257
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1B14B970;
	Fri, 18 Oct 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1z5GFVB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05855887;
	Fri, 18 Oct 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260322; cv=none; b=MEkcPDnuKpG0IxwLX5blMr2YDNukJnd/7t00nqHYGxuQ+1mjQjWLc4IM3r+nrCxTxOZ/XJG53TPnxgyeEMYsfTRt/6X0jpJ24RyYtrOWxJnfmnIFxwjADrZtj/lWYCOW+BfiS2EcptlwyJ/pIy1p3Feq++B0/9+f4SJrXEfF6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260322; c=relaxed/simple;
	bh=P9qBmyXGIzGRI89cIDSu6vSc+y6v3VHIeeNmZvDVNYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEgXYnlW8fQpkzBTYd+ldWrkmGr0ihyDKd3MwcBelKQHjPZdQVe6EW2SUzoW8S1Tq46xmdeWmV/e/VUj7VyWCI4+/XWqSRTSLoz13kWkbEDbPFTWuWBM1C8qaXWy2dEI8rzRBZT2LQ6jTcmxsGdd23WR1kBsrwLb0U6KOzFuAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1z5GFVB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so2124624f8f.2;
        Fri, 18 Oct 2024 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729260317; x=1729865117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTkCgrhi6E/v/PaGg7K+YIRM+2KJUh5JNs+NbX3CH8M=;
        b=J1z5GFVB+aF6JxSozVTb3gZ4oDP7FXXXZby5U6/uj7hejLtPk1G1VFKCo+QOUsZbEU
         vECj4b7mYV75KOOo0jO3dieWmnFnMXr/Q7nN6glEf2tWfX//06HBq8+4OVihji9eMj5f
         Wl3HOckRqHO9Ku6jmMqfZdsFgu6k/yNQgRY6zJyCi4yinytyWAco3kc472qO8/So8vES
         pAAFh8KwhBLgffQz9QrxCZU7NWwfh/zyewvkY6bg9DYmXy4hi5FdelagACnw/+8j5BHQ
         gNLHrWxseg1WZI7DzM8NAZpMXSRNsAKx4VKNwayg6i6gZvprh5bSaCYFOL0P8pOU2fif
         sECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729260317; x=1729865117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTkCgrhi6E/v/PaGg7K+YIRM+2KJUh5JNs+NbX3CH8M=;
        b=LzdgYHskV9AGAoFk0xnZ4QG/Hm0IyxEGXrV+cnG+/7Lx14LEU3JPY0cmRLfpWPhwaa
         UKBNuJWuM7o9k29b1dlY9KNPlTiBXx2e1q6F3p7grA+7P2tx2U2VYC8hJxx7NaQX7VPv
         9a38USWDdAA/V11eezpg+6CDqWk2N0doHDMBfYJwWQcIRMxvVGvDMfsSUIpRrrLi5vkn
         rsHEnKvocay+PKmNaatHRwpvekdnZtf685AUgBos1Dju400EK4Qc/D5J7MYhW0zM49cB
         J8oSfqlAvjLLF7vrTj7RCBXfOkhrCYD1N/SvYzQ2QhmUUgm+0jb3flL/JFyiE+qWPaSY
         dDug==
X-Forwarded-Encrypted: i=1; AJvYcCUc45jIB0xQp9pSqP1Azkx1ttWZJWDS6+8ps0X2iOs+zgV3CfTkdJpTNen/u5vm7DKHQ3K+BIMMfFHu@vger.kernel.org, AJvYcCXHggEM45hHGzpylUQ+ldr8cBnsKUflkj72zXlD5PGBPChuWnyfrtEzjDPPECftdBptLNEhocGR/tjVxIYs@vger.kernel.org
X-Gm-Message-State: AOJu0YzHD5fIJ3Wzu/FkWOveVsm/SSX7dvIFDo08HWYyNFM5Qai1LQws
	VK+X2daAvZ+f4gXRenFIw8Jc8xgDUirmYLcGdUApTBjBpu/WirUUVpb9iw==
X-Google-Smtp-Source: AGHT+IEnp2W2dXw6NoQrQmydW69Ers3+3AL19DsB5XQ6f9H/FM7NWLcN5xbruXS42FaGRRUgR+JBMg==
X-Received: by 2002:a5d:5e0d:0:b0:37e:d2b8:883a with SMTP id ffacd0b85a97d-37ed2b889acmr1610795f8f.12.1729260316476;
        Fri, 18 Oct 2024 07:05:16 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:ae3c:75ce:73d:b809? (2a02-8389-41cf-e200-ae3c-75ce-073d-b809.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ae3c:75ce:73d:b809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160694e5csm28320085e9.21.2024.10.18.07.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:05:16 -0700 (PDT)
Message-ID: <45630b06-c5cc-4512-8376-dc99fd0976bc@gmail.com>
Date: Fri, 18 Oct 2024 16:05:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: light: veml6070: add support for integration
 time
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
 <20241017-veml6070-integration-time-v1-4-3507d17d562a@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241017-veml6070-integration-time-v1-4-3507d17d562a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 23:39, Javier Carrasco wrote:
> The integration time of the veml6070 depends on an external resistor
> (called Rset in the datasheet) and the value configured in the IT
> field of the command register.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6070.c | 109 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index d11ae00f61f8..87dc3295a656 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -6,7 +6,7 @@
>   *
>   * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
>   *
> - * TODO: integration time, ACK signal
> + * TODO: ACK signal
>   */
>  
>  #include <linux/bitfield.h>
> @@ -29,15 +29,78 @@
>  #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
>  #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
>  
> -#define VEML6070_IT_10	0x01 /* integration time 1x */
> +#define VEML6070_IT_05		0x00
> +#define VEML6070_IT_10		0x01
> +#define VEML6070_IT_20		0x02
> +#define VEML6070_IT_40		0x03
> +
> +#define VEML6070_MIN_RSET_KOHM	75
> +#define VEML6070_MIN_IT_US	15625 /* Rset = 75 kohm, IT = 1/2 */
>  
>  struct veml6070_data {
>  	struct i2c_client *client1;
>  	struct i2c_client *client2;
>  	u8 config;
>  	struct mutex lock;
> +	u32 it[4][2];
>  };
>  
> +static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
> +{
> +	u32 rset, tmp_it;
> +	int i, ret;
> +
> +	ret = device_property_read_u32(dev, "rset-kohms", &rset);
> +	if (ret) {
> +		dev_warn(dev, "no Rset specified, using default 300 kohms\n");
> +		rset = 300;
> +	}
> +
> +	if (rset < 75) {
> +		dev_warn(dev, "Rset too low, using minimum = 75 kohms\n");
> +		rset = 75;
> +	}
> +
> +	if (rset > 1200) {
> +		dev_warn(dev, "Rset too high, using maximum = 1200 kohms\n");
> +		rset = 1200;
> +	}
> +
> +	tmp_it = VEML6070_MIN_IT_US * (rset / VEML6070_MIN_RSET_KOHM);
> +	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
> +		data->it[i][0] = (tmp_it << i) / 1000000;
> +		data->it[i][1] = (tmp_it << i) % 1000000;
> +	}
> +}
> +
> +static int veml6070_get_it(struct veml6070_data *data, int *val, int *val2)
> +{
> +	int it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
> +
> +	*val = data->it[it_idx][0];
> +	*val2 = data->it[it_idx][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int veml6070_set_it(struct veml6070_data *data, int val, int val2)
> +{
> +	int it_idx;
> +
> +	for (it_idx = 0; it_idx < ARRAY_SIZE(data->it); it_idx++) {
> +		if (data->it[it_idx][0] == val && data->it[it_idx][1] == val2)
> +			break;
> +	}
> +
> +	if (it_idx >= ARRAY_SIZE(data->it))
> +		return -EINVAL;
> +
> +	data->config = (data->config & ~VEML6070_COMMAND_IT) |
> +		FIELD_PREP(VEML6070_COMMAND_IT, it_idx);
> +
> +	return i2c_smbus_write_byte(data->client1, data->config);
> +}
> +
>  static int veml6070_read(struct veml6070_data *data)
>  {
>  	int ret;
> @@ -81,10 +144,14 @@ static const struct iio_chan_spec veml6070_channels[] = {
>  		.modified = 1,
>  		.channel2 = IIO_MOD_LIGHT_UV,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>  	},
>  	{
>  		.type = IIO_UVINDEX,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>  	}
>  };
>  
> @@ -127,6 +194,40 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
>  		else
>  			*val = ret;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return veml6070_get_it(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6070_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	struct veml6070_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*vals = (int *)data->it;
> +		*length = 2 * ARRAY_SIZE(data->it);
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6070_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml6070_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return veml6070_set_it(data, val, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -134,6 +235,8 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
>  

I just noticed that the processed data needs to be updated to take into
account different integration times because in its current form it
provides fixed values for Rset = 270kohm, IT=1T. I will add it to v2,
which is required anyway to address changes in the dt-bindings.


