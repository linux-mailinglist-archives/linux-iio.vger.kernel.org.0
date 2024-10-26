Return-Path: <linux-iio+bounces-11316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E39B175C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0669B23052
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859A1C1ABC;
	Sat, 26 Oct 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk47TMwH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FF217F29;
	Sat, 26 Oct 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941418; cv=none; b=CkIvbNJPhOjGnQx52U3EqJyXbn36DpCBIJMhvte9p4beF0F7AoQLn5f/srJ/2V2RKQXoPOtfEL5KePvkRIjpSrRP5VtAMlWWmqwVzlwZCAaFP9/GQ3j0q5HnyS/IsI+TsUVJoghhHAAGo68B30IRGw/GwAjdc+Dd5CeBsoAElng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941418; c=relaxed/simple;
	bh=OMpsTdVYMihbCxq4UwD+nRquehpqEihzxQ+Rsqsxkxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbMOIhluk4JNOK3xT9SEpvIuDpKUouqTJhXpPD9PfJNo5NYGHgdxG1771zolCwiIe5d2osj4qYqTCMi4gUVOW2HwApVV3QVuWvhdZXbym2YZi5P8Ulka3g7lPraystiahqJRYBtSPSx1v9mIUdYlsLyyqRdAeuq/eSZaVJ6mYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk47TMwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14FAC4CEC6;
	Sat, 26 Oct 2024 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941418;
	bh=OMpsTdVYMihbCxq4UwD+nRquehpqEihzxQ+Rsqsxkxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rk47TMwH3OyCpJNr0ItFF45D+RD4Y07nNfEb15BETGSZgPm6v9W/lOHd0a298bnEq
	 aBZEJpdVttGYDe79Z9dXiRdTDss7OVOjQDYGZRbgP0VBS8ndOarXXEP3R8GeiEONj6
	 wfFX/vxW966rlCBAgxi1AYHumG5CmsEKhptBsRCVRRhnOTKT/CysY8OBYihWo18+DT
	 mC8lxe8tVDZIug8Xd9DzSkwlTvgmvkqQZqP1Q+ORVwGwxVAFs7UTmKiEqZ914N1hPA
	 q60bJ5OfOqrFeP8naWgj2Zh4oO61nMkWAUrmbWBCjR0hqko/4OrIGo6QLSEQbm6UcN
	 1Vuu+uzy2f4qg==
Date: Sat, 26 Oct 2024 12:16:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rayyan
 Ansari <rayyan@ansari.sh>
Subject: Re: [PATCH v3 07/24] iio: accel: kxcjk-1013: Revert "Add support
 for KX022-1020"
Message-ID: <20241026121619.668d07d7@jic23-huawei>
In-Reply-To: <20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-8-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The mentioned change effectively broke the ODR startup timeouts
> settungs for KX023-1025 case. Let's revert it for now and see
> how we can handle it with the better approach after switching
> the driver to use data structure instead of enum.
> 
> This reverts commit d5cbe1502043124ff8af8136b80f93758c4a61e0.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I'll take this the slow way as I don't think there is time to chase the revert
through the various trees and still get the dependent patches in.
Hopefully we will fairly quickly get the missing table data and can
bring this back again.

For now, applied to the togreg branch of iio.git.  
I have tagged it as a fix though. and +CC Rayyan
(I'm guessing maybe that will bounce as you rarely miss people you should
CC!)

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 2eec95d8defb..208e701e1aed 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -174,7 +174,6 @@ enum kx_chipset {
>  	KXCJ91008,
>  	KXTJ21009,
>  	KXTF9,
> -	KX0221020,
>  	KX0231025,
>  	KX_MAX_CHIPS /* this must be last */
>  };
> @@ -582,8 +581,8 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  		return ret;
>  	}
>  
> -	/* On KX023 and KX022, route all used interrupts to INT1 for now */
> -	if ((data->chipset == KX0231025 || data->chipset == KX0221020) && data->client->irq > 0) {
> +	/* On KX023, route all used interrupts to INT1 for now */
> +	if (data->chipset == KX0231025 && data->client->irq > 0) {
>  		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
>  						KX023_REG_INC4_DRDY1 |
>  						KX023_REG_INC4_WUFI1);
> @@ -1509,7 +1508,6 @@ static int kxcjk1013_probe(struct i2c_client *client)
>  	case KXTF9:
>  		data->regs = &kxtf9_regs;
>  		break;
> -	case KX0221020:
>  	case KX0231025:
>  		data->regs = &kx0231025_regs;
>  		break;
> @@ -1715,7 +1713,6 @@ static const struct i2c_device_id kxcjk1013_id[] = {
>  	{"kxcj91008", KXCJ91008},
>  	{"kxtj21009", KXTJ21009},
>  	{"kxtf9",     KXTF9},
> -	{"kx022-1020", KX0221020},
>  	{"kx023-1025", KX0231025},
>  	{}
>  };
> @@ -1727,7 +1724,6 @@ static const struct of_device_id kxcjk1013_of_match[] = {
>  	{ .compatible = "kionix,kxcj91008", },
>  	{ .compatible = "kionix,kxtj21009", },
>  	{ .compatible = "kionix,kxtf9", },
> -	{ .compatible = "kionix,kx022-1020", },
>  	{ .compatible = "kionix,kx023-1025", },
>  	{ }
>  };


