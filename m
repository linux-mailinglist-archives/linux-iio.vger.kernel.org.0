Return-Path: <linux-iio+bounces-27587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B64D0EB3F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCE3300DA6D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BB335559;
	Sun, 11 Jan 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTaIm9so"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E02C21D3;
	Sun, 11 Jan 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131197; cv=none; b=Mey/r5x3D/UBJjh/+3Rr5+gH1b2xFytV1xEImbjRLaUg1Idnq/7Z9ABV68+LwVMPDZA2QP9WgGab+rQzIA2bnpZVp5d9Z4KkbnwuEh52DR+1jUFwNY82zPN9NQo8+nuYMrRJ7dfYmcj6Q6FLz+B6cxX56XKMjCwnwOW2VLpmEQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131197; c=relaxed/simple;
	bh=61jN0u6N/7FdllL+22N9CPsVrpSeGc94JQmwpLCa7O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3tGaDcPWesMz28GsmmHT5um84igqM/FNNQHFe2uvBe4y08lcp+FO/J7GpsQU4O1yKSD8S8UOwF7P+Hblk+NrFY0fvUrOD+4Bq+FGZAT3d80i8qKfUV3Wz+KWQfqt3SfmOyTP78lvaf4nZb51BtneQvQX0KYpx2dytYBvghMAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTaIm9so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C6EC4CEF7;
	Sun, 11 Jan 2026 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768131197;
	bh=61jN0u6N/7FdllL+22N9CPsVrpSeGc94JQmwpLCa7O4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTaIm9soQSvtAiQx+vZGdTlTKetupzcUUaCKBxt+LIBTHoqN7eCDNMPfeqQDVPj4X
	 gfi/Hil7h978iwDm5AhppM04oTEVtkeFllpHVlJ6AFndCGTgql8PanKv+DAPy//Vcp
	 XhA5cfK1YppvUZVfvzorIqYL13M9hmdrz0LGlJDDLekOKNOu03yC6GCnuDHWNb4CkR
	 dlaHi1t6X/P22/wb5X6dQSkS/GWlDURMD7fZvjZyLFMGovwzrNgfMt03dEDXjRn7Ff
	 rqX7WB1XCEQrfNgtPea8rATvgm4eCOP4jMr9lFspe8I5h8rOHdujqBGSEjHd33x7tl
	 Bi7zK2kfLoIlg==
Date: Sun, 11 Jan 2026 11:33:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Benson Leung"
 <bleung@chromium.org>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Gwendal Grignou" <gwendal@chromium.org>, "Shrikant Raskar"
 <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
Message-ID: <20260111113305.415941e4@jic23-huawei>
In-Reply-To: <DF97Z8HIH640.49M8GK9XPEXZ@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
	<20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
	<20251227144707.1bebcf27@jic23-huawei>
	<DF97CCMNGWVP.2JBZR7CQF1FID@gmail.com>
	<f1c1ca8d-7896-4ccd-b59b-8c6c1bf4fa66@baylibre.com>
	<DF97Z8HIH640.49M8GK9XPEXZ@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Dec 2025 13:44:35 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Sat Dec 27, 2025 at 1:24 PM -05, David Lechner wrote:
> > On 12/27/25 12:14 PM, Kurt Borja wrote:  
> >> On Sat Dec 27, 2025 at 9:47 AM -05, Jonathan Cameron wrote:  
> >>> On Thu, 11 Dec 2025 21:45:21 -0500
> >>> Kurt Borja <kuurtb@gmail.com> wrote:
> >>>  
> >
> > ...
> >  
> >>> Given earlier discussion about this one being rather more tricky
> >>> to name than the claim_direct because claim_buffer sounds like
> >>> we are grabbing the buffer, I'm not sure on the best naming to have
> >>> here. iio_device_claim_buffer_m maybe?  Ugly though and
> >>> these are super rare so maybe this isn't a particularly major
> >>> concern.  
> >> 
> >> Yes, it's a bit ugly, but as I proposed in the cover letter, if we go
> >> for a full API rename, it shouldn't matter for now?
> >> 
> >> What do you think about that?
> >> 
> >> I'll go for iio_device_claim_buffer_m() if I can't think of something
> >> better.  
> >
> > iio_device_try_claim_buffer_mode()?
> >  
> 
> Yes, that's better.
> 
Agreed. That's nice.


