Return-Path: <linux-iio+bounces-620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EC804431
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 02:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CA11C20C02
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805317F1;
	Tue,  5 Dec 2023 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="nDYd7mEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5EB4;
	Mon,  4 Dec 2023 17:43:33 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 55E50870B7;
	Tue,  5 Dec 2023 02:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701740612;
	bh=WtPjUVf5j3WC4+8LX7w7DclZoF+g78ryXngm3BZJZVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nDYd7mEi/0+Z0RbhV3XhsVpj9SfeMOChKEW4HLNIuWySz5XUEcRXXbLgiRxbjKg35
	 fIVTdo8TNluP9Rot6PdTXj6CoRDKBgCKwXvsuZoei3R53a0pYGdjqelpvAW+msEMUb
	 fzFrwYdovij0VdtXyT9vCnYgrx66K2D/ZQdwIs5a9RpPPiL5C4RPtso90OuBJVR4O1
	 3RqUBfjIjTb+7RnYnEfwIwgSeXRGNTO6akU2bpej74Bl+PSjB0WbCCfO++NEvXbLYI
	 MQpft9QuQh3EW5uDmuPpbHdtCeXPki6wG5+jtvlEbs2I5yPnVHebT1o+29XGEvlJR3
	 798LyeTl6VU/A==
Message-ID: <0ae6466f-479a-476a-adf4-3bd099235eda@denx.de>
Date: Tue, 5 Dec 2023 02:43:30 +0100
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
 <20231127212726.77707-2-marex@denx.de> <20231204112941.770e22cb@jic23-huawei>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231204112941.770e22cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/23 12:29, Jonathan Cameron wrote:
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
> 
> There is a additional question on what scale means for
> an IR channel.  There aren't any well defined units (as it depends
> on the sensitivity curve) so in general we avoid providing scale
> for intensity readings.
> 
> The datasheet has a vague go at working around this problem by
> using counts relative to IR measurement in daylight which would
> measure 210 LUX.  (via faking that with a 850nm green led??)
> 
> That's far from a standard..
> 
> We do have precedence of scale applied to intensity channels
> so I guess the ship has sailed.
> 
> Perhaps we should just add an explicit not to the ABI docs
> to cover that changing the scale in these sensors will result
> in the counts changing, but multiplying raw by scale isn't going
> to give any sensible units.
> 
> So probably not a thing to fix in this series, but to address
> separately.

Is something like this what you have in mind ?

diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
b/Documentation/ABI/testing/sysfs-bus-iio
index 0eadc08c3a139..584607f560d02 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -618,7 +618,9 @@ KernelVersion:      2.6.35
  Contact:       linux-iio@vger.kernel.org
  Description:
                 If a discrete set of scale values is available, they
-               are listed in this attribute.
+               are listed in this attribute. Unlike illumination,
+               multiplying intensity by intensity_scale does not
+               yield value with any standardized unit .

  What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
  What:          /sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain


