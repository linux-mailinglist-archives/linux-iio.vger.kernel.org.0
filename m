Return-Path: <linux-iio+bounces-5385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556DC8D1817
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1060B2894F4
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BD16130D;
	Tue, 28 May 2024 10:05:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97351021;
	Tue, 28 May 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890718; cv=none; b=V6ycOkaLECMCWN271GL4R1xiIZ1tZXceMLUk4tC8WMQ5V4YE2Knq/abSa+7M6j2dznfGoAXSEc6rbd2IxfHCqpdPjl7adPdHUr0ypIQ8iE9wnWvce+VKE9G2F1Xx/rgPd1ZhW9qHvvptlnfUz2DdcErDi7JDDxI1MHfvDn9iFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890718; c=relaxed/simple;
	bh=SRcYTZBLE8y2e1/1r9ygLjdIMLPRef74Z1w77qnd6aw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpBiS3vq9Dd6+xfPVbUejZy20bsZ0MP7zRlUCgE8AuEnxO4ydkx6ezGUh23roXJ/t+2Ww918wXTKhOVyj4m6SoevJtoGul7MHFHEP8ukqTnn0r4jazUvL5c+8KbK6meBIa3G5etJAQyiLGx3i8aAPERFs1OJKiaQuSUxgoVqafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VpSly22V1z6K9F5;
	Tue, 28 May 2024 18:04:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5022D140B63;
	Tue, 28 May 2024 18:05:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 28 May
 2024 11:05:12 +0100
Date: Tue, 28 May 2024 11:05:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Arthur Becker <arthur.becker@sentec.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Message-ID: <20240528110511.00006fe5@Huawei.com>
In-Reply-To: <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
	<e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
	<ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 28 May 2024 07:23:03 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

> Thanks for the Review!
> Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-binding file.
> I'll modify that the next time I make adjustments to the driver.

It's absolutely fine to have shared bindings even if the
drivers (because of different register interface etc) are completely
separate.  It's a good way to keep bindings aligned between
similar devices.

Jonathan

> 
> Kind regards,
> Arthur
> 
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 27 May 2024 18:31
> To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS bindings
> 
> On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:
> > From: Arthur Becker <arthur.becker@sentec.com>
> >
> > Device tree bindings for the vishay VEML6040 RGBW light sensor iio
> > driver
> >
> > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
> > ---
> > V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
> > along with v2 of the driver but not in a set)  
> 
> It's basically the same as veml6075, so should be put there...
> 
> Eh,
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 


