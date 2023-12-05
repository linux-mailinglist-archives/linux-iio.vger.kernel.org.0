Return-Path: <linux-iio+bounces-654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C895A806005
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 22:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714891F2173E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074616AB97;
	Tue,  5 Dec 2023 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hZ6TuF4k"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554BD18F;
	Tue,  5 Dec 2023 13:02:36 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 174CF870DE;
	Tue,  5 Dec 2023 22:02:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701810154;
	bh=f+N2Yu7AIHQddi497s2W5pp+WWb2A6s6ckPENX6+zcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZ6TuF4k9gPudiU82Tr0x83+v+Nv/Sx7rejRG4TjO3njQagWh2AjqGUFNQ2X1cmN9
	 cQiDqM71epHBTvTAQR73riP+D41IareubPtZbiMNN5J+Eh04jztcZ1koNgn1mVl5jA
	 OubeaDdlwJEilZCKx3NH4WTkCjXvMFYgvVOfkov9LYhzmL7qMAenw9FCcNRUm6UcxP
	 3Eckt4RTBHpAQDGQ+A+zyoSSYtqfUP9WnOKfN0cca21BqrPHhILkigtvRr8xRjzJtn
	 IjD4/fKkEy8rxzcdjFLkVODWcgspXOPq9dcDdbiLvylRpRhxAkJvP+XOAf9oSldbZj
	 AptGcaLZ0RP4Q==
Message-ID: <62015c87-cc24-4ab6-9c91-605926f1c572@denx.de>
Date: Tue, 5 Dec 2023 22:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZW9Hwm5LnPGl4Ird@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/5/23 16:54, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 02:43:30AM +0100, Marek Vasut wrote:
>> On 12/4/23 12:29, Jonathan Cameron wrote:
>>> On Mon, 27 Nov 2023 22:26:53 +0100
>>> Marek Vasut <marex@denx.de> wrote:
> 
> ...
> 
>>                  If a discrete set of scale values is available, they
>> -               are listed in this attribute.
>> +               are listed in this attribute. Unlike illumination,
>> +               multiplying intensity by intensity_scale does not
>> +               yield value with any standardized unit .
> 
> (Do not forget to drop extra space)

Which extra space ?

