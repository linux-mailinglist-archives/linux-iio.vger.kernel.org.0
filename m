Return-Path: <linux-iio+bounces-11796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B79B9580
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339411C2204F
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653531CACE0;
	Fri,  1 Nov 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEEZYmFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE51DA53;
	Fri,  1 Nov 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478879; cv=none; b=sUibz0srz5TtG+iu/IzpjxW//p7TP5NiqjwodqM4W3lARn7U03aYHnUYC31cR8Wxmejd8TLoYkvfnv9f0rQEDNOncoowalX38v8Wo5h6BuumU0Gt7XuhMC5jDMD+50gW8U5m6C18DofIKBd7Vl5gDymBRI1GINeQTynN/WpXDIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478879; c=relaxed/simple;
	bh=qTEpZeX5h5BrvEm5uvCJhihnL5J4dBpTWfPtxvKIQr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ6QyUz+OSJAbW/wWz0o1RB7r1rgD+cAXismKajMDiit6i1e3yHKnQaokcJqTbplJX5am+xTq0JCKL4fsLIHeGoCm2FSGbT7YRycu7TjbK06+xig7ePyHeOdSOqYeEtEwtyBiLuNajKkY2ttwf9NtSvjM5SVaukdDPDxQk1axPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEEZYmFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D7BC4CECD;
	Fri,  1 Nov 2024 16:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478878;
	bh=qTEpZeX5h5BrvEm5uvCJhihnL5J4dBpTWfPtxvKIQr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEEZYmFhVei4xYtLqNT5xERqEDKa4LsyeSJA+vRyONXu1PON2O9YAA28WvhzumSm/
	 P7ss/OsrhaAwQPUCt3fxzGY8oMkvwDroediE64Y4qPJ1GKUoN0cG8Y69aM57YVvD5e
	 WmL4Wqz8nj1/GjJrrYynROUzphMc6LF3lCfXgGxbBquZLuwOkq3+VQ7LHAaXamgB2s
	 qJ3TOYuyToFdAk/3ebKBMRfBUtLk5bDYb+drPbM64j8rP3Qmxwzk/wXyNhADWciOvJ
	 oBC3u5avJcQPoS8hhF+NUwwfVm+JjhMn4yBUNEvrYdOxFKYY8JtDV5YX2kcviJ7ffk
	 O+oqIcHc9Idfw==
Date: Fri, 1 Nov 2024 16:34:29 +0000
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
Subject: Re: [PATCH v2 09/15] iio: accel: sca3000: use bool for event state
Message-ID: <20241101163429.29745c05@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-9-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-9-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:04 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update the signatures of the functions it calls accordingly.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied
> ---
>  drivers/iio/accel/sca3000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 36cbfcbba04d6920ba68bebd70d21bc3898a044d..3fb0f386c3db603714a746c28be36ee78d1b2a6a 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1158,7 +1158,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
> +static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
> @@ -1181,7 +1181,7 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
>  }
>  
>  static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
> -					   int state)
> +					   bool state)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret, ctrlval;
> 


