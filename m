Return-Path: <linux-iio+bounces-11338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB829B1808
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47B6282B94
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810321D5ABE;
	Sat, 26 Oct 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO2Up6ey"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAC1D54E9;
	Sat, 26 Oct 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945601; cv=none; b=b5hHdSg6ZumIodymmhySflSivJQpAQhy4iSRmSUdcGGDjdCcILOTua7pP1j8ES1+NGVDU6NkOFXwtjDi84uYWWPAzCFzkl0jYFVuCliKwC6//gmXMHYAje2W2qnNshGC2V9PBtoyIAmwpI3+J3Tqn48yz1EXR4j4Cl/4XCRxdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945601; c=relaxed/simple;
	bh=vlTJxPv2hpMGHbCdwNowbs1x9acLLoluxWNNFVabxMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ1rT6ooSuNuJWNqVCdLETOOD9D02bVC5OOXt7qAsYVeQfp9LKFCGPzCwF82niG5jc3A59h4aYW/FfhpRFne6KDEOCnJA5k//R6sENlN2pA+8Vh/h94tqxeFTKgiE9BNFeRBXbHTUJEvygEKfyrC+sCQeLIar1U4uJzSICF/bGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO2Up6ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F06AC4CEC6;
	Sat, 26 Oct 2024 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945600;
	bh=vlTJxPv2hpMGHbCdwNowbs1x9acLLoluxWNNFVabxMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dO2Up6eyFA00wtIu1eKIzr4FHLenroJ+GhPOJGXPB30hjWhR7vkq09eQzcjKqya57
	 rJKnZlBhTu1zfFDjvaIQ18QYeDOL08aiaLP0mV3Dl7Z4wsFv5oFRmxVPCusH9NjiQb
	 C0DaH+jMpUg2gydCUy/T6pXM0eJzudxFtlY/0o6zbZzcspwn1GzZ4bWx01JdC2ffuR
	 TWp95dUb3HYQKeBFB+r1fkwPJ33hwaoJ7wOqEMyIIhl72Mrk2C9W/03cLGl5NUGKj+
	 MeqX6HJSdGAENBbPYmuB9zhw7j/sffaJeQH8Q4JebVodN1/+E5D4I00W4G/11oQSTo
	 2tb+KZcb+F+Yw==
Date: Sat, 26 Oct 2024 13:25:47 +0100
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
Subject: Re: [PATCH 4/7] iio: light: veml6030: simplify code in
 write_event_config callback
Message-ID: <20241026132547.481ca1be@jic23-huawei>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-4-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
	<20241024-iio-fix-write-event-config-signature-v1-4-7d29e5a31b00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 11:11:26 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.

After patch 7 this will include a shift of a bool which is a little
unusual but valid C.

> ---
>  drivers/iio/light/veml6030.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index d6f3b104b0e6be8e095a1ad9f20acb81ce492630..95751c1015909cd80543a559673f435d1a168f68 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -826,9 +826,6 @@ static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
>  	int ret;
>  	struct veml6030_data *data = iio_priv(indio_dev);
>  
> -	if (state < 0 || state > 1)
> -		return -EINVAL;
> -
>  	ret = veml6030_als_shut_down(data);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> 


