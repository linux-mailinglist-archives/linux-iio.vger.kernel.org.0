Return-Path: <linux-iio+bounces-3033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDB8626CD
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 19:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB88282B16
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38814264;
	Sat, 24 Feb 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjlQrhDQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF93EDE;
	Sat, 24 Feb 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708799551; cv=none; b=eczdZboTsMkA9mihoa6+dK8GtkH4jQkn2Inck4AJGylAtbm4KRn3PlOXiOamfBlUosrl+VzX+7kOkbvMfz73xVQLlFn+7Zh6p2QdGVNRgGWz3+25uH1RlhkU0ylBRSn83q+ZHsOuakHQaYecRQSt2wu7kyY00AaHYW+JB6MKxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708799551; c=relaxed/simple;
	bh=vIKrVRRo5ogvPsSww2rc77ridlsBoXGNDayjIb3Ao1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjYLtBLza+kv9L0ZP9Zar/gVIrxS9mj2hN4lKqncNhr7gQ1163Yb3CbGcBoyiuiZ//OmW9ym1iL8tL9xliIE0hJHghBcmZSDxKksMwvs5Aro+AS/WLAaJPgXfMq2yXa28vwUG0YpDYr9+1m7TtBLoA9GwlY6C5uq1evaqUkMPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjlQrhDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27059C433F1;
	Sat, 24 Feb 2024 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708799550;
	bh=vIKrVRRo5ogvPsSww2rc77ridlsBoXGNDayjIb3Ao1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WjlQrhDQi8KsW2poEqOhGp+0od2ZgybxOdjLKTnj2TZjpe0HevY6cWc0JexlWndku
	 tIo+IMLAzEyxByJ17h7Vilmm+lj+5QN84bWxXyc3K7ni3WBmdYLwpfziVQGwxGSiSo
	 ShY0vO74KwVx/LfiVgeKaSHD3PflnhTDS40jrKrAS+iEiqlb1boKjX9ty2bmv59Gqn
	 I5gLTuOgBzx6wMyndrE5gRhaYRPMrBl86gWyo0JoG3+tqQXpKiGZ8WGn7Befwg6Keb
	 k4a5Mmc1qKmAHzX8sqktSlQJPsiILCNNvR23HvQ0g74tBG0d2ZKWsIJ45S4ywnURBq
	 hN89iS7lWvOqA==
Date: Sat, 24 Feb 2024 18:32:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH 2/6] iio: temperature: ltc2983: rename
 ltc2983_parse_dt()
Message-ID: <20240224183216.12307f7e@jic23-huawei>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-2-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	<20240222-ltc2983-misc-improv-v1-2-cf7d4457e98c@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:55:53 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Rename ltc2983_parse_dt() to ltc2983_parse_fw() as there's no explicit
> dependency on devicetree. No functional change intended...
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
It thought the same whilst doing the cleanup.h series but punted it for another
day.  Seems that day has come. Applied.

> ---
>  drivers/iio/temperature/ltc2983.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index acc631857e27..23f2d43fc040 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -1346,7 +1346,7 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
>  	__chan; \
>  })
>  
> -static int ltc2983_parse_dt(struct ltc2983_data *st)
> +static int ltc2983_parse_fw(struct ltc2983_data *st)
>  {
>  	struct device *dev = &st->spi->dev;
>  	struct fwnode_handle *child;
> @@ -1630,7 +1630,7 @@ static int ltc2983_probe(struct spi_device *spi)
>  	st->eeprom_key = cpu_to_be32(LTC2983_EEPROM_KEY);
>  	spi_set_drvdata(spi, st);
>  
> -	ret = ltc2983_parse_dt(st);
> +	ret = ltc2983_parse_fw(st);
>  	if (ret)
>  		return ret;
>  
> 


