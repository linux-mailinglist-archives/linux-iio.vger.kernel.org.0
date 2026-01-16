Return-Path: <linux-iio+bounces-27878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B6D385F1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D49A3016B8F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069593A0B2C;
	Fri, 16 Jan 2026 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoyBVWtg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446339E167;
	Fri, 16 Jan 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591965; cv=none; b=QiGVpf5aiBLofsUUGqHTg08k5/NnEvv8GfzTmsLFAVqCzVHiI5foMSgkGnnwl+baTDSo+yafgjF2d0DmBOJ90XAiRbjrTNs4ZrUK8GZpgS769JDbFSi8ciB8gmyfHHy8RjSscM4fx/6qse2QOUivVFaLt3lyuvAwTgS4TL+VCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591965; c=relaxed/simple;
	bh=6HsSb/fP8gXYd+dhG24kcRinx/PwdNIxCVHSYmMbCww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWwlaCczjVU7+VNBpl1JnKBm1ayQsrapMG5llSiB954LUHfrjctmgndMr5MPoZlL7MRo4MLQNBi8As+rPpR7DGwm5gNEwg5+dlQJYpgTL1+cWVTtxt96+gjPFLRBQ5jfGbwnrMrGkWVDWLU9MIh5TGNe5NRF61jrcpsp18rc/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoyBVWtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E14C116C6;
	Fri, 16 Jan 2026 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768591965;
	bh=6HsSb/fP8gXYd+dhG24kcRinx/PwdNIxCVHSYmMbCww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PoyBVWtgBBFesHjbJoDX3TjmpYYfb1Jma9iBottpDfPafzQPm6gn5heh+TziTVyMU
	 GwtyqOZNGtRkhPxl9I11P30unhSVBRNAwrcademrCDubU3+tGs6X6qx2KK4FBWqKqk
	 8tgtaxMtKmVFTAwNKASdxBTC+LnHWwZXjWaqmHFd2979vLPKPOnG1ACr1EVVAxt1dA
	 uuBw58aknqgT1OlgRdkxly/3ynkwgIlUWi+AeJTFSVJ9EiDWTSbbVQhWo91SSC7c3i
	 TdyATQY9H/ppnU/nBJCdyJ1hEwAuToVxXSXcj7z/MSzx63PKiskmz6cEoGOWcBH3rh
	 ZAyObHMAe5EWg==
Date: Fri, 16 Jan 2026 19:32:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: accel: adxl380: Introduce helper function
 for activity detection
Message-ID: <20260116193236.55954b67@jic23-huawei>
In-Reply-To: <aWlN1c4miwb94mOZ@smile.fi.intel.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
	<20260115175350.1045887-3-flavra@baylibre.com>
	<aWlN1c4miwb94mOZ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 22:28:05 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 15, 2026 at 06:53:49PM +0100, Francesco Lavra wrote:
> > Motion detection functionalities (such as activity and inactivity
> > detection) are only available when the chip is in a low-power mode; this
> > affects the available sampling frequency values.
> > In preparation for adding support for a new frequency value, introduce a
> > helper function that checks whether activity/inactivity detection is
> > currently enabled; this function will be reused in a future commit to
> > determine what frequency values are available at any given time.
> > No functional changes.  
> 
> ...
> 
> > +static int adxl380_act_inact_enabled(struct adxl380_state *st, bool *enabled)
> > +{
> > +	unsigned int act_inact_ctl;
> > +	int ret;
> > +
> > +	if (!st->chip_info->has_low_power) {
> > +		*enabled = false;
> > +		return 0;
> > +	}
> > +
> > +	ret = regmap_read(st->regmap, ADXL380_ACT_INACT_CTL_REG, &act_inact_ctl);  
> 
> > +	if (!ret)  
> 
> What's wrong with the standard pattern?
> 
> 	if (ret)
> 		return ret;
> 
> > +		*enabled = FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
> > +			   FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl);
> > +
> > +	return ret;  
> 
> 	return 0;
> 
Fully agreed. Whilst it's a tiny bit longer, it is a lot more consistent
to always handle errors out of line and good flow inline.

Jonathan

> > +}  
> 
> 


