Return-Path: <linux-iio+bounces-546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA3801B0D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 07:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A431F21164
	for <lists+linux-iio@lfdr.de>; Sat,  2 Dec 2023 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524FB8C16;
	Sat,  2 Dec 2023 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qa5lbQNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC62FF4;
	Fri,  1 Dec 2023 22:48:15 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 23E4686501;
	Sat,  2 Dec 2023 07:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701499694;
	bh=SJQw8DaK4VYPp5Yeh5d4szEpr1yjYE0TnrTuEac1xnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qa5lbQNFZHYm6QzO+iNKeox2LWacguxtLGuWP4eYY/giu22B1F36ajv14RemtXKuv
	 HeNBkXZV29/eXNZ2vDMqZ1HLcHhBgeBsI1B70b6sCFEL2qw1wG+Nw4p/IusWLCWH+u
	 nyB3HCrX//3HkEhY+0jYNGcUXfppFGk61ITzCRxjxFyeL/Jt3A/NfF+HuUAypSFkax
	 z0u+W2jh6U3TyJcCdxFtwQPBzVCcmx1p6IgjZ+j7rjJONqwCCqRzlYUo04j0SQBi+1
	 baheDkAI3TsFCz0Rf4pTh5DMU+i00mBXae26MbEKzLyGIfd4hEJ4KoZLDxKJ2YnzYd
	 ILz3SFPBfXbJg==
Message-ID: <00a21ed4-18b5-4aca-8dd6-628d475664e7@denx.de>
Date: Sat, 2 Dec 2023 07:48:12 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
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
 <9e73c450-2380-459a-9b41-a1b88f89548c@denx.de>
 <20231201181721.0000445c@Huawei.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231201181721.0000445c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/1/23 19:17, Jonathan Cameron wrote:
> On Sun, 26 Nov 2023 23:09:36 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 11/26/23 19:16, Jonathan Cameron wrote:
>>> On Sat, 25 Nov 2023 23:26:23 +0100
>>> Marek Vasut <marex@denx.de> wrote:
>>>    
>>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>>>> other fancy functionality.
>>>>
>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> Hi Marek,
>>>
>>> One last question + a comment in general. Act on that if you like.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>>    
>>>> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
>>>
>>> Why have an available attribute for a single value. Is it useful for anything?
>>
>> To report it to userspace, iio-sensor-proxy uses that to control the ALS
>> poll interval .
> 
> It should use integration_time, not the associated available attribute.

So, what should I do with this feedback ?

I did send the V6 already, so shall I change anything in V7 ?

