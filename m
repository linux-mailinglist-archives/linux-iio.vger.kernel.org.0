Return-Path: <linux-iio+bounces-11789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D39B9478
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84441F215C3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587271B4F2E;
	Fri,  1 Nov 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExR7YdMP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AD82C7E;
	Fri,  1 Nov 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475287; cv=none; b=m9tACw2QJnXCDDmgb/JGg1dyVoYyE5hGQ6UcmcMnxtTdIP4r1oRW19AGxczOfxZj1e8n4XlFsJUWEkRTcrxmK31gIWbkcB40npyZa0NY9lMJ90wX29mDcidBDaR/33t1d3XsPWk+gdCVqXyvwX+ZLtAxjn8p9oRyFNlVh/kLi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475287; c=relaxed/simple;
	bh=3gF4dUs4I0hbZEB/vl2nNOfNJfrWUy9SgixJZc2ZpYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4tlZMAJrxUlPOTeOtenP8LhDeTSmJIhsmx9vUdjdnei8RWGKv/U6pq1HhepEgeAP1UFenPp2hV2/PRe9G+6Igd62Aqgzp6wkjqsJUNCY5g/vB5Y5O5A7gvA64Nb1aXwpOF6tq0+pM94a7zeN1S3hJKgnFQkuRVg+ZW7zHf5NVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExR7YdMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50629C4CECD;
	Fri,  1 Nov 2024 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475286;
	bh=3gF4dUs4I0hbZEB/vl2nNOfNJfrWUy9SgixJZc2ZpYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExR7YdMPH4ej6K7ujfnj4MwHuH/ToU0rvxAgB76QLIOBPcjQVQwD0RnU/KhoWucTr
	 7THMxdiDKds6yE9+xL6TTZTncVEfFMjP1V2Ik4AXfTlGUGzhUoxA7r7Ck89HCCh+QZ
	 Z0zaqgT4DcM9JJeSsr6hY4ZY/+XjCozJb5jzEAj0Aut+XaN+deDpesWtuh0olIVhEF
	 vU7bmW6UR4yxJdX1o3mSNkSR4399Uek5adBzhXoudUfhmcUtwvicAJFd+mlNwpNFA5
	 zM4ooysvKCmWA0G1nhHe6buqZl6LjmNTjOeTmxBMUtOxyXgNUDa5DWgJiBmKf/D0wH
	 BUZ+itl6SwQJQ==
Date: Fri, 1 Nov 2024 15:34:34 +0000
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
Subject: Re: [PATCH v2 02/15] iio: proximity: hx9023s: simplify code in
 write_event_config callback
Message-ID: <20241101153434.11d85f8b@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-2-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-2-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:26:57 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing.
Note if anyone else has time to review, I can still add tags for now.

I'll probably push it out as an (in theory) not rebasing tree early
next week to give a bit of time in next before a pull request.

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index d8fb34060d3db88a3ba5ecdc209b14be8e42e8b9..38441b1ee040c7c26047b0cb2ac443ecb8396df3 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -879,7 +879,7 @@ static int hx9023s_write_event_config(struct iio_dev *indio_dev,
>  	struct hx9023s_data *data = iio_priv(indio_dev);
>  
>  	if (test_bit(chan->channel, &data->chan_in_use)) {
> -		hx9023s_ch_en(data, chan->channel, !!state);
> +		hx9023s_ch_en(data, chan->channel, state);
>  		__assign_bit(chan->channel, &data->chan_event,
>  			     data->ch_data[chan->channel].enable);
>  	}
> 


