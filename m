Return-Path: <linux-iio+bounces-11795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA75A9B957B
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33752B210FD
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA71145FE0;
	Fri,  1 Nov 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku5wNbzg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D621DA53;
	Fri,  1 Nov 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478842; cv=none; b=kkQEuyWw/0H85Q2HbjfQzFoU8a1mbAs2k0+8M8loC4Hvs1zGa4tBzTfylcJAHn+ri4shwJyFd5m9b4XPPRSSeaIFXhzyI+oHdEJeJ/fAFDhGm5dVa4OHhNd6159jWyOyhc1LoiidlyloELfUix6mPju2ClxeS8zRTuEc5GLJeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478842; c=relaxed/simple;
	bh=mV4filxoSKBiK71CYZhpWrrl9CqzhvPDqtVuqoioWyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIzM7R727HUxnnQVf132jonZ6KNhJWqj2Ky+55BTYRD+44NqOuz8KV6tuIv82oFnVRz7+1udScXkJvin2x246ZK2s97uHYmGjBj91AkNfBtsiJalwwFbz1TBDJzDIJ78qmFK8pcvgKfzeByzjZIUqGfmitnasc1yliGn9DmaSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku5wNbzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C779C4CECD;
	Fri,  1 Nov 2024 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730478842;
	bh=mV4filxoSKBiK71CYZhpWrrl9CqzhvPDqtVuqoioWyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ku5wNbzgaB7PBFzp01OX7dN3Qoocj0oms6qDky3kymDhlxzCHfVXQhlhs8tl17TVg
	 u5WqRUhWJYWicQ1JqAXejS0of8h6nH2RHHvzmXtKZenX6byI10t0qxgDeRH/dHoyzO
	 QddUeSVQoH2vSOThk/YmXBMZF+MsXZ5bh+7/QWKDIbWBaPGawUnwVv3C5ZAtKTGhFf
	 ilTtMm1/MdrZi39812ZCmE9r1958q6x50Z94xSpvsurovX907vwQFdxo6sQtA83H7N
	 vUBitiqwDTldBfSg5zHPTjTcFZtDo9ZUYO1yVvyGqU46PnLZRtocjnIhh7Ej8oiPl5
	 eFA743SovKREQ==
Date: Fri, 1 Nov 2024 16:33:49 +0000
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
Subject: Re: [PATCH v2 08/15] iio: accel: mma9551: use bool for event state
Message-ID: <20241101163349.6b827eaa@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-8-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-8-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:03 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update the signature of the function it calls accordingly,
> and use a bool array for event_enabled.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.
> ---
>  drivers/iio/accel/mma9551.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 605022f5239a6412827f4ba059aa18d490908720..6d73eec951263956f314f82542becbbae933de91 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -45,7 +45,7 @@ enum mma9551_tilt_axis {
>  struct mma9551_data {
>  	struct i2c_client *client;
>  	struct mutex mutex;
> -	int event_enabled[3];
> +	bool event_enabled[3];
>  	int irqs[MMA9551_GPIO_COUNT];
>  };
>  
> @@ -162,7 +162,7 @@ static int mma9551_read_event_config(struct iio_dev *indio_dev,
>  
>  static int mma9551_config_incli_event(struct iio_dev *indio_dev,
>  				      enum iio_modifier axis,
> -				      int state)
> +				      bool state)
>  {
>  	struct mma9551_data *data = iio_priv(indio_dev);
>  	enum mma9551_tilt_axis mma_axis;
> @@ -174,7 +174,7 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
>  	if (data->event_enabled[mma_axis] == state)
>  		return 0;
>  
> -	if (state == 0) {
> +	if (!state) {
>  		ret = mma9551_gpio_config(data->client,
>  					  (enum mma9551_gpio_pin)mma_axis,
>  					  MMA9551_APPID_NONE, 0, 0);
> 


