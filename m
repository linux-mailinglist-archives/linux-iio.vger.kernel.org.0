Return-Path: <linux-iio+bounces-8860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00A96441C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DE1F25A9C
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FF195FE8;
	Thu, 29 Aug 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C86/mMyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB95194C86;
	Thu, 29 Aug 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933721; cv=none; b=FjnX+yqtGQlZ4z/IPZ2/ALxqAErPpjj/tHkfKx0knPql+wdwfHQTbTLMfPgmNq6QTKyrRdRAt02MF3ahovoARyPDitizNoCAaPj2QrxZebJJhGhBx0Cb7ur0kpIWF97sD3D6eRpAp/XoZJq11AqzX7NWzoUqlCyDfodzveE3Q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933721; c=relaxed/simple;
	bh=/cyFcVMaEuDDsDW+Zpc6YMDwmq+hIwkCU3DTDVpSXIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa4rOhUQL42nZOmBtc5iLe89h56tKiWTiqAXKEPGwVDc3/6Dm5CSwrwtF890HdakSRlgIBMv6UqURRDvwCaFqYkFSKO0h1LkB6/Sc1tKo8NoJNRw0y+Mrd5ZSobpksETHYvEpfoYdDUuYJJvi8mZWPSqZbkUgcsOMfRA1WbX3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C86/mMyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D06AC4CEC8;
	Thu, 29 Aug 2024 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933720;
	bh=/cyFcVMaEuDDsDW+Zpc6YMDwmq+hIwkCU3DTDVpSXIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C86/mMyWMJmx6x2K0Uo7zAiNJVlA3Uatfou/+/Gx1yUwRihM6PmEsWQKnWSQvVMBR
	 vFBOOSyoqfNiS70lXUwBYAn1UH/loNFuc8/6nTKl2gY0Qzkw2dJ+kauH/ebunAZwxy
	 LZxW87GXYeCJnvEfi5Y6/IuNtqPx/1pwogXgC0ea6pzIixBFxFLQcv8AXMyP4dA66q
	 lakhLTeKcG3DhzStRe3bukDb7rGznxqGH5h6ydx2Ojtx+uWhDg9JLObjwUQKemsItQ
	 iSFkB0GkD/EJ5cqQCFpgL0L2+wItFHGK/+pxcmhfIToxT5xTD3m2jjQQk3yYdsMzSv
	 zEU2wwlqvHKjA==
Date: Thu, 29 Aug 2024 13:15:13 +0100
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com, mripard@kernel.org,
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V4 11/15] mfd: axp20x: Add ADC, BAT, and USB
 cells for AXP717
Message-ID: <20240829121513.GN6858@google.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-12-macroalpha82@gmail.com>
 <172433485381.1334876.7027428905035727559.b4-ty@kernel.org>
 <20240826120342.503bef41@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240826120342.503bef41@jic23-huawei>

On Mon, 26 Aug 2024, Jonathan Cameron wrote:

> On Thu, 22 Aug 2024 14:54:13 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Wed, 21 Aug 2024 16:54:52 -0500, Chris Morgan wrote:
> > > Add support for the AXP717 PMIC to utilize the ADC (for reading
> > > voltage, current, and temperature information from the PMIC) as well
> > > as the USB charger and battery.
> > > 
> > >   
> > 
> > Applied, thanks!
> > 
> > [11/15] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
> >         commit: e1043ad46060c181ffb8f981ccb25d9f698b2f09
> > 
> Hi Lee, patch 12 is dependent on this because of the header
> additions.
> 
> If you don't mind can you pick up 1, 8 and 12
> (all the IIO ones)?  Otherwise they'll have to wait for next
> cycle. Guessing too late to ask for an IB?

Hold that thought!

-- 
Lee Jones [李琼斯]

