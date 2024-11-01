Return-Path: <linux-iio+bounces-11790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249C9B947A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28E91F218A3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A751BB6B6;
	Fri,  1 Nov 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3AiIkIU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944B25634;
	Fri,  1 Nov 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475321; cv=none; b=NBDk6T3esdGlOO1nsAUiB/m7PeEbxE6xYGy8HKuXmppvBjacHFh2CJ9oSM4bLE/HfOTxFQZr97qz6ux2UXCkEJ8gUiMgqhEXNWeR6wZWLm7sWy0/ej3jLZWdOdUTFYvE4/+4dPsSceK7F8Zjje+97FcOyPBo6UMh1++LuFk3F7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475321; c=relaxed/simple;
	bh=uwTrmg5E+/4Xe9TIGAk2cAH3uSAcEGblqU7abk42CGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kncyo/fdcGF71UPKwUWlcvxWKly+fc68SjusX7WqZ5Eaccu7ANN+BR/hkw5X1fY+zTIizPy49pGiJnyx0opIxazL0SBfb1BscXcD7b7ih+toTYGxQvZb9/PRN8a6Y4f2cShMDs01wdmJoVGnx2ja0QH6be2ova9t+plsSkPq0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3AiIkIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5625C4CECD;
	Fri,  1 Nov 2024 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475321;
	bh=uwTrmg5E+/4Xe9TIGAk2cAH3uSAcEGblqU7abk42CGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3AiIkIU/BSsjG/DRK0gOBsQNCmallFcN03rt4Dn64kR6xgsju3LZdub0MGEhcFbO
	 8hVC7lrN2OqSTEB5eKdoNpk+yavuzjdG6TvlVlzJFHFsBoZg6v2t5i1UVtJI6u4uNL
	 C+GYScq1jm8Z5A+QG4H/DnxGU6Ag+0qbprQUXSZnulLE6Pu3iRb5/6iqc1BQXWVVbu
	 SkzRUcGyqaccScCfOrrGHpxBk4w/0/JdfESf6O52gSE4IacVL1tA4lgEJqjPSIZBVy
	 ywXIYDDdFa0pOL0fgDqnzHbPKfd5KOjSZ07O+i8vjcbIFVLbf83BU2S9A0rW67jPwW
	 FjFvCR9XuDoHg==
Date: Fri, 1 Nov 2024 15:35:09 +0000
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
Subject: Re: [PATCH v2 03/15] iio: light: tsl2772: simplify code in
 write_event_config callback
Message-ID: <20241101153509.11ae74b9@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-3-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-3-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:26:58 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> iio_ev_state_store is actually using kstrtobool to check user
> input, then gives the converted boolean value to the write_event_config
> callback.
> 
> Remove useless code in write_event_config callback.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.
> ---
>  drivers/iio/light/tsl2772.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index cab468a82b616a23394977da1d8822d29d8941d3..26082f239c4c3aeabfe73ed100d6e885f5266329 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1086,9 +1086,9 @@ static int tsl2772_write_interrupt_config(struct iio_dev *indio_dev,
>  	struct tsl2772_chip *chip = iio_priv(indio_dev);
>  
>  	if (chan->type == IIO_INTENSITY)
> -		chip->settings.als_interrupt_en = val ? true : false;
> +		chip->settings.als_interrupt_en = val;
>  	else
> -		chip->settings.prox_interrupt_en = val ? true : false;
> +		chip->settings.prox_interrupt_en = val;
>  
>  	return tsl2772_invoke_change(indio_dev);
>  }
> 


