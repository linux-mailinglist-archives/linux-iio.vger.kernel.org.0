Return-Path: <linux-iio+bounces-25784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D98C28282
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 17:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB0AD4E5019
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3224DCE6;
	Sat,  1 Nov 2025 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND0y+nyb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97912264CD;
	Sat,  1 Nov 2025 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014336; cv=none; b=Mq2YgeW/4tR8CO+8rhPpW38Ba2fRPtdnlnEQVbLEvJFT+pbgSBHQeR+7a6hwP/Y6hlCtsm4lbdRA2VDjltZo1j6p8OeNfE1mUWC+iPG7LLPpZs+ijuOmGxe/pia2vRp5GDR0Fl3cIUBpnqamNgY8U5LBF40iCWKYlAypIjBfxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014336; c=relaxed/simple;
	bh=SRbrrNLlJ5lCbs8a/4PWMzoJ6nWZ1XkxIIFLmPdvMh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDF152MwFwZSebwjM2EwtUAqhu6+jWmz7/+xK3TpGcoiye2FPpZrtpXBrJ6dxJ+IOTWQRPhOZ3DEoFkmWNi78yl9IIv9yKTORz2ush8LNo395tHkZCep4IyV+Tkk6eupjIcdj1Egoymop+ES1dZVRBwba9z9fPLmLLKHhKnIXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND0y+nyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7BBC4CEF1;
	Sat,  1 Nov 2025 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762014335;
	bh=SRbrrNLlJ5lCbs8a/4PWMzoJ6nWZ1XkxIIFLmPdvMh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ND0y+nybUBovBHJJGQhF0YDfxfAQZWjjCD6xEBXDM+C2f+k06RTyJrp54kXqb+6yZ
	 2toHnjxWY10D7gZKaO63DhrOcx3VSiZsYMbAI8RlSO6hSJrN0gsJl07GlrRTExg5Mm
	 fzBBu15ZEew41apW9f7pH5kzZL7iObKgrvwJ/0bfyV/CARe+rKha1pHvEBltcZ/ANf
	 7sWljTmDpl4gcDF+kYoA0ziyG4euiz0gY/CWUYU93eWJTEsYdrQy0P55tv4NqXpRlX
	 439sQAld8HajfvUaez574QXfnUKEHq2I3evrRUGYoxGa0igT7fQU/pCFBH0rI/KLf6
	 AmZpG7/srIDMw==
Date: Sat, 1 Nov 2025 16:25:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, linux@roeck-us.net, Carlos Song
 <carlos.song@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v9 0/6] i3c: Add basic HDR mode support
Message-ID: <20251101162525.44c9862b@jic23-huawei>
In-Reply-To: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:39:12 -0400
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

Hi. Assuming everyone is happy with this version, the next question is how
we expect to merge this. I think someone (either myself or Alexandre most likely)
probably needs to spin an immutable branch with the i3c parts in it.

Then we can merge that into both trees and I can apply the driver on top.

Jonathan

> ---
> Changes in v9:
> - remove reducated check for ops->priv_xfer.
> - improve mmc5633 (see patch's change log for detail)
> - Link to v8: https://lore.kernel.org/r/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com
> 
> Changes in v8:
> - Add cleanup patch replace framework's i3c_priv_xfer with i3c_xfer
> - Link to v7: https://lore.kernel.org/r/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com
> 
> Changes in v7:
> - add explicit define for I3C_HDR_*
> - add missed include files.
> - detail see each patches' change log
> - CONFIG_DEBUG_ATOMIC_SLEEP=y
> - Link to v6: https://lore.kernel.org/r/20251014-i3c_ddr-v6-0-3afe49773107@nxp.com
> 
> Changes in v6:
> - remove acpi part
> - collect Conor Dooley ack tags
> - Link to v5: https://lore.kernel.org/r/20251007-i3c_ddr-v5-0-444184f7725e@nxp.com
> 
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
> Frank Li (6):
>       i3c: Add HDR API support
>       i3c: Switch to use new i3c_xfer from i3c_priv_xfer
>       i3c: master: svc: Replace bool rnw with union for HDR support
>       i3c: master: svc: Add basic HDR mode support
>       dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
>       iio: magnetometer: Add mmc5633 sensor
> 
>  .../devicetree/bindings/trivial-devices.yaml       |   4 +
>  drivers/i3c/device.c                               |  27 +-
>  drivers/i3c/internals.h                            |   6 +-
>  drivers/i3c/master.c                               |  19 +-
>  drivers/i3c/master/svc-i3c-master.c                | 115 +++-
>  drivers/iio/magnetometer/Kconfig                   |  12 +
>  drivers/iio/magnetometer/Makefile                  |   1 +
>  drivers/iio/magnetometer/mmc5633.c                 | 598 +++++++++++++++++++++
>  include/linux/i3c/device.h                         |  42 +-
>  include/linux/i3c/master.h                         |   4 +
>  10 files changed, 784 insertions(+), 44 deletions(-)
> ---
> base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
> change-id: 20250129-i3c_ddr-b15488901eb8
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 


