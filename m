Return-Path: <linux-iio+bounces-27605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7AD0EED8
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26A4300C0C7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D13382C9;
	Sun, 11 Jan 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1jAGpz1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC121632E7;
	Sun, 11 Jan 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768136014; cv=none; b=NGYSNCkxoAOsvClK1+0R0UPY40/QYZA615HyF/5H/e1Rt0liaHXGsob4cQcadCnTGkRIcG1er6Y7sOil5NI+5o36Wecn7Z32AI2TRONAFdvJRjGwhGAPJ28tcXX5U18skpNXjOTUl2wLL6dk+vIjrsmtZmD4PZ/4calu3Sv+lpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768136014; c=relaxed/simple;
	bh=T+tGl0uO+pMSOU6FdeCk4ZnSSOJ6q7eaHMsFfHHrIQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJUkNFQuZhJPmXGpG/jaleZhrzsj/dnXeogL5C9ta7NprTEYQWFRgY46iLgoJuuedBInV84lrRd4qMiUjipP5sTbQiORCmKdxH3Shwu95wfhHeVb8xi5XCQ3o220pQyqPWEjmiXK8ChxoLL6XRBUudSXexxEVXJBaESWzjTcuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1jAGpz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16446C4CEF7;
	Sun, 11 Jan 2026 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768136014;
	bh=T+tGl0uO+pMSOU6FdeCk4ZnSSOJ6q7eaHMsFfHHrIQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1jAGpz1uIMOb1TJDlf03wGRA+xwjs+ZFwqs1ENH4+0iTpUIEvcx23Q0KL3TETcBU
	 bv0cs+sMJNUL2PavEWSMPEP1+Fe3xbGB8rSe8WXZpwIW2p7dQHzoKnchfYFA8cinWg
	 ACKcSZN7bnVZj6K9bh5HKvR+dzmEiQNzh0H4t3taEfTdV10PiJxlE7Ghc10R6jsL7y
	 l0gklgGlfNY5hjjdx8tN9Ssem9yga2XRI/E6m+l8LtcM1vXUzZKNnfgpDM41fHfn+7
	 szFjUOKMPb8tctz0onzMMq4jOVC2/G6S1wLK2VbCkdZGAoh+DRIUdc1gCwqnL5tchG
	 M7NDjhC08K+wA==
Date: Sun, 11 Jan 2026 12:53:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <20260111125324.0e86e990@jic23-huawei>
In-Reply-To: <aVkX6bCR8nkoUwQI@smile.fi.intel.com>
References: <20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro>
	<20260103-honeywell_abp2_driver-v5-2-0435afcf306d@subdimension.ro>
	<aVkX6bCR8nkoUwQI@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Jan 2026 15:21:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jan 03, 2026 at 06:35:17AM +0200, Petre Rodan wrote:
> > Adds driver for digital Honeywell ABP2 series of board mount
> > pressure and temperature sensors.
> > 
> > This driver covers 113 different pressure ranges and units on
> > both i2c and SPI buses.
> > 
> > The communication protocol involves sending two simple commands
> > to the sensor and there is no register access or a memory map.
> > For this reason the regmap API was not used.
> > 
> > The i2c address is hardcoded and depends on the part number.
> > 
> > Optional end of conversion interrupt control is present on the
> > i2c variants of the chips.
> > The EOC can also be defined for the SPI variants if a non-ABP2
> > but compatible chip is to be driven.
> > 
> > Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3).  
> 
> > ocuments/sps-siot-abp2-series-datasheet-32350268-en.pdf  
> 
> Broken link now.
> 
> > Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/d  
> 
> Should be in this line, but do *not* resend just for this, I hope if everything
> else is okay, Jonathan will fix the above issue.
> 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>  
> 
As I replied to v4, this is now a long way back in the tree so
I'm not going to rebase.  Please send a patch on top of the
testing tree of iio.git making the changes.

Thanks,

Jonathan


