Return-Path: <linux-iio+bounces-21486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D6AFEDFB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EA7AC61E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795042E6106;
	Wed,  9 Jul 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZmhns8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378731F5858;
	Wed,  9 Jul 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075956; cv=none; b=Zyzg7ZRVp3OZ0y9eiHE7EGlXlbW0/cjKV/VtmSEoaRMJTbMHTsyqjfzvFPtZkMYugSZjb6b4zmf3Ddu7A5NrCzPEeeDmhFPQ0e2sdFDsRHdtQ9EAOIDaPNw+Qmv0JeORxugIq4ky2KOTnoMlF+jFRUZHFFCzCOY4Ddpmm0NO37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075956; c=relaxed/simple;
	bh=NZLsgo/GCu0/UsX/slLs+NFStGyMgjDOW7ILK5SmxOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7MlvKnOcdcqPJ5PYLqTsPMbwRsOt056XT967XdMUrjH7iX7r9UJ4cW2HLgkaVqcxXhVwU9S1AXkmFZ8ygZMwsCg1cR0XQ1qsOi537M70A4aQkOVUPQmBPxyCSDLpguJ2DqcQf3Gs3bkFJXZE8xBHqs3RNsQvJi+IGTLZcUGA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZmhns8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98360C4CEEF;
	Wed,  9 Jul 2025 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075955;
	bh=NZLsgo/GCu0/UsX/slLs+NFStGyMgjDOW7ILK5SmxOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZmhns8JeNZIijU0BxQ/tILDwGFINFfYF99CDYscz9U0oc4h4kFxvd2XXnvfdVSFW
	 eahqLrq+D6wBYH658BClvDNq/IY7nakWtz7pDd55h3oxg2a8a+v8ytSu8Vi2Q2cOvw
	 LEXYsu9YORHXOCAveKQev3f9HLPIqfBTJ2vRVMxuK9p9EAJ6vJ6kNDPCVO/P0LktnD
	 cfmP0PRNx0wC14winMjH+1zwaZS1ObxnTzzd78awa6MRRpZT0/v9SA9+MFElSUPizy
	 6TEOOZOY/S+5nKyXGv6VroOg4gtV6yTIO0dtLJTYuyEy4bv5TaAMlOwIU60VsQmRdj
	 N00etAPKYU/sw==
Date: Wed, 9 Jul 2025 16:45:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, Abhash Jha
 <abhashkumarjha123@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>,
 chuguangqing <chuguangqing@inspur.com>, Shreeya Patel
 <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>, Al Viro
 <viro@zeniv.linux.org.uk>, Vasileios Amoiridis <vassilisamir@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] iio: light: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709164545.3af9f056@jic23-huawei>
In-Reply-To: <20250708231152.971728-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231152.971728-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 02:11:52 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/light/apds9306.c   |  2 --
>  drivers/iio/light/apds9960.c   |  1 -
>  drivers/iio/light/bh1780.c     |  1 -
>  drivers/iio/light/gp2ap002.c   |  2 --
>  drivers/iio/light/isl29028.c   | 11 +++--------
>  drivers/iio/light/ltrf216a.c   |  1 -
>  drivers/iio/light/pa12203001.c | 11 +++--------
>  drivers/iio/light/rpr0521.c    |  6 ++----
>  drivers/iio/light/tsl2583.c    | 12 +++---------
>  drivers/iio/light/tsl2591.c    |  2 --
>  drivers/iio/light/us5182d.c    | 12 +++---------
>  drivers/iio/light/vcnl4000.c   | 11 +++--------
>  drivers/iio/light/vcnl4035.c   | 11 +++--------
>  13 files changed, 20 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 0e4284823d44..374bccad9119 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -336,16 +336,11 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
>  static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
>  {
>  	struct device *dev = regmap_get_device(chip->regmap);
> -	int ret;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
This is one that can definitely be squashed down to call sites given
the parameter is always hard coded.
>  
>  /* Channel IO */
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 61f57a82b872..5f27f754fe1c 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -208,7 +208,6 @@ static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
Also this one.
>  			return ret;
>  		}
>  	} else {
> -		pm_runtime_mark_last_busy(dev);
>  		pm_runtime_put_autosuspend(dev);
>  	}
>  

> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index fc3b0c4226be..8801a491de77 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -641,16 +641,10 @@ static const struct iio_chan_spec tsl2583_channels[] = {
>  
>  static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
And this one.
>  {
> -	int ret;
> +	if (on)
> +		return pm_runtime_resume_and_get(&chip->client->dev);
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(&chip->client->dev);
> -	} else {
> -		pm_runtime_mark_last_busy(&chip->client->dev);
> -		ret = pm_runtime_put_autosuspend(&chip->client->dev);
> -	}
> -
> -	return ret;
> +	return pm_runtime_put_autosuspend(&chip->client->dev);
>  }
>  
>  static int tsl2583_read_raw(struct iio_dev *indio_dev,




> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 90e7d4421abf..7d70bb71b432 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -576,16 +576,11 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
>  static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)

And this one.

>  {
>  	struct device *dev = &data->client->dev;
> -	int ret;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 01bc99564f98..963747927425 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -141,17 +141,12 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {

And this one. All as follow up series though to keep this series focused
on just the dropping of the calls.
>  
>  static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
>  {
> -	int ret;
>  	struct device *dev = &data->client->dev;
>  
> -	if (on) {
> -		ret = pm_runtime_resume_and_get(dev);
> -	} else {
> -		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> -	}
> +	if (on)
> +		return pm_runtime_resume_and_get(dev);
>  
> -	return ret;
> +	return pm_runtime_put_autosuspend(dev);
>  }
>  
>  static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,


