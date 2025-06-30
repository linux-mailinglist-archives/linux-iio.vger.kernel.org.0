Return-Path: <linux-iio+bounces-21142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCBAED59B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B2C7A5C53
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E1220696;
	Mon, 30 Jun 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kbD1+/P5"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945456BFC0;
	Mon, 30 Jun 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268585; cv=none; b=U6rA/hrdk2L2bI4qEY84kt0E5IJdQhEVPKOL3PYEJGjLCF5fe36VAT18AmI7plPVCZZ0z3r98EBSrRIJAq798jI7jWT5Bwgqy4aFMJoP0r7I1mlJO+3veebJo5uY8cZyHLtQha7M2jj69lf7qm/QZ/itYi/s398DxSPnQ4wHRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268585; c=relaxed/simple;
	bh=d4y8+hqplOcGJJ/rNY/oDMRKZ0L4Q60ZUzRRcNJDT1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GF9JzuQJ5oLEuRG9XQRiORoawat9u2KH39RvRlonmaDbjjy2JWOixnY13cXL/0zVVfWNu4n3aZZXFgJCg8uJYCFbm1codA70HUmiB1OSuL4NS6ibQZJv0f1yARMpdjodX10elYQ+u0EXSTHLvCGw4LoVwBf/T9peMBsbK/I9eQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kbD1+/P5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751268576;
	bh=d4y8+hqplOcGJJ/rNY/oDMRKZ0L4Q60ZUzRRcNJDT1Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kbD1+/P5H9bkqVVAmP7J2kyS9/Q8TesbyfEdHQApY6e6CAXcECdkwDi9F14S15xBV
	 nEC9ZKJ0eTXfihRHL3XCm5bQfbcwsdE54Jgwv2wKeH1/J8zjJz66fpv076LsOJgI4w
	 C4AnKNNURKG3gOOr2gFqXNxx8QJU/c7DIl2Oj8HXBHXlUJYVBzu/xwY6725s45I5Ux
	 hW1Aax8R8qxaijT2Ifnrg/to+R5y8A+Bvk6hmFdIR1HjQN5WqQVy3YuyZKYdp7/7Ej
	 yUzsoyiplH9LZ9Rrj6LmM/iOc0B7kcBqg2jsZWEFJLpjirr54nDSpdMF9kPYNFPngK
	 Txg1nQ/ozCWdw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 70E1117E0B0D;
	Mon, 30 Jun 2025 09:29:35 +0200 (CEST)
Message-ID: <f16c18eb-9a28-4f44-ad8c-7303ee5347a8@collabora.com>
Date: Mon, 30 Jun 2025 09:29:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] thermal/drivers/mediatek: Add support for MT7981 SoC
To: Aleksander Jan Bajkowski <olek2@wp.pl>, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250628223837.848244-1-olek2@wp.pl>
 <20250628223837.848244-3-olek2@wp.pl>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250628223837.848244-3-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/06/25 00:38, Aleksander Jan Bajkowski ha scritto:
> The temperature sensor support on the MT7981 is exactly the same
> as on the MT7986.
> 

If it is exactly the same, great! ... but then this change is wrong :-)
You should, instead, change the bindings to allow you to specify

compatible = "mediatek,mt7981-thermal", "mediatek,mt7986-thermal";

...and that's about it, no driver changes to be done.

Cheers,
Angelo

> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>   drivers/thermal/mediatek/auxadc_thermal.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 9ee2e7283435..020324901505 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1149,6 +1149,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>   		.compatible = "mediatek,mt7622-thermal",
>   		.data = (void *)&mt7622_thermal_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt7981-thermal",
> +		.data = (void *)&mt7986_thermal_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt7986-thermal",
>   		.data = (void *)&mt7986_thermal_data,


