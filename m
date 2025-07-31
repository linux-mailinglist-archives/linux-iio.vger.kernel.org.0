Return-Path: <linux-iio+bounces-22166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03ECB17033
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5157B2E50
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9972BE65E;
	Thu, 31 Jul 2025 11:13:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4E2BE647
	for <linux-iio@vger.kernel.org>; Thu, 31 Jul 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960381; cv=none; b=sc1iMgcvbIx+48WmncTGdGjA9NXXNS0Q9YDRoexzk6xD1OSj9xQCW/dN3nvgu4Qi9Nk8LjUxIGZBFyjBVZbnFnetISx4GuD1qPrfSGE1ZJAUMMcLWEM6ZvkAWSA3yHnLTm7ZEoYtjTkPneNksERlthEqmeqg/qIlGQiJWMgQfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960381; c=relaxed/simple;
	bh=2LS7dfIY/ReX4aArJov9uhrofdBimWK+q6vAV3duFac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmO9yPJnxySe3KFX0xFGGd5XW8isVio4TVudPE2843+HPb4syw9mqQkY7kfjiwKg1OiPx5i7tHYM/VhZPlxU903+9i/cmtj9lDA6eWFTIS/Zy+EpDTpSMv5jA0p5IyZSBzF+Ikcg5nuiWbOjkzXhQyXUu29PjnE0RHJbJbCVS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt5tL1LlSz6HJgJ;
	Thu, 31 Jul 2025 19:08:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC1C414038F;
	Thu, 31 Jul 2025 19:12:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 13:12:57 +0200
Date: Thu, 31 Jul 2025 12:12:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC
 driver
Message-ID: <20250731121255.000025c5@huawei.com>
In-Reply-To: <9536f598-1d49-4742-92e3-0d2603c5267e@baylibre.com>
References: <20250727210639.196351-1-hansg@kernel.org>
	<20250727210639.196351-3-hansg@kernel.org>
	<9536f598-1d49-4742-92e3-0d2603c5267e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 12:50:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/27/25 4:06 PM, Hans de Goede wrote:
> 
> ...
> 
> > +static const struct iio_chan_spec dc_ti_adc_channels[] = {
> > +	{
> > +		.indexed = 1,
> > +		.type = IIO_VOLTAGE,
> > +		.channel = DC_TI_ADC_VBAT,
> > +		.address = DC_TI_ADC_DATA_REG_CH(0),
> > +		.datasheet_name = "CH0",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_PROCESSED),
> > +	}, {
> > +		.indexed = 1,
> > +		.type = IIO_TEMP,
> > +		.channel = DC_TI_ADC_PMICTEMP,
> > +		.address = DC_TI_ADC_DATA_REG_CH(1),
> > +		.datasheet_name = "CH1",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	}, {
> > +		.indexed = 1,
> > +		.type = IIO_TEMP,
> > +		.channel = DC_TI_ADC_BATTEMP,
> > +		.address = DC_TI_ADC_DATA_REG_CH(2),
> > +		.datasheet_name = "CH2",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	}, {
> > +		.indexed = 1,
> > +		.type = IIO_TEMP,
> > +		.channel = DC_TI_ADC_SYSTEMP0,
> > +		.address = DC_TI_ADC_DATA_REG_CH(3),
> > +		.datasheet_name = "CH3",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	}
> > +};  
> 
> Question for Jonathan: If we don't know the scale on these
> temperature channels, should we implement IIO_CHAN_INFO_SCALE
> and just always return an error? My understanding is that
> by not implementing it, the scale is assumed to be 1, which
> likely isn't correct in in this case.

Good question.   We have quite a bit of precedence of just
not providing scale in these cases.  The docs for the main block of _scale
do say

"If known for a device, scale to be applied to <type>Y[_name]_raw
 post addition of <type>[Y][_name]_offset in order to obtain the
 measured value in <type> units as specified in
 <type>[Y][_name]_raw documentation. "

Rather than trying to fix all those, shall we tweak the docs
to say that scale is assumed to be 1 if offset is provided?

If neither is there, the channel can be _PROCESSED anyway.

Your suggestion of returning an error would have been somewhat neat
long ago, but now I think it will just be too confusing for userspace.

Jonathan

> 
> 


