Return-Path: <linux-iio+bounces-21353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E0AF958A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF1B5819EF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC71B532F;
	Fri,  4 Jul 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wvt49SsH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAE19F115
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639493; cv=none; b=ds6Tf0w4YMu7RoGXXv9sQf0HD40/0UkWW6NURXsVs9D16JHlbMDBmlC+5+Bk1FGzgRQMH1maXZ5xoz1Z/j6/SIjkJ19RQ/FTTYVJw25sKZyTG8zOssehnia6dtfY8cAGWT0s6fRyFwIfHvpZUvr4BqrZ/ZOVsyK7OPASWBkfyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639493; c=relaxed/simple;
	bh=b52C+U5bQaP9z+z//dF0zycSMtn9eLujZEpRiMtsPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnoMMGXeq2WFRyP6Q/wJGxLhpzSNCv68n+c7TOyC+jnrFVYAgW+gN9UvnrlaE/I7zFUqd/A26UHEYRPwKw5vfSBGksagABrzLCrNNzL4Hrf1j5YytnmR0Ol0Ksy2O2/7ziHAgNVqyQex3G4YCtJ5DizgKDGCFj4Hzdj9ouVBt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wvt49SsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155D2C4CEE3;
	Fri,  4 Jul 2025 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639492;
	bh=b52C+U5bQaP9z+z//dF0zycSMtn9eLujZEpRiMtsPy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wvt49SsHDlb6FGEV9jD8t/y7Nqsvi+xT/CrfgIym8znNgTRsaxjoOyt0/EdoN+3Cj
	 BODUeGYhn0ZoLqGRckzVVdAPJVh5sFd95qUNCuhoorSI1y2Ytz7ct7yuxdjSPf97Ht
	 KeHeydkAltem1qgRuUFg64y6+03NbwVPyygnLQH4=
Date: Fri, 4 Jul 2025 16:31:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.16
Message-ID: <2025070406-scam-jujitsu-716f@gregkh>
References: <20250701185650.4c5a6872@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701185650.4c5a6872@jic23-huawei>

On Tue, Jul 01, 2025 at 06:56:50PM +0100, Jonathan Cameron wrote:
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.16a
> 

Now pulled and pushed out, thanks.

greg k-h

