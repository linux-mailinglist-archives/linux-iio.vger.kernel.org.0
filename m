Return-Path: <linux-iio+bounces-11250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8BA9AFBEA
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CEA1F244CC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFB1C4A12;
	Fri, 25 Oct 2024 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnn/qp/t"
X-Original-To: linux-iio@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580B19993F;
	Fri, 25 Oct 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843428; cv=none; b=MUGtvnb4R11nr2YAEOU8uTDXlg1aYPqmjDTzaRQAlI88bEDwXx0FtWA7UUCF/u99hf3SMiYdbVaLm1U850zrlvv5tBvVuabZw+FWZea9OHPUENxf5+fEqLp0KwPg6MzXQV4szEA0PSEVoruK181efmGfc4TDeOFsSUuZfUnj1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843428; c=relaxed/simple;
	bh=2aPKfNALzkpJp29hMibBDxsN/1IEQFWjWaeTxWeCVGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEG1WPZisQRISwDGO/Z7OnlaoEPKNPGtYPMT6q19qyTzLi/hNzfb2DkOifZASKJlR+Kx/TIhQs21oDGn374o1lPg2Zg7t6PAeJ5TYMTGx6818lR92AlswsDEM4r8IpDjN23YuX5bch7g6n97ZErvf7Xe/ItSKTnCs+srkRX1nLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lnn/qp/t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i57bkHF9sQcl8RJiWITAQ/lKUm1zBjNfTfF9j6Jq640=; b=lnn/qp/tQw9gmpY9Ny+IraHsyl
	HMGoe7TNdUiZEKgc+PK3c7oijk6TcsS8ruDatMGeM5s+GKzi6XBP8ugNgEmm16ipNchQfTgVZN7yD
	Pw6vVanPfhUmZfyb/zOfjd+bpYVwiqP8pjijGQpq5hj17JHZE7KqeEDEbOXOKKQuchsgV/aRFVUcj
	q6ihAOSgJp7s7P05z2UlEgR+EsNYwAKusJvtU7gtEW8infOFrDagcRWBzv9fAmy1eOWgyOCOAYhiA
	IwM/oRynDY1Ra9SkQURlVIMgDaMacutk5AYodTv5OgLVCJtLN3cnVFofUPRzf6KUwdkgqI0VlKdYE
	i1nhWZKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4FIM-00000004zVi-0wtq;
	Fri, 25 Oct 2024 08:03:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 36AD2300ABE; Fri, 25 Oct 2024 10:03:42 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:03:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Message-ID: <20241025080342.GE14555@noisy.programming.kicks-ass.net>
References: <20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e@baylibre.com>

On Thu, Oct 24, 2024 at 11:12:10AM -0500, David Lechner wrote:
> Replace usage of iio_device_claim_direct_scoped() with
> if_not_cond_guard().
> 
> This makes fewer lines of code, less indentation, avoids having the
> error return statement in the macro args, and avoids needing to use
> unreachable().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is addressing the build failure reported on Peter's locking/test
> branch [1]. I've done a test compile locally with LLVM=1 and it compiles
> successfully.

Updated it. Do note, I had to still: s/if_not_cond_guard/if_not_guard/g on
this.

Assuming it all builds now, I'll push out the two cleanup patches to
tip.

