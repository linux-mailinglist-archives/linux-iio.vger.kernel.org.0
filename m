Return-Path: <linux-iio+bounces-11819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2469B99C1
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 22:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB841F2207B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2941E2828;
	Fri,  1 Nov 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lQXmySVY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EA1CCEF8
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494823; cv=none; b=ARXjnVaJjKSa2u6pUn+1IWqDDxbDMI8KioivNq1WgGimXotuPf6WCbHolfx4RH3n2xQ/HBgKKixlyhJqY2szhDQwqFeLeMC3RLBKjSVJxtB0xJCVp/iAw7zOI7P2zzQZrjf3A2qlIlNTsA+/02OQ1V07SQhIyonlewOnc+y4TUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494823; c=relaxed/simple;
	bh=yd1oNMlXQNHRuMi9NKJGY6s8WrK4lyJGOmQW7IQTstg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GafCaLvzUjyvYtPJxNIQCS+LFcJcqiIjtXxWXdDnfNZ1dgyIvtQKL96s0bq/S5YIXyGvZddHAL6Gyr8WWTOzQ2yFUNy6fn94EONUUmP236j+B2sNgy6/mM2pMHyIlmEWAePMNrrGFaXZ5fE1lsEDWbzgFZwzaqxhS2Tm/5ZlMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lQXmySVY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5f968230bso1068296b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730494818; x=1731099618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK/XrqgDzkOhN4kuc7qZmLsvJLPawrpRaDB6kgscLdM=;
        b=lQXmySVYehuOhc7BQQQ/s7pyqfrMG2u0vr8cPMmjmIQ5RC+6UBqUDRPcxIYeN8h9d4
         6f1qc44zGoIxs/I2/LKvSPQvCpUpeKsO3FU0TH9aOp2cBEaUQqS14zndjk8M+ych9qCk
         FMgkGClqYJRJY8TQ081sH5Tn9cx/vkFCjLnDelRKq+rwHE/4lmhQHSVYrnK0uGBYvYt5
         guQTC3848v73IMLNxNFoqQRIDmXTDs4ygnlyp3G6rfQKzDh7WoqX3nuOOUzr7i5ofwL0
         rmezQSP2Rb7wSb2HrqNwFdImjU2VF1u9UUfuB0/mS1JzrC/B3Kmqv9/42UiViFc7URAP
         IEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494818; x=1731099618;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK/XrqgDzkOhN4kuc7qZmLsvJLPawrpRaDB6kgscLdM=;
        b=fjesB7BuIaTIaSupX5DUBPg6TVev2pLR92U4F5m4e3ZLw6kftHrbCRfqNvQKj0fdCI
         q8p88/PBPRtTMql7e4zJmYPYkRRApqxkZ7zKjFFWLMHNV2rV4XMzKdg46NUf7hbzgGrx
         PLDwuvf6iQ6RnMYcoYyBNUC+9bg4rrRsY3zc1DQS0Cw1XPBKUFm3mUaRAsGiu4MQOBy8
         1VPCp0erdmbbPtmppvuUx/A2D9o/SVMBcKGwU+loarCsAf99he1GSoyNU3m5Nm1y2AD9
         I1QVMRRJIp6nFRI4gnW/XU+PUYQEyy1xr5yvvq+T3XOksZK+DcHe+2oh0qbhuMV2Bf8S
         OeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMu9WQ6XEUSbeX4+aOG4fk/cDboQegOLCHDCVBHL9F0BBD3Cvr+oXOvNJUT2zkOHd0u+BcNxxPdHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SPKpZxw0cj9WvnjmxEo+exJ10yjODPDp5qpAIGkVGqK4Xcq3
	pqN3lhAXvAha39eKHM640sRLO9Bi7sQ5qmdeUau4WbE5N1BIePWiog154/8L4W0=
X-Google-Smtp-Source: AGHT+IGeoavYr/rIDZkAnrFaEnGlzF7zFA9Ef48oqV2Y27RnuBBx8c5ltJ+SujJAWX1hr8+KRN0XLw==
X-Received: by 2002:a05:6808:de7:b0:3e7:60b9:d62b with SMTP id 5614622812f47-3e760b9da08mr1870355b6e.43.1730494818274;
        Fri, 01 Nov 2024 14:00:18 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec704e25dbsm793593eaf.12.2024.11.01.14.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 14:00:16 -0700 (PDT)
