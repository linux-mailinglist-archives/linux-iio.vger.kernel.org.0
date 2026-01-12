Return-Path: <linux-iio+bounces-27631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48218D11491
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 09:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1160300819A
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D0342C92;
	Mon, 12 Jan 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MmN64m3L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEC342526;
	Mon, 12 Jan 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207396; cv=none; b=LbTGTMSXrhtC1KrdyMG2FpH6ahSqG9BxmqQZ36m8QDd0M4P03keDW0MNq4qa+cTUR4b5/YOq5saa3HYHoY1fC8FqYkqkQpjQ7GRtsnuBGlVCYUfVjmvGHMojiIJKy/LeuKrCAb6knTNoXhd/uva0h47AQSkHOKYbicvwamwd+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207396; c=relaxed/simple;
	bh=ylg53CFQMcFOWZq+OaZP8KskwuBY1zcwOT/DVRs6FBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGM+iDB1yLiZlnxsjJ6I6Tnb3VfiTF8bcIn8b9YVHICkblUUH5JXKdjCCnppM/CJtXiVQZVetBCTXv0wYskFoBOT4KRTPnsq9AwlyA1qzT0UXk2lsVCGAuX3g/7Hfb+7ujwFpFwO9D95U1TnRB/+JWvzxO/iiIQzc15sDLN+2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MmN64m3L; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s0Hq7TpKuiBwJrLhHZ1L9fuGzvKt6/dBTepcFLwguoU=; b=MmN64m3LAgnbW+OBKYPXRA9maE
	P9f51MhW+XhYcvNPwtL+HC1MsnGaYF+NXj/jmhU7XWCdrQiVHpi5Y16eOAksVkwl0QkZb5NWpujJK
	H0bUUU66ZzHeJae/yYr8zi3GftNMeCfFPdxccqC3cji7XF5ZAmX8uiEywVgNFH2P6OkzhXBFEZQn1
	Ubs43hHWW0NVzeIO4H+KCOx/LHV/vX3sOWY0w0XybB1BHvsLvGPHqY1ri37For01XQG9jDMPONrkN
	0iLcpBOd2BE1boDlbokTLKkk0QFiwhg1v+gVGi1J62pOkjfVFngYmHS3dKL4VF4UaK8pU/oyPgV2V
	2wIv7z0Q==;
Date: Mon, 12 Jan 2026 09:42:59 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Jonathan Cameron <jic23@kernel.org>
Cc: akemnade@kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
Message-ID: <20260112094259.4648cfaa@kemnade.info>
In-Reply-To: <20260111123200.6871a41b@jic23-huawei>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
	<20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
	<20260111123200.6871a41b@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 12:32:00 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 31 Dec 2025 22:14:17 +0100
> akemnade@kernel.org wrote:
> 
> > From: Andreas Kemnade <andreas@kemnade.info>
> > 
> > Define interrupts properly. Unfortunately, this hides a bug in the linux
> > driver, so it needs to be used with the driver fixed only.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Not related to patch 1 so if TI soc folk can pick this up that would be
> great.
> 
well, it needs things fixed via patch 1 to avoid creating havoc...
But from a strictly dogmatic point of view the devicetree describes the
hardware, so it is unrelated.
... but from a more pragmatic point of view, I do not want to have interrupts
enabled for drivers which do not handle them correctly.

Of course this should be picked up by omap folks.

Regards,
Andreas

