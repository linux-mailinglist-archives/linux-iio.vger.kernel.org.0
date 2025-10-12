Return-Path: <linux-iio+bounces-24984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAABBD0827
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577093BA7EC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56722EC0B2;
	Sun, 12 Oct 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEEDutV8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842319258E;
	Sun, 12 Oct 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288618; cv=none; b=lMJ9qoUG2f8+xbbq6ah8lhELUW61hH4xIgXbqWUgHm1SEOg2wPXZsgQqul517p8El1d4dUgnSp/+rYxJHoFWW1Sx3Oq95RJfqlSt9VjaMJR7hOAgu+I2AXB/NgMyyN1chp+iw28YIPXZQPYvWulkx+B3pGPimozG/RtELN8BdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288618; c=relaxed/simple;
	bh=drlLQGlwLQo2pYW3pURe98GZgeWSVpXQQiStRl+tcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXbasHB2HjJeUK/IXomoNdutWr2Ak4bFG1dOTw60U91ZrFwMQGC/tBnr05TLUzb3oT5CqoUYfASaJgU9s0YylUJl8k9FYc9KYDKQ0s81H088HKGEPZ1LAIbArbmcqp1jlAomCYcMT/MjgexO0PllgeDo4OjxH5dea7QvDvwwEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEEDutV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218E6C4CEF8;
	Sun, 12 Oct 2025 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288618;
	bh=drlLQGlwLQo2pYW3pURe98GZgeWSVpXQQiStRl+tcvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FEEDutV8crqRGBHnLSYU+7zC5L/vb02ZyzH38InOMP7klwj600fQPtjdnAea+l7Lu
	 D0A78tRChRSuHZmelmiysDNSBHE4+K7eF3TGRZrr4ydDDqV0CZBIY7IqNM/bFu5IT9
	 zRqR09CgmYEbIQoQDRx1+2NiiOGpavmaUdsUSkKdioFzsujuTfu9m84DumgCnGe/Ox
	 8ta3Uy3g4oW4yTSmnhDySLdL+Goch1dEdmPO++bmCgO14qD7lyvtdE49v9PalDziiy
	 zfYlRwK1c3BuziZXLNYEjgxoADov1UGRLGfIQqqPul2mRYgQlRUpKIZK80OFHjtEIp
	 W0hLwyT/jhDkg==
Date: Sun, 12 Oct 2025 18:03:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 0/5] i3c: Add basic HDR mode support
Message-ID: <20251012180327.5d94dda2@jic23-huawei>
In-Reply-To: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 16:06:12 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> Add basic HDR mode support, only support private transfer, not support
> CCC command.
> 
> Update i3c framework API to allow pass down mode and extend driver callback
> function.
> 
> Implement HDR transfer in svc i3c master driver.
> 
> Simplifed HDR flow is (ref i3c spec line 5514) Figure 129
> 
> <--              SDR            ---> | <--- HDR
> START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)
> 
>                                     ----> |  
> HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT
> 
> Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
> read/write command.
> 
> svc hardware can auto issue SDR part.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Whilst there will probably have to be a v6 for the ACPI ID issue in patch 5,
I'd like to ask the question of how are we planning to merge this?

Maybe an immutable branch either in IIO or I3C trees that the other one picks up?

It's a new driver so could gamble on taking the IIO driver the I3C tree but even
then I'd like a topic / immutable branch in case any IIO wide refactors or similar
hit this cycle.

Thanks,

Jonathan

> ---
> Changes in v5:
> - Just realized missed CC mail list devicetree@vger.kernel.org and resend
> - Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com
> 
> Changes in v4:
> - use master's hdr_cap to check HDR cap.
> - add mmc5603 support.
> - Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com
> 
> Changes in v3:
> - Add new patch for change rnw to union for svc.
> - Detial changes see each patch's change log.
> - Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com
> 
> Changes in v2:
> - Add sensor driver, which use HDR mode read/write data.
> - change priv_xfer to i3c_xfer.
> - Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com
> 
> ---
> Frank Li (5):
>       i3c: Add HDR API support
>       i3c: master: svc: Replace bool rnw with union for HDR support
>       i3c: master: svc: Add basic HDR mode support
>       dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
>       iio: magnetometer: Add mmc5633 sensor
> 
>  .../devicetree/bindings/trivial-devices.yaml       |   4 +
>  drivers/i3c/device.c                               |  27 +-
>  drivers/i3c/internals.h                            |   6 +-
>  drivers/i3c/master.c                               |  19 +-
>  drivers/i3c/master/svc-i3c-master.c                |  96 +++-
>  drivers/iio/magnetometer/Kconfig                   |  12 +
>  drivers/iio/magnetometer/Makefile                  |   1 +
>  drivers/iio/magnetometer/mmc5633.c                 | 579 +++++++++++++++++++++
>  include/linux/i3c/device.h                         |  34 +-
>  include/linux/i3c/master.h                         |   4 +
>  10 files changed, 745 insertions(+), 37 deletions(-)
> ---
> base-commit: 5248ab97a6dd1dc6856422f6b1595baaf4fa85ce
> change-id: 20250129-i3c_ddr-b15488901eb8
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 


