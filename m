Return-Path: <linux-iio+bounces-22837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A1B28EAC
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563663BAB99
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE72EFD9B;
	Sat, 16 Aug 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIpOxMKg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B52E5D38
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356199; cv=none; b=rERBvLOhPMVcZSH2mI1ZNxThkdTz7iY7pLYQJ+/73Zbr9UUBiOtILfbc1IbyNJAkooGml/CmSkxoc5/EJ/wExmZ3ZnnOjlenMMFrnNDuhqE8e7WTWh6Ebxc8gZ1NVvadhS6hDECvCFIWQEDJr+fyPxg7xTV8h+SzGnfXrHgrzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356199; c=relaxed/simple;
	bh=CLrslxKUIBG8bRUZlGQgeucNJvV2cWod5Cf4xYLBxYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru2xiUnBrXoq86y00uXHJr9iOaNEWVHCkezcUiLNd7hGjUWGfyzwHFgOYhoWOhuiFC5TvceQP3BwlX0afrC4eFwmLbjBy1mnPLT1oxNjygOgPBmyLABKaZCiTVPyy0eoI/7PKZUvZ4BzI0o+shQsthlV6g+vI9VOvInjQVHf5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIpOxMKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35403C4CEEF;
	Sat, 16 Aug 2025 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356196;
	bh=CLrslxKUIBG8bRUZlGQgeucNJvV2cWod5Cf4xYLBxYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rIpOxMKg4MfEcFp1vXgeKwbbm/lzrFDGTsvULT0L/IJ3TI0vH4fa1ZXD4MrqyO4+D
	 i1Xgz8DPONdRtGduVY3Jdzw+3Ct/jKIBFtTnfXXAD4d8eMRvKUI/Dr2AycZrsor+Tp
	 aca9o5rA7WE7nPNE3CuoFCD+X80sTotAzXo327odWzzJ/ynyQrK+EKwCrlBvOLJ9m8
	 hJl+9cuoLCYUEOYkb8KwsRzdU7lDRBlgMU5dADD2xMb7FlIl8SmC+sSgcWtSIz3ddN
	 UL3zgdlvGrrCboGzxcIIsyKQWwPnkuM8U96mqr30R1oxKIAi6bjrsAkfXulPy44eFo
	 N8tMt+SEk8Bhw==
Date: Sat, 16 Aug 2025 15:56:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/16] iio: light: st_uvis25: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155626.702dc43f@jic23-huawei>
In-Reply-To: <2d5a629a-3e95-44f6-ab8c-80894013b968@gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-12-jic23@kernel.org>
	<2d5a629a-3e95-44f6-ab8c-80894013b968@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 10:09:56 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/08/2025 19:44, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Also move the structure used as the source to the stack as it is only 16
> > bytes and not the target of an DMA or similar.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Tweaked description inline with Andy's comment on earlier patch and applied.
> 
> > ---
> >   drivers/iio/light/st_uvis25.h      |  5 -----
> >   drivers/iio/light/st_uvis25_core.c | 12 +++++++++---
> >   2 files changed, 9 insertions(+), 8 deletions(-)  
> 
> 


