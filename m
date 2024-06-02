Return-Path: <linux-iio+bounces-5608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E48D74F2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2D21C2107B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE3383A2;
	Sun,  2 Jun 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxteHi9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913A2574D;
	Sun,  2 Jun 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717327667; cv=none; b=u4QTKROV5BMFSEU3t4Uq4FPVe0HNVtHlaJUeRlbShk1SwFFActH1zsV+EaRJx40eVVKM01skzgLcf6yv+/7Ff4cId3mbZps43MIn6/bKkAh0fVwNkzNCdTAWqkA7swiYZaFjCrk3AaQ8yAbrMmCc+Bq/MYuCDS+Yf7YpvM1BD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717327667; c=relaxed/simple;
	bh=Lwha5IB5hh3/aivFQ6QRrrVvxlZpn4aDHhuG6j1fiLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUiWhyRuPnCQ1AmvDlWf9elTlGrvrHFDkZUXxu36WTNwONjN1Fum9yPsiyjWWS+PSabOfMgBBSdtbrEWs61ROmF2t4Af3hReSU9/Sp6RPg85yBDe1ph4c8nld1s0wmNS4oU7wfXY9zbcYVxpCpeaG5f7CnZOU7TlVRkJpZY03R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxteHi9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFCAC2BBFC;
	Sun,  2 Jun 2024 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717327666;
	bh=Lwha5IB5hh3/aivFQ6QRrrVvxlZpn4aDHhuG6j1fiLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FxteHi9aVxAg7eNJqwBtC5wRZJh+Qupe4klOk81L4hCTTbJbnyRqY+1+LKjkfxT6c
	 UJLvyjoKrDfleEQNaF7/d3NOLV3Y/5yjaN4i2+Pd+8Q6xPVQUWG7k+2ifh6rS+3vSg
	 FUFVs4K+1ixX/H0ZQcHpXezLEC3UYoktLn5kbRx2js04siUTusFY+nzzRdCcpe/saE
	 oR2D39eU7UgIURlGzNdidh00Wl8A/UwW8Tue7QqzmaGpX/dJd8Sr6Y1EWIqY9mEm0J
	 xYIvp3iHop+R+qc7PnyvPa25/lf5V6tA1zf7gcH6vuMEpOXm0XAI2V0UJ9YwYuB+Hq
	 W4GU9vxzK0k4Q==
Date: Sun, 2 Jun 2024 12:27:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: chemical: ens160: add triggered buffer
 support
Message-ID: <20240602122733.5935da67@jic23-huawei>
In-Reply-To: <20240529001504.33648-4-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
	<20240529001504.33648-4-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 21:14:21 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ENS160 supports a data ready interrupt. Use it in combination with
> triggered buffer for continuous data readings.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
A couple of really minor comments inline.

Thanks,

Jonathan


>  #endif
> diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
> index a535f62c4..74ef7f150 100644
> --- a/drivers/iio/chemical/ens160_core.c
> +++ b/drivers/iio/chemical/ens160_core.c
> @@ -10,6 +10,9 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> @@ -19,9 +22,14 @@
>  
>  #define ENS160_BOOTING_TIME_MS 10U
>  
> -#define ENS160_REG_PART_ID	0x00

move this in earlier patch so no need to realign here.

> +#define ENS160_REG_PART_ID		0x00
>  
> -#define ENS160_REG_OPMODE	0x10
> +#define ENS160_REG_OPMODE		0x10
> +
> +#define ENS160_REG_CONFIG		0x11
> +#define ENS160_REG_CONFIG_INTEN		BIT(0)
> +#define ENS160_REG_CONFIG_INTDAT	BIT(1)
> +#define ENS160_REG_CONFIG_INT_CFG	BIT(5)
>  
>  #define ENS160_REG_MODE_DEEP_SLEEP	0x00
>  #define ENS160_REG_MODE_IDLE		0x01
> @@ -48,7 +56,12 @@
>  
>  struct ens160_data {
>  	struct regmap *regmap;
> -	u8 fw_version[3] __aligned(IIO_DMA_MINALIGN);
> +	struct mutex mutex;

Mutex needs a comment to say what data it is protecting.

> +	struct {
> +		__le16 chans[2];
> +		s64 timestamp __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +	u8 fw_version[3];
>  	__le16 buf;
>  };


