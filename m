Return-Path: <linux-iio+bounces-11801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBD9B95A8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFF8280F71
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC51AC88B;
	Fri,  1 Nov 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlWLeQto"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA11798C;
	Fri,  1 Nov 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479343; cv=none; b=hpBdVGUOby+9Vv4lMnVJ4Bvzm8CrSJKkrPK0jY7LlaPwNqSAL+JryUbalYb4Bq1K6QBIhIpqZ7mPaRpaqh83gSG9x8MMxE0WxNhtJF6DLusIYwTbN3NHMXzx/xnDJpUUTO3uM4Htw/KYSESN6hG/ESQ0cH4ndJGcU3Z7XIhpmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479343; c=relaxed/simple;
	bh=eYks79MFdCeXodwGGFKWKp7Y3D0VclXHgXCntP1ZON0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/m201c+XXGdgB/pN3yfdy1XZUOtDTS2fE2htIl401ju002ya76Vy3ISXQjHdqGJ1ZvGWZbQ2wLo31lvFs1g4oSxXQ65KhJ9CeEBPVw9ebmH3ld6mbqAzNuZEqWcMMvCrMBvPT/eNdud72t69gN7cp1dROVNRjxfP8XShxRyuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlWLeQto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BA9C4CECD;
	Fri,  1 Nov 2024 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479342;
	bh=eYks79MFdCeXodwGGFKWKp7Y3D0VclXHgXCntP1ZON0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlWLeQtokne+QgI9Z+5Asb5yiBmPqRnDRQRBU7GjWr5Mfm2Sc/dJDHE74H/EuhrER
	 1FhjTnmZTpSzhW6ji5fqrdinVlh9VAqUP87j2Y01K7QB3wpW4XuovFc8DA+mhMBXVZ
	 ahm2BHoQMgbFh+M0DAb4cD4hjMPBRwfOs3xlHkjHBUejSZE00z6q6BJ/+IXUciBQY9
	 l1dsNGbIJC0mozF+H3D6dBoWWNyouhae6p7mpnBTVLq7qgHEgzUFIpOtbGoM9lEqtL
	 t2D1zzku7zqY3mR0U9CDrUJCExfRAcztBuTVLB7aHrs2xCl5xz9obFRFabcYRJeFUf
	 M1FQzr3pUnSVA==
Date: Fri, 1 Nov 2024 16:42:10 +0000
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
Subject: Re: [PATCH v2 14/15] iio: light: apds9960: convert als_int and
 pxs_int to bool
Message-ID: <20241101164210.4a33197d@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-14-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-14-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:09 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update type of als_int and pxs_int to bool.
Applied.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/apds9960.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a7f0cc99f236685900f89fbc48de3be0e9a40704..7b3da88885693c488807da459ceaa1cbb3881bcd 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -133,8 +133,8 @@ struct apds9960_data {
>  	struct regmap_field *reg_enable_pxs;
>  
>  	/* state */
> -	int als_int;
> -	int pxs_int;
> +	bool als_int;
> +	bool pxs_int;
>  	int gesture_mode_running;
>  
>  	/* gain values */
> 


