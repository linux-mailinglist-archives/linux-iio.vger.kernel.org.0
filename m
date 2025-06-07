Return-Path: <linux-iio+bounces-20299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF75AD0E64
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7E81643BB
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5F81F461A;
	Sat,  7 Jun 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohkjZ4gp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C5184F;
	Sat,  7 Jun 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312328; cv=none; b=e1cFPdqEbmMnpxybQVKCqMXuAhD8wM211+Nn/oVvwIaiKVjDZIipNc9oNiYBK/u+yNoPsNPxMywy9f37HH6MzCxbU4Du3iXdldjgiUiK/Pcn3u9R+s4Pvp+82LaQNGLCrGP66LX55igQyKm8SfvJV+R7hq8G5bAuPud7eDe9S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312328; c=relaxed/simple;
	bh=/2Oid7V9igQ//eRZiHAbFXNzy1VUD4A4Fxpgl8aQLgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvJigwjCSNk3xdy8ofCOErnEhaB0PKp9lH0vzDblGzR1tqoMplOWhGevWenyUnhIkCJu0zMAKwSMfiNhAMIf8fwhfePEmpaLWMaKOdRS3EF7igkaWvezbl5Ps5guSZL51JQ+EYKEtxhXYpZDGpcy5zFWNLxGS78q4OWLL+DWgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohkjZ4gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F66FC4CEEE;
	Sat,  7 Jun 2025 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749312328;
	bh=/2Oid7V9igQ//eRZiHAbFXNzy1VUD4A4Fxpgl8aQLgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohkjZ4gpjMRplCqFCSujT7SV5nwR7LaDwhBHe4526q5+NklW2hLduk8sGjNhP5VFV
	 XrtG5lSe+OvpsGxgJPsGUmVtCThMDIyVHU5uD08KZmAv7qlibtkBtaSUBRGgyXb2AV
	 7J4zleMlaGxjrFvCqzmJzCED6gmWzAHE1xhSDrzQ4R9MsRr8+iTiCziaSLVuI/x3wZ
	 oqQdk5Efm7d4XT0DssERhm3v20kPcUt3MoW1dbo9iUH7yiOkNO1Uk3rxhK2Ifp2Mmj
	 hBapp0H/YXroldf+Uyc91ORBwa+bnI3ITCOUaRpOZTr4/Fzx+ZXK1wn0T4SS11kNhz
	 lsGY1VYcXs51w==
Date: Sat, 7 Jun 2025 17:05:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: ti-ads131e08: Fix spelling mistake
 "tweek" -> "tweak"
Message-ID: <20250607170521.4001eb9c@jic23-huawei>
In-Reply-To: <aEBmhUv-xpNgmv6v@smile.fi.intel.com>
References: <20250603165706.126031-1-colin.i.king@gmail.com>
	<aEBmhUv-xpNgmv6v@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Jun 2025 18:30:13 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, Jun 03, 2025 at 05:57:06PM +0100, Colin Ian King wrote:
> > There is a spelling mistake in variable tweek_offset and in comment
> > blocks. Fix these.  
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> Datasheet doesn't give any special term for this, so I think the patch
> is correct. OTOH, the dictionary defines tweek as "A form of atmospherics
> (radio interference) produced when the high-frequency components reach
> the receiver before the low-frequency components." which is somehow might be
> related (like high byte goes before low or vise versa).
> 

I think this is just tweak so applied.  (I'd never heard of tweek so interesting
to know about that one!)


