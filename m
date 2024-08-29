Return-Path: <linux-iio+bounces-8861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB5964434
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E71F25F58
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C7195F28;
	Thu, 29 Aug 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQgSNJzA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888C191484;
	Thu, 29 Aug 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933839; cv=none; b=M14yjCp2YhURfOEcILCephNQziwPpj7g+Fj+zpo2Ytx15jLn4L3oUnUPShiTOuB5z7zvICQ1CZahrinw0UawbFh86GZnbTDz4Fhcoh6gNILNaHopNgnSOmmU92cdIz8vYSw11OxNFJFDwDB0B8GajrfAkc02OtP+ORELoAuDpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933839; c=relaxed/simple;
	bh=v/B6Vemoz5UVv9Q9pJjiOPvlKAyPbByHh9Sq+fB/fZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY0g1pB6k8PyzzEZMddLbItkPe4HxFa70hBaoEjOVkjhnqTRkpEI4+ON2MU/gwMh9c0oysK1LyuwC6lH7ovJh3sVZgVWh8Dz7GEF9efPVE30giA5sZ4Il5iTwssbzteMym8bIfeIHLTevHkGZ6RQk7wePsUzfMm3gbQKd5/iHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQgSNJzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF0BC4CEC1;
	Thu, 29 Aug 2024 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933839;
	bh=v/B6Vemoz5UVv9Q9pJjiOPvlKAyPbByHh9Sq+fB/fZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQgSNJzAX6oqUPXkZWdSdTSA08iSZJYD7uoupZr7idOScnC44ZxC+f+ECoEKiBtRE
	 bWcPKpFY8hJNn2iyv/5Wm/7cZnQPEKFl6Bmb1F6Dk4rI/uutH6MzzAsqFDWwj5MO2h
	 Ka5p4SSScWRTAhYqfhWduecmlMhjjfIND4b+WqKg1RNH62ZIVEvY1gASF4sqWxF5io
	 QhDIVuNc3w48F6dl7DScVEKXIVWSiP6V43iyrBV1tgPaR3s7fHc6SGSuy8Sko55vzz
	 g/y+B6sT4g55gatzrGmMyWr1DHGMMxj8G7r4jaOUxj1fQvsC0EKnvFxxDJHY46vm6n
	 wJH70WZDuv4XQ==
Date: Thu, 29 Aug 2024 13:17:12 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	samuel@sholland.org, jernej.skrabec@gmail.com, sre@kernel.org,
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de, jic23@kernel.org,
	jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 11/15] mfd: axp20x: Add ADC, BAT, and USB cells for
 AXP717
Message-ID: <20240829121712.GO6858@google.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
 <20240821215456.962564-12-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821215456.962564-12-macroalpha82@gmail.com>

On Wed, 21 Aug 2024, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 PMIC to utilize the ADC (for reading
> voltage, current, and temperature information from the PMIC) as well
> as the USB charger and battery.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/mfd/axp20x.c       | 25 ++++++++++++++++++++++++-
>  include/linux/mfd/axp20x.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)

Moved to an immutable branch and submitted for testing.

PR to follow.

-- 
Lee Jones [李琼斯]

