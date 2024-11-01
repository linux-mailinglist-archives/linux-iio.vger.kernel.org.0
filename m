Return-Path: <linux-iio+bounces-11787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122439B9470
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957051F21B26
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588931AA7A3;
	Fri,  1 Nov 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1uOO8A9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8367482;
	Fri,  1 Nov 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475173; cv=none; b=Nl8i1u4g0C1wgMdHNqz4bhUzlThArb3aEaoCBDTQLTwMukIIPf01N9xWGP1nUbd3TR7LIGzcX70uNQde1inA5Cir0ikjfbI76DmVKZnbpKN66N1U4euYlT/KKCQvhsmQ2ltLsu5wFLUYP5RQqAKPO4ZA31Sqh3BQ2rqxPDro0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475173; c=relaxed/simple;
	bh=eA6sS7IrYwjajIXFNQUoLe6SENHwun0qV7uEqwc+0NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGuZ7Ij2pgWU5YSNh9XZN5HFFKGE517/X8whfhzt5cvrQAEXx7xu2WyknJQQzvd3vmQbArnm26CPHQUf9VK/Dm5RTcBfLZ8i2qgYjEFBrySLBPa4+XRUk5IC1anbS/Jtqxhv1Y+UqCZEQPnQ5i0NV9WTPkovjUdYV6LCSURmffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1uOO8A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB1BC4CECD;
	Fri,  1 Nov 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475172;
	bh=eA6sS7IrYwjajIXFNQUoLe6SENHwun0qV7uEqwc+0NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a1uOO8A9pfM8WLPoRG18XrKF5+1d2xT6jefKmyNwGStSAA0rRVPyClCMwQDVlfo6b
	 CDjhRIsoP4G+xNsWGL3JHgccSZszyX1hnFFvEAN1FO8gaQ42f/eGb8j25LmNcvvLyO
	 kB85rKqEj/WKRrEOb4YhPSluUMA3GsCXeKRiXZXuQ+4psGlZoYwIHHtYahkQXmEm7p
	 z5MTPLZFt0GdZM/I2VvZmUSqfNkidvpUKYIe+iyV0xmk7RR0BfLpo73LO+UecHnuuq
	 +yrG59A8512fb+Tdxz9+RmU245U+91mCbX3NzCWd8VsdjI3gc+911PQWC5NpzRcyDe
	 bKPCA6CZb8l8Q==
Date: Fri, 1 Nov 2024 15:32:40 +0000
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
Subject: Re: [PATCH v2 01/15] iio: light: ltr390: simplify code in
 write_event_config callback
Message-ID: <20241101153240.26c6c5ea@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-1-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-1-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:26:56 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Given these are good cleanup even without the final patches I'm going to
pick them up as I go. Maybe I'll end up taking the lot though!

Applied this one.

Thanks

Jonathan

> ---
>  drivers/iio/light/ltr390.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 8e0a3fc3d923a6f65d2a629c87e7bfd35d82a507..3bdffb6360bcbaab4df1a2d39c8ea3813b5d6bd3 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -558,10 +558,7 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
>  	struct ltr390_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (state != 1  && state != 0)
> -		return -EINVAL;
> -
> -	if (state == 0)
> +	if (!state)
>  		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
>  
>  	guard(mutex)(&data->lock);
> 


