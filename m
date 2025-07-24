Return-Path: <linux-iio+bounces-21936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5CB1079E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970111C8535A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32FE262FF3;
	Thu, 24 Jul 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phDo8jra"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A62367A6;
	Thu, 24 Jul 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352482; cv=none; b=tuGwFFfV67GgLG8LLbl8QiuIwL3143Z3uBAlXkVBOhLb17LPu0JiLMYwatFt8Tcc2tJyuQ/boBubcYAP2w//S2grJ/Q3HQVBWwWkLfycFlLHc0+H+HSrWWBNkcb9ysBcF25NEO78oDtZe72IM+Wwexf9W4RPIUzHO/i+NMQXgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352482; c=relaxed/simple;
	bh=tfgrRYHo0vXYtdtTDaVJnEB+ORbrQpP2ZOHprCaV6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZXOqKs87zkv8wUkSnRr7z+MuKJNYX8T+UkM1Lx6rClYSvgDWmHOQzZMKoZt0gj+9FtsjiPk7NuR/hQtrNDroAI9WV3OmrLBKVF6ZHuqpGiZP22Ha+q4ZkXO75Rz6nqUPIiRKstf09CsGUJNa1Ae0AIkkJYKCfhxtnRfsjrASTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phDo8jra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC2C4CEED;
	Thu, 24 Jul 2025 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352482;
	bh=tfgrRYHo0vXYtdtTDaVJnEB+ORbrQpP2ZOHprCaV6Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=phDo8jraqdctHHXAGuipz9dVCiO5sLm9QbiFCAKLPd1dDKTqNw9OISbRGMMN1Z8gB
	 F5hfkhbtcmkAsCT0loBMniwr2yybBYtdWoUG3edzCqEQQj/R0Co83OPFo4yfyxy7eZ
	 r1OigGixiVn77GEjYwd3E/5dgsFpMl3Qm5Of8UaYj0DRfpHRV4Z5fCWOX6mADBFEzu
	 aOxIrqcv1RcrZDxomwRiDTSGKkC306rLAiMFPuhZooqg6lNT5BrMtMQwnvv7/vwBJ0
	 LTvJ076PxJA3ldtDDIV/r51TSOhE93jEw+UPeTjdXyAFTiXX55/f9dhNKe20cgYTzr
	 yQnYu9U+Yyn+Q==
Date: Thu, 24 Jul 2025 11:21:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3300: fix uninitialized iio scan data
Message-ID: <20250724112114.47865250@jic23-huawei>
In-Reply-To: <20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-v1-1-12dbfb3307b7@baylibre.com>
References: <20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-v1-1-12dbfb3307b7@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:29:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix potential leak of uninitialized stack data to userspace by ensuring
> that the `channels` array is zeroed before use.
> 
> Fixes: edeb67fbbf4b ("iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to a temporary fixes-togreg-for-6.17 branch.

Will sort this out after the merge window.

J
> ---
>  drivers/iio/accel/sca3300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index bda370c0f660b2a603d7d70dbe5e088bf96eca7a..8380b237831cec8e7520335dd9f78a2f30531448 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -477,7 +477,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct sca3300_data *data = iio_priv(indio_dev);
>  	int bit, ret, val, i = 0;
> -	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
> +	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX) = { };
>  
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250723-iio-accel-sca3300-fix-uninitialized-iio-scan-data-c31f13b4b520
> 
> Best regards,


