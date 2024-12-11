Return-Path: <linux-iio+bounces-13336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DB9ED4B6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEF1688A6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0884202F9B;
	Wed, 11 Dec 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRs+ikbT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C1204088;
	Wed, 11 Dec 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941806; cv=none; b=cGfJJqeesVFhybged3HYUcIN1d7/f+jiTnv09aCjlPO/cxTyP3hmIf2GmDE33e+ZEnknYEAsCBBO35tXkLtj1+sFNGJTO+T0LJvkmfR7ANu9eh797ulYYKKL/gX1if4sDYC8NGPut81uX/ArySOpYk8sLmOUKsxZz49k+b6nyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941806; c=relaxed/simple;
	bh=3EOPBqTl7kOiXAdzXvznRh9sU5nZldiuzqryJ/CeS/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHiM8l7gi8FMKC1S9PudNkoK7Q6HmeCbrmpmmd/OgFhQ3EzYiWpUpvetUPRBUCHTbmM92Y4PzxKYt/3Ne5J3xrId1RudHDv2sZ73+2gxbx3Gpatr4mWMcyCK1yRvmP6i52OuTNLl2lfKNXJzdZnFQ2vDfaA9zI0rrlfSG1fjJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRs+ikbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91894C4CED2;
	Wed, 11 Dec 2024 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941806;
	bh=3EOPBqTl7kOiXAdzXvznRh9sU5nZldiuzqryJ/CeS/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRs+ikbTgJ//ePzjAixtOtsqlN7s6XebBPOU0MOXmAkGHvUVuHwuIAkf8if5GcT3y
	 ueVaq3p+vQ3rFKDYu1gL7eFJ1qgUSPem4YIhJwSWVlBcZLrXSw0KntB7g0UykX592G
	 1ga5Tdt+HcMK5WxugypcBTQboSfroam2kuap+5jx8d/H6oK6uz7BhiMoum9xUbSged
	 J/j0tkSM4fI2O3zLMFHggpozZcGy/GxT4QvqlIY60cWJa73nU2G651JI/VRgo/fl+f
	 /sdQTyHaqRbErQQDB13C4oF2PrXmEn/I/L40N/hAAWZDDNLAaikArqF8AJqTAZ7sja
	 z0sMOeRUALfuw==
Date: Wed, 11 Dec 2024 18:29:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, gregkh@linuxfoundation.org, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Split devres APIs to
 device/devres.h
Message-ID: <20241211182958.5afc82c4@jic23-huawei>
In-Reply-To: <Z1Y9uqGyq-yuxoEe@smile.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
	<20241203195340.855879-2-andriy.shevchenko@linux.intel.com>
	<20241208171001.4994e749@jic23-huawei>
	<Z1Y9uqGyq-yuxoEe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 02:45:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Dec 08, 2024 at 05:10:01PM +0000, Jonathan Cameron wrote:
> > On Tue,  3 Dec 2024 21:48:51 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > device.h is a huge header which is hard to follow and easy to miss
> > > something. Improve that by splitting devres APIs to device/devres.h.
> > > 
> > > In particular this helps to speedup the build of the code that includes
> > > device.h solely for a devres APIs.  
> 
> ...
> 
> > > -#include <linux/overflow.h>
> > > +  
> > Unrelated change.  
> 
> Which one? Blank line?
I think that's what I meant :)  Was a trivial comment though.

> 
> ...
> 
> > > -#include <linux/cleanup.h>  
> > This header movement is unrelated.  
> 
> No problem to let it stay at the same place.
> 
> > I agree both are good but probably want to be a separate patch.
> > 
> > Otherwise this seems sensible to me, but your cc list seems a little short!
> > 
> > Greg and Rafael seems a good starting point so I've added them.  
> 
> Thanks! I need to check why they were not included into the original
> submission. Perhpas I need to amend MAINTAINERS,
> 


