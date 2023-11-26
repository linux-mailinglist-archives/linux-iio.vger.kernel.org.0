Return-Path: <linux-iio+bounces-414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB697F95B2
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B15B20AAA
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E971401A;
	Sun, 26 Nov 2023 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YaBzI/4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B0102;
	Sun, 26 Nov 2023 14:09:41 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 81C0586F40;
	Sun, 26 Nov 2023 23:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701036579;
	bh=i+1H5oq7d5+njJjmJV0ha95JRghdNU1TcHInoKjQUS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YaBzI/4JIWaHKCa+W3etRux1cdATQykk6jL5OeSujRuFxipjlKsWdm0whJsvzajHE
	 l1a9t9xMT6YuDAqfb7kxS7hsdA3kklf0qTws40G4aLqzQrfUjrQTPmVflmgyEQv4jW
	 orc3lYwyoLOE5AnOa/mxijV9KvUJfC+sjfVdaSGxv1xxf+hBRBzL67/llHbMbw78sr
	 oPdQ/Kc2AsAzdt31AoZ7UUgj5YYLC0VwZvCli3FCopJaoirFpSW72s5n9kxUO2o7Wr
	 JMfPK5eRe7v0HDBF69KvzwdV7XZClNnDVdPvk9bebgwtj21PdLIxneQsbufIuVhp9S
	 bUwNX1NWbdwcw==
Message-ID: <9e73c450-2380-459a-9b41-a1b88f89548c@denx.de>
Date: Sun, 26 Nov 2023 23:09:36 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231125222738.97875-1-marex@denx.de>
 <20231125222738.97875-2-marex@denx.de> <20231126181655.4e1040f9@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231126181655.4e1040f9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/26/23 19:16, Jonathan Cameron wrote:
> On Sat, 25 Nov 2023 23:26:23 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Hi Marek,
> 
> One last question + a comment in general. Act on that if you like.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
> 
> Why have an available attribute for a single value. Is it useful for anything?

To report it to userspace, iio-sensor-proxy uses that to control the ALS 
poll interval .

>> +static int isl76682_probe(struct i2c_client *client)
>> +{
> 
> ...
> 
>> +	indio_dev->info = &isl76682_info;
>> +	indio_dev->channels = isl76682_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
>> +	indio_dev->name = ISL76682_DRIVER_NAME;
> Trivial but I'm not a fan of using defines in cases like this. It just makes
> me go find the define when I could see the string directly here.
> 
> In cases where matching or similar strictly requires the naming to be the same
> in various places a define is useful. In this case less so.
> 
> Anyhow, it's a very minor comment so never mind if you prefer to leave it
> as it stands.

I added it to V6 .

I'll wait for the integration time reply above and then send V6 .