Message-ID: <54d39d0c-2021-4571-8d03-92456f2d1a4d@baylibre.com>
Date: Fri, 1 Nov 2024 16:00:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] iio: adc: adi-axi-adc: set data format
From: David Lechner <dlechner@baylibre.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-5-antoniu.miclaus@analog.com>
 <0f4a6e40-a7c8-43e4-8596-4fa495159378@baylibre.com>
Content-Language: en-US
In-Reply-To: <0f4a6e40-a7c8-43e4-8596-4fa495159378@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 2:52 PM, David Lechner wrote:
> On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
>> Add support for selecting the data format within the AXI ADC ip.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>> ---
>> no changes in v5.
>>  drivers/iio/adc/adi-axi-adc.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
>> index f6475bc93796..6f658d9b4c9d 100644
>> --- a/drivers/iio/adc/adi-axi-adc.c
>> +++ b/drivers/iio/adc/adi-axi-adc.c
>> @@ -45,6 +45,9 @@
>>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>>  
>> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
>> +#define   ADI_AXI_ADC_CNTRL_3_CUSTOM_CTRL_MSK	GENMASK(7, 0)
>> +
>>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>>  
>> @@ -312,6 +315,24 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>>  	return 0;
>>  }
>>  
>> +static int axi_adc_data_size_set(struct iio_backend *back, ssize_t size)
>> +{
>> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
>> +	unsigned int val;
>> +
>> +	if (size <= 20)
>> +		val = 0;
>> +	else if (size <= 24)
>> +		val = 1;
>> +	else if (size <= 32)
>> +		val = 3;
> 
> Should these be exact matches instead of "<="?
> 
> Also, what would val = 2 mean? Perhaps we need some macros to explain
> the meanings of these values. The docs linked below give the meaning
> for a different chip, but not AD485x.
> 
>> +	else
>> +		return -EINVAL;
>> +
>> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
>> +				  ADI_AXI_ADC_CNTRL_3_CUSTOM_CONTROL_MSK, val);
> 

Answering my own question:

I did some digging in the HDL source code and found that there
are actually multiple field here.

So instead of ADI_AXI_ADC_CNTRL_3_CUSTOM_CTRL_MSK, we should have

#define AD485X_CNTRL_3_CUSTOM_CTRL_OVERSAMPLING_EN	BIT(2)
#define AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT	GENMASK(1, 0)

And the meaning of PACKET_FORMAT is different for 16-bit vs.
20-bit chips and in some cases if oversampling is enabled or not.

For 16-bit chips:
	0 = 16-bit data and no status bits
	1 = 16-bit data and 8 status bits

For 20-bit chips:
	0 = 20-bit data and no status bits
	1 = 20-bit data and 4 status bits OR
	    24-bit data and no status bits (oversampling)
	2 = 20-bit data and 8 status bits and 4 bit padding OR
	    24-bit data and 8 status bits (oversampling)
	3 = Same as 2

So this tells me that A) we probably need a separate oversampling
enable callback and B) we should be more clear about what "data
size" means. Do we mean just the sample data size (realbits) or
do we mean the sample data plus status bit (realbits + shift).

The implementation is fine for now (other than we should remove the
val = 3 case). But if we need to enable status bit in the future,
it won't be compatible with this function.

> My understanding is that the use of REG_CHAN_CNTRL_3 is different
> for every HDL project depending on what (frontend) chip is is being
> used with. In the AXI DAC, we added a new compatible string for this
> (and other reasons). Not sure if we need to go that far here, but I
> would at least put a comment here explaining that this use of the
> register is highly specific to the AXI AD485x variant [1] of the
> AXI ADC IP core.
> 
> Ideally though, there should be an ID register that we can read
> to get this info or use a different DT compatible string.
> 
> [1]: http://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
> 
>> +}
>> +
>>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>>  						 struct iio_dev *indio_dev)
>>  {
>> @@ -360,6 +381,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>>  	.test_pattern_set = axi_adc_test_pattern_set,
>>  	.chan_status = axi_adc_chan_status,
>>  	.interface_type_get = axi_adc_interface_type_get,
>> +	.data_size_set = axi_adc_data_size_set,
>>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>>  };
> 


