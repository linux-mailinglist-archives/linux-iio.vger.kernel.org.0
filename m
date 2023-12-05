Return-Path: <linux-iio+bounces-656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E78062C2
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 00:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBDE2820DD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 23:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750E405FE;
	Tue,  5 Dec 2023 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kSbyj5x5"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD01B1;
	Tue,  5 Dec 2023 15:11:40 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4165686D10;
	Wed,  6 Dec 2023 00:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701817897;
	bh=89Pwr4A+LObOBTtUkWIj1tmP5pCkLj29nfLDYovVCdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kSbyj5x5CQ3m1HecmzdFLs+WeSCilRaSbaagFD9+JEEOraX02VVJiW3BUum5Ew9td
	 cpONxXaoY8KZx5Uv9M7ydpNUu9fvuwEobvV8pgDz1YttzBSNdJocXujDiJ3QlpRQ8n
	 ApcO8SseCARN5NQVAAjg9MAoU7sHlv1VtF56e12IaRKlzNoZTC2Aqm8LV1BkOPk6fN
	 UbMAeLn6QKRTWIQ3R/Js1te9ewt/YRv6LFCWLTAQr5woWPRGxyB/6XaYfOyYROzrYc
	 BRD5CuM74l4Xe+HWUjhL//U63oSqwB1+MpRA0yqzbuHWSHGk1gs9Ey20KBzDXciuWf
	 RTbcx2WL+hpXw==
Message-ID: <5eabd094-45bc-4adb-ab25-1b76352c1115@denx.de>
Date: Wed, 6 Dec 2023 00:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
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
 <20231127212726.77707-2-marex@denx.de> <20231204112941.770e22cb@jic23-huawei>
 <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
 <ZW9Hwm5LnPGl4Ird@smile.fi.intel.com>
 <62015c87-cc24-4ab6-9c91-605926f1c572@denx.de>
 <ZW-c44H84hZPNWl-@smile.fi.intel.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZW-c44H84hZPNWl-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/5/23 22:57, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 10:02:32PM +0100, Marek Vasut wrote:
>> On 12/5/23 16:54, Andy Shevchenko wrote:
>>> On Tue, Dec 05, 2023 at 02:43:30AM +0100, Marek Vasut wrote:
> 
> ...
> 
>>> ...unit .
>>>
>>> (Do not forget to drop extra space)
>>
>> Which extra space ?
> 
> Like in your question :-)
> (I left the only relevant context, easy to notice.)

Added, thanks.

