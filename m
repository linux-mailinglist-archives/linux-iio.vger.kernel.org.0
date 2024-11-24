Return-Path: <linux-iio+bounces-12570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3C9D7014
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B9162DD1
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA91FF60E;
	Sun, 24 Nov 2024 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoDRo/DU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C621FF602
	for <linux-iio@vger.kernel.org>; Sun, 24 Nov 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453105; cv=none; b=llyHFAxLs8vHvAWAeO1RSVD0inNRd+7JYmNgnpv7LsCzcR2VJaO8tv0wynexxUEBLm18Ozs4tM9daDB12s8v7yUeT+QX7Dwx8meZsDnr2oXhsC3odz7YKzj+KLwT6M69FCRrifoMWyTSMIi2LzS8ShrBxECX1qKgNy1lQagdq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453105; c=relaxed/simple;
	bh=3Zu2ixvDtTcV8MJVAOJlQTvG5NvNyYajw458ZICIa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOlaH0DntAPsJ0t9YfTnsMnQhu8NB1c4rmcKX3yFprx037hUu+1ecBunmLVymR5csbQkcgXoLj+q9gg37iNxt09j25v0V3Jv3YSQVFm9ATAGhDIn7WRSsjK7/30RATfTLt7FI/w56/jpfW05FCfeazgP+izZCuIjWg5mUeF2qow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoDRo/DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6943C4CECC;
	Sun, 24 Nov 2024 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732453105;
	bh=3Zu2ixvDtTcV8MJVAOJlQTvG5NvNyYajw458ZICIa7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZoDRo/DUPFHhcUY5bATQCSeoYWeARcvAuMB3E42kl8IR/2YJ8dnv4oK5pJ6KD3cdC
	 FYb1HPo6NZmTs5wpkCIAOhX2VKHl2g0OBFH9tT3VPMtIkUOyYmTJP1tNTiXeHFcUaG
	 7Nffvm40mu73drFPtRip47O59MY6686k4P3AYwv22e3fSTBKE3YOl7BEYNBznB/OAk
	 JblO5v+q/CE+dypVRcLRdljK5sXzluZZo4KZ997zVadUu3mnQBSksRjrNbfEanGhxq
	 2x4eaJhMpZv8fh6UIS+yzCzsIwcS4KSAdNxaWxtPdj0EJTvmU/Me6mkGYCGU2lBk5w
	 iygChWJkJm8mw==
Date: Sun, 24 Nov 2024 12:58:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Cibil Pankiras <cibil.pankiras@aerq.com>
Cc: linux-iio@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH] iio: light: cm3232: Reset before reading HW ID
Message-ID: <20241124125818.1161a85b@jic23-huawei>
In-Reply-To: <20241114091323.7415-1-cibil.pankiras@aerq.com>
References: <20241114091323.7415-1-cibil.pankiras@aerq.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 10:13:23 +0100
Cibil Pankiras <cibil.pankiras@aerq.com> wrote:

> According to the datasheet, the chip requires a reset before any data
> can be read. This commit moves the device identification logic to
> occur after the reset to ensure proper initialization.
> 
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Signed-off-by: Cibil Pankiras <cibil.pankiras@aerq.com>
Hi Cibil,

This is an interesting corner, because if the ID register isn't going
to match, chances are that write just wrote wrong data to something else.

Ah well, the firmware should be correct so I'm not sure I care about
that change.

Applied but to the togreg branch of iio.git, not as a fix because
it does make me a little nervous and I'd like to not rush it in!

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3232.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index b6288dd25bbf..5b00ad2a014e 100644
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


