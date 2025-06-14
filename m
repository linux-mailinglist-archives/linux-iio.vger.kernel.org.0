Return-Path: <linux-iio+bounces-20643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52230AD9CAF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A93B738B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C62C08DE;
	Sat, 14 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pgti5zy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5014BF89;
	Sat, 14 Jun 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749903798; cv=none; b=iCnY4VaCU9JmiwYMo52hEgzDK1nWOnjME2vszCRrUzGQOMbt9Xb4jI/IxkFDunRsu9zizAfMyAXQ9pdnAdcqYTzd0Ve48yJLxp5L/zWpCeYN6X1KApGcgU1nssd6AJ7P0CkReiinMLWjY3UB6CkF2JU6BW1D8Z3G1cdtV2/rs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749903798; c=relaxed/simple;
	bh=avQIQVx7PU9oe/rVrLoBrchrvxBkxtx/0zHOHlcJODc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/6SOFceayiXtrDylzpme/HkcIxghTFXiNbk1aaSUu9UBxZBfSBk1DRB+ucuQXJMl3yIT0wZlnnCuK4TTQA54EzTqYz2NZoutaUpeLGVMCUp4SXxgmpZe4/6YK5r0zCGe8iOhYXqNHegtQDrIBxCQxFZbTelIz6L6LEcehrekwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pgti5zy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2293FC4CEEB;
	Sat, 14 Jun 2025 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749903796;
	bh=avQIQVx7PU9oe/rVrLoBrchrvxBkxtx/0zHOHlcJODc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pgti5zy4ItelGapySex+FZlobPH1ZsV8BcOmcj3kvZ6Snf8tCTF9OmjDGY3m/b9Aj
	 9TOcW6MkYFqsFdxt+Yd8DvskBa347QChTcLoSzKscD/3BPjAM6oDWD4aqEtqGLCFHJ
	 gfWHC6vIp9nCB2k7zjGv6UrQnDbSalAu/DY9Rn7uorWpFfqbpjRt6sqse2u82ZxUuN
	 KFqL9+qjeWTWlaQcSqmx8HfFGcjFxDTQdf5vkViKZkNT+3gXdRlvYPjvJGaSam1uEH
	 jcn/7MjIf2gi+25/9/TexlgWxUj9VGGmJlktRIIxCG1MglzTHDP9SYeq4mFLCL8x9F
	 PsUHqZaN26mdg==
Date: Sat, 14 Jun 2025 13:23:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Heiko
 Stuebner <heiko@sntech.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Francesco Dolcini
 <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZl?=
 =?UTF-8?B?cw==?= <jpaulo.silvagoncalves@gmail.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, kernel@pengutronix.de,
 Oleksij Rempel <o.rempel@pengutronix.de>, Roan van Dijk <roan@protonic.nl>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, =?UTF-8?B?T25kxZllag==?= Jirman
 <megi@xff.cz>, Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 25/28] iio: pressure: mprls0025pa: use = { } instead of
 memset()
Message-ID: <20250614132302.1e134315@jic23-huawei>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-25-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
	<20250611-iio-zero-init-stack-with-instead-of-memset-v1-25-ebb2d0a24302@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 17:39:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use { } instead of memset() to zero-initialize stack memory to simplify
> the code.
> 
> The initialize of the cmd value is trivial so it can be moved to the
> array initializer as well.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/pressure/mprls0025pa_i2c.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
> index 1a48f8d43d716b28b8fceb8e1a06d63a73a74a86..79811fd4a02b370b3fde8bd67a5115a3934f8614 100644
> --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> @@ -44,10 +44,7 @@ static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
>  {
>  	int ret;
>  	struct i2c_client *client = to_i2c_client(data->dev);
> -	u8 wdata[MPR_PKT_SYNC_LEN];
> -
> -	memset(wdata, 0, sizeof(wdata));
> -	wdata[0] = cmd;
> +	u8 wdata[MPR_PKT_SYNC_LEN] = { cmd };

Slight preference for trailing comma after cmd,

>  
>  	ret = i2c_master_send(client, wdata, MPR_PKT_SYNC_LEN);
>  	if (ret < 0)
> 


