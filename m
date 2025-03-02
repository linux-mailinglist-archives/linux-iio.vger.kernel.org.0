Return-Path: <linux-iio+bounces-16232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5BBA4B12C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AAF188FB76
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA31DB366;
	Sun,  2 Mar 2025 11:29:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5F23F362
	for <linux-iio@vger.kernel.org>; Sun,  2 Mar 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914944; cv=none; b=fA4he7sGT+cdLXurI9kUeOu/Ap7ghKxB4GUwpyKp5xEaApwmpjGU9ZLXgLwwwp3FHF20+gNMF+FRj9xQ77EmebjFBhDUuxVtvraLi06saOaIIADfry/NaG9sOP9sgrgNyETitnzfS++u+tNrHc2KwnZgB5rIjRHNwdog1vqPLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914944; c=relaxed/simple;
	bh=23aweMb9y+zwrd/oW/+ODKLjtvkuDtsifEk1fO91XAs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJsdtqfVDJkmCH0rwRWTx+T2MEjATkeyjFUUQphc52JsLgaiMzXPSBc2qZlVqOiXTMQBJlNnxpDCQAz26KZ8skqcIK9DqINf1lisOMZa87SFhiXW1fRNgYeFm6f2N0qqCpZq9oO7vAXhZe9MLII4NlC8PuhhweafKtASjJdnA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 850de69e-f759-11ef-8392-005056bdd08f;
	Sun, 02 Mar 2025 13:28:53 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Mar 2025 13:28:52 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
Message-ID: <Z8RA9DL3vE5sMRIC@surfacebook.localdomain>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
 <Z7o62qQDyWLk642C@surfacebook.localdomain>
 <7416028f78ba0e10e8d1722edd67756e13c3867b.camel@gmail.com>
 <20250301033725.2718db6c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250301033725.2718db6c@jic23-huawei>

Sat, Mar 01, 2025 at 03:37:25AM +0000, Jonathan Cameron kirjoitti:
> On Tue, 25 Feb 2025 09:18:38 +0000
> Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Sat, 2025-02-22 at 23:00 +0200, Andy Shevchenko wrote:
> > > Tue, Feb 18, 2025 at 10:34:57AM +0000, Nuno Sá kirjoitti:  
> > > > Don't use of.h in order to include mod_devicetable.h. Use it directly as
> > > > there no direct dependency on OF.h  

Just noticed a stray 'h' at the end.

...

> > > >  #include <linux/delay.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/mutex.h>
> > > > -#include <linux/of.h>
> > > > +#include <linux/mod_devicetable.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/property.h>
> > > >  #include <linux/regmap.h>  
> > > 
> > > Can we preserve the alpabetical ordering?
> > >   
> > 
> > Ups, my bad. Jonathan, should I re-spin or can you directly tweak it?
> 
> Tweaked.  

One more time, please? :-)

-- 
With Best Regards,
Andy Shevchenko



