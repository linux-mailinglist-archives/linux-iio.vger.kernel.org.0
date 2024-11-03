Return-Path: <linux-iio+bounces-11875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03AD9BA7F6
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 21:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CB2B20FC8
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009218B462;
	Sun,  3 Nov 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyeJETQX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0113CA81;
	Sun,  3 Nov 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665991; cv=none; b=GLPQrT3p4M/YwkcQtzg18YJNzYUqnvBgKYHwh+9WlX9X//t5JwMF7TQwa3IZhpLNFo3FUa3wq4kInYiXTkuuwM5bklaWfJ3IESqo57CZbRkI0KWMDFrs2B686Tw4gsSrC2wd6j3ITnmsk+FP5NmYINlRMefGU2RSLT25uQ7Dhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665991; c=relaxed/simple;
	bh=bFxWhN5DQcon1Ev2lD9Kduq69yR0xQF46x+e2qKuI5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4MlP4zX/A7CAGYqaiA19PjSvNR2gU6E46hXkjAF5HfjZEQbUaGz/zdNOBXCKmhnHhuTcBQZimBWTRZguSg1dNVn2h1iLPRt6pCeUxt278RYbOOOz8La8a+eX3kYtBj5Ey4kP+NeL3kisHZpNX9Co67/TcQNvajPoBfOONSpuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyeJETQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CABC4CECD;
	Sun,  3 Nov 2024 20:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730665990;
	bh=bFxWhN5DQcon1Ev2lD9Kduq69yR0xQF46x+e2qKuI5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IyeJETQXDw2v4u2VMCRSlPx4ejbRFrKe547TUKR4nk/pPVZzT3wrYRu9J9Z7N0jCv
	 AQGF5n0vv+L4B65NP6b3beBBaUikldjNRbjDqwQl4JTClp+fAd20Bq2y/b0huZDuXk
	 kTq7QzfC+xbmOxMLPBZrsVpSUuXhoyB/lrdV/JR+KxLWFGe0bSvHABb4VY0He7N9TR
	 DaymSUBNCRxlYilqHYRSo2nOIq2g/KRI9MDbvyJ/MxHDk3z/PrxMkwFYvuWnK+Te11
	 KMu8ayMEupjtsTumKALhS7D5Y/NlltE5l7Ze32T/4MulY/zIKreEld0b9919rN7u8N
	 gKSdF9qTyTq7A==
Date: Sun, 3 Nov 2024 20:32:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>
Subject: Re: [PATCH v9 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241103203259.03e62eeb@jic23-huawei>
In-Reply-To: <20241031212511.57ec5d6e@jic23-huawei>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	<20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-7-f6960b4f9719@kernel-space.org>
	<20241031212511.57ec5d6e@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 21:25:11 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 28 Oct 2024 22:45:34 +0100
> Angelo Dureghello <angelo@kernel-space.org> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add High Speed ad3552r platform driver.
> > 
> > The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> > through the current AXI backend, or similar alternative IIO backend.
> > 
> > Compared to the existing driver (ad3552r.c), that is a simple SPI
> > driver, this driver is coupled with a DAC IIO backend that finally
> > controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> > maximum transfer rate of 33MUPS using dma stream capabilities.
> > 
> > All commands involving QSPI bus read/write are delegated to the backend
> > through the provided APIs for bus read/write.
> > 
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>  
> Missing bitfield.h include. I added whilst applying.
Also, needs a select IIO_BACKEND (thanks 0-day for finding that one).

Added and pushed out again.
> 
> Jonathan
> 


