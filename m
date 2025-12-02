Return-Path: <linux-iio+bounces-26644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA09C9C55B
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB513A75CE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BA2C026C;
	Tue,  2 Dec 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mvju4zv1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC6220687
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695250; cv=none; b=VnHUnlFW5B3PGTfBb/VsxkRFF/fzHmH0qid7x/GKiMxRuTfOUJWvsYSDryYpdkDWYFwDvIBKi4cxPmRgomIvLy7iuRXs8W1TIXqPonaVNiEHGvHe8OKSwi51ntwqyan3gCcC/SOYmFITTgHJliC6E0qnCha/CIdao1jSz3UHqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695250; c=relaxed/simple;
	bh=W/hnSeMCg+W015Cn892P0HxaTYvwCN+oAP/xc/6bCJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDCOacxnbv+mL3sSU14gh2pl0zW5SHme3CoZFYkSoHZciddWf7WeU63+MWbmJ3v+9883/oBcAo6F5PaZeg6houJjXUG6X74pI9y6dea1r0ZS6o+N0zFWeYCPjZoXw0EgMkVtDMnknDEnx/lrQQ+36OdhPsX+C8e1PQfhahPDEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mvju4zv1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BFE0C16A20;
	Tue,  2 Dec 2025 17:07:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B305C606D6;
	Tue,  2 Dec 2025 17:07:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A2B111919DE1;
	Tue,  2 Dec 2025 18:07:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764695244; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6Er31q3t3D9gDuRWCtmdgM2TNfpxlbVnIHYGvg/Vq/c=;
	b=Mvju4zv1UyTlkJNTxNx8wDVLUVXLZ/EeOiQS6vKcvKy1up6MPthK6/BtaBYRFYjqwJop/9
	/wryL3GpnX3d0tJe+cIYz3QY6J+bLto6sLBrP7OVqXkJtEmZbgr5xWS/Dy+jtf8JRYg6/v
	p+SjOOIC1rUNgLb4ONS2ZFhKjp+f9sNOOVj1d4icJzeAdxcWOf+Doquvbw+Ons7pfWppHi
	On9a7deMVX5QKmeRd6Ed44STYFYYdk9OB+tneBwtQTIulfQfTZgwRgj+BF4djdk4cKUl9n
	TV2r8coBIPzA9qRKq70l+CrTOHPAE0V7pFUnn5LgxAtN28mRCMX0XrpxD8HjyQ==
Date: Tue, 2 Dec 2025 18:07:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
	joshua.yeong@starfivetech.com, devicetree@vger.kernel.org,
	linux@roeck-us.net, Carlos Song <carlos.song@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: (subset) [PATCH v11 0/6] i3c: Add basic HDR mode support
Message-ID: <176469517224.2676946.11188643090832836705.b4-ty@bootlin.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 06 Nov 2025 12:35:59 -0500, Frank Li wrote:
> Add basic HDR mode support, only support private transfer, not support
> CCC command.
> 
> Update i3c framework API to allow pass down mode and extend driver callback
> function.
> 
> Implement HDR transfer in svc i3c master driver.
> 
> [...]

Applied, thanks!

[1/6] i3c: Add HDR API support
      https://git.kernel.org/abelloni/c/256a21743d91
[2/6] i3c: Switch to use new i3c_xfer from i3c_priv_xfer
      https://git.kernel.org/abelloni/c/9280b6ebbf08
[3/6] i3c: master: svc: Replace bool rnw with union for HDR support
      https://git.kernel.org/abelloni/c/108420fe2100
[4/6] i3c: master: svc: Add basic HDR mode support
      https://git.kernel.org/abelloni/c/4e7263b87ca3

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

