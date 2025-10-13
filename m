Return-Path: <linux-iio+bounces-25042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76772BD603B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17D018A4600
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC22DAFAE;
	Mon, 13 Oct 2025 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tSMPaCM3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982E2D7385;
	Mon, 13 Oct 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385314; cv=none; b=F9uhjpJ5WtAZY8im2oGs1G4XHpjiJTKD+2DC1S+LWIBaJtGu/9CHkZge5K6+5QRYyL07H8Yzm6m3xT/HBFgzkywtPLMBp7fSCwTTCML8dPRwdwn98m7/ZLXR6yRffpoPoeLBZXu1szOYUAX01QT9B4CxWcCfYmwtsVlX9H9XynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385314; c=relaxed/simple;
	bh=p04emB7EWJKdYHfPdfNWI5BlN1aHWFazFo2EChhEZhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4RGoAawFQUXINQlaUPi5fb/xzWOGECYVnaQP/teZSHghHV/fG64lGRuhEFelTeCQEyxjyKGRcFB22qjIRJY9okUiIgyN5YxdFp0F+RDSNaUxFsM686Dr2HPVg7wxbM4JpC6Rsy91VpmqZe/eCQ6Qm1RJn+KXrBgA2XcZ7VEVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tSMPaCM3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 805B71A134E;
	Mon, 13 Oct 2025 19:55:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45DA66067B;
	Mon, 13 Oct 2025 19:55:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10BD9102F227A;
	Mon, 13 Oct 2025 21:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760385305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ueA4Mw4ZvAdPduByR8LCFz7NV7MIajA8VN4BjDi+iYc=;
	b=tSMPaCM3u/5AMWi6C2uaGeO7nteYc8EWKCbf8Atx+55xMokblB8D7uyqQUIN5UN0VCyf8M
	92rSu2RHAMygLwiTzDHbfNr6o39la14ofppeSKWml+FP2LeSBi+tMVaA9t21CfewwODbPY
	O2iuzUWMZ9m3sdCASDH/6F85ruQDAszHZA2BlFfDdR01oDoTOGJcZVTzMKsl+PR7xrtB/u
	kCvU5b6eyw7dGzYrzu/ZYfz+585J2Rmp3YyycCPmvrqpkvXzI4JJICjnHtrTPDlVVxjYUD
	8Lnbu5vdBtJDAqrcnk19G+o0IESLUGkvny+JXMAEGdeZnfZ8WdPwOeSuFhLf8w==
Date: Mon, 13 Oct 2025 21:54:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 0/5] i3c: Add basic HDR mode support
Message-ID: <2025101319545551cfb399@mail.local>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
 <20251012180327.5d94dda2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012180327.5d94dda2@jic23-huawei>
X-Last-TLS-Session-Version: TLSv1.3

On 12/10/2025 18:03:27+0100, Jonathan Cameron wrote:
> On Tue, 07 Oct 2025 16:06:12 -0400
> Frank Li <Frank.Li@nxp.com> wrote:
> 
> > Add basic HDR mode support, only support private transfer, not support
> > CCC command.
> > 
> > Update i3c framework API to allow pass down mode and extend driver callback
> > function.
> > 
> > Implement HDR transfer in svc i3c master driver.
> > 
> > Simplifed HDR flow is (ref i3c spec line 5514) Figure 129
> > 
> > <--              SDR            ---> | <--- HDR
> > START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)
> > 
> >                                     ----> |  
> > HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT
> > 
> > Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
> > read/write command.
> > 
> > svc hardware can auto issue SDR part.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Whilst there will probably have to be a v6 for the ACPI ID issue in patch 5,
> I'd like to ask the question of how are we planning to merge this?
> 
> Maybe an immutable branch either in IIO or I3C trees that the other one picks up?
> 
> It's a new driver so could gamble on taking the IIO driver the I3C tree but even
> then I'd like a topic / immutable branch in case any IIO wide refactors or similar
> hit this cycle.
> 

I can definitively provide an immutable branch once this goes in or if
you are more comfortable with this, I guess there is no urgency and we
could apply this over two cycles, first the I3C part and then you can
take the driver.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

