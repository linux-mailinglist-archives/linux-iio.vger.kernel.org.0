Return-Path: <linux-iio+bounces-11340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D419B1817
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F741C21FEC
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5B1D279F;
	Sat, 26 Oct 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUJk+S/M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B791E4B0;
	Sat, 26 Oct 2024 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945879; cv=none; b=qsbNfulHLO7+VGFEYZDFSdLtR4e18Od/yHPvlBU22f5J9kHmRBs6dhIv023VDMSwVggKgcESO0L19/uSoLMJBY0YSJ97XjSYgovNHpo2k4gq8Elp0Kn6XPF6Qf4c/RQNE9aPpp+0xcDjKteaCDB9l/guseZS3ij4z3uPkEg8NDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945879; c=relaxed/simple;
	bh=R/H1PsXY01GRskZLD70K/F7ZGE40dFF0NFTDLydVC68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqBnWBr/B32UDTHp81xSRI1t6bAGO53sEPMBn8SJLoHm/NltT29CcWT1UFlAiPrZEI/GmywSUfTYoXZyRNc0tgh6B4dCsUqFgbN4tjKUbWIf7v1Qp0hhqWJHLfGCKCO5rffiM2YaT6C2uEUzu3FuwZjOJurMfm8h7PY3Xnr9jT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUJk+S/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964B1C4CEC6;
	Sat, 26 Oct 2024 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945879;
	bh=R/H1PsXY01GRskZLD70K/F7ZGE40dFF0NFTDLydVC68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUJk+S/MQmFzr4RKHIxhUiy2zUnLAqzIEuKoF4/RJ1b6grii7PG0WGE0zSq56hwXz
	 bWZO93/MhN9t4cymKBLENf365sT7y+crOFNauUI5/RvZ3zaOv7kt5bcPrMwphM1Pw8
	 amChXnPLlCREf8Gn5pnVGKp7lsB5xQZr6JDdOJQ2fEdjoocIN92Gqff0Bwznd49FIY
	 69LG+TEsmW4gnqlk6xBMe+DvUZapZFvbil1wxVhwR7RrGECOGpNnnqj3SuXEakYgDB
	 bZvuR5tsKw6XrN+EsFA0ekPrkTsn+jMQMjRU+7inIPiCc4odTMEFBnRjomwwpsRkF6
	 NsgwNdAKhGcug==
Date: Sat, 26 Oct 2024 13:30:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Dan Robertson <dan@dlrobertson.com>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Anand Ashok Dumbre
 <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Subhajit
 Ghosh <subhajit.ghosh@tweaklogic.com>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 6/7] iio: light: stk3310: simplify code in
 write_event_config callback
Message-ID: <20241026133039.10742c75@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-6-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-6-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:28 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
This one is odd.  The field is 1 bit so I've no idea why checking against 7
would ever have made sense.

Applied, but if anyone is familiar with this part I would like more
eyes on that code to see if there is a bug hiding there.

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index ed20b67145463d253a0dff28a4c1c3e02e710319..c6f950af5afa0f77a617bd2baf0a08eef5ec26f0 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -330,9 +330,6 @@ static int stk3310_write_event_config(struct iio_dev *indio_dev,
>  	struct stk3310_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
>  
> -	if (state < 0 || state > 7)
> -		return -EINVAL;
> -
>  	/* Set INT_PS value */
>  	mutex_lock(&data->lock);
>  	ret = regmap_field_write(data->reg_int_ps, state);
> 


