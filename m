Return-Path: <linux-iio+bounces-9622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE897A6E1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7BA28556E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E615B555;
	Mon, 16 Sep 2024 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYOM1LZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4156315B130;
	Mon, 16 Sep 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508484; cv=none; b=eoJEO+0kLT3OzFpi9zcUi+kR0yX07KZ2BIzj121q4BPbrLOZnsCmMtl8/1ef/8oqeNXiSydP+P6Aik2ZvTKND5XZsNiR7A3n2XPAc/sXqPZU8fJ/WA9myZKjzDinR6gmSthuNZdFcRESycfJ6D5iA5vW4D5ngmaMYChlc2HGZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508484; c=relaxed/simple;
	bh=WloC7Qh/dLsituTGu+eNmaO/f60monF/EFxD1o3csTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp3z38k1CVZXRmZfwaj/s+3k+mWesb9SjXdqSE55sEcCmOBID5Qq9Mm9ooZWzrDWSkMee0Gt6I2lBlshAC01N6VdChQjJEFIkiHrPi8+GCbMOiONJtiHwvTBVXGisb3qTc8dKLfFrqsLO7FdlqbRWNfVTLIRDyRNOgPB+KsO634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYOM1LZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88D9C4CECD;
	Mon, 16 Sep 2024 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726508483;
	bh=WloC7Qh/dLsituTGu+eNmaO/f60monF/EFxD1o3csTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYOM1LZsrgkaAz4oK4zF9ZHnqMRf07KFptCLqVRXkqSMDSNZbfmFFUlbFyAQeqoKK
	 CfuSaUjL5WDiUww44Pex4wE/sVOMeZ9D/aTMdqL4Y59UXXSdeEOmOeXgBBGao2Y1E3
	 VVmaTaHKo9uDpZQkHAyc4/dybfagoB4Z5mjfMDISXZj+6tZQzJG5QlOxdVyyFK5Ufw
	 /KNaB0x7vRKhThBYusOLYLF8fS86Kx/UHHiAdaT1cfH32RgoO1Qu1UAZ2l/954t+cG
	 cjF98NCl6YUXnCQfzDNGEb2IEAfu88VzLpHmFdMmDxFj1YuMK4VePvx8wlmD9g1edW
	 F/otK1TVZGL7A==
Date: Mon, 16 Sep 2024 12:41:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: also allow
 meson8-saradc to have amlogic,hhi-sysctrl property
Message-ID: <172650848142.859049.15257284071045853888.robh@kernel.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>


On Wed, 11 Sep 2024 17:29:53 +0200, Neil Armstrong wrote:
> The SARADC on the Amlogic Meson8 SoC also requires the amlogic,hhi-sysctrl,
> property, document it by adding the amlogic,meson8-saradc compatible in the
> adequate allOf:if:compatible:contains:enums along meson8b and meson8m2.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


