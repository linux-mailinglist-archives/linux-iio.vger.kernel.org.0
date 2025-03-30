Return-Path: <linux-iio+bounces-17340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B7A75A48
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F0B164C3E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DDC1C8628;
	Sun, 30 Mar 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzX+btqP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610C3FE4;
	Sun, 30 Mar 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743343723; cv=none; b=W+Y8F+5r5feudxd3fnwaGDxBfjzkMDFcTVjOxI+pAVAc2DIJGiWK6skldBdHJ/Bqf59d5Hi8ESJE8KFkAHc4PV5rgnzoWBzJXuS9BNi0t/ONlVUg+3iDMIBfK1zufsKxaciqO3odecOwY3XCakslKLvFGBRf/lMM5p9Y2E8yhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743343723; c=relaxed/simple;
	bh=LUNlOYjoJtR6+clEBUbrqDLTYdqMe7/XahYp2tVYzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy04+SScoRydIw1Fppc1kfXfiwxp7boTL4NvJPOgZ2S8G4nBb3VO7tbs8X3bs4gG3LpWZMOJmKzXwXsUmKlBM1r23LCM/AqjpWuUw4Jvm+li0GN7DgzHO7m7ZLe7E+KISFgtvX+JDl89l6THFfgE3fBKUph1DqILFslLjOtY/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzX+btqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A021C4CEDD;
	Sun, 30 Mar 2025 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743343722;
	bh=LUNlOYjoJtR6+clEBUbrqDLTYdqMe7/XahYp2tVYzz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzX+btqPnXdQnxDdtC+MgH0y2su0B3Q9rb4mjPFUuMbBR6fveId99VkuFVJDF5RDy
	 xpxizkQzir8PMcCcppTfz0Ewl76E76tA73MLL7edbZdk6J7vQg84YUhmVx8C5al+9S
	 ou7zmYaCMMVbyUPANs03OYmcurr0DnCUwNoZktNCCf0qw/nwDTkQBud6aV43Url0xk
	 xE+qPnxQV3Sq/leew3rkyw48lLTzFlpm82n1e3CpPI0hj8zpAJaNXsjI+jksar7ctP
	 T54sH2e5/hjRMtw9ALVsYtLrdfe7IzRXoWlEul8kwZYtl0G7xikuCl73gjQMae73Ub
	 Z7AJRSZaFES6g==
Date: Sun, 30 Mar 2025 15:08:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, gnstark@salutedevices.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 christianshewitt@gmail.com
Subject: Re: [PATCH v2 0/2] iio: adc: meson: add MPLL clock workaround for
 GXLX
Message-ID: <20250330150834.2171d106@jic23-huawei>
In-Reply-To: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
References: <20250330101922.1942169-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 12:19:20 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hello,
> 
> Amlogic GXLX SoCs seem to be mostly the same silicon as GXL. The only
> known differences are:
> - one less Mali-450 GPU core
> - no VP9 codec
> - and an odd one: the three MPLL clocks need a bit toggled in the SAR
>   ADC register space
> 
> This series attempt to fix audio output (which relies on the MPLL
> clocks) on the GXLX boards. Unfortunately all we have is a downstream
> commit [0] without any further explanation (or anyone who wants to
> provide details on this). Since it's not clear if this is a gate, a
> reset or some other hardware fix: the driver side includes a warning
> for users to update their .dtb along with kernel images in case we
> ever figure out what these bits do and how to model them properly.
Applied to the togreg branch of iio.git. Initially pushed out as testing
to get some early testing before I rebase on rc1 next weekend.

Thanks,

Jonathan

> 
> 
> Changes since v1 at [1]:
> - added Krzysztof's Acked-by to the dt-bindings patch (thank you)
> - added Neil's Reviewed-by (thank you!)
> - fixed meson_sar_adc_gxlx_param to be independent of future
>   to-be-upstreamed patches (fixes a build error)
> 
> 
> [0] https://github.com/khadas/linux/commit/d1d98f2ed8c83eb42af8880ed8e206aa402dd70a#diff-c5aaf54323ef93777c5083de37f933058ea8d0af79a1941e0b5a0667dc0f89b3
> [1] https://lore.kernel.org/linux-amlogic/20241231194207.2772750-1-martin.blumenstingl@googlemail.com/
> 
> 
> Martin Blumenstingl (2):
>   dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
>   iio: adc: meson: add support for the GXLX SoC
> 
>  .../iio/adc/amlogic,meson-saradc.yaml         |  1 +
>  drivers/iio/adc/meson_saradc.c                | 34 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 


