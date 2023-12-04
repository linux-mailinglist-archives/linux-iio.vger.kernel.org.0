Return-Path: <linux-iio+bounces-567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DE80316A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3491C20A63
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E422EF8;
	Mon,  4 Dec 2023 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pRTV6FL4"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBD9C;
	Mon,  4 Dec 2023 03:23:10 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4438F87708;
	Mon,  4 Dec 2023 12:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701688988;
	bh=XkFcIw8F1X8M0JhSxOrwg4Heu0z/3VpkYreg0zZNBXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pRTV6FL46RqR105r5hZAVF8C4wMhx1w6tlnXwqBELDZhlkgOTX7kDnommZpk4ueKA
	 zUX6VoTPjWHoQFB6Hokj11qw17DICbxWSoAVFvoGFXHODUAg8rGN9K8gexnWJn/wfo
	 fzQWb8hiGPTtI3NwrCrH3HWeCVlvLIADVgqiHTYwF2/tHOM8iOSXBBIRu7G0pMJpJe
	 bEQl4G0e3eNXms9T7Jz7PKefg2Ti2iZkAlfW2/eKmWn7EIjSmF71pqRsN44PIVIbhp
	 fwrdkzQ6xachp9xmDpRqE41ROJkrxrMMlZ95E7dzIb4JJFQm2dyZ9NvAnslUgCoKdw
	 E9j5c0HYpMzng==
Message-ID: <6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
Date: Mon, 4 Dec 2023 12:23:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
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
References: <20231127212726.77707-1-marex@denx.de>
 <20231127212726.77707-2-marex@denx.de> <20231204112001.7dff7066@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231204112001.7dff7066@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/23 12:20, Jonathan Cameron wrote:
> On Mon, 27 Nov 2023 22:26:53 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> Hi Marek,
> 
> Discussion around available on v5 made me look closer at that aspect.
> You are providing all the available entries in the callback but they
> shouldn't be exposed to actually read unless the *_available bitmap
> bits corresponding to them are set.
> 
> If you like I can just rip the unused code out whilst applying?
> Or if you'd prefer to send a v7 that's great too.
> 
> Otherwise everything looks good to me.

Maybe just do that while applying and I'll test it right after to see 
whether something broke, that's probably fastest. Just let me know where 
this got applied. I have the device on my desk .

