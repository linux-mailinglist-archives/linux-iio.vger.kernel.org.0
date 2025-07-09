Return-Path: <linux-iio+bounces-21491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A9AFEE41
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFCF17AF62
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62342E973E;
	Wed,  9 Jul 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4SMq1lD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3D2206B8;
	Wed,  9 Jul 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076617; cv=none; b=tgQ2DkfloVKv89TrNuVEEQFjiXaICGSwevBf+5FbxT4KxLW9jEkD/PxqVFIxRZzAXRmJvfbsEyWG9G+yhu8uFRtIXjXp2JjqpgRgE1aBqp/M9T8z554GeSkitBzq0Of/klNLFEIqE3Qip6auAsieUSZ6M32X1X1Ss0Hg0ItVkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076617; c=relaxed/simple;
	bh=O/H+N3TO1iyF42W90FkvMaPdy1iyg2L5o65UAMgY4T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzZapIg7qQJVv7roXUOebP8/Sg2TimFECjFFhPXrt26EqyGouODikMKfEHBPWFEoMmkhNcxiPj7n9cMmx3D9UNzrAmqQStxRUQnWK7Jt0pBICSs40u/4sKZzJWlm+jIW+WSKcNjQ12iUZlBrl6hnTS8P2YLoR8OwnENjCCMJCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4SMq1lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408B2C4CEEF;
	Wed,  9 Jul 2025 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076617;
	bh=O/H+N3TO1iyF42W90FkvMaPdy1iyg2L5o65UAMgY4T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4SMq1lDl0t/cpPFrA7uow796FMW7GCeKwtQrN5wEi5zXBiXSwxFeWIdMUbzVd5U8
	 /tblIRlrJdfQKZdoPr64vHfpPgtdz3fhQFrMloKf7NMXZuE34W2HxGhgEcNfmHMSZY
	 tq861hDUdrgazQaM7yKEeYXZflRhGBK75t5WX5mWhufldFDQzMfW4AOxp7jfLxl5h0
	 O8ezv6cLXuzwzFIBfudhF8WWA8f5GaL8f1aQH9vOLfSmq60HHZMSfuyDc9fNtc45pT
	 IP9aiI2TJCh67BTt8KnMuziAjKBMiYg6I6WH8b7cANgamtSjfRZhFslDKYecXU1Qn+
	 rdOkyQBZs4YNQ==
Date: Wed, 9 Jul 2025 16:56:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 s.hauer@pengutronix.de, zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add support for MT7981
Message-ID: <20250709165644.7614ac41@jic23-huawei>
In-Reply-To: <20250709-industrious-marigold-snake-5a3eb5@krzk-bin>
References: <20250708220405.1072393-1-olek2@wp.pl>
	<20250708220405.1072393-2-olek2@wp.pl>
	<20250709-industrious-marigold-snake-5a3eb5@krzk-bin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 10:27:50 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Jul 09, 2025 at 12:04:03AM +0200, Aleksander Jan Bajkowski wrote:
> > The temperature sensor in the MT7981 is same as in the MT7986.
> > Add compatible string for mt7981.
> > 
> > Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> > ---
> >  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml   | 4 ++++
> >  1 file changed, 4 insertions(+)  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Picked up this patch for the togreg branch of iio.git. Initially pushed out
as testing as other stuff on there needs some test build coverage.
> 
> <form letter>
> This is an automated instruction, just in case, because many review
> tags are being ignored. If you know the process, just skip it entirely
> (please do not feel offended by me posting it here - no bad intentions
> intended, no patronizing, I just want to avoid wasted efforts). If you
> do not know the process, here is a short explanation:
> 
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
> However, there's no need to repost patches *only* to add the tags. The
> upstream maintainer will do that for tags received on the version they
> apply.
> 
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
> </form letter>
> 
> Best regards,
> Krzysztof
> 


