Return-Path: <linux-iio+bounces-6858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B19159DC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 00:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DD81C22DC2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3091A0B13;
	Mon, 24 Jun 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTVF9WDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4273454;
	Mon, 24 Jun 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268071; cv=none; b=ikmWSDhsz6gnnU4yjuqifvKnK8PXwyx0foTR6RwKpm3E9tm5ETKl1csSerGkNgxou8Q87YpzXLeRc+9arvptykUe2uCbNmtMfK1c5Nbis+dHQgtTFb/HrEeprC8Kpm4qXYk6TIZq4nXCi+6tmFm31fNZhxYfZgvCczD7Ma9w/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268071; c=relaxed/simple;
	bh=3tBXMnVdJtF6HYG+GYIwRFDVlIVNQNp37p1A2WjbPec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgTy98xfWC4sOeaAghI3qcnWgYhPkm4qiiGWfnKTgmow8f1lZES4hLI1S2RuzMHaeJVaktO6jf2RpXe51luWOd8CJ6Q/Rq6dK5RbOPY2S49lvqZX5MlXyxrKtUEQ6FTNZT6FAGy53kqIVH8Y1ArznK0IyJmcG5knaKrhgb0JLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTVF9WDP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-363bbd51050so3859167f8f.0;
        Mon, 24 Jun 2024 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719268068; x=1719872868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35sYl9K/ORXM1x/6zIhMbEdYZNSt6JD+mOFZG+4VxFQ=;
        b=dTVF9WDPxozw7wmvOvtJ4tebC/VB23M2at+TmCLvsS1a6CocDT9GRtPyHwpV7bQaLu
         kddMjbxZ67ho8b7nteZnIFBjXp1nsGkpBbCS1dGC88HXIfxAgltDBDAD6AwPIKYtc/z7
         eaoRbSKdZo0qlfPpPGILOtqOCLVBxt6m0tnQ1MyXqT59lAvPgOF1xOOiqW2VHsxbQ1Qy
         pN2qhrdhtaQvQUpSn7kVSaB4t9hSMMVVbxd9Z+SlO/e6pcLh1fOKxnxe8hvLLg0EZ2od
         97eexgpdM9iNwGB/u/US/9xCErUDn7ytVm05amUmo0qK44v/nxjl9ou2l4Ft86fqNk6K
         l2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719268068; x=1719872868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35sYl9K/ORXM1x/6zIhMbEdYZNSt6JD+mOFZG+4VxFQ=;
        b=sAFZM5usQNJR4wivTaoUdfRfeJ8ntKmfHuYIzxsvzjs8qI7fhLUVxJfic/rtOfWgQ4
         o/dpyMAAC/ymzNq3DY9WV44eWpyl2WT874e46jO9lavyHHWpVf9oW/ILsrgEGgPZ2BzY
         iLrFFW1oVFxaI87OSDmUASehkG+ooD/YKplv8Ffz/lVcpT4JRGJh7/qSHbiODdhi18qe
         kX3xEyIKOfVUz+XarQbl6O3qYfzlZLrgUV1notnGg4ePEFLi2S0dWNF04XvHrbOBiPh9
         YU//ZQ1PuH/xJ019kRMJDqIuOtZK4nb/fXQLeEYob5Ns1SRiDi5qV6Olbv6ElSFGa1MO
         OQIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZArFFceCduVqt94AOCW4ZCgxgOBcNvYM/yTZSgUOIrspXybg7ZocSH1g4beH/61RhRV0j9LAuyVzDpAxz+09IXA/7KBOezfsLf3VPqy7TuafDshLLc1dAkoNclZLtJlfAInJvdZDkv6wKKEZAVL10A4Jnewv5Zoo4JP8q5wGYvBtxSw==
X-Gm-Message-State: AOJu0Yw+ovTAfTvGtR+y6CNV6YhTaxOYaTk8j5g+FOpeSeD18sV8hO6p
	4ElCVoGRHE1i1Ey7OoarPBQdiN+00A7dOzFnpNHaOkabilYFUxpr
X-Google-Smtp-Source: AGHT+IEMV86qBKjtTRO9I/8HtY+xnZlcd5tLts38wCLKE/SFMz1NzVCGnCwWzuy9hf0NDXq4vqQJWw==
X-Received: by 2002:a05:6000:b0f:b0:360:91c2:56fd with SMTP id ffacd0b85a97d-366e4f00b78mr4522844f8f.49.1719268067724;
        Mon, 24 Jun 2024 15:27:47 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b88easm11214117f8f.39.2024.06.24.15.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:27:46 -0700 (PDT)
Message-ID: <cf06ea77-c8b0-4476-94d1-32171c96f22f@gmail.com>
Date: Tue, 25 Jun 2024 00:27:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20240624215543.459797-1-muditsharma.info@gmail.com>
 <20240624215543.459797-2-muditsharma.info@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240624215543.459797-2-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 23:55, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event and interrupt latch is always enabled when setting 
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Hi Mudit, some minor comments inline form my side.

...

> +
> +struct bh1745_data {
> +	/*
> +	 * Lock to prevent device setting update or read before related

typo: calculations. I would recommend you to use checkpatch.pl
--codespell to cach such typos.

> +	 * caluculations or event push are completed
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct iio_gts gts;
> +	u8 int_src;
> +};
> +

...

> +static int bh1745_int_time_to_us(int val, int val2)
> +{
> +	for (u8 i = 0; i < ARRAY_SIZE(bh1745_int_time); i++) {
> +		if (val == bh1745_int_time[i][0] && val2 == bh1745_int_time[i][1])
> +			return bh1745_int_time_us[i];

Nit: unnecessary blank line before a close brace.

> +
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int bh1745_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int value;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {

Missing scope indentation.

> +		ret = regmap_bulk_read(data->regmap, chan->address, &value, 2);
> +		if (ret)
> +			return ret;
> +		*val = value;
> +
> +		return IIO_VAL_INT;
> +		}
> +		unreachable();
> +	}
> +

...

> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	int ret;

Why is value initialized here? If regmap returns an error, you will not
use value anyway. I caught my eye because it is initialized here, and
not in the other functions where you use the same pattern.

> +	int value = 0;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	if (state) {
> +		ret = regmap_read(data->regmap, BH1745_INTR, &value);
> +		if (ret)
> +			return ret;
> +		// Latch is always set when enabling interrupt
> +		value |= BH1745_INT_ENABLE |
> +			FIELD_PREP(BH1745_INT_SIGNAL_LATCHED, 1) |
> +			FIELD_PREP(BH1745_INT_SOURCE_MASK, data->int_src);
> +		return regmap_write(data->regmap, BH1745_INTR, value);
> +	}
> +
> +	return regmap_write(data->regmap, BH1745_INTR, value);
> +}


Best regards,
Javier Carrasco


