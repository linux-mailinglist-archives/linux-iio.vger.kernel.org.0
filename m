Return-Path: <linux-iio+bounces-715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D457D808926
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F47F282F68
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9240BE0;
	Thu,  7 Dec 2023 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oh0ok9Gh"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EDA10E4;
	Thu,  7 Dec 2023 05:28:08 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A5CF38753C;
	Thu,  7 Dec 2023 14:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701955685;
	bh=0wKxzcUCMw/n82kLhCV1yeT04V/Xsa1hN4v+coG+iAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oh0ok9GhptED24/O7hzP1nX++mJs44X0lSSIj1ah76fiHZIWkUG4bxzps32yRNc0Q
	 FSC4CtMwjLFQKdYUSVRrl3Cy3fPg1Z0dWhVAiMaOKhYvjlmgfzWQK4jed8pcILCqaD
	 CZ1gmUFV6XBHS5e0yjK4Wrtj2yEibU/3QOzypv/YdfVPJcKu6lB+kyOazFH2RzZSyk
	 8QFmliMltmzju2srguGJjPe2+gEVgyGV9yyL9yOTccLmkCMcHvVPn4d2dRZPq1FuFH
	 fgpwu+oD+OV4WuIS9KKZ16GW5XkmhkCZw0WqvyQ99pI/ksELxMg7sgVhOx8AgQYeyb
	 W9pDzJWDCzQhw==
Message-ID: <a59d6e31-5339-4e13-a5e5-f627206065a6@denx.de>
Date: Thu, 7 Dec 2023 14:28:03 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
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
 <6e4ed42c-21be-469c-a8bb-57779ef24bf9@denx.de>
 <20231204143521.5ca0fc7e@jic23-huawei>
 <e3d3cc61-0d31-4d83-92a9-07d74995a66a@denx.de>
 <20231206172049.3e0ce859@jic23-huawei>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231206172049.3e0ce859@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/6/23 18:20, Jonathan Cameron wrote:
> On Tue, 5 Dec 2023 02:24:51 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 12/4/23 15:35, Jonathan Cameron wrote:
>>> On Mon, 4 Dec 2023 12:23:06 +0100
>>> Marek Vasut <marex@denx.de> wrote:
>>>    
>>>> On 12/4/23 12:20, Jonathan Cameron wrote:
>>>>> On Mon, 27 Nov 2023 22:26:53 +0100
>>>>> Marek Vasut <marex@denx.de> wrote:
>>>>>       
>>>>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>>>>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>>>>>> other fancy functionality.
>>>>>>
>>>>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> Hi Marek,
>>>>>
>>>>> Discussion around available on v5 made me look closer at that aspect.
>>>>> You are providing all the available entries in the callback but they
>>>>> shouldn't be exposed to actually read unless the *_available bitmap
>>>>> bits corresponding to them are set.
>>>>>
>>>>> If you like I can just rip the unused code out whilst applying?
>>>>> Or if you'd prefer to send a v7 that's great too.
>>>>>
>>>>> Otherwise everything looks good to me.
>>>>
>>>> Maybe just do that while applying and I'll test it right after to see
>>>> whether something broke, that's probably fastest. Just let me know where
>>>> this got applied. I have the device on my desk .
>>>
>>> Diff is below.  Applied to the togreg
>>
>> I only found the commit in 'testing' branch , so I used that one .
> I messed up it seems and didn't actually push the updated version.
> Done so now along with squashing in the bracket tidy up.

Driver works just fine, still, thank you.

