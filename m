Return-Path: <linux-iio+bounces-11792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138B9B948A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56039281A46
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A271C761F;
	Fri,  1 Nov 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYC00OtJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D21C729B;
	Fri,  1 Nov 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475430; cv=none; b=ClSwbqC2HSeSXmesApoNx8wJyhTfkRPbKql5XpAA+7TFWgaXAt0G2uXRdS46N4d/syRoOXCoJIlyKkTgAQiQyvWiaRxKk9Lp3VxvxUXkz707EL6BRbhbHETpnbzwz8jQeQCNqE4vcQygVZbPLyndE+57mQ0yjbuysdvspsYCCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475430; c=relaxed/simple;
	bh=7A7xoAlxFzqvHKjOX7THt9g8OUG8yAzJ9stzmiv/cWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io4FYKk/toMiPDIZ5s8QA7qO988qKnmPyf7BbsDksL4tTFQDiPvGiV/oeBgp0kKaJTwwFdiTWchc+BdskX3lRs569Qusu98aGL1P/eFRBYgXlSQyejvggHKFCkfe6rwqZocBN3GIm/7FqpxCHJK3N6gk+PNh0BXL07rs03T/+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYC00OtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB34C4CED1;
	Fri,  1 Nov 2024 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475429;
	bh=7A7xoAlxFzqvHKjOX7THt9g8OUG8yAzJ9stzmiv/cWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DYC00OtJJLTmceKdnDnDi/ze3IYHInLzbnPJwblyMVaZ6/79mK5qNn1SBTsLb2THP
	 wEREqCfpvTEaW5eef9G+TzESdyHDAqBsE1oTqLFuHosJ88c3NBvKmU+YtSnZ3oKrUh
	 Uzl4tqNObZKVsoPUoGqXbC6FT/AX2y+R0jCD16AQbRx0ABdAgP7+77wWIBR5vnJnZo
	 aUi86jXogCaDebDgWfXyKeM26AwlXLz6IkVtcmzqMBtbVKOyZl82LVACQfOuP4p01+
	 blVT77UVEHoRlXfrR2z5xR7w4Na1L+PRK7eYp0wJbonYPlKOCeuifbpSGEgls0PJ2w
	 Y760sWGMOHvSw==
Date: Fri, 1 Nov 2024 15:36:56 +0000
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
Subject: Re: [PATCH v2 05/15] iio: proximity: sx9500: simplify code in
 write_event_config callback
Message-ID: <20241101153656.43e27240@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-5-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-5-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:00 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied and pushed out as testing. Still time for other reviews if anyone
cares to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9500.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 3f4eace05cfc6a4679fe82854dc059aa4a710d6d..e3da709424d5b2bd4e746df7adc4a4969e62f2a6 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -551,7 +551,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&data->mutex);
>  
> -	if (state == 1) {
> +	if (state) {
>  		ret = sx9500_inc_chan_users(data, chan->channel);
>  		if (ret < 0)
>  			goto out_unlock;
> @@ -571,7 +571,7 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
>  	goto out_unlock;
>  
>  out_undo_chan:
> -	if (state == 1)
> +	if (state)
>  		sx9500_dec_chan_users(data, chan->channel);
>  	else
>  		sx9500_inc_chan_users(data, chan->channel);
> 


