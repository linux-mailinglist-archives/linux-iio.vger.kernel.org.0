Return-Path: <linux-iio+bounces-19769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A3ABF3BF
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A331BC3D33
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA23267AFD;
	Wed, 21 May 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQRJyK89"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130C79CF
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829254; cv=none; b=cEruZkpAZvfG2I/CrSfiTzaccU4qHFzU7JcwJJm60zOvwUrwj/connV14c86dR0eCJ8l05fY5f05PLJ2NN3yrBle2sLm9Ehfse0hoejKG3Pvk/3N6v7Xko3ZiMT4BgILlcDDNsIdXN4Ft2pue3MowE5hVjmp8DwNCvgqCUXbgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829254; c=relaxed/simple;
	bh=SRibIRI2ahb10eFrmpabxP97ZIlmrALG4XgDsqrfQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IywaWdwH1hscG7U8W720kkXBtMcurRIbeizghFLxROXm+bmeCzaoxZyL//SHEYDlXWYAF7Mw5xFP4yaiKEcLI0tviSg5BDUpzwHWCtQYlbNLEfhO/7ad0V9FIiPiRJsYhYr4j6K5JwPNukTn6mkWucfd8cCsGnX8emOot/l9kII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQRJyK89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9C9C4CEE7;
	Wed, 21 May 2025 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829252;
	bh=SRibIRI2ahb10eFrmpabxP97ZIlmrALG4XgDsqrfQog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zQRJyK895mOn1muJeIOBUhKcq0uknl/+nz7p4uDcdRoDyCewnLyQEcOx0oKjm5QHb
	 OKvuEvOgWP0Zq8cltTe0w6/Ptb7+PNXGX7Waq1Xm+riS7SCQU54FQE4ydascCLzZqx
	 0EppBFXbrFFZCJJFMl/z1T9Eoprx2hGowyMW4pAY=
Date: Wed, 21 May 2025 14:07:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter fixes for 6.15
Message-ID: <2025052145-culprit-underdone-c69b@gregkh>
References: <aCBHEaGd0qlzkZa5@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCBHEaGd0qlzkZa5@ishi>

On Sun, May 11, 2025 at 03:43:29PM +0900, William Breathitt Gray wrote:
> The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:
> 
>   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.15
> 
> for you to fetch changes up to 7351312632e831e51383f48957d47712fae791ef:
> 
>   counter: interrupt-cnt: Protect enable/disable OPs with mutex (2025-05-03 08:45:11 +0900)
> 
> ----------------------------------------------------------------
> Counter fixes for 6.15
> 
> A fix to prevent a race condition when accessing the Count enable
> component in interrupt-cnt.

I took this into my -next branch BUT for some reason you have this
commit with a Fixes: tag but NO Cc: stable tag.  Which means it will not
get pulled into the stable trees automatically.  Are you sure you wanted
to do that?

thanks,

greg k-h

