Return-Path: <linux-iio+bounces-27884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406B6D38641
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B60B3029C1F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99728399A43;
	Fri, 16 Jan 2026 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We4owIwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE232B9A7;
	Fri, 16 Jan 2026 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593206; cv=none; b=Be4HbPJFLNw3sromugowtSCLcxDKcaVv0Xk/fSqU7FaGQXw3LKAUdiHZoq6c/p/i5Z/Xjka2wEX3NRHGndQQ4EFbPpB8SWIJs5a46ssarVz6zSUdy+/XQTy18aHEN/mhct7Vr3wBKdux2A6tO+mrOO+/abbrW9augr/b8L4H5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593206; c=relaxed/simple;
	bh=XgjY2XhLj/gBW2jS0mMmVSHPLcaoPzyeq6ziRC+q144=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNIB1t/dcaNq7wyWgbnL96ZqW/9trdH3u1w1LzQTNXRHHlLf+HkZ3cgZXz9hRCRY0MR17NuvqKqiMi/GbjAOavnoppEUTe6WuLNQmghpiBZNXztTWm16AYDUfgmLjUKoxc7l9FZ0b0UvU3KT00wQwUZie5G1vKhEn/JBtYfhGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We4owIwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6368CC116C6;
	Fri, 16 Jan 2026 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593205;
	bh=XgjY2XhLj/gBW2jS0mMmVSHPLcaoPzyeq6ziRC+q144=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=We4owIwg5y2oI/YyxbY4uhmA8gmHF/l8KcHWeCWWIYxa1jqkk4j58KQLoFIQv0TNh
	 lxnCA44b71HTrCzCiuSIrLL/vM4aWTZZlJdZ9bBEFA545wK2BanNMuwtcK2CfQU19N
	 Ibii4sXdGocFp/kwM54Q17oBFbNAd0wmpvzW/mdUPfFX44GDQ+pH0wdrZORR5s+7xP
	 RjBrE1AJ/vegLVIDOyZxpu8TyMRqBnWUT1CJ3Ph+QMr2W3aV5Ne125UXerzii8hRWF
	 AmfwthFlYk1/ou4NE+shjXEoZSrWr7WiaGcOXWAS0TjZupC5KWcEYlb7z7LaqDg1kR
	 LbYnCLj/KYovQ==
Date: Fri, 16 Jan 2026 19:53:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Francesco Lavra
 <flavra@baylibre.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260116195317.11c0978a@jic23-huawei>
In-Reply-To: <aWjyjLnNE-K0AyUi@smile.fi.intel.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
	<20260115122431.1014630-4-flavra@baylibre.com>
	<aWjsWzo3PXHKsdJX@lore-desk>
	<aWjwWF2XmXJb-iJI@smile.fi.intel.com>
	<aWjw7_poJUIh9HgI@lore-desk>
	<aWjyjLnNE-K0AyUi@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 15:58:36 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 15, 2026 at 02:51:43PM +0100, Lorenzo Bianconi wrote:
> > On Jan 15, Andy Shevchenko wrote:  
> > > On Thu, Jan 15, 2026 at 02:32:11PM +0100, Lorenzo Bianconi wrote:  
> 
> ...
> 
> > > > > +	settings = &sensor->hw->settings->sf_settings;
> > > > > +	switch (mask) {
> > > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > > +		u32 odr_mHz;
> > > > > +		u8 odr_val;
> > > > > +
> > > > > +		odr_mHz = val * MILLI + val2 * MILLI / MICRO;
> > > > > +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +
> > > > > +		sensor->hwfifo_odr_mHz = odr_mHz;
> > > > > +		return 0;  
> > > > 
> > > > break;
> > > >   
> > > > > +	}
> > > > > +	default:
> > > > > +		return -EINVAL;  
> > > > 
> > > > break;
> > > >   
> > > > > +	}  
> > > > 
> > > > return err;  
> > > 
> > > Why?  
> > 
> > I guess it is more clear, but just a Nit, I can live with the current implementation.  
> 
> At least what you proposed is the opposite to the style that is accepted
> in IIO.
> 

My preference is always to minimize flow I need to follow.
If there is a break, I expect to see something to do after the switch
statement and will scroll down to check what it is. 

Whilst not the only use, it's one of the reasons cleanup.h stuff is
really handy as it often means there is nothing common to do by
hand before leaving a function.

Jonathan



