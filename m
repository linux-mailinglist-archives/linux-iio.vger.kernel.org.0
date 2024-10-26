Return-Path: <linux-iio+bounces-11334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594739B17F7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045B01F21F3F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1E1D517C;
	Sat, 26 Oct 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSvc8r+U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC41D3654;
	Sat, 26 Oct 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945292; cv=none; b=gOD+kryDcRakTjkS91mpim9ANf9EtBmI/bI2neVoYnyiWiCIZ2Ygnn1rq5u8bzPvEBDeLoVH0d/cp/BeYvM6qzvu5Eoa6E/yH74RvU7N9KJ658EVkrnaVlemOtRDqAhnsb1Hld9lx9KnfHuzmQaI1acMm4mysY0D7YjSRYJa/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945292; c=relaxed/simple;
	bh=Ju/lj4vABPXWpilJsZn2ZHii6DTE7FTc99SBlTaAD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgAzN+e0Y9uotiG0SYK4u2qoM4I4NzMuhhhem7wRdX5ytpUnJSrwP5P7/T8cJmwK4/bXqNq51Lr7ciPAv0pZ3S+ZiGibsKC2HFA8mero96vYk9yMvPVGbn58tUTIv+x4DVZ81Pa4AUAOwOagmTT9ZZyLJiwKpN/714qLhDQgs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSvc8r+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58460C4CEE4;
	Sat, 26 Oct 2024 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945292;
	bh=Ju/lj4vABPXWpilJsZn2ZHii6DTE7FTc99SBlTaAD3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSvc8r+Uw1DWrTEM5C7W1k7Ks8GEApnqCgs/61ldeB40ISoLzMVAyDjyavK3RZ5oa
	 6b36O30X6KyTXnxMKTnyGyZgaP3ZcTTZBnKw/yBkICpmeNjoOJFCML2FAqcP1ChqP4
	 +GE7WXP+yWqklYIW5YELuuJBm4oVaRqazifC6bNRUtHfvuS/6VIh767cO6KhvjA90k
	 9jF+9jz2RVd9cZP2zYz53XjA94eP6TI/SQ9qjthPG7LTH5bl1slSr5QGiuqH+RZafh
	 8ls170l7gssruKdgFhzEMNE87r26b31zL3ufQILnEDhwmY0/Cy6Q2iKsn5J+RVSeB2
	 85vA/1KemdKvQ==
Date: Sat, 26 Oct 2024 13:20:25 +0100
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
Subject: Re: [PATCH 1/7] iio: light: bh1745: simplify code in
 write_event_config callback
Message-ID: <20241026132025.1d7a700c@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-1-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-1-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:23 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
There are a few additions needed to the final patch. 
I'll pick up the earlier ones now though.

Applied this one.

> ---
>  drivers/iio/light/bh1745.c | 48 +++++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 2e458e9d5d85308fb6a13d9dbd845fa03b56a40e..fc6bf062d4f510886f909509d8115f0cf892f3c4 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -643,41 +643,37 @@ static int bh1745_write_event_config(struct iio_dev *indio_dev,
>  	struct bh1745_data *data = iio_priv(indio_dev);
>  	int value;
>  
> -	if (state == 0)
> +	if (!state)
>  		return regmap_clear_bits(data->regmap,
>  					 BH1745_INTR, BH1745_INTR_ENABLE);
>  
> -	if (state == 1) {
> -		/* Latch is always enabled when enabling interrupt */
> -		value = BH1745_INTR_ENABLE;
> +	/* Latch is always enabled when enabling interrupt */
> +	value = BH1745_INTR_ENABLE;
>  
> -		switch (chan->channel2) {
> -		case IIO_MOD_LIGHT_RED:
> -			return regmap_write(data->regmap, BH1745_INTR,
> -					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> -							       BH1745_INTR_SOURCE_RED));
> +	switch (chan->channel2) {
> +	case IIO_MOD_LIGHT_RED:
> +		return regmap_write(data->regmap, BH1745_INTR,
> +				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +						       BH1745_INTR_SOURCE_RED));
>  
> -		case IIO_MOD_LIGHT_GREEN:
> -			return regmap_write(data->regmap, BH1745_INTR,
> -					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> -							       BH1745_INTR_SOURCE_GREEN));
> +	case IIO_MOD_LIGHT_GREEN:
> +		return regmap_write(data->regmap, BH1745_INTR,
> +				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +						       BH1745_INTR_SOURCE_GREEN));
>  
> -		case IIO_MOD_LIGHT_BLUE:
> -			return regmap_write(data->regmap, BH1745_INTR,
> -					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> -							       BH1745_INTR_SOURCE_BLUE));
> +	case IIO_MOD_LIGHT_BLUE:
> +		return regmap_write(data->regmap, BH1745_INTR,
> +				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +						       BH1745_INTR_SOURCE_BLUE));
>  
> -		case IIO_MOD_LIGHT_CLEAR:
> -			return regmap_write(data->regmap, BH1745_INTR,
> -					    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> -							       BH1745_INTR_SOURCE_CLEAR));
> +	case IIO_MOD_LIGHT_CLEAR:
> +		return regmap_write(data->regmap, BH1745_INTR,
> +				    value | FIELD_PREP(BH1745_INTR_SOURCE_MASK,
> +						       BH1745_INTR_SOURCE_CLEAR));
>  
> -		default:
> -			return -EINVAL;
> -		}
> +	default:
> +		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
>  }
>  
>  static int bh1745_read_avail(struct iio_dev *indio_dev,
> 


