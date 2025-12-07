Return-Path: <linux-iio+bounces-26918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1DCAB982
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045A73004788
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C862E0B71;
	Sun,  7 Dec 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3I/R5pK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E212D839C;
	Sun,  7 Dec 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765137384; cv=none; b=gdC67Z4c9wEdI7jJZpsX/MFRM5lWt8yYyVM0wc6SMXrZykc4NwAnVmyGRAK5UlPpNerI4EAF1WlmmFB7SiKLKi5iWCsPvCgwWsOsQnKmbipow/DCNTA09G9pglidQn7eclb7XSDYg1xchPyxe8yiGxQFV4MwEv8TdQ0WYtpriTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765137384; c=relaxed/simple;
	bh=0deVdN2tw0uwmwWzij6NAyvqEtFvxMegmN58/qDKTcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ltr6fX9JCb/kOdecyJ/a/zn48H0uSzjDgUyh/E3rU6SteCvREmtYX4jJk3U1xbcTSKc0I2y5/lPFTCg+y+MKAgxyeorU2WX3WiHqrCYZaVL58mWXS7m+9L48KQGTuNjR8Jh/VFeJOrVmKz6DINfxZCKXy8T24GVYz5Sm+/Y5lsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3I/R5pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF245C4CEFB;
	Sun,  7 Dec 2025 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765137383;
	bh=0deVdN2tw0uwmwWzij6NAyvqEtFvxMegmN58/qDKTcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3I/R5pKm+cUVwflUmf112xMi2EAa7z4mj2pt1iRFLe3H0P0kKCR7vWHWdZ2r2ARK
	 J+qvaHnct958KqNm9LrCDor4IExjFvHx2Rcs6b/mnIPBp7Keth3LruSG5TmL0p6caR
	 CaX3loUE2Frsi40EdVdxeaeYMBgJ/NaLjPydNLyW2DV/T/4U5M78mVMUia2bNoiaoY
	 cTgQKngqIy2BhgK8cwGRQBDLxdGIfJ29tWc3ojPaCzxJhNZsoykms1NIMAS6BOfqui
	 h8VHA+VQMOS4FJz895rZe0lHLpTzPCsuLwL+wSWV4yyuhzWFQcTBYWlFQFawkhRrtx
	 fy1ONZc6CNl3Q==
Date: Sun, 7 Dec 2025 19:56:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Tobias
 Sperling <tobias.sperling@softing.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251207195613.0e222b3a@jic23-huawei>
In-Reply-To: <5b843df0-138e-4e2e-a70d-beb8a39ed85f@baylibre.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
	<20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
	<20251206200721.5e683a83@jic23-huawei>
	<DES3ZWAKXXEB.2LQPMDZN4JFCB@gmail.com>
	<5b843df0-138e-4e2e-a70d-beb8a39ed85f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Dec 2025 11:12:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/7/25 10:02 AM, Kurt Borja wrote:
> > On Sat Dec 6, 2025 at 3:07 PM -05, Jonathan Cameron wrote:  
> >> On Thu, 04 Dec 2025 13:01:28 -0500
> >> Kurt Borja <kuurtb@gmail.com> wrote:
> >>  
> >>> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> >>> analog-to-digital converters.
> >>>
> >>> These chips' MOSI pin is shared with a data-ready interrupt. Defining
> >>> this interrupt in devicetree is optional, therefore we only create an
> >>> IIO trigger if one is found.
> >>>
> >>> Handling this interrupt requires some considerations. When enabling the
> >>> trigger the CS line is tied low (active), thus we need to hold
> >>> spi_bus_lock() too, to avoid state corruption. This is done inside the
> >>> set_trigger_state() callback, to let users use other triggers without
> >>> wasting a bus lock.
> >>>
> >>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>  
> > 
> > ...
> >   
> >>> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
> >>> +	.type = IIO_VOLTAGE,							\
> >>> +	.channel = _chan,							\
> >>> +	.scan_index = _index,							\
> >>> +	.scan_type = {								\
> >>> +		.sign = 's',							\
> >>> +		.realbits = _realbits,						\
> >>> +		.storagebits = 16,						\
> >>> +		.shift = 16 - _realbits,					\
> >>> +		.endianness = IIO_BE,						\
> >>> +	},									\
> >>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> >>> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> >>> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\  
> >>
> >> What motivates per channel sampling frequency?
> >>
> >> Given you have to write it each time you configure I guess it doesn't matter much
> >> either way.  
> > 
> > I guess making it shared by all is simpler too, so I'll go with that.
> >   
> Just keep in mind that if there is ever some use case we don't know
> about that would require a different rate per channel, we can't change
> it without breaking usespace. Once the decision is made, we are
> locked in. Keeping it per-channel seems more future-proof to me.

Only way I can think of that might cause that to matter would be
if the complex dance to avoid the onehot buffer restriction is added.
Given you gave this response I went looking and that might make
sense as an enhancement as the SPI protocol would allow a crafted message
sequence to do this efficiently.  Extension of figure 15 where first message
sets config and after that they read out channel and set config for next one.

Given that is sane, I agree with you that we should probably keep these separate.
I doubt anyone will use different sampling frequencies even if possible but you
never know.

Jonathan

> 


