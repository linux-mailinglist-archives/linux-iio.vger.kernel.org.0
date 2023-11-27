Return-Path: <linux-iio+bounces-446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CD7FAC82
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A55B21425
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29D4644A;
	Mon, 27 Nov 2023 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="t5SQMCx3"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F43101;
	Mon, 27 Nov 2023 13:25:18 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AB04D8777D;
	Mon, 27 Nov 2023 22:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701120315;
	bh=LegISOAZj/VTwj6ARkkB9OAlGrxp17UtyxUiTPjGYlE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t5SQMCx3A6ona53IT5vZtfKVi1fqQT3ABwspsknnFQx00H/tU1CYy38TVhIZWcW8S
	 83ks7rWZcdDMakATT2Kk1oK6MKYL5Fq0vLtpPbT6Y6lkFQvafqFqkberCYtxmu/V70
	 C1HRd/YdWrUxrSasKOhikb9r4pqlhxWrz3t08HJOfqMqfvgZWo+mrIs+SDkMXagkXf
	 G9nuBRgOkCHnND6gU7vxMhgEmR5fnSUP5/gZS1YXfkRherGHwm/V5TMnEgXrB4gCcO
	 6v4SQ7axkcWudjG75/mCSchWbG+Emz1ruBVNN3fO6cacEJRV52QLivYZF35reTa/6T
	 uW9QYJr3dbP3w==
Message-ID: <d5c0cc28-693d-4797-aebf-e4c13b6c8267@denx.de>
Date: Mon, 27 Nov 2023 21:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231125222738.97875-1-marex@denx.de>
 <20231125222738.97875-2-marex@denx.de> <ZWTAEWRreMir7x_T@smile.fi.intel.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZWTAEWRreMir7x_T@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/27/23 17:13, Andy Shevchenko wrote:
> On Sat, Nov 25, 2023 at 11:26:23PM +0100, Marek Vasut wrote:
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality.
> 
> ...
> 
>> +	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
>> +		if (chan->type == IIO_LIGHT && val2 != isl76682_range_table[i].als)
>> +				continue;
>> +		if (chan->type == IIO_INTENSITY && val2 != isl76682_range_table[i].ir)
>> +				continue;
> 
> You forgot to drop indentation level for 'continue' lines.

I noticed that too and already fixed it in v6 .

