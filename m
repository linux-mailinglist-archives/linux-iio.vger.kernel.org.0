Return-Path: <linux-iio+bounces-205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFF7F248C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 04:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1C22827EB
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 03:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173D154B6;
	Tue, 21 Nov 2023 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dzvku55x"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83FFCB;
	Mon, 20 Nov 2023 19:14:57 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B771887585;
	Tue, 21 Nov 2023 04:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700536495;
	bh=66+J6N66ETQ2okClDx/UV5gWv1oaPwcXo9HXtkPLRnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzvku55xt7NDZr0Enpc3WC63JucQdm1lQc/1DTeC+PKisS6XVECAesP9TXHIvw+Uf
	 stSoDYublvLYIqnIcaj+mEb2AwFGFxX8lordeVDCU7V/KtifimLXVbKXidT3rYTSul
	 5xVZ9gLkzDWdwYTgxW2FAF0OjHhQo39/klFHsMoozcDVJlOME3QAh0JVRGYeOy4oG9
	 Wh3HxuSBMcz5awW37Fxu8hLzbfPgzWEKvsWRvh5IOw0JrG/y0RVRAQNxH/vzFVw+lb
	 rdaLH5ms3+u5UZ1/m6J+oY/5Xs+QBrlJO+eg8So8QJYYE9inMRppdJC1xLi5W0bSAe
	 XwLcCIWsDpcdA==
Message-ID: <adb40cdd-c4c0-4564-99e5-aac25f5cd700@denx.de>
Date: Tue, 21 Nov 2023 04:14:54 +0100
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZVtKyPvYHgg61JFG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/20/23 13:02, Andy Shevchenko wrote:

[...]

>> +static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
>> +{
>> +	struct device *dev = regmap_get_device(chip->regmap);
>> +	int ret;
>> +
>> +	ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
>> +	if (ret < 0)
>> +		dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);
> 
>> +	chip->command = 0;
> 
> Even in an error case? Is it a problem?

I added a comment in V4, if the I2C communication fails, hopefully the 
next time user reads data the command register will be rewritten again 
and the communication would have succeeded by then (assuming this was 
some weird glitch on the I2C bus). So this is best effort attempt to 
recover from that.

>> +static const struct of_device_id isl76682_of_match[] = {
>> +	{ .compatible = "isil,isl76682", },
>> +	{ },
> 
> Remove comma from the terminator.
> 
>> +};
> 
> ...
> 
>> +
> 
> Redundant blank line.
> 
>> +module_i2c_driver(isl76682_driver);

That ^ newline is above the module_i2c_driver or below it ?

I removed the one below .

