Return-Path: <linux-iio+bounces-21342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A537AF8E1B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08444A49D7
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 09:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310632F5086;
	Fri,  4 Jul 2025 09:05:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1B328B0E;
	Fri,  4 Jul 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619915; cv=none; b=KRb+SYW0WkSGGOola5MtCEf2LTLDrVpphf5gHLKW5WnE6p7PTLvwfiucM4zusL+4Xj7npBs4+QoTRC7sNuFRVqAsNGfXF5O+JNQGg5fTVN/HhZvJDdu+cXk4maoJBH6vGbClQq9cGdYKUp6WJnyB3rc9F5qz5bsAZfc0yN8p+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619915; c=relaxed/simple;
	bh=R5qVhKkjPUiTBo/+tB/8r3Ngdh043u2yCazSz7hAlH0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3UxyH+OqqB5lQxTQIgCvN/Sx05nDqQXM1Gxt4dNhDtpNtkFIrQUHYNyrLoNxtvtBTy12wEIujypHDOiuJMORyAhVv3UZg1x+jDBqXDRkqIKPM0uDoTu/Ez/X1ll+a17H57JfjMvA4nhao7t9IA5Px/Jm0mtrxUlCW4Mdms9KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYSPf6gdMz6L5pZ;
	Fri,  4 Jul 2025 17:04:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC2391402A5;
	Fri,  4 Jul 2025 17:05:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 11:05:09 +0200
Date: Fri, 4 Jul 2025 10:05:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>,
	Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
	<peterz@infradead.org>, Bo Liu <liubo03@inspur.com>, Greg KH
	<gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, "Sean
 Nyekjaer" <sean@geanix.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rayyan Ansari <rayyan@ansari.sh>, Francisco Henriques
	<franciscolealhenriques@usp.br>, Matti Vaittinen <mazziesaccount@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 27/80] iio: accel: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250704100508.00003d3a@huawei.com>
In-Reply-To: <20250704075418.3218938-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075418.3218938-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  4 Jul 2025 10:54:18 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> 
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                 pm-runtime-6.17-rc1
> 
>  drivers/iio/accel/bmc150-accel-core.c | 1 -
>  drivers/iio/accel/bmi088-accel-core.c | 3 ---
>  drivers/iio/accel/fxls8962af-core.c   | 1 -
>  drivers/iio/accel/kxcjk-1013.c        | 1 -
>  drivers/iio/accel/kxsd9.c             | 3 ---
>  drivers/iio/accel/mma8452.c           | 1 -
>  drivers/iio/accel/mma9551_core.c      | 1 -
>  drivers/iio/accel/msa311.c            | 6 ------
>  8 files changed, 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index be5fbb0c5d29..f45beae83f8b 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -335,7 +335,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
>  	} else {
> -		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}

See kernel coding style.  The drop to one line in each leg means we should drop the {}


> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 12598feaa693..8afd151c03ad 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -222,7 +222,6 @@ static int fxls8962af_power_off(struct fxls8962af_data *data)
>  	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
> -	pm_runtime_mark_last_busy(dev);
>  	ret = pm_runtime_put_autosuspend(dev);
>  	if (ret)
>  		dev_err(dev, "failed to power off\n");
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 6aefe8221296..44d770729186 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -637,7 +637,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	if (on)
>  		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	else {
> -		pm_runtime_mark_last_busy(&data->client->dev);

Likewise here.

>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
>  	}
>  	if (ret < 0) {


> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index aba444a980d9..5863478bab62 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -227,7 +227,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(&client->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(&client->dev);

And here.

>  		ret = pm_runtime_put_autosuspend(&client->dev);
>  	}
>  
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 3e7d9b79ed0e..22768f43fd24 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -672,7 +672,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
>  	if (on)
>  		ret = pm_runtime_resume_and_get(&client->dev);
>  	else {
> -		pm_runtime_mark_last_busy(&client->dev);
And here...

>  		ret = pm_runtime_put_autosuspend(&client->dev);
>  	}



