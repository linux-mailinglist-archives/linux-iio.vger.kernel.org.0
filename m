Return-Path: <linux-iio+bounces-21526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D02AFFF1E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2879C5A1477
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FC2D6611;
	Thu, 10 Jul 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="jKqujF+X"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDB27FD5A;
	Thu, 10 Jul 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143044; cv=none; b=DNVGJfqJ6wiw8NpZKcfI3KluP4JAWuxlrB6/BgDTtTuLxpr+RL//jsEndhamk4W1ecjH4FCi0SnuRRZeItWjg3BBqoJwjhD/4A7r4Fz4QrKn6oTBuQKEVaYCdfAtV4BESTWlI+gUiT06aoscGpY51j5ZUICaKqF/g5FaursGuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143044; c=relaxed/simple;
	bh=AQ/J9THDUl9sKXMswle0non7KDNpXUkQiO4AwVVqe/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzj8C2d/UjD7ycHfeQKe5J7guMWbSL7nOdT++PUiqyqRN/81V1ZDe80QE3C0+LJnMTzpVxVietHPzX+5FgVbenqtK/qoS7/GC8eVF2gevFr8Oe3VSeMoLcw64DnrxrWFbHiumUbFU64V5bEBO7SoL+u1ceNypnQCHrJekvl/tOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=jKqujF+X; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rqsAZLGhFuNxn7FEmeaLa9mYFTex/7gLFWe6hyGIPKg=; b=jKqujF+X2Dw/rtWVGBaKfu3a2c
	0sZYm8fqmDUF6PRcNTVEg03N2Vx4GSBjyRPAWFsnXEDmJII6K3P74CTupU8W/43I2XYARDDOwW6es
	0mOvatHxA/RNFPNe41Y/dN8ftUx+fYtI2bEoLljz/iDnQUURpNmpWxdxHFbbIl10Pg8zc4qpookFQ
	pQZwrjo3P5+pXBiJsoRy0ezcVjkMMR1z+N0auJNcNh8iH7WkVSYkMfk0/BkP8eCQzYye2I1hd5h15
	r+XU0k+eHVek857nvRAydXiEGHsPbYq6R8VlX+RL2KSGTRjneHabEVVlZa+Kzo9d4SkOesfbSATgH
	PH0q47Yw==;
Received: from [89.212.21.243] (port=48522 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uZoRc-006kdW-1b;
	Thu, 10 Jul 2025 12:24:00 +0200
Message-ID: <42dd658e-555a-43f7-a7bf-e5365d508f4a@norik.com>
Date: Thu, 10 Jul 2025 12:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: imx93: Make calibration parameters
 configurable
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 upstream@lists.phytec.de, andrej.picej@norik.com
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-3-primoz.fiser@norik.com>
 <aG-GZqhABwErcEyM@smile.fi.intel.com>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <aG-GZqhABwErcEyM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Andy,

On 10. 07. 25 11:22, Andy Shevchenko wrote:
> On Thu, Jul 10, 2025 at 09:39:04AM +0200, Primoz Fiser wrote:
>>
>> Make i.MX93 ADC calibration parameters:
>>  - AVGEN: Enable calibration averaging function,
>>  - NRSMPL: Select number of calibration samples,
>>  - TSAMP: Select sample time of calibration conversions,
>>
>> in the MCR register configurable with the corresponding device-tree
>> properties:
>>  - nxp,calib-avg-en,
>>  - nxp,calib-nr-samples and
>>  - nxp,calib-t-sample.
> 
> ...
> 
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/property.h>
> 
> Keep it in order.

OK. Will fix for v2.

> 
> ...
> 
>> +	ret = device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
>> +	if (!ret) {
>> +		if (val != 0 && val != 1) {
>> +			dev_err(adc->dev, "invalid nxp,calib-avg-en: %d\n", val);
>> +			return -EINVAL;
>> +		}
>> +		reg = val;
>> +		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
>> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, reg);
>> +	}
> 
> Please, since it's optional, do other way around.
> 
> 	val = $DEFAUTL;
> 	device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
> 	FIELD_MODIFY(...)
> 
> Similar approach may be used for the other properties.

OK, I guess I could implement it like you suggested to explicitly set
the default parameter values.

But in current implementation MCR values are read at the beginning of
imx93_adc_calibration(), meaning calibration parameters are register POR
defaults. With you suggestion, we put defaults in software rather than
reading them from the hw directly.

> 
> ...
> 
>> +	/* write calibration settings to MCR */
>> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> 
> Please, factor out this to the function, so we won't see the direct IO in the
> ->probe().

Sorry I don't understand this part.

What do you mean by factoring out this writel()?

Do you perhaps suggest to implement function
imx93_adc_configure_calibration() and put all our changes into it?

But we are already in imx93_adc_calibration() which is separate from
probe().

Please explain.

BR,
Primoz


