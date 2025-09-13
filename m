Return-Path: <linux-iio+bounces-24062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4EB56190
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25A5179D1F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB922EFDA6;
	Sat, 13 Sep 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6B8L73k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE42287241;
	Sat, 13 Sep 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773562; cv=none; b=XAoCOqURh6dtJu3nnX+7fiPOZIQvUhknN23oQJtGr4gmsDPMX4WFua4iBgtr2TP7ltxzp9MVdsTQ7U5hCC9sIRJanrXvzlR1ZnEQUO7lNsJRiCmH7qknXx/Ce4NWkaiS/Vxdrr8TNlBuxKjI38CWPuotfDs5MUD0vlxG8J5VINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773562; c=relaxed/simple;
	bh=iLR+wMZkehN56E53wCGSMm2CSGQ7xDJDJUUYfyMxMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8cI0RdjcJIUiI/1PtJui2hLlhimo9/ihZBqhULb6X97U2YbaLRTtryCMcqZEwg+iJAVDZsf5rChpTwkpXdLYecbJJjfX10sVcES1SVxlpRPicGn90GWSZGxThB6+oF1FKd4OYa+iSRLHAcVsND/yP5aou09ygEuOzHPOzT+q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6B8L73k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3105BC4CEEB;
	Sat, 13 Sep 2025 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757773560;
	bh=iLR+wMZkehN56E53wCGSMm2CSGQ7xDJDJUUYfyMxMIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6B8L73kzLWqTY4rb2aYhJM1u2uhQNgHb+RtjzTrC3zbPOUpQhrShP67str4KSiSm
	 rdAO4nVetqvk2hvUdN8GQlP1FGcoIeyGhamaGmNLdSK7CiOI+d/uf7zv4f34QMokcu
	 UGeU02vJ5uuLY6EVSfbJUiLm9RBDlAShk9eM8PqQ1xqsAgoH8S0ogV4De/Fm0OhoxY
	 7+9TxczJcoXFN2WaaKTeRUYUrX0NsOYkeyjUa/xgvdqatsSAsDjzKSzJwoY7Ga30q/
	 Lm+qj03yD2kwaqYP9HOUnndgw/XeZtgeCzz2cEKnCUUrO4RGptWtsccFFZ41Fquh2n
	 i7t6+3OYw2KzA==
Date: Sat, 13 Sep 2025 15:25:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: pressure: bmp280: Use
 gpiod_set_value_cansleep()
Message-ID: <20250913152552.5f7d82d3@jic23-huawei>
In-Reply-To: <aKsAMRkmGX160gHl@pc>
References: <aKsAMRkmGX160gHl@pc>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 13:06:09 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Replace `gpiod_set_value()` with `gpiod_set_value_cansleep()`, which is
> required when the GPIO controller is connected via a slow bus such as
> I2C. This is also safe to use in sleepable contexts like the driver
> probe function.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
dropped my editted v3 and picked this up.

Please don't send parts of patch series and if a patch has already
being replied, it is fine for the numbering in a later version to update
to reflect that.  Anyhow not a problem this time as I think I have
all the right patches.

Jonathan

> ---
> Changes in v5:
>   - Clarify commit message in patch 3/3 to better explain why
>     gpiod_set_value_cansleep() is needed, as suggested by Andy
>     Shevchenko.
> 
> Changes in v4:
>   - Split patch 2/2 into two separate patches, as suggested by Markus
>     Elfring.
> 
> Changes in v3:
>   - Split into two separate patches, as suggested by Andy Shevchenko.
>   - Improve the error message to "failed to get reset GPIO", as
>     suggested by David Lechner.
>   - Add Fixes and Cc tags where appropriate, as suggested by Markus
>     Elfring.
> 
> Changes in v2:
>   - Use IS_ERR() instead of IS_ERR_OR_NULL()
>   - Drop dev_info()
>   - Use gpiod_set_value_cansleep()
>   - Improve commit title and message
>  drivers/iio/pressure/bmp280-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 1f0852fc3414..656f6189c84c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3217,7 +3217,7 @@ int bmp280_common_probe(struct device *dev,
>  		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
>  
>  	/* Deassert the signal */
> -	gpiod_set_value(gpiod, 0);
> +	gpiod_set_value_cansleep(gpiod, 0);
>  
>  	data->regmap = regmap;
>  


