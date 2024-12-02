Return-Path: <linux-iio+bounces-12950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FE9E0668
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E889D168983
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876A205AAA;
	Mon,  2 Dec 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8NksDRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA341C760D;
	Mon,  2 Dec 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151313; cv=none; b=d1VnA+2FVDWsi5mB8a+dxsx6jqQZy6NBBlv1EYbfTlkKLd9nSP3r4PWZ+bvBycdtmbq707tFgS4+kQviTj6nGeZjc7FxTsoCB7WCCis8eUZNJ8MUXHqbaO5UdWeabUNzCcf54auQ+n6wD3U8wF5HgSgWyY8V3KzKLkLheYP2VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151313; c=relaxed/simple;
	bh=Xi7z3mGKYAnFo2hmFL0lmu9h3tus4BKQg5mPtJ0FUhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKKR9KUyLqS3snlXWMeoU/sOLybCViD9GG5Rfk7DZ6utNPotTnffVuQz7G7f40v4/tww4XLa39rshgVZF9h/T/Ha3EqaDLQkLH5FQ4Ms2MP5Xb2bLYBvTRLJJvrY8MP7CcMaCfZiz3lucKuD1BiwJDwjaxlerVuhFaAeRtROsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8NksDRE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733151311; x=1764687311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Xi7z3mGKYAnFo2hmFL0lmu9h3tus4BKQg5mPtJ0FUhU=;
  b=G8NksDREv7P9A08h/qE25zr/SOtjymRYT21vnCZXeRzM+DqdZ+kslKqt
   uQudAzHutj2mo+QW8BjUQw3NkZtWaUoA76wCCa/6JisnOj453eCOTeXOo
   JUQPZnITJDE5RTLApnP7hIv2Fj5B8ptHklkmcv483OaFR7QY45BisZxyG
   bHHs/dVzNdf3ptG3iKswZAJCdTbmwsFTQTITEWEtButQLy9xJhP/HpnAx
   wVPNuJuyBalN2A0Lsi4nQIr+m23fjB+opGVLa3u3p1BsenRBs0C1HtTnE
   miecR4qf/EThYK/flrf+APeZJKdhw/0iF/JnIknJXxrLpKvRaNCowXFHI
   A==;
X-CSE-ConnectionGUID: CORq2IjRQN+nDrg9k/yr+A==
X-CSE-MsgGUID: f39yfV8TQz6DMGEfQtf6dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44700083"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="44700083"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:55:10 -0800
X-CSE-ConnectionGUID: HNqifk7jTMyUCk8FpgpNMQ==
X-CSE-MsgGUID: SVs3sPoySgazHwnjNAQBUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="97896772"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.139])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:55:08 -0800
Date: Mon, 2 Dec 2024 15:55:00 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color
 sensor
Message-ID: <2yc2igv2lxh3u4kmkz73httg3sp24ziagcoaa7unfupagji7zk@ezaue3umwe44>
References: <20241130174212.3298371-1-paulk@sys-base.io>
 <20241130174212.3298371-2-paulk@sys-base.io>
 <20241201115529.1375c6c3@jic23-huawei>
 <Z0yjTkXt0JhqdD15@collins>
 <20241202110659.00000171@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202110659.00000171@huawei.com>

Hello Paul :)

On Mon, Dec 02, 2024 at 11:06:59AM +0000, Jonathan Cameron wrote:
> On Sun, 1 Dec 2024 18:56:30 +0100
> Paul Kocialkowski <paulk@sys-base.io> wrote:
> 
> > Hi Jonathan,
> > 
> > Le Sun 01 Dec 24, 11:55, Jonathan Cameron a écrit :
> > > On Sat, 30 Nov 2024 18:42:12 +0100
> > > Paul Kocialkowski <paulk@sys-base.io> wrote:
> > >   
> > > > The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
> > > > with an additional wide (visible + IR) channel.
> > > > 
> > > > This driver implements support for all channels, with configurable
> > > > integration time and auto-gain. Both direct reading and
> > > > triggered-buffer modes are supported.
> > > > 
> > > > Note that the Y channel is also reported as a separate illuminance
> > > > channel, for which a scale is provided (following the datasheet) to
> > > > convert it to lux units. Falling and rising thresholds are supported
> > > > for this channel.
> > > > 
> > > > The device's interrupt can be used to sample all channels at the end
> > > > of conversion and is optional.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>  
> > > Hi Paul,
> > > 
> > > Various comments inline. Most significant is that this seems to be
> > > suitable for a simple dataready trigger that will make your various
> > > interrupt and non interrupt flows more similar.  
> > 
> > And thanks for the fast review and insightful comments!
> > 
> > I considered implementing a trigger in the driver, but the issue I found
> > is that the trigger is expected to be called from hard irq context,
> > while the new values are read in the bottom half. 
> 
> The trigger can be called from either the hard irq context or from
> a thread.  See iio_trigger_poll_nested()
> There is a quirk that you then don't end up calling the registered
> hard irq handler for the trigger so sometimes a bit of fiddly code
> is needed to ensure timestamps etc are grabbed.  Not sure that matters
> here.
> 

If the timestamps do matter: here is a (maybe relevant?) discussion for
an issue I faced with timestamps for a driver that supports both FIFO
and triggered buffer mode

Please note that iio_trigger_poll_nested() was called
iio_trigger_poll_chained() back in that discussion.

https://lore.kernel.org/linux-iio/Y+6QoBLh1k82cJVN@carbian/

> > I understand the triggered
> > buffer callbacks are executed as a thread as well, so there would be race
> > between the two which could result in previous values being returned.
> 
> With the above nested call it is all run in the same thread
> See handle_nested_irq() in particular the function docs.
> https://elixir.bootlin.com/linux/v6.12.1/source/kernel/irq/chip.c#L459
> 
> > So I concluded that it was more beneficial to preserve the synchronous reading
> > mechanism over implementing the trigger.
> 
> Definite preference for a trigger approach, but I may well still be missing
> a detail.

--
Kind Regards
Mehdi Djait

