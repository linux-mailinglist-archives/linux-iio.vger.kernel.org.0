Return-Path: <linux-iio+bounces-5142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26468C9D11
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CDB1C2133B
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562854675;
	Mon, 20 May 2024 12:20:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24DD27A;
	Mon, 20 May 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207636; cv=none; b=gYP9HCApHyiinPZYVu/0TzQhmhDyq1YTb1I9qAFARmCMcxiIqT60znOz1noC+GA2vixaWGp5mPoBlU9+biXgDgG9buiLIUw7+7mhKoDsRUU3Jl73Q37/T8uMuKMLjoCqvXm2Krj0l3/eW6ura5ogwOk9541I/Evhj23p7chqBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207636; c=relaxed/simple;
	bh=ObRVKHWaB4CM5RTO0eg5J95HnSHERG6Nnl09+CO0QO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGLY4YWhUxJK+pJRZjgku6rL6fhxyannb6cBNZC8EOcTUKOBJdwD3J3h/EbU/9vze8BxcEmneKbqXDWRSQKF9Da6sKPkzER4o5Nk5GhW8R/WvkKw7O3BOpFYmMK8ZOvCmTnxhIdt2S4DKwmWGZFYOrwq5YETsg7IngnlzEujLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjc4p6zyyz6JBVR;
	Mon, 20 May 2024 20:16:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B8791400DD;
	Mon, 20 May 2024 20:20:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 13:20:31 +0100
Date: Mon, 20 May 2024 13:20:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	<michael.hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lars@metafoo.de>, <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<nuno.sa@analog.com>, <marcelo.schmitt@analog.com>, <bigunclemax@gmail.com>,
	<dlechner@baylibre.com>, <okan.sahin@analog.com>, <fr0st61te@gmail.com>,
	<alisa.roman@analog.com>, <marcus.folkesson@gmail.com>,
	<schnelle@linux.ibm.com>, <liambeguin@gmail.com>
Subject: Re: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240520132030.00000838@Huawei.com>
In-Reply-To: <34c21023-441f-44e4-a427-f3e2bb2f5c15@gmail.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
	<20240514120222.56488-7-alisa.roman@analog.com>
	<ZkNijKz0N7PPvmeU@smile.fi.intel.com>
	<20240519190304.4d93530a@jic23-huawei>
	<34c21023-441f-44e4-a427-f3e2bb2f5c15@gmail.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 19 May 2024 22:37:58 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> On 19.05.2024 21:03, Jonathan Cameron wrote:
> > On Tue, 14 May 2024 16:09:32 +0300
> > Andy Shevchenko <andy@kernel.org> wrote:
> >   
> >> On Tue, May 14, 2024 at 03:02:22PM +0300, Alisa-Dariana Roman wrote:  
> >>> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> >>> dynamically configure them in the devicetree.
> >>>
> >>> Add sigma_delta_info member to chip_info structure. Since AD7194 is the
> >>> only chip that has no channel sequencer, num_slots should remain
> >>> undefined.
> >>>
> >>> Also modify config AD7192 description for better scaling.  
> >>
> >> Some non-critical, mostly style related comments below.
> >>  
> > Tweaked a bit. And applied.  Please check the result in the testing branch
> > of iio.git.  
> 
> Thank you guys for the feedback and for making the adjustments!
> 
> +/* 10th bit corresponds to CON18(Pseudo) */
> +#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
> +
> I noticed this comment got away in the testing branch.
> 
> 
> +static bool ad7194_validate_ain_channel(struct device *dev, u32 ain)
> +{
> +	return in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR);
> +}
> And the negation got lost here.

Ouch :( 

> 
> With these little changes, tested on board to make sure, running perfectly!
> 
To make sure I don't mess it up again, could you post the fix and I'll squash
it into the patch on the tree.

I blame caffeine (for no particularly reason ;)

Jonathan

> Kind regards,
> Alisa-Dariana Roman.
> 
> 


