Return-Path: <linux-iio+bounces-14240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30BA0AADA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1CC3A49D0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BF1BDA97;
	Sun, 12 Jan 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aliZlmFM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6B1BD00C;
	Sun, 12 Jan 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699367; cv=none; b=N6+X6URcXAK2YnkIY8WAcJUy3O3VU7bQq4FE5xILU7bcXMHuXMottchxQuIraKx2menKqEC37py5K9VRu5G3/80cPT5nIj2dICl6XvAApUER2MqAF1pYv2YKoyhAE86t9GE8b8YnWf4BE+i1CQCpRNyS7fwFERND1zUc3TcqQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699367; c=relaxed/simple;
	bh=1FkGHxrT+4FUVFMQX+a0GLRmX87lnAGxI0y0ZQ+2hJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxYQljCTyxHrm88WucJjy8ko3fc8PuvTYwDgSkkPHbYG8OUmalG1u5tJ2Ds6KBukG+4/bqH2qvCakRnsl7UxT9oZuh3Dt1SK6EOY1RD6ApduWbBsuLblpGuueUxKAs5Kralxb8oRUXCPzz1krZXrjqCSWv03OBm39lYb5gEiz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aliZlmFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBFEC4CEDF;
	Sun, 12 Jan 2025 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699366;
	bh=1FkGHxrT+4FUVFMQX+a0GLRmX87lnAGxI0y0ZQ+2hJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aliZlmFM1+XAmime2dBU9phGfqMWeTj7hU4DwTx8Q1mFQZrULukizPyPuZ4tzZUJ0
	 zpEYnrP5tjK/Xq1JyJdfyhg5EHtuDWt7SrT50jIiFXgJkXt58pkFg6AammScNSM6k1
	 M6MQGH7t+5VXnd610cOCGfek9L1ksS9KWWWc+KbW/UVskOaZfy5H4rQXS2H5wjfhdN
	 8IFdCdH+u3LmrwfLDV3dZG+u9c6PrcerK68jKECnPztXS4zr2rft4HEZgO9r+DNdME
	 5bo4MU5z+zfOfuG+u6yJn+ih/R3kjXmoBCn/gM8+cTUlG7m4BZ6PSdbFJbLb2N9CBv
	 2IEsWFLFN6Oew==
Date: Sun, 12 Jan 2025 16:29:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: accel: mc3230: add OF match table
Message-ID: <20250112162917.6f0cfa9f@jic23-huawei>
In-Reply-To: <20250112-mainlining-mc3510c-v3-3-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
	<20250112-mainlining-mc3510c-v3-3-9ee6520ab69d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 15:25:37 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This will make the driver auto loaded via device-tree.
Are you sure that didn't previously work?  I thought there were
fallbacks that would make it use the driver name if nothing else matched.

> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index a153a3f715ed7f2f1417618715767f265b49191d..ba30c904d3f67002deeb3ca5a7e12bfae312e05f 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -205,9 +205,16 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>  
> +static const struct of_device_id mc3230_of_match[] = {
> +	{ .compatible = "mcube,mc3230" },
> +	{}
{ } 
here as well. 
> +};
> +MODULE_DEVICE_TABLE(of, mc3230_of_match);
> +
>  static struct i2c_driver mc3230_driver = {
>  	.driver = {
>  		.name = "mc3230",
> +		.of_match_table = mc3230_of_match,
>  		.pm = pm_sleep_ptr(&mc3230_pm_ops),
>  	},
>  	.probe		= mc3230_probe,
> 


