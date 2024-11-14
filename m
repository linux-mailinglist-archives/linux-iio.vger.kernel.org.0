Return-Path: <linux-iio+bounces-12235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638119C8405
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E348AB25B7A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9D1F5822;
	Thu, 14 Nov 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xq0Bo4fp"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF6163;
	Thu, 14 Nov 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569608; cv=none; b=tLyaU8a7NxigX1dMcDhTlxKgDk/CEI+bpGa8CBBGnIodbJ3HZG53PrHEt7ReHPTPYJSCodJ4u4u+vSjwr1GevLNnkcIFGEg8ekXfiKYGU2mpR+crntiol4A7V6XvhaaTEdMk6VaZ4Nvyi7AtzOXVHq2Nfn3IBKbRz5NPQuBXaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569608; c=relaxed/simple;
	bh=alnA+EGvN8cBrlMmTMXnKzmMF5dg1/dO24x59s+AigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTrTPjBq0gv2UVF4dy0VmVfJDb+3wYpRCuxXBteyGJqhxQTzngef0BQVd9pLy2q5AePaf1ggrp6jYcFrFcluYiTCvL2fQh2iAn4nvfeDcGXipYAuitQZoGGFHHkNSxcOkOG+fw2RcYr+UCpradwAbMXA1MJJOLPDiHN4ZBxeepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xq0Bo4fp; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=BfZ4nbjrHSSOcVC33gwwx76GXVKab1ZLNWFFHe2ck9M=; b=xq0Bo4
	fpcf+oDtPnVRuL1tX1RYLUg1a9jJgPBCkZvYtav5UVimDBYWGeV1riqhCuktOGseBhpvzXeaDREkk
	M8T4VRRSX9qwIqiDnAkc7KjtGUg/kwrkWIbOMv+6opj7Al52fWFOPPFlR2OxtJI5G9L8x1IDmdOaY
	EKVka1rBfIqxLLjb/R+uyN+EK+q+j0RlqLxhXwLZKSJ5DibrwiMCTWW0ADRBMpWIy6A2sTEV8voAo
	hNNFIaFlHRSIUNsiu+Ql2dULHYU8Wdo3xt026GkNiWIMCgecakoN7AoDA68eXx5GeNG7VoOIvJM6B
	yNbK/85yB2oPW4rXJl9qyef5oKPA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBUM0-000Pqi-Q5; Thu, 14 Nov 2024 08:33:24 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBUM0-000Flv-0S;
	Thu, 14 Nov 2024 08:33:24 +0100
Date: Thu, 14 Nov 2024 08:33:23 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 3/4] iio: accel: fxls8962af: add fxls8974cf support
Message-ID: <oik276kjzz6i3iz3mabylot64quuljyhqy2i7yx5mssusxshwk@5t4zbzrbp3io>
References: <20241113-fxls-v1-0-5e48ff1b1fb8@nxp.com>
 <20241113-fxls-v1-3-5e48ff1b1fb8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-fxls-v1-3-5e48ff1b1fb8@nxp.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Wed, Nov 13, 2024 at 12:54:41PM +0100, Frank Li wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> fxls8974cf is similar with fxls8962af, the only difference is the device id
> change to 0x86.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
>  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
>  drivers/iio/accel/fxls8962af.h      | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index f07fba17048e7..b5607e753a7db 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -129,6 +129,7 @@
>  
>  #define FXLS8962AF_DEVICE_ID			0x62
>  #define FXLS8964AF_DEVICE_ID			0x84
> +#define FXLS8974CF_DEVICE_ID			0x86
>  
>  /* Raw temp channel offset */
>  #define FXLS8962AF_TEMP_CENTER_VAL		25
> @@ -766,6 +767,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
>  		.channels = fxls8962af_channels,
>  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
>  	},
> +	[fxls8974cf] = {
> +		.chip_id = FXLS8974CF_DEVICE_ID,
> +		.name = "fxls8974cf",
> +		.channels = fxls8962af_channels,
> +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> +	},
>  };
>  
>  static const struct iio_info fxls8962af_info = {
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index 1601246733083..ebdf6926db0a7 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
>  static const struct i2c_device_id fxls8962af_id[] = {
>  	{ "fxls8962af", fxls8962af },
>  	{ "fxls8964af", fxls8964af },
> +	{ "fxls8974cf", fxls8974cf },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> @@ -37,6 +38,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
>  static const struct of_device_id fxls8962af_of_match[] = {
>  	{ .compatible = "nxp,fxls8962af" },
>  	{ .compatible = "nxp,fxls8964af" },
> +	{ .compatible = "nxp,fxls8974cf" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index 6eaa2803b26f0..733b69e01e1cc 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -11,6 +11,7 @@ struct device;
>  enum {
>  	fxls8962af,
>  	fxls8964af,
> +	fxls8974cf,
>  };
>  
>  int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
> 
> -- 
> 2.34.1
> 

