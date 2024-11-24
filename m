Return-Path: <linux-iio+bounces-12571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8079D7353
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F7AB39BC8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4C1BFE03;
	Sun, 24 Nov 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btUWidhC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA2191F83;
	Sun, 24 Nov 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453200; cv=none; b=TS740LLUxn10T2KwLm+44pZc4/geGtvCsfnFwrbOOabfUvWoVIWmYDZpeP35nqxnWroQE1zOUkYPP7Zgyjy+V+QUQA4aGDhI2GE6RhlxTR6N3bsBFxW/OWUeQKXCdnpX+n+DmJ568W8dfM6OrNeNlLsZmYLkNAz5oYpaIeMMkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453200; c=relaxed/simple;
	bh=UfgeGn4y2cFVozdHktQuVc/TCDzh8P9uvUWprzDl0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZJTsgD5/170qSNtagEgjS5WWSwzViZ9b91q9agu5NpbEMxlNNi58LS2FaBhrOVwyWnm6gckZKWlZCpPUPFfpKJncVVScMSPHso62W/tWyovGMIQLQA6YXPtbt4WhTaVAE4vLjVd7WdTvRQ87s9ogHnl8BoaIlWgd/3GYJa9+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btUWidhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97A4C4CECC;
	Sun, 24 Nov 2024 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453200;
	bh=UfgeGn4y2cFVozdHktQuVc/TCDzh8P9uvUWprzDl0Fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btUWidhCVDT32/7FYK4cU/r7tcrjFXGeaTd9Y8TVQyNjC93xpqbH7QJgczB+s75m3
	 t1pwlrtbX7mvJmLprJgFjffvQ3/yf1qFk0j+RtxSUAgSinM80ilNfJLBhhxA3l7H5I
	 /DE1Ou/4ZQcMHe0xrAH0qAD9oc+xPDaxcHtVupixUM2IOmyGEc1dwoSG/iw0lYGQje
	 PDPX5fXfD0QhWrw07J+LLRRlP/xS4s5Dtds6b/PJktfQe2e9bSQM4FJDT29b+3guBh
	 oWPLLwyvTsjwbNbO/QChIJDM0Cth97KFaFxMcLs3d6OyOZJyw8FqCR7N5ERZAqH4/z
	 GJkN0/NY8iXbQ==
Date: Sun, 24 Nov 2024 12:59:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Cibil <cibil.pankiras@aerq.com>
Cc: ktsai@capellamicro.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm3232: Reset before reading HW ID
Message-ID: <20241124125953.75d241b2@jic23-huawei>
In-Reply-To: <20241114131656.1707358-1-cibil.pankiras@aerq.com>
References: <20241114131656.1707358-1-cibil.pankiras@aerq.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 14:16:56 +0100
Cibil <cibil.pankiras@aerq.com> wrote:

> From: Cibil Pankiras <cibil.pankiras@aerq.com>
> 
> According to the datasheet, the chip requires a reset before any data
> can be read. This commit moves the device identification logic to
> occur after the reset to ensure proper initialization.
> 
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Signed-off-by: Cibil Pankiras <cibil.pankiras@aerq.com>
Hi Cibil,

If you are resending for any reason make sure you add
[RESEND to the patch title and say why under the ---

That let's people know it is the same code if they have multiple
copies.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3232.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 2c80a0535d2c..db33671c448c 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -89,6 +89,15 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  
>  	chip->als_info = &cm3232_als_info_default;
>  
> +	/* Disable and reset device */
> +	chip->regs_cmd = CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
> +	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> +					chip->regs_cmd);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
> +		return ret;
> +	}
> +
>  	/* Identify device */
>  	ret = i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
>  	if (ret < 0) {
> @@ -99,15 +108,6 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  	if ((ret & 0xFF) != chip->als_info->hw_id)
>  		return -ENODEV;
>  
> -	/* Disable and reset device */
> -	chip->regs_cmd = CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
> -	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -					chip->regs_cmd);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
> -		return ret;
> -	}
> -
>  	/* Register default value */
>  	chip->regs_cmd = chip->als_info->regs_cmd_default;
>  


