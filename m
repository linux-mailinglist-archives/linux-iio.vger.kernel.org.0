Return-Path: <linux-iio+bounces-21968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E7B10A8D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D183BF402
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382F2D3A6C;
	Thu, 24 Jul 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgXVKLuQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA1E4A4;
	Thu, 24 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361285; cv=none; b=jieTFEMjXDIybe8OU6fLNSHbrvyY7th7EsLkUn/cnFA7j7V/k31o95pEGJ9Dva8tzC+p6eag8dKfDxNR1S6RYLspK6BUh490E/39jatmBUlANwATRtYNH+ehEWK6f6sZ4m1Zm77oIhR9NfyQRXS2Y+jnoaqjH+UTCmrnJIwGFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361285; c=relaxed/simple;
	bh=Iq4Zfgan0e05gZ3HYwToOt0i/vXkzvYddxAGBSEawMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6wDNpy0QsiAOLm451bZOMsZi7DzaNLckUhfRlBbpDAHldJFUfJLC1QNKysZViOdT0VPLDAO8gDC2bKQcJ0Ij9xlNNW4dCyriEsLDdmE4IJHhFqt1O5Vp/OEA9Ls2fdX31f0UAZ0y1wxj3TAWk29rzwPnYwlCrv8XNpT5H9L2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgXVKLuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3502EC4CEED;
	Thu, 24 Jul 2025 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361285;
	bh=Iq4Zfgan0e05gZ3HYwToOt0i/vXkzvYddxAGBSEawMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BgXVKLuQDcpmiqLMNNGFY8NGFCzIiILodBEfIaCLUCOl1xuVW6KV0CiI/euZi6SPr
	 +SiZZbAfiq477M9OWwNYdU4AzBkDwwoE+lZjJWsXdL6YZA7UN71HlOsD6Yk3Tvee1T
	 3YtZREITIFbLbALbsZcyO8d0HalpDIg214kFnt93plG00Q34xMRZlbQGUXNUS2K0sB
	 7NTNyta/L9Y+FkD0v2qQU2n1dkZOjCrHK7fF2va7GalwPOxoBf3IgkpGAMm/c6qtbZ
	 fP8JAa4ssgS1UuCowr+k+GCI5kwKUL9nEpv+dcKTVp9rpgxdUAmwDVZzqKYhf+5ILX
	 B6+IE03tdAsIw==
Date: Thu, 24 Jul 2025 13:47:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, ~lkcamp/patches@lists.sr.ht,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel
 and avg sample before setting register
Message-ID: <20250724134758.43df3ccc@jic23-huawei>
In-Reply-To: <aIDoZHBjO4tU3Gkh@smile.fi.intel.com>
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
	<aIDoZHBjO4tU3Gkh@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:49:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 17, 2025 at 07:13:49PM -0300, Rodrigo Gobbi wrote:
> > avg sample info is a bit field coded inside the following
> > bits: 5,6,7 and 8 of a device status register.
> > 
> > channel num info the same, but over bits: 1, 2 and 3.
> > 
> > mask both values in order to avoid touching other register bits,
> > since the first info (avg sample), came from dt.  
> 
> Is there any issue with a Shift key?
Sprinkled some capitals.
> 
> > Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>  
> 
> ...
> 
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> >  #include <linux/completion.h>
> > +#include <linux/bitfield.h>  
> 
> While it looks unordered, it's still better to squeeze a new header to the
> place which organises a longest (but sparse) group of ordered headers. This
> will reduce churn in the future for the ordering changes.

The full set is currently:

#include <linux/mod_devicetable.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/property.h>
#include <linux/interrupt.h>
#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/clk.h>
#include <linux/err.h>
#include <linux/completion.h>
#include <linux/bitfield.h>

I'll move it to before clk, but that's only a really minor improvement!


> 
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>  
> 


