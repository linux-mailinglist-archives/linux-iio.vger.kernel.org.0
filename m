Return-Path: <linux-iio+bounces-21108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00397AECEB0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA13B60FE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A89226D1F;
	Sun, 29 Jun 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3403vbl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C71C36;
	Sun, 29 Jun 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751214793; cv=none; b=J0/yFDp6fFXG0snoJqoeMd/207QbtJtypUAYxiyd3hnXbwkNxwQ4MdgIrA6bIvmnX7ILsQZo6cnyrHsTysW0UiJJeVAZd7zhus5w7/uHCJ5MlFjNlxu7BPPOq/sIuK4PVPFODwNLXV/4DJMkiTO4VFO8vqqQuYu2Wp9236RoI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751214793; c=relaxed/simple;
	bh=ef6rQZIC/ziH2BA7dycq513/pksDVMKdMUwcu1DRESk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vnd9JZZ1p/ndyViYNBAw6TxPjxx1e/QlBaaWeeOe5d/E8jQbaOuaXG/dZJCojEVkVHM2qbgjZGSsTcNdcwe5tW0sfS4A5V7ZMLN69LO5EPTtysl+dMABLw4fsfYhFM+lGyp9MBKQGMqjVaEyzIqqb8VdnMfX2FxCX+BQo2PoMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3403vbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF621C4CEEB;
	Sun, 29 Jun 2025 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751214792;
	bh=ef6rQZIC/ziH2BA7dycq513/pksDVMKdMUwcu1DRESk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3403vbl5suB3BrPuAl8KFrQvJDwX3oceR5hJkBeRfCQTkr2VPdRgfrIy6osO9NaM
	 5iFhBP+D/40TQiUYWJ6359Q7YctQi90tChVaGzd/piy31o1J7zGtQ60leZlTI56YEQ
	 HXGVpSxU15mXzACinvG8PiaVVr9xoKaSxX6+tSwFlihR1rtZQ9GcbOj/0oWL+jZPEM
	 /4rfI+Miu1+9+I1gs4fVgLf3WFVwUf/eAEBjAfUY/1WkDKwyfBpEaGseUd4hndXfqX
	 cSamFty1PIZTQ1ZvfmQQDTxr5Q2do3HK4pvp5GVbzPUYm/FU7XkqC8Bg2UpqfBtmIM
	 UwLaJxoPnDipg==
Date: Sun, 29 Jun 2025 17:33:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] thermal/drivers/mediatek: Add support for MT7981
 SoC
Message-ID: <20250629173302.265b67ec@jic23-huawei>
In-Reply-To: <20250628223837.848244-3-olek2@wp.pl>
References: <20250628223837.848244-1-olek2@wp.pl>
	<20250628223837.848244-3-olek2@wp.pl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 00:38:36 +0200
Aleksander Jan Bajkowski <olek2@wp.pl> wrote:

> The temperature sensor support on the MT7981 is exactly the same
> as on the MT7986.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 9ee2e7283435..020324901505 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1149,6 +1149,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>  		.compatible = "mediatek,mt7622-thermal",
>  		.data = (void *)&mt7622_thermal_data,
>  	},
> +	{
> +		.compatible = "mediatek,mt7981-thermal",
> +		.data = (void *)&mt7986_thermal_data,

Random drive by question.  Why the (void *) casts?

static const struct mtk_thermal_data mt7986_thermal_data;
is the definition and data is a const void * so
you should be able to assign directly without a cast and not
have the casting away of const only to assign it to a
const void *

> +	},
>  	{
>  		.compatible = "mediatek,mt7986-thermal",
>  		.data = (void *)&mt7986_thermal_data,


