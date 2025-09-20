Return-Path: <linux-iio+bounces-24316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB1B8C682
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE0817BD33
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECEB2F9982;
	Sat, 20 Sep 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7r0zvnN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCA2F7AA1;
	Sat, 20 Sep 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366396; cv=none; b=g3jZxjcMJIKA0N++bljbWAS938lV2FzitM+ZUbqwh/hQp6saoWurH/77judtKv9Scp7sNzbTXhT9N0y89OwfdAot1LPQalZCEXCDStQBKDElmHLAzho4YLuexv0fMA5MWNrKz4TdC1jyADpKbgFlQqURsYsOtmZtXDwDfaUXo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366396; c=relaxed/simple;
	bh=IHYF4fNI1oCnSq4pPg7KO014w0tMqzNW/+gAbGAx5jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdwMzb3qiVW8mxBEy2J/rkkQijOL8iSoZMM6tJ79OHB42r3ebhL9K6v8zVAcFi5QGY9IjKNdol3PZQfAd9JxrfRtRhiVXwnOs0C95uHG/Wd/FTLA1kTfgRoDqYoQvg73ljhZwM7S88AETiKU7yI78y/w4hdPK1j5FP3sVuVpyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7r0zvnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D39C4CEEB;
	Sat, 20 Sep 2025 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758366396;
	bh=IHYF4fNI1oCnSq4pPg7KO014w0tMqzNW/+gAbGAx5jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7r0zvnNZb1vwinp3SBO7mS8ko9Xhkr/Q4HQdSXsiYrurJ6vjAdRPsBfyFShyydcW
	 chq/uZa9UbI+CD+8l1aBUsGcmXeuG5bmyEIHFiJuSKZ8sHtjM6SPQMQcQbrZLkXtHf
	 PGyXG/9sflpJhBywjKsiNvLll+mRXuMaqK01j0OD7tmARCDr0IIvRpYQRS4zeND9dx
	 hxISftz9NSQLIn2u0dhP/sqX33vflFJ+Hph5P8n7eOdK2ucnCklS3abJhqnxqDDwgW
	 K0bPl3VUSmJh+mdqXGFiQdahCA9rZT+uNy+qNKyFXNf7z6ZKbmRig68N+lKcQ4m85E
	 +ts/FeQnA4S/Q==
Date: Sat, 20 Sep 2025 12:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: use devm_mutex_init()
Message-ID: <20250920120627.307a8bdd@jic23-huawei>
In-Reply-To: <20250917-iio-adc-ad7124-use-devm_mutex_init-v1-1-ff23fe3ad954@baylibre.com>
References: <20250917-iio-adc-ad7124-use-devm_mutex_init-v1-1-ff23fe3ad954@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 10:22:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use devm_mutex_init() to initialize the mutex to handle automatically
> freeing in debug builds.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Normally I'd say this isn't worth the churn but fine this time given
all the other patches for this driver.

Applied to iio.git/testing

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9ace3e0914f5acab695c0382df758f56f333ae72..9d9250274b9a02e2982e6ceda27009a84413dc2f 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1482,7 +1482,10 @@ static int ad7124_setup(struct ad7124_state *st)
>  	st->adc_control &= ~AD7124_ADC_CONTROL_MODE;
>  	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_MODE, AD_SD_MODE_IDLE);
>  
> -	mutex_init(&st->cfgs_lock);
> +	ret = devm_mutex_init(dev, &st->cfgs_lock);
> +	if (ret)
> +		return ret;
> +
>  	INIT_KFIFO(st->live_cfgs_fifo);
>  	for (i = 0; i < st->num_channels; i++) {
>  		struct ad7124_channel_config *cfg = &st->channels[i].cfg;
> 
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-use-devm_mutex_init-45a297b1ff8f
> 
> Best regards,


