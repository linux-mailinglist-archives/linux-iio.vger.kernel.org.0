Return-Path: <linux-iio+bounces-11803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C319B95CB
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E9284108
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E861CDA14;
	Fri,  1 Nov 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUwoG//T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B11CDA02;
	Fri,  1 Nov 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479468; cv=none; b=MWEs7I89E0TuSFuMh0wB1SCHRpahf767n4sRZCgf9SzrIKOllG7tWBeUvmln6UuFKtyqTbSx2ECydCOWGedj2z6AkMqUiZrTwa1W8QaQiNk02vtpEt2UOTFt1UP5xw3rBV2YM48K9lg9Mv0EcVtrlnMZva+upqsO0KT+cwUr70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479468; c=relaxed/simple;
	bh=1CfY2+o4mRhy02U7CFSYwo0qVuQU+kj4WkP+HlKqRn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPJCfb+o81Ks5tEgAPd9EPaCModKB1emBk+2qPbN9S6Nf+ROfCWikB1LZVzmNTlwvOQttfSXVe+JzkXTo0Vgx0wqXJwF5pfXMQtz/xriePIdDEOPNxedwEPLlWihgEsHjUJnHdzYQAg0+emWwyY6dBOvAQXqub/XuKRCxxHv1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUwoG//T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145FC4CED3;
	Fri,  1 Nov 2024 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479468;
	bh=1CfY2+o4mRhy02U7CFSYwo0qVuQU+kj4WkP+HlKqRn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RUwoG//TVOvFq/Z1QHtZYQirIJMBlS/ZHXo9vBPUi0Cy17F9j38/a/zHCwtOEm+A+
	 jdAI7FoQWJ3E7573lT0saQ+1WwkRsUr30AomYt07P6Jm+HAD55oXdbAlh5JgFHBBcg
	 /TivdakH0u8CYOnH1xagXujZ4e7+vg4FIIUfiQC9/kUkDKREYlEuTHucOjUyKDNV43
	 16tmfjxwvKsDTI1rAC/Y7BUc/mC+Me2Nl1FXZcv/bTXZocBCLFYBI0Pu2XZyW91u7I
	 ZuYJZdvuiJJ9W/q5PRmAmH9rXDbLOLxB4bwEnwBWVn+TDgr9N6e/CSZG/uMhTF5l0s
	 2FGA5tFv/zEXA==
Date: Fri, 1 Nov 2024 16:44:14 +0000
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
Subject: Re: [PATCH v2 15/15] iio: light: apds9960: remove useless return
Message-ID: <20241101164414.4f14c75f@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-15-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-15-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:10 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> return 0 statement at the end of apds9960_read_event_config is useless.
> Remove it.
Strange that never triggered a build warning that I noticed.

Anyhow applied.  

So I did end up more or less (i.e. with tweaks) applying the whole series.
If you have time to follow up on the few cases I spotted where passing the
bool value into functions instead of an int may make for better
readability.

> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/apds9960.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 7b3da88885693c488807da459ceaa1cbb3881bcd..d30441d3370309fce9d6c717d42b829ff1db3174 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -749,8 +749,6 @@ static int apds9960_read_event_config(struct iio_dev *indio_dev,
>  	default:
>  		return -EINVAL;
>  	}
> -
> -	return 0;
>  }
>  
>  static int apds9960_write_event_config(struct iio_dev *indio_dev,
> 


