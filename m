Return-Path: <linux-iio+bounces-6275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917DF908EA9
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D62FB2EEE7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8090715FCE9;
	Fri, 14 Jun 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tgq7yRJs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82C15FCE7
	for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378387; cv=none; b=TE9fAI3E/LVTFMtPwhu6a6ZmuCizTtyuoHHf5umJ/GYvKXwFmm5MoovWD++mKqmEArOMgWDF7WjEzVe1J6JEtzLA7xeJeRvMgO+SbTH0fmecydt1xKzVwDe+9x7/DyjBGI1IJqWBqmOLoUrhrFfk9NeV0ocpfVyfUXhCKlDZFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378387; c=relaxed/simple;
	bh=87BvkSs+ygZRPSAr5u8PQe27OoMFmlNRGMl2XHFRvZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMRRZgv4YE2u4thw89PcQoz99SxEsqdT5/s+Xv0+20WM4/rpYauid+zq6vM8XN/w1z6cbcbS2X+y4UbIF1CIOtHzKHKh/OJ6sQ2oQKq+SJjjkITXwC6Mec36lurGgSFE3lVjJo24JOIJjKkyW97kjgESCI3j+5ZR1AJcOylGnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tgq7yRJs; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d2220a11a8so1309633b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718378384; x=1718983184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FR+hiQXGSlrheXhrw7JSUh0i260ebEnk3xX8ftIKEk=;
        b=Tgq7yRJsWAu14Bp8NDol5G0wh3QjxMhyjWt2SfgpNQhFSw4QJsxSF38c211CfNb7Zp
         ZIsL0A4ftVzlvlHrHf2o095CiZZR9liZJW8AQ5CaqxVWb9HtDuTFL5171ASp7TZdJvFU
         fR1zvArfTm5A2PJEQtoOKFYArlX/r5vGz2DSGdz+ODcWaXOURsL4tBIE1W75FwshdiOr
         Fm2VeXrbmbFusUyB1NzpjjME0ctMCbONMZosbpvXZ+LxLftnItMCq+ocmAeKSCrLObLz
         dv9jNn4Y/ObJ33/CQ3JwJPtIeAJkQQfmG2Os0bx6wZdpK9KYw0RX7EkndAT+oozT0oSk
         k4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378384; x=1718983184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FR+hiQXGSlrheXhrw7JSUh0i260ebEnk3xX8ftIKEk=;
        b=RsWnnX4vqARVIGmCFGPr93KtUiCY2tymF5ol3cLMHEvg8LnZP3AWRZYGZfgiwcoTKi
         gRfT5JBfjonrnuQToms7DfgXJpWLYsLixSkqcZWV4Wfg9qym9v5MaU7utM1lYn2m/H16
         JLkwgAUrrs0AKMfmoiBxCPoMc3xmMIjqT3msNyG38vFvgULXb5CLLL31kiNyoe+FlQQY
         hYFZQiAhErbN9dZ6iMbl+kEkgovFwfmGRLIDX84EjSz8PoE3g/iXkfBOQjpMeMXT13Wp
         oDAad7ZF18y1l7lrY5bW2gsbHMd6mOTDlqB7vQWPJ0Ev22rYT/oBdJ9MnVBkaXbRqcwO
         LmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFdQHs7+o+AZAb8Vc2nrNidLiqWX8+antF5BXMfA9aRYmXSqUXWKmyS7qtCKSXZKX7d3rRJSk8cEGHn5pBcTg8tFWGiOVgrR5b
X-Gm-Message-State: AOJu0YwhDkem3FVVbJY9wXNf4r4oOi5z2T5xj1B73uQ38a9a8cvZKFDd
	s7KBMUnrwfjjaAmdKEVm8U3tJyKLXVsXclpvewnU7da/wWnAARZiEfSwxrPn/AE=
X-Google-Smtp-Source: AGHT+IEAqvqHfFDA+A3uFeBB8KWxkDw9vqnQ60TPDGHKsueaFYx9tY9DwpwzFQc4VT0/2eObv6TjgQ==
X-Received: by 2002:a05:6808:3081:b0:3d2:22c6:59d1 with SMTP id 5614622812f47-3d24e90b611mr2985106b6e.34.1718378384537;
        Fri, 14 Jun 2024 08:19:44 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e31cbsm558174b6e.50.2024.06.14.08.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 08:19:44 -0700 (PDT)
Message-ID: <1f02200d-e38f-47f1-a6dd-def7225e5426@baylibre.com>
Date: Fri, 14 Jun 2024 10:19:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: adc: ad7944: use
 devm_regulator_get_enable_read_voltage
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-5-fa622e7354e9@baylibre.com>
 <6f607e60a781f74b3cde2405c8c6659d0e304c96.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6f607e60a781f74b3cde2405c8c6659d0e304c96.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/14/24 10:16 AM, Nuno Sá wrote:
> On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote:
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v2 changes:
>> - don't read voltage from refin regulator
>> - avoid else in return value checks
>> ---
>>  drivers/iio/adc/ad7944.c | 54 +++++++++++-------------------------------------
>>  1 file changed, 12 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
>> index e2cb64cef476..f8bf03feba07 100644
>> --- a/drivers/iio/adc/ad7944.c
>> +++ b/drivers/iio/adc/ad7944.c
>> @@ -464,23 +464,17 @@ static const char * const ad7944_power_supplies[] = {
>>  	"avdd",	"dvdd",	"bvdd", "vio"
>>  };
>>  
>> -static void ad7944_ref_disable(void *ref)
>> -{
>> -	regulator_disable(ref);
>> -}
>> -
>>  static int ad7944_probe(struct spi_device *spi)
>>  {
>>  	const struct ad7944_chip_info *chip_info;
>>  	struct device *dev = &spi->dev;
>>  	struct iio_dev *indio_dev;
>>  	struct ad7944_adc *adc;
>> -	bool have_refin = false;
>> -	struct regulator *ref;
>> +	bool have_refin;
>>  	struct iio_chan_spec *chain_chan;
>>  	unsigned long *chain_scan_masks;
>>  	u32 n_chain_dev;
>> -	int ret;
>> +	int ret, ref_mv;
>>  
>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>>  	if (!indio_dev)
>> @@ -531,47 +525,23 @@ static int ad7944_probe(struct spi_device *spi)
>>  	 * - external reference: REF is connected, REFIN is not connected
>>  	 */
>>  
>> -	ref = devm_regulator_get_optional(dev, "ref");
>> -	if (IS_ERR(ref)) {
>> -		if (PTR_ERR(ref) != -ENODEV)
>> -			return dev_err_probe(dev, PTR_ERR(ref),
>> -					     "failed to get REF supply\n");
>> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
>> +	if (ret < 0 && ret != -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
>>  
>> -		ref = NULL;
>> -	}
>> +	ref_mv = ret == -ENODEV ? 0 : ret / 1000;
>>  
>>  	ret = devm_regulator_get_enable_optional(dev, "refin");
>> -	if (ret == 0)
>> -		have_refin = true;
>> -	else if (ret != -ENODEV)
>> -		return dev_err_probe(dev, ret,
>> -				     "failed to get and enable REFIN supply\n");
>> +	if (ret < 0 && ret == -ENODEV)
>> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
>> +
> 
> ret != -ENODEV right?

oof, yeah messed that one too

> 
> - Nuno Sá
> 
> 


