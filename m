Return-Path: <linux-iio+bounces-11791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F29B947E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A01F21C8C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D31C5798;
	Fri,  1 Nov 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4OIx+gY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0225634;
	Fri,  1 Nov 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475381; cv=none; b=e5s+ZvSJXzAAId9P3TlSj18qjDEJJpKENYLi8RcZkZRDsbe/sNtYyUFpxT/7Edy3a7cICILtOyYEf3hmHnGRs+2gesS1ckIeq71wh+3+S29wWZaDajNfhypXqHq650MKpeMYcPtA0g0Je0J43v5Jo723AytRfhUxF3qUrLXurEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475381; c=relaxed/simple;
	bh=CInveFC1m9HxfkdDgTiov6AuuZys4diPXXNz/tkR8p4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3j2oosfaHw9icDeK9Gb9fLjLEWTGz4iV7gPWl0Q/+8fbxjBDfzZ0LWTZs5YtGXG6tP9O+10SXvDIxSHSteWMhEsgS9mL88Nuxaj4bhrcsZrmHx73oHC0ywESZQXaJcFh251XK65YgMWpwQYhv8ZnKCAwdgyQ5PwoqO84fR7VJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4OIx+gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F13FC4CED1;
	Fri,  1 Nov 2024 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475380;
	bh=CInveFC1m9HxfkdDgTiov6AuuZys4diPXXNz/tkR8p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c4OIx+gY5i/ZqGD7pB16BQSXB+sNUiTxnmiQ5jviDP+MUdg+r+xetscqBpuPSITk0
	 q4O9yc2wAs4VW9nno1436qfBtor3HhTvgpEOYeoDLEtu6ZqWeAXb7KOsFjUkcniyUt
	 VO3vpMdmV+sm3iHbFgWT1Ot9zjujPzWlnYYk0sy7WTBEUrEB9FPHMsTWoQHtkJttSE
	 9go7oGFdlZo9/6cFOL0ByHxGeKc90pStWaB1uttiXBxE4lGvUY2CpyRTlTFYa7zP6x
	 hgaEm9qfgn4gr1jAQ5iy1AEV1ryh0I8uqRSVne8qUYnXE8/YVwQKXCs6MMwVTyo+Mf
	 KXK9HQtOId3eQ==
Date: Fri, 1 Nov 2024 15:36:08 +0000
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
Subject: Re: [PATCH v2 04/15] iio: proximity: irsd200: simplify code in
 write_event_config callback
Message-ID: <20241101153608.23a9c6f1@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-4-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-4-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:26:59 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied and pushed out as testing.  If anyone has time to review
I can still add tags (or pull the patches if there is something I missed!)

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/irsd200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> index 6e96b764fed8b577d71c3146210679b0b61d4c38..fb0691da99ee621e19013a64d122f097e793efd9 100644
> --- a/drivers/iio/proximity/irsd200.c
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -662,7 +662,7 @@ static int irsd200_write_event_config(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		return regmap_field_write(
> -			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], !!state);
> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], state);
>  	default:
>  		return -EINVAL;
>  	}
> 


