Return-Path: <linux-iio+bounces-18412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5461EA95013
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB216B5F2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8D5261591;
	Mon, 21 Apr 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+mQihMe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B22561DA;
	Mon, 21 Apr 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234283; cv=none; b=ptTan9N17QYO5/Ak/T3Lwabzq7cR9ziis93UXH9iGhjoINV/hdEhg+AurcyWcdRon3WBd4nOY8F21Oub9oKK9W9jipYy3qHgK7+mVIBd9nauleBxfojceuvhvwLDXmJuAFmhwL0ghoR3geN+1JRsuTcM0UTBwMDW8O5BTappIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234283; c=relaxed/simple;
	bh=USOlz+eqtQB3+FtKVUspdDKmHiwUiEaAqh+xoaci2Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuNmsbDrUgNL4aP4V4aXEp2X9joXdL7r/2BTAQGAHHVsbwG7uCCMoAb0b27L1FUV5na6Us55OIvvxUCk9/MezbV1ObYDTaLLHKiIaL1igfAS93QpRyE0sqYymfy0vOD6wB2aeU6M54MWLu5bIxHsNCWLs1IZs6//Famx2hDjv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+mQihMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45781C4CEE4;
	Mon, 21 Apr 2025 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234283;
	bh=USOlz+eqtQB3+FtKVUspdDKmHiwUiEaAqh+xoaci2Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+mQihMeljmxRToq4vLWJkTWNB90Va0fKqkBYzu8vYC/MxjJU+CG72R4LBbJjLo91
	 BoCMnbHxkzQ4LOxaYbDmIgJ3nuQN1MPCHL8NgOEvFlsGvdRUSoWFv0CfMKT3FZVeL0
	 IRECzDhQsSUeucp1L8AUQhNisZ3q6aICkBfUhTkIGIaHjWJFvNa/AAHnTMmqgJn/jO
	 psgr+Q6iCj5qDorPs38PyrAyftZMpqSug/e2BC/U96v26UwTTTbEqbWdyW//8Tp143
	 bSrG78Fde/w6848U8BZXQom1OxXevS9DAtMMEs8A0QXlLOfFyH8P74CUfbmzAfuOWF
	 TkMaau80HEy7Q==
Date: Mon, 21 Apr 2025 12:17:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/10] iio: prefer aligned_s64 timestamp (round 1)
Message-ID: <20250421121752.5a7a178e@jic23-huawei>
In-Reply-To: <abe0db44-b27f-4cea-9edc-862e4096f80c@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
	<abe0db44-b27f-4cea-9edc-862e4096f80c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 18:05:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/18/25 2:58 PM, David Lechner wrote:
> > While reviewing the recent conversion to iio_push_to_buffers_with_ts(),
> > I found it very time-consuming to check the correctness of the buffers
> > passed to that function when they used an array with extra room at the
> > end for a timestamp. And we still managed find a few that were wrongly
> > sized or not properly aligned despite several efforts in the past to
> > audit these for correctness already.
> > 
> > Even though these ones look to be correct, it will still be easier for
> > future readers of the code if we follow the pattern of using a struct
> > with the array and timestamp instead.
> > 
> > For example, it is much easier to see that:
> > 
> > struct {
> > 	__be32 data[3];
> > 	aligned_s64 timestamp;
> > } buffer;
> >   
> After sending [1], I realized that some (perhaps many) of these would actually
> be a better candidate for the proposed IIO_DECLARE_BUFFER_WITH_TS macro rather
> that converting to the struct style as above.
> 
> Case in point: if the driver using that struct allows reading only one channel,
> then the offset of the timestamp when doing iio_push_to_buffers_with_ts() would
> be 8 bytes, not 16, so the struct would not always be the correct layout.
> 
> As long as the driver doesn't access the timestamp member of the struct, it
> doesn't really matter, but this could be a bit misleading to anyone who might
> unknowing try to use it in the future.
Agreed.  

These timestamp inserting functions have always been a bit weird. I kind
of regret not just leaving it as a per driver thing to do, but that ship
long sailed.  I definitely want to keep the layout apparent in the drivers
though so this approach only applied to 1 of the ones in this series.

Jonathan

> 
> [1]: https://lore.kernel.org/linux-iio/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com/


