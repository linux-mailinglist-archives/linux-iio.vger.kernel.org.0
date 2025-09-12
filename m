Return-Path: <linux-iio+bounces-24013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0AB550C8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3EA1C818F0
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71FD26563F;
	Fri, 12 Sep 2025 14:18:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B01F16B;
	Fri, 12 Sep 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686734; cv=none; b=R6J3EPirs0Kia2G68Hx0NHhwBNccCci0SwML1WMaxZNCY95NGy/sYmMjmRtix3zkPXJr8PdcnitasdhYljnqXk3YJMzxhRoJr64aypEdUb8vENgDj1eZ1RhKRU2tMQW5oPnlDi8FTKbAcUd/njdkFd5fi3DAGeN6uN4LUtdjcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686734; c=relaxed/simple;
	bh=F6GrmkoCEAOXZtxxQSAaFKv2Epo0dqUdTMBqm9EYMh4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpKeST9tpDqkYrrcJi/ivTMoT9JGLDjT9jBxGExXp7d8OYhOJKgHVfOAwsv9XCwJxW14w+M1ja69iPyaLlLihgUUMdkK4CtXqbyWL4aQy2boUimlHiERjO/hgzmH8qB5UVqiz+oZug9vSJcxWQ47t/ogl6iVwVXIE9HePPbhUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNc2M35Nxz6GDFg;
	Fri, 12 Sep 2025 22:17:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BA4241401F4;
	Fri, 12 Sep 2025 22:18:49 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 16:18:49 +0200
Date: Fri, 12 Sep 2025 15:18:48 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<s32@nxp.com>, <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<chester62515@gmail.com>, <mbrugger@suse.com>,
	<ghennadi.procopciuc@oss.nxp.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250912151848.0000470e@huawei.com>
In-Reply-To: <b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	<20250910155759.75380-3-daniel.lezcano@linaro.org>
	<20250910183212.6640e662@jic23-huawei>
	<b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 11 Sep 2025 14:55:00 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Hi Jonathan,
> 
> thanks for the review
> 
> On 10/09/2025 19:32, Jonathan Cameron wrote:
> > On Wed, 10 Sep 2025 17:57:56 +0200
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:  
> 
> [ ... ]
> 
> >> +/* Main Configuration Register */
> >> +#define REG_ADC_MCR(__base)		((__base) + 0x00)  
> > 
> > I'm not really convinced these macros help over just having
> > readl(info->regs + NXP_SADC_MCR_REG);  
> 
> That is really a matter of taste :)
> 
> I used to create this format in order to stick the macros with the 
> debugfs register code which is not part of these changes. There is a 
> similar format in drivers/clocksource/timer-nxp-stm.c or 
> driver/thermal/mediatek/lvts.c IMHO is less prone to error than base + 
> REG all around the code.
> 
> Do you want me to convert all the macros to info->__base + MACRO ?

I'm not that fussed if there is other code for related devices using this
style.  To me it adds little benefit but it doesn't hurt that much either!

> 
> [ ... ]
> 
> >> +static const struct iio_chan_spec nxp_sar_adc_iio_channels[] = {
> >> +	ADC_CHAN(0, IIO_VOLTAGE),
> >> +	ADC_CHAN(1, IIO_VOLTAGE),
> >> +	ADC_CHAN(2, IIO_VOLTAGE),
> >> +	ADC_CHAN(3, IIO_VOLTAGE),
> >> +	ADC_CHAN(4, IIO_VOLTAGE),
> >> +	ADC_CHAN(5, IIO_VOLTAGE),
> >> +	ADC_CHAN(6, IIO_VOLTAGE),
> >> +	ADC_CHAN(7, IIO_VOLTAGE),
> >> +	IIO_CHAN_SOFT_TIMESTAMP(32),  
> > 
> > Whilst we only insist on monotonic numbering, putting it all the way down
> > at 32 seems excessive. Why not 8?  Perhaps a comment if this is to avoid
> > moving it for some future feature.  
> 
> The ADC has 8 channels for external acquisition however others channels 
> 8->31 are described as reserved. They may evolve in the future to more 
> channels. That is probably the reason why 32 is used here.

Add a comment on that so we don't forget the reasoning.

Thanks,

Jonathan




