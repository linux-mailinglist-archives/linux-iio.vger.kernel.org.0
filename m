Return-Path: <linux-iio+bounces-238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6707F359A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB51C20E22
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F222074;
	Tue, 21 Nov 2023 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hJr0oOJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B70D5C;
	Tue, 21 Nov 2023 10:05:14 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CD63587590;
	Tue, 21 Nov 2023 19:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700589911;
	bh=X12lKl0Eis4S7nQeR4I267TOiQ1HcVNy1COOpceGe60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hJr0oOJ0g/s/V99IdjXzF/6J+qnqYb8MDP/cfjVSx6LgDkMC8hrqfiaUu46VQh+aN
	 41U5Ftwd7tDHSMMTbhg2cqLH9oEv3I5TLshS1WSKUSTrFpyWMOnDZa1SR240bMAZ0c
	 IfqZvxT7eqQI8v5FWe2OYPpVe2CBXB8eE6iDYUbuzWTTbWH6ItLZNsinuG2qLCEuUS
	 Wd9ONU3ZNKMq+bamWeLZ+Oj6p530YKoAkpbm3DgGR3ukeukXd92NWsP4/KBbuKsSXF
	 MvmRtLT3l/BrZGAG83axPja3VN4e/B3ulYvvZEkm/KxymdQAi8fs0TygHXAnHkcZ5F
	 9F/FnxMb+BSzQ==
Message-ID: <acfe012d-c703-447b-8bcd-ceaa10db8013@denx.de>
Date: Tue, 21 Nov 2023 19:05:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231119212515.54001-1-marex@denx.de>
 <20231119212515.54001-2-marex@denx.de> <ZVtKyPvYHgg61JFG@smile.fi.intel.com>
 <adb40cdd-c4c0-4564-99e5-aac25f5cd700@denx.de>
 <ZVzmxP2FypnkUE4I@smile.fi.intel.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZVzmxP2FypnkUE4I@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/21/23 18:20, Andy Shevchenko wrote:
> On Tue, Nov 21, 2023 at 04:14:54AM +0100, Marek Vasut wrote:
>> On 11/20/23 13:02, Andy Shevchenko wrote:
> 
> [...]
> 
>>>> +static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
>>>> +{
>>>> +	struct device *dev = regmap_get_device(chip->regmap);
>>>> +	int ret;
>>>> +
>>>> +	ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
>>>> +	if (ret < 0)
>>>> +		dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);
>>>
>>>> +	chip->command = 0;
>>>
>>> Even in an error case? Is it a problem?
>>
>> I added a comment in V4, if the I2C communication fails, hopefully the next
>> time user reads data the command register will be rewritten again and the
>> communication would have succeeded by then (assuming this was some weird
>> glitch on the I2C bus). So this is best effort attempt to recover from that.
> 
> OK.
> 
> ...
> 
>>>> +
>>>
>>> Redundant blank line.
>>>
>>>> +module_i2c_driver(isl76682_driver);
>>
>> That ^ newline is above the module_i2c_driver or below it ?
>>
>> I removed the one below .
> 
> Hmm... Comment was clearly about above one (as you see a single + there).

I'll fix that up in V5 then, will wait a bit for further feedback before 
posting that one.

