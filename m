Return-Path: <linux-iio+bounces-13255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BE9E8773
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCADC2813F6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BB81749;
	Sun,  8 Dec 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asemkir9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3B9460;
	Sun,  8 Dec 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733685422; cv=none; b=YE5VjoDH3qql7vM9Vbhb3tfHcaOLREG/g4RfgGcM22eNvM4xAh+1eT0/lV2uMJ13hn8cAembtdCDDboFL7TK8BgrNYcwolTW5qBEwTdSw+MiPy8EY/mT8Dc4THg/KCNFa3gI+O9UGCOo3NGcxNRC+NSFeyWoQXpSxPwRxJvJ56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733685422; c=relaxed/simple;
	bh=9P7eDdU3lwCaYxTLKvhv84X7YwvgWDh+uOaewSaH9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkbwEwm2JvGDJEgZxrXVWyusp1JJbDgHPWhJ/WXLi7kQz2w9b1MSy7FCKUK/va0KDmxYNeknf/vkwJKcMzX+ed9KMmMhAJk4vfB1Ze3ZJjJsRT3xF/+z5ChvC7mijH+abeN5MYP+XWwdmNYZdu9vJhZEBTf/4sXKxpsAOtquhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asemkir9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F8C4CEE0;
	Sun,  8 Dec 2024 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733685421;
	bh=9P7eDdU3lwCaYxTLKvhv84X7YwvgWDh+uOaewSaH9L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Asemkir9sxjwR9WNfh6XYMm1ZkY0Z3FF8atekBh70zVVd6CzroNvLpR4nXu7ez7LS
	 Y6YNe8YnP2cebIzjaeGrWDcphQvYgZN/jpuhqZoXJVXnYISPKOgjNe8z/G0w4wPeoG
	 mNXTIRArvsL0Ymf4BOFGjctLvx1EOn41ZDHu2xDLkS5RoEZJc45P4yLwChIVHM0vac
	 kxbWiu6vZvdI/J8YWRawl/beqRiazRlpOqNzYv73rVTSdCcdXPYen2aksP9EqjfqZx
	 lGkD3kQbf1GsxZCUxEPSSacDE4hsi1SyTlQj1Lzf9o+7xfmQhEceo2pzrO7LPfU2Sk
	 6BwrwZBG4AF6g==
Date: Sun, 8 Dec 2024 19:16:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: ad7173: add calibration support to
 chip family
Message-ID: <20241208191654.4412d6ad@jic23-huawei>
In-Reply-To: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
References: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Dec 2024 11:09:51 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> Calibration on the ad7173 family is the same as on the ad7192 family of
> chips and mostly uses the ad_sigma_delta common code.
> 
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if we missed anything.

Thanks,

Jonathan

> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
> Changes in v3:
> - Small fixes to the ABI documentation of sigma_delta
> - Move the system calibration mode to the ad7173_channel to avoid yet
>   another allocation.
> - Link to v2: https://lore.kernel.org/r/20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com
> 
> Changes in v2:
> - Add a common ad sigma delta ABI documentation to describe calibration
>   nodes that are common in the sigma delta family.
> - Link to v1: https://lore.kernel.org/r/20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com
> 
> ---
> Guillaume Ranquet (2):
>       iio: adc: ad7173: add calibration support
>       iio: adc: ad-sigma-delta: Document ABI for sigma delta adc
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   |  23 ++++
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  24 -----
>  drivers/iio/adc/ad7173.c                           | 116 +++++++++++++++++++++
>  3 files changed, 139 insertions(+), 24 deletions(-)
> ---
> base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
> change-id: 20241115-ad411x_calibration-2c663171d988
> 
> Best regards,


