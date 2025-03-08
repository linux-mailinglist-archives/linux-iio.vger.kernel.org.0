Return-Path: <linux-iio+bounces-16555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C712A57B03
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0EA16D4DE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E481DB37B;
	Sat,  8 Mar 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlEoUUst"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340913E02A;
	Sat,  8 Mar 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444346; cv=none; b=uMRE+bc73OC2GwTO77hOkL+PFEvjcKM0BjqhwIGtLERnKJkeO12fJEY9t+dhP2EE12F3eOzImLDylxUNGeSr/3ZvT4zHKS0VGqwQbz7CcG6t/60J5X/vBp/SWMg2F5iBnZj6jXqmp4KMjiSAhNzTh+bmQm8jL1moQCuvCg9p8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444346; c=relaxed/simple;
	bh=vImS6KlVH00/hRc3EcVeL0uqaFnM69ue2lZAlyRA/9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGhLPQQTD+4AKpRL/28DVjEPFiCUfPyswOwXaPqJ1kA+pIjtsNo+cNE4K8ujyShaOo0in6WaUULf47e8UNoamiMywbKowj7sHiO8/FyoTLSocqiwndboBz0j8PaG9itl9sKHHmppVQwNZ+tXLasjUy/5M+AAWdtY7WUVgJcIRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlEoUUst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6DAC4CEE0;
	Sat,  8 Mar 2025 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741444345;
	bh=vImS6KlVH00/hRc3EcVeL0uqaFnM69ue2lZAlyRA/9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IlEoUUstB2MiybBJBTKMllgwYsFDPeSHOhGG6m4hTVlLUjRpyvyixIXRG26fmN8Ra
	 aNZ/0OYxpGgXPVtzs2waux+RgLplax430MqN7G8TI67CDTjKgRhbOxxqfP8b0gMWAo
	 DkZRAblakClsZuFG1tU/Iq//gnxQZqhd0hloGDaYD03CicndtMmpfR2sIRU+2BEEl8
	 3Og3cRX9wFmCTq/7IV3SB7oM8TgrTgt4dPOzOyu7sIy+jSARIxYIr04A3EFQ8HdIhZ
	 sUkqeN6sWA1CYiDMAkqlgnuW9RNGcr1KufAzEaqnRt4MhHzuguBGBWvabgG4cxFXoR
	 BORMvUulRsjWw==
Date: Sat, 8 Mar 2025 14:32:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, "open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC
 DRIVER" <linux-iio@vger.kernel.org>, "open list:NXP i.MX 7D/6SX/6UL/93 AND
 VF610 ADC DRIVER" <imx@lists.linux.dev>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add i.MX94 and i.MX95 support
Message-ID: <20250308143214.6dcc41ac@jic23-huawei>
In-Reply-To: <20250307-county-dissuade-eed621016369@spud>
References: <20250306170825.239933-1-Frank.Li@nxp.com>
	<20250307-county-dissuade-eed621016369@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 15:58:34 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Mar 06, 2025 at 12:08:25PM -0500, Frank Li wrote:
> > Add compatible string "nxp,imx94-adc" and "nxp,imx95-adc", which is
> > backward compatible with i.MX93. Set it to fall back to "nxp,imx93-adc".
> >   
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied - thanks,

