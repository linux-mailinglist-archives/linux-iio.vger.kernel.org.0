Return-Path: <linux-iio+bounces-21379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD788AFA42B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A509A189ACE9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9141FCD1F;
	Sun,  6 Jul 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXbKO9Mg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C084145355;
	Sun,  6 Jul 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795588; cv=none; b=rt6lFrByEN6cwUVVu6Rf1ukKbrWnJWYUkQmdNxvaXcnDBrqeSzowDQTrpSxwLJNAYA1hnsQwNT/XOCQ08BMdOhQU6vxU77lVFlKf5miqR6o5GCc2FKP7dKhaWtTbW/qkmNxy85nOJlu74GEWwilh8kSVISwiS0pBR2Jls2pIp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795588; c=relaxed/simple;
	bh=O8KzvpWHk/kIL/b6hsdAACsg+PQkbHBGUpJV8YZRQIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gzm8QBzMLFJz1/PHfDBa5e0Nqt05B8mCBGp/7DslebiU9mG6wVK2Z2k5KOLur3VC3ZSUqBFKnCpppg/25PBjsPEuoDvIrubYkgY5gsPT5QxOaup7TM1WSOgbFb6xzUCClgUmbLO1G3/ZiizdzfMtKyLHuZ0OUzcycHRDYwhAWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXbKO9Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED14C4CEED;
	Sun,  6 Jul 2025 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751795588;
	bh=O8KzvpWHk/kIL/b6hsdAACsg+PQkbHBGUpJV8YZRQIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXbKO9MgvZNvuuRSQ5EhgIVwCbVyhf22FkYqSX1IgGh6/adkM1ITCpX6vYBREXXZF
	 NmdNtBK5LDxxV74DFdlfvUmN4A1kNczcCYenOaUeMJpshZER3djqzizMI07/0H70Aj
	 pgmY0uVUYGI26HJmjsJi7s7+oDqC6jtGnNVRPeE/a6JK3W2jLS39aKBsnv7r9e24KA
	 XWlmWUguWwThqZr1dk9bOtYWZfhK2t9/nPTqFtRGITApXmj0Z993fvcMqNXPMGJE4I
	 NHgZqB3r0xCOUXsrUnP1GJfif6yAuq1fOZv3vrIPSubwDeyZ9+O5qJwIU4QXOXIGPV
	 Iwe3lt/jX+ynw==
Date: Sun, 6 Jul 2025 10:53:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: drop use of chip info array
Message-ID: <20250706105302.6ba58b3c@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-24-v2-1-1c90073d1323@baylibre.com>
References: <20250628-iio-const-data-24-v2-1-1c90073d1323@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 13:15:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the dlhl60d driver to use individual chip info structures instead
> of an array. This reduces the verbosity of the code. Also, the data is
> now const as it should have been in the first place.
Applied with tweaked patch title to Use separate structures rather than an array for chip info.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Changed the patch to drop the chip info array.
> - Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-24-v1-1-353b97281534@baylibre.com
> ---
>  drivers/iio/pressure/dlhl60d.c | 47 +++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> index 48afe5c94000b44eb324d7631f3c0db8e3d0079e..6a13cf2eaf50187d4cbd94cd93b1d14ad4de8b26 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -32,35 +32,31 @@
>  /* DLH  timings */
>  #define DLH_SINGLE_DUT_MS   5
>  
> -enum dhl_ids {
> -	dlhl60d,
> -	dlhl60g,
> -};
> -
>  struct dlh_info {
> +	const char *name;   /* chip name */
>  	u8 osdig;           /* digital offset factor */
>  	unsigned int fss;   /* full scale span (inch H2O) */
>  };
>  
>  struct dlh_state {
>  	struct i2c_client *client;
> -	struct dlh_info info;
> +	const struct dlh_info *info;
>  	bool use_interrupt;
>  	struct completion completion;
>  	u8 rx_buf[DLH_NUM_READ_BYTES];
>  };
>  
> -static struct dlh_info dlh_info_tbl[] = {
> -	[dlhl60d] = {
> -		.osdig = 2,
> -		.fss = 120,
> -	},
> -	[dlhl60g] = {
> -		.osdig = 10,
> -		.fss = 60,
> -	},
> +static const struct dlh_info dlhl60d_info = {
> +	.name = "dlhl60d",
> +	.osdig = 2,
> +	.fss = 120,
>  };
>  
> +static const struct dlh_info dlhl60g_info = {
> +	.name = "dlhl60g",
> +	.osdig = 10,
> +	.fss = 60,
> +};
>  
>  static int dlh_cmd_start_single(struct dlh_state *st)
>  {
> @@ -170,7 +166,7 @@ static int dlh_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (channel->type) {
>  		case IIO_PRESSURE:
> -			tmp = div_s64(125LL * st->info.fss * 24909 * 100,
> +			tmp = div_s64(125LL * st->info->fss * 24909 * 100,
>  				1 << DLH_NUM_PR_BITS);
>  			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>  			*value = tmp;
> @@ -188,8 +184,8 @@ static int dlh_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (channel->type) {
>  		case IIO_PRESSURE:
> -			*value = -125 * st->info.fss * 24909;
> -			*value2 = 100 * st->info.osdig * 100000;
> +			*value = -125 * st->info->fss * 24909;
> +			*value2 = 100 * st->info->osdig * 100000;
>  			return IIO_VAL_FRACTIONAL;
>  
>  		case IIO_TEMP:
> @@ -281,7 +277,6 @@ static irqreturn_t dlh_interrupt(int irq, void *private)
>  
>  static int dlh_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct dlh_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -302,11 +297,11 @@ static int dlh_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  
>  	st = iio_priv(indio_dev);
> -	st->info = dlh_info_tbl[id->driver_data];
> +	st->info = i2c_get_match_data(client);
>  	st->client = client;
>  	st->use_interrupt = false;
>  
> -	indio_dev->name = id->name;
> +	indio_dev->name = st->info->name;
>  	indio_dev->info = &dlh_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels =  dlh_channels;
> @@ -316,7 +311,7 @@ static int dlh_probe(struct i2c_client *client)
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  			dlh_interrupt, NULL,
>  			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -			id->name, indio_dev);
> +			st->info->name, indio_dev);
>  		if (ret) {
>  			dev_err(&client->dev, "failed to allocate threaded irq");
>  			return ret;
> @@ -341,15 +336,15 @@ static int dlh_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id dlh_of_match[] = {
> -	{ .compatible = "asc,dlhl60d" },
> -	{ .compatible = "asc,dlhl60g" },
> +	{ .compatible = "asc,dlhl60d", .data = &dlhl60d_info },
> +	{ .compatible = "asc,dlhl60g", .data = &dlhl60g_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, dlh_of_match);
>  
>  static const struct i2c_device_id dlh_id[] = {
> -	{ "dlhl60d",    dlhl60d },
> -	{ "dlhl60g",    dlhl60g },
> +	{ "dlhl60d", (kernel_ulong_t)&dlhl60d_info },
> +	{ "dlhl60g", (kernel_ulong_t)&dlhl60g_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dlh_id);
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-24-4ace82a87bfd
> 
> Best regards,


