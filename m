Return-Path: <linux-iio+bounces-12236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE59C8407
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E173E1F22AFC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF701F470D;
	Thu, 14 Nov 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Fne2Z7PL"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615D1F26E6;
	Thu, 14 Nov 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569621; cv=none; b=ZgtjPUKrMP1fBchA41HOspGJoyGXPQkxDZD4t4h8dET/bisT+C0HH9ZtjxTb+brj4QpZtSJ3VaSUgd5GkFv9YhlQiakm232yDTh7juEgtqmgezyWdWIdBaRBKqbFS6CnoQTWrfynSt32O/Isgh7w/p7UERwCpbr+MOEi5IU0R6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569621; c=relaxed/simple;
	bh=7J4uK4QeeYYm76x2b7jzzLx/Fvq4GR2XnkYjpHH2qzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+A/FjV2uJcsr7ieE90p4BTrZgtJ4XRUz5xVWOItO+wnJ5X6ovkMPXcpuiq6SouV19DmICS19ZVJ5xtBRpwRb6MJUPUam28V/0ItfAGOvondoJPA7PnEAP4sZwquZq6vyD0lzdWl172PDq8k8fMlBnvaZT3hWZegs8B8NUpQ3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Fne2Z7PL; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=bJvP8iP45vhHARfs0RyJrwfJhojC+WwD+KjZ2RpOHOs=; b=Fne2Z7
	PL+NM/Ji3LVVIKjtKqfn9VDlLRjpCzMC6t1YLJ5UepIUpkgxFAI3iv45hKGr9G8RAqKMQf2aymS4i
	qTuKWe89InnpE5DUpFQijONWHuoHOWxHkV9kUYDuGzPHuUss7T0F39vLFsCwtfTx7dW7xnPDEKtQX
	c5+37aE9dXKk28nXUfkHuByzK8IXaYf8ySgMCkadVBCkUnSZpEouUbZTrnZ27CZuvbAKFETDFuxAI
	2o5at3Sf8oN4SOqnHetdE6pkRp8lrjXJgnqKTLCkyo8JZJEdXBAe4QNt/JY99ZkXXIJpmP9sNgAyW
	xvtYKB6wthIyGFNZQ4V/mz3cNu6w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBUMD-000PtS-F7; Thu, 14 Nov 2024 08:33:37 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBUMC-000Gy7-2a;
	Thu, 14 Nov 2024 08:33:36 +0100
Date: Thu, 14 Nov 2024 08:33:36 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH 4/4] iio: accel: fxls8962af: add fxls8967af support
Message-ID: <ro4gzsfpr6sxdrp2yuv4worvi2mb2fchpxvl63c7phgnuwe4et@nlnnifxdovm2>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-4-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-4-5e48ff1b1fb8@nxp.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Wed, Nov 13, 2024 at 12:54:42PM +0100, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> fxls8967af is similar with fxls8962af, the only difference is the device id
> change to 0x87.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index b5607e753a7db..fd9b461904c20 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -130,6 +130,7 @@
>  #define FXLS8962AF_DEVICE_ID			0x62
>  #define FXLS8964AF_DEVICE_ID			0x84
>  #define FXLS8974CF_DEVICE_ID			0x86
> +#define FXLS8967AF_DEVICE_ID			0x87
>  
>  /* Raw temp channel offset */
>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> @@ -767,6 +768,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8967af] = {
> +		.chip_id = FXLS8967AF_DEVICE_ID,
> +		.name = "fxls8967af",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> +	},
>  	[fxls8974cf] = {
>  		.chip_id = FXLS8974CF_DEVICE_ID,
>  		.name = "fxls8974cf",
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index ebdf6926db0a7..029ba849a0423 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
>  static const struct i2c_device_id fxls8962af_id[] = {
>  	{ "fxls8962af", fxls8962af },
>  	{ "fxls8964af", fxls8964af },
> +	{ "fxls8967af", fxls8967af },
>  	{ "fxls8974cf", fxls8974cf },
>  	{}
>  };
> @@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
>  static const struct of_device_id fxls8962af_of_match[] = {
>  	{ .compatible = "nxp,fxls8962af" },
>  	{ .compatible = "nxp,fxls8964af" },
> +	{ .compatible = "nxp,fxls8967af" },
>  	{ .compatible = "nxp,fxls8974cf" },
>  	{}
>  };
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index 733b69e01e1cc..1c9adfc8c0dc1 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -11,6 +11,7 @@ struct device;
>  enum {
>  	fxls8962af,
>  	fxls8964af,
> +	fxls8967af,
>  	fxls8974cf,
>  };
>  
> 
> -- 
> 2.34.1
> 

