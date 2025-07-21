Return-Path: <linux-iio+bounces-21804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC3B0BF7F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 10:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF433189D99A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A438287243;
	Mon, 21 Jul 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXWstyCx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581D284687;
	Mon, 21 Jul 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088313; cv=none; b=kwOrKQjzJ8hBcnXFKHqKR+0cAxWbonsLKDGW43Y68Q4bN/sb/r7htodTyyO2KYJomEXi1zup/dBVsDt2u4VExevbbZypGtOQj4DqOJ2ttIXtzuEQM7wiUc9h7c0f4rFMW4H3PEC86UCH8ssK8+md/VV94ItSJI0FsiAgeZG+4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088313; c=relaxed/simple;
	bh=wWzhLjHGZJcD5noQr983sn3nffxSA3p1GlMP8Z76gKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGd3OSYgothRiXPlAIeqD0sW8R0TqmUeq7oNZLvn1VJyoICocop4pDE9fe9g/v8xFL40xKFhddZj4FKI2xRa/OUlslMFrT/QXuuTl0+zXGuklxIOwBL0yCzGHVCZG139azTp48Drk4quTqQXZtNzUniN7HZY+HVziAvab8LFDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXWstyCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51A2C4CEED;
	Mon, 21 Jul 2025 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753088311;
	bh=wWzhLjHGZJcD5noQr983sn3nffxSA3p1GlMP8Z76gKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXWstyCxPGPIJO8pzpKzr6nvQfsFBff1Najfu2/05gZZgbXC1ByTffziSA3Qw5tpD
	 cQFrp6jsLrGFu3p+kvXYhKIGWg1xtJeUW7/wJHW0xfO3MPxuXsS6fEd+s7rRBg5sij
	 Nk04tBj8sC5stOAgwzyqxU9bK4Pl8oDyk/84ktYE=
Date: Mon, 21 Jul 2025 10:58:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 5/7] misc: qcom-coincell: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <2025072120-swaddling-fencing-3dc0@gregkh>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075525.29636-6-angelogioacchino.delregno@collabora.com>

On Mon, Jul 21, 2025 at 09:55:23AM +0200, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a charger for coincells, usually
> powering an RTC when external (or main battery) power is missing.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device and
> initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/misc/qcom-coincell.c | 37 ++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

