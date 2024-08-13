Return-Path: <linux-iio+bounces-8437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EC950180
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899071F236FE
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99B17CA12;
	Tue, 13 Aug 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUgzbxCa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21245210E7;
	Tue, 13 Aug 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542400; cv=none; b=D2p7+ARUY621J6mALpasAQ+euMoV+ZQABwKhAeq8+FgeGqGfbS9prsggooMbnJ3TtBqGGe+mC4CKmuD5raoIp9Z58gPJKlDs9dvCxXMUXa8p3XSH25C3WOp70Aff1AeufLY7TRU9fENeoJKJ/iFQ0iSMrhcl7gNa5ZBC2/iNGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542400; c=relaxed/simple;
	bh=ymT2I/4SMiXIMej+1eahwXe1+S+4WvRsTFHYt6PhdBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E9PYN1etTvH6/G6eqh7HTGh/q1+BebjPlWdbYfEKb0QaePW33539FznkBIUQAlXkpjr+zBuUKvjskj1iShROeH3MHl3E6wkW2CVBfksg8KpmvUd70gz8lfF/smqu0nMfiSsNSr4bbQCYo9Pdjq/wdB3HRq0oBf52dQNZ+kyyJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUgzbxCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BAFC4AF09;
	Tue, 13 Aug 2024 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542399;
	bh=ymT2I/4SMiXIMej+1eahwXe1+S+4WvRsTFHYt6PhdBw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DUgzbxCawhn90Us54mf07Kp2BVFRryYEFFpQk5WaFAaQ3on9Q6ze54BnZqNwLIT1U
	 Ulpikv8Ezg1ps+7rjMImZ0GDRdsQIEIWgf4cW77Ghk1SJ89QW5ENBumrmr5mrXaMyY
	 jAQA5XLiyqvGBfMZ4Vl9w/zRC9ewuyQAImj/mw+r6en32QTE+j9VuNk7WCTlXAWJIa
	 XZyXn9o4Iw1pD+oVDUM9d1CXtAwEPuFWYsCAEazScW+wdXB/xr0IiGiAE+wmEXlJ9l
	 OYpayNnwA9cC/22naDb0clXeLuax9Eib990R+lCiTR3PICpakxUlw/ZUmlHG1Woquc
	 zrPFGqIkYmtaQ==
Message-ID: <bb33aeb0-7134-45ec-8536-47c524ec9e4b@kernel.org>
Date: Tue, 13 Aug 2024 11:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: imu: smi240: imu driver
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>,
 "Frauendorf Ulrike (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>,
 "Dolde Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 11:41, Shen Jianping (ME-SE/EAD2) wrote:
> Hi
> 
> On 09/08/2024 13:16, Jianping.Shen@de.bosch.com wrote:
>> From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
>>
>> iio: imu: smi240: driver improvements
> 
> ?????
> Did not get your point, what is wrong here? how it shall be?

See submitting patches. This does not match your commit at all. I do not
see any driver improvements done here. If so, please list all your
improvements against existing kernel driver.


> 
>> Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
>> ---
>>
> 
> 
> ...
> 
>> +	ret = regmap_read(data->regmap, SMI240_CHIP_ID_REG, &response);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Read chip id failed\n");
>> +
>> +	if (response != SMI240_CHIP_ID)
>> +		dev_info(dev, "Unknown chip id: 0x%04x\n", response);
>> +
>> +	ret = smi240_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Device initialization failed\n");
>> +
>> +	indio_dev->channels = smi240_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(smi240_channels);
>> +	indio_dev->name = "smi240";
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &smi240_info;
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> +					      iio_pollfunc_store_time,
>> +					      smi240_trigger_handler, NULL);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Setup triggered buffer failed\n");
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Register IIO device failed\n");
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(smi240_core_probe);
>> +
>> +MODULE_AUTHOR("Markus Lochmann <markus.lochmann@de.bosch.com>"); 
>> +MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>"); 
>> +MODULE_DESCRIPTION("Bosch SMI240 driver"); MODULE_LICENSE("Dual 
>> +BSD/GPL");
> 
> Hm? How many modules do you have here? What are their names?
> 
> We have one module, named  "Bosch SMI240 driver". Any problem here?

Yes, you put MODULE_* to how many files? Two? Three? Why is it needed
everywhere?

> 
> 
> 
>> +
>> +static const struct spi_device_id smi240_spi_id[] = { { "smi240", 0 
>> +}, {} };
> 
> Don't wrap it.
> 
> We don't , git send-mail did it automatically for us. 
> 
> 
>> +MODULE_DEVICE_TABLE(spi, smi240_spi_id);
>> +
>> +static const struct of_device_id smi240_of_match[] = {
>> +	{ .compatible = "bosch,smi240" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, smi240_of_match);
>> +
>> +static struct spi_driver smi240_spi_driver = {
>> +	.probe = smi240_spi_probe,
>> +	.id_table = smi240_spi_id,
>> +	.driver = {
>> +		.of_match_table = of_match_ptr(smi240_of_match),
> 
> Why did it appear? You introduce now warnings.
> 
> Did not get your point, why we introduce now warnings here ?

Fix your quoting. It's impossible to figure out what is here my quote
and what is yours.

Why? Test your code properly... Drop the of_match_ptr.



Best regards,
Krzysztof


