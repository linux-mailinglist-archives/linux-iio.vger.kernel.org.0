Return-Path: <linux-iio+bounces-23955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E18B51F93
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AF23BEEF6
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AF132ED52;
	Wed, 10 Sep 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnoQMl12"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B24C068;
	Wed, 10 Sep 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527130; cv=none; b=ZojfYyddldS09LbeTXUAIilL7uBvzFvbdETZbl1lYYF165rj6fOW30NwAkYVL0VBceE34DO6WtNmM/7MUIfFFC/LxOD8FuAMNeQd6Lt+wG7dJ6s7COTpaB7T9Z7zhj0f+68FtaLcqu64MJz2kgFLGD+dAFaw1QJVq8achp7APk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527130; c=relaxed/simple;
	bh=g2xed9pxoxUvYaYcTwnFZ+tdZ8w4HAXKzjc4YLhXk9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3S6HPhdlXTCZsTngtFjxCNw4BExTyTeJkbUUyMVjFAocf3kFlxoS9SSjKmFSvv6W+5tM1Bgn/QtSriScev4ugjOMD8N+ygbuhvO+ZU623xCr4DjYtZ8+7SR1tnNZFZt9HGL9IXKaD4KAW6KmdmI714PVQt/VeFFs/079Assvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnoQMl12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B9BC4CEEB;
	Wed, 10 Sep 2025 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527129;
	bh=g2xed9pxoxUvYaYcTwnFZ+tdZ8w4HAXKzjc4YLhXk9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnoQMl12ZDhP3vlKfv+GqmgcN3uFjROZ/lUTMJJZpPd6wuRTAi2gw8FJhxowP0FkN
	 MLkUmHkBz+3YqS9VCd/UQOIIQjpQ5gq/GAklyUX3KdJhPiHY37YgfEdta+GljLin5X
	 hemJXD/YN9ChdDleZIMjxVHbt+KH24dRBj6xlC8kd68n856dUbc0gvoscChJR7L2Ni
	 75jQm2QpBGDomwm9SBon01q933NmpHi4K2RsRJoti3Hc7bLwcTUkaAiS8X8zmVzMIP
	 e5Uozcv/lnMWJyq57xIMHp+aGiAFMDkSp58k5OLzPl8usJrSx/yMfC7HUY5GQTwPEs
	 E+BdZAQUR/0QQ==
Date: Wed, 10 Sep 2025 18:58:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/14] iio: accel: bma220: add get regulator check
Message-ID: <20250910185841.075594bb@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-6-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-6-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:11 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

I don't follow the 'add get regulator check' of the patch description.
This is ensuring they are powered up if necessary.  So I'd
just go with the vague: "turn power supplies on"


> Add devm_regulator_bulk_get_enable() to device probe().
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> no change
> ---
>  drivers/iio/accel/bma220_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 6bc2e5c3fb6cebd50209acbcc2d5340630c27cd1..b6f1374a9cca52966c1055113710061a7284cf5a 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  #include <linux/spi/spi.h>
>  
> @@ -205,6 +206,13 @@ static const struct iio_info bma220_info = {
>  static int bma220_init(struct spi_device *spi)
>  {
>  	int ret;
> +	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> +
> +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
>  
>  	ret = bma220_read_reg(spi, BMA220_REG_ID);
>  	if (ret != BMA220_CHIP_ID)
> 


