Return-Path: <linux-iio+bounces-251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280557F3A96
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63FD2828B7
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEABA620;
	Wed, 22 Nov 2023 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kad6Sj1X"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D980CB;
	Tue, 21 Nov 2023 16:06:22 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BEE79875C0;
	Wed, 22 Nov 2023 01:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700611580;
	bh=XMMrwyKsBsycWwXnVlUDTKSykEZqCTTjiQUeNA+/Kxs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kad6Sj1XqRR5KcdxrNjooyLuypfHLylc3M+ib6z9YYRef8fO8usVbl9pLCIS3JPE1
	 I9beBh1Mo/3HQ1AfOi00srWtGLkDD6lg4pZQr3jr8Qol0S8mkxN8vGcnphIeCEMqlA
	 ICRWSkz9mkk+0Ynkj/0t8SlC+zjxnacpYccIWhyxC4CIAOy6eDPs3zBPTl3LhPOoUV
	 ZD42N2/lreOfrQoHE9w5Z3D/PzKJ+L8ZustoVFSTDIxEsaSlF5yAGbntuqZstpKNdt
	 Dm6INqhtBWqD3ZlXxTpQ8S5Kavy7N1nl53L8yjxyMHjIox/+qib6SwGtzE0NeSmffN
	 9LnndGhiowhbw==
Message-ID: <d49858e2-b11a-44f3-9038-64ef2b7e8059@denx.de>
Date: Wed, 22 Nov 2023 01:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
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
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de> <ZVzyP0Oj1J0efmGO@smile.fi.intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZVzyP0Oj1J0efmGO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/21/23 19:09, Andy Shevchenko wrote:
> On Tue, Nov 21, 2023 at 04:10:40AM +0100, Marek Vasut wrote:
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality.
> 
> ...
> 
>> +	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
>> +		if (chan->type == IIO_LIGHT) {
>> +			if (val2 != isl76682_range_table[i].als)
>> +				continue;
>> +		} else if (chan->type == IIO_INTENSITY) {
>> +			if (val2 != isl76682_range_table[i].ir)
>> +				continue;
>> +		}
> 
> Redundant 'else' and you can combine if:s.
> 
> 		if (chan->type == IIO_LIGHT && val2 != isl76682_range_table[i].als)
> 			continue;
> 		if (chan->type == IIO_INTENSITY && val2 != isl76682_range_table[i].ir)
> 			continue;
> 
> But it's up to you and Jonathan.
> 
>> +		scoped_guard(mutex, &chip->lock)
>> +			chip->range = isl76682_range_table[i].range;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> 
> ...
> 
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			ret = isl76682_get(chip, false, val);
>> +			return (ret < 0) ? ret : IIO_VAL_INT;
>> +		case IIO_INTENSITY:
>> +			ret = isl76682_get(chip, true, val);
>> +			return (ret < 0) ? ret : IIO_VAL_INT;
> 
>> +		default:
>> +			break;
>> +		}
>> +
>> +		return -EINVAL;
> 
> 		default:
> 			return -EINVAL;
> 
> ...
> 
>> +static const struct of_device_id isl76682_of_match[] = {
>> +	{ .compatible = "isil,isl76682", },
> 
> Inner comma is not needed.
> 
>> +	{ }
>> +};
> 
> ...
> 
>> +
>> +module_i2c_driver(isl76682_driver);
>> +MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");
> 
> ...other way around:
> 
> };
> module_i2c_driver(isl76682_driver);
> 
> MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");
> 
> ...
> 
> Assuming you address all these,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

All that added to V5 , thanks.
I'll still wait for a few days with sending that V5 though.

