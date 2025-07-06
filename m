Return-Path: <linux-iio+bounces-21389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287FAFA480
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB957A74D9
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F51EF391;
	Sun,  6 Jul 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev46bPNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091C1BF58;
	Sun,  6 Jul 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797874; cv=none; b=g1ayb+M/iekc43gxo32CVsw/Gk18BrXdzFD5E9t3RpgjiwWVMLA8yLsZpF1t0vNiuhZUYX4sOhqpHubqiiZoiPzwMWrmaEKdUWuY0q8dXLCO5rkt0djj72DgjEH9gNH64DiNAjzic6qgERVfdIpyLKFipSDWiwFuimdScnxIb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797874; c=relaxed/simple;
	bh=4b2/yxGWqycuhWxGvnNsktc/w0ep9DLI+POzB2HJGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUKPfbu6poCQJXeHTwtQTaIOWbELb7vHs5eWrBfujohAi71dLY6uLTtE42aivMiojYbXmpe5bGR9uJE5ZykmMxplauVZXzJitjtB0HVJDBfC6XAyGnVtjhakj+fElMKewweKcis7tJs+UFyltggkVdNjp5tZHO0hw0o13iCuT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev46bPNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F2C4CEED;
	Sun,  6 Jul 2025 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751797873;
	bh=4b2/yxGWqycuhWxGvnNsktc/w0ep9DLI+POzB2HJGIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ev46bPNFr2BCwSB6+/bXLW8119iPpNbVGkKVRqRurx3+YsMcB+vfBzF20CiLJdUdP
	 VFzQD9MlPZ7wqwtnwdpp5dmyNiougsKxqDpt/X1iKgNQL5N59zldaB+2XpKJvbeh1n
	 RuRip6eCd7j53g5B878+1HgfreDS+2xRzT9u4l/SLyOyxGpJri2u+SDT2ST9+YId72
	 XbGxg89oE49U3hQEHm2Ye908FfRDEu0SaUx6xFpCBEvtlaQ0FDbXFW+nV9CtYeBpc+
	 ewmdVSeT3KvTS2IxXTyPKfjtF5aEPVGf3tgaL9/Blu/ZPzVNYAG9Lwpsk+gUFtZMPu
	 gIPFSKxkGj2Lg==
Date: Sun, 6 Jul 2025 11:31:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, Waqar Hameed
 <waqar.hameed@axis.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 chuguangqing <chuguangqing@inspur.com>, Shreeya Patel
 <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>, Al Viro
 <viro@zeniv.linux.org.uk>, Vasileios Amoiridis <vassilisamir@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/80] iio: light: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250706113105.773ba56a@jic23-huawei>
In-Reply-To: <20250704075424.3219556-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075424.3219556-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 10:54:24 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 0e4284823d44..5ff20d423def 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -341,7 +341,6 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}

Drop {}


> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index 8885852bef22..93823421f42f 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -189,7 +189,6 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  
Whilst here drop this random blank line.
>  	} else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
>  	}
Drop {}
>  
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index c50183f07240..15e2cca22e4d 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -361,7 +361,6 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
>  	}
Drop {}

>  	if (ret < 0) {
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index fc3b0c4226be..d3a4923e5adc 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -646,7 +646,6 @@ static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(&chip->client->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&chip->client->dev);
>  		ret = pm_runtime_put_autosuspend(&chip->client->dev);
>  	}
Drop {}
>  

> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 61a0957317a1..8f0f85e98f3a 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -369,7 +369,6 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
>  	}
Drop {}
>  
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 90e7d4421abf..39e2cf20038a 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -581,7 +581,6 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}
Drop {}
>  
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 01bc99564f98..079fb49bf73b 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -147,7 +147,6 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}
Drop {}
>  


