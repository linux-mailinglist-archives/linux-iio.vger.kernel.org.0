Return-Path: <linux-iio+bounces-25474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4CCC0E690
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B6174FEDE2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97E3093C1;
	Mon, 27 Oct 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueDnygwb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896503090D7;
	Mon, 27 Oct 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574309; cv=none; b=QXCj+KpBNVNqx7zd/c7I9uUpVsIAnXcyedimycft5RD+wr2tIBYu3x5/h/u4HbA9IFrL8VP4j7R+dFzJjqFmv9DweowsqNRNfhSvn8hcKRF6g2+EWxFaheT7Wbi1L32Wn2plcWLe5Zh2/+RsWSujQhyb6ega5wmAoMKLeUweqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574309; c=relaxed/simple;
	bh=n3msU3UD9GX+xWDWAp/rD8x8/U0Q4zeDFmIgKJ5TDYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ8y3G66YmZ3DCZp0Z7ZcBYvTfVrW9nmWE4Av9rfm8y4ysekz014YdBGhTI82DGhSJPL6JsbFBwBcgTEpouVK2bSfQ3Lfy45RlkvgFLh6oNlFWsSUpE24bUhFkfeYmx7ZWz5KsXsl70pMtWuT7JqZNxYmOrwBg77DsbjWlKsgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueDnygwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A813C4CEF1;
	Mon, 27 Oct 2025 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574309;
	bh=n3msU3UD9GX+xWDWAp/rD8x8/U0Q4zeDFmIgKJ5TDYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ueDnygwbu8cdrg7gRKAFmnFxZ9YqXXIn8KS6nqfGnVBcoGinYtR5TAZ9UsHyzQ8Ur
	 e+JnItcDhMtC4q7P6bWWTDEGSA256PgdjGFhX0PY+OXE2VlG8qRigghA0CUCATO4+Z
	 6lqizi6tiUU7xiYGCtwwPvL4y/LBVsp5lE1jSfC2YmDn/In63l2lthUNIE/+PFmhK1
	 tPDLJD9D9xp7ShMZW4D2pAhwLyXt0hVPVajNgKmtP3RpFGr4WU343avMHEdsXGCS9l
	 ILILYwNLCIegQ5196JUaz+LzRuVa9xJEBijbiyD7U7bFyFXD2akMzEzJAVRHB7MMHU
	 PIF2gQu2sFvPQ==
Date: Mon, 27 Oct 2025 14:11:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <20251027141142.555a05e7@jic23-huawei>
In-Reply-To: <aP8Cx7gMxGfpfb6n@sunspire.home.arpa>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
	<aPjE-n0wKNIJd2-M@smile.fi.intel.com>
	<20251023182318.00004319@huawei.com>
	<aP8Cx7gMxGfpfb6n@sunspire.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 07:27:35 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello Jonathan.
> 
> On Thu, Oct 23, 2025 at 06:23:18PM +0100, Jonathan Cameron wrote:
> > On Wed, 22 Oct 2025 14:50:18 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > On Tue, Oct 21, 2025 at 01:31:49PM +0300, Petre Rodan wrote:  
> > > > Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> > > > based on i2c_verify_client() in bma220_core.c that would make core
> > > > always depend on the i2c module.    
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > But Kconfig for this driver is a bit strange. Usually we do other way around,
> > > i.e. make user visible selection of the glue drivers, while core is selected if
> > > at least one of the leaf driver selected by the user.
> > >   
> > This comes up from time to time.  There kind of isn't a right answer
> > to my mind in the trade off between complexity of configuration 
> > and desire for minimum useful set of Kconfig symbols and people wanting
> > to build only exactly what they want.  So we've ended up with a mix.
> > 
> > I don't mind setting a policy on this for new code going forwards, but
> > that means we need to decide which approach we prefer and document
> > it somewhere.  
> 
> I will come back with a new patch to Kconfig once you decide what is the best way to handle dependecies, but in the meantime can you please accept this current patch?
> 
> I keep getting automated errors that would be fixed by it:
> 
> https://lore.kernel.org/oe-kbuild-all/202510210604.mAtgE54g-lkp@intel.com/
> https://lore.kernel.org/oe-kbuild-all/202510222324.SxYlIaLW-lkp@intel.com/
> https://lore.kernel.org/oe-kbuild-all/202510271347.115BMnsC-lkp@intel.com/

Done. Was travelling (and on wrong computer).

Should be resolved now.
> 
> If the current patch does not correctly reference the automated 0day-ci reports please tell me what I should change within my b4 workflow.
> 
> thank you,
> peter


