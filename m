Return-Path: <linux-iio+bounces-11799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0E9B95A0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E168B1F20CD9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E31AC88B;
	Fri,  1 Nov 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs9ZbcYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975D1798C;
	Fri,  1 Nov 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479244; cv=none; b=IoWzlMgtj5ROO+OVIwJRgaxl0D13L/m8ycIjPsjpRXOOIUO7INQtwK3UXjNXw8N38KokUSDxap5aE7NYOlhO/+pBzm180k2kvl6UiG0CUTxC82YKlSReCoeM98LQAb4Syq68uHRhhTpWFS8cJ2j/cOelEUq0RsW5hGr3nwvGb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479244; c=relaxed/simple;
	bh=DvSXCpiKc8373d/ShlW5K4xcJlHzMFMf1zR+xMexCHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+rCeXY05UCQ2NOQ8FpJ3hj1eGrfEwYkhXvinus7ukcakN6fYaNAiTG7R1rhtYC2JnNpMQVNsjuj38m9U88DA/80X8S6M9yxHvTzicbbmtZIfmbafiTeiOo5i+cOYOQOQLbUTyi/EFCCuatHB9e1Pr0vY6Snalv9ct2UUyUQn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs9ZbcYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD5C4CECD;
	Fri,  1 Nov 2024 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479244;
	bh=DvSXCpiKc8373d/ShlW5K4xcJlHzMFMf1zR+xMexCHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bs9ZbcYmg1J0/HaInPkVgKVS1cocVnMizPIxPqupxNDp8GjrkU3/T65uszjP/rZ7P
	 VPmIfATWJuNkC0nkiFZtZxIVDDtxtA1MbZyGFwSrslgVpuH/o6Fy4pvcfnAkksBncG
	 VRJXlQzBVfRxZAfGKIBWEsSa8HvmRREB5DAmEP0CstN+e1s3J929lDSTIePHEam8R6
	 b51ma+yT250Wzh4uzHOpnzCFj/FN89rdzZ3/TCr5cBpUOyuaALryezbJIP+4spdxpV
	 KtPEVUeA+mDqFMUHLRlpbqfn7zxSJx4AWBWmHanBVDn5yO87wmhnsmpCjmm0QsSHK9
	 gtV2jDgNpN1Tg==
Date: Fri, 1 Nov 2024 16:40:29 +0000
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
Subject: Re: [PATCH v2 12/15] iio: light: apds9300: use bool for event state
Message-ID: <20241101164029.2d15fb6d@jic23-huawei>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-12-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
	<20241031-iio-fix-write-event-config-signature-v2-12-2bcacbb517a2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 16:27:07 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Since the write_event_config callback now uses a bool for the state
> parameter, update apds9300_set_intr_state accordingly and change intr_en
> to bool.
> 
> Also update apds9300_set_power_state and power_state for consistency.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/apds9300.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
> index 95861b2a5b2d94011d894959289c5c4f06cc1efe..98bdf8bc298b664aba71d3c38d7f224808e5997d 100644
> --- a/drivers/iio/light/apds9300.c
> +++ b/drivers/iio/light/apds9300.c
> @@ -46,10 +46,10 @@
>  struct apds9300_data {
>  	struct i2c_client *client;
>  	struct mutex mutex;
> -	int power_state;
> +	bool power_state;
>  	int thresh_low;
>  	int thresh_hi;
> -	int intr_en;
> +	bool intr_en;
>  };
>  
>  /* Lux calculation */
> @@ -148,7 +148,7 @@ static int apds9300_set_thresh_hi(struct apds9300_data *data, int value)
>  	return 0;
>  }
>  
> -static int apds9300_set_intr_state(struct apds9300_data *data, int state)
> +static int apds9300_set_intr_state(struct apds9300_data *data, bool state)
>  {
>  	int ret;
>  	u8 cmd;
> @@ -169,7 +169,7 @@ static int apds9300_set_intr_state(struct apds9300_data *data, int state)
>  	return 0;
>  }
>  
> -static int apds9300_set_power_state(struct apds9300_data *data, int state)
> +static int apds9300_set_power_state(struct apds9300_data *data, bool state)
There are a few calls of this where an explicit 1 or 0 is used. Those should be
updated to be bools.

I added this diff whilst applying.  Shout if you disagree with it.

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 98bdf8bc298b..938d76f7e312 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -221,7 +221,7 @@ static int apds9300_chip_init(struct apds9300_data *data)
         * Disable interrupt to ensure thai it is doesn't enable
         * i.e. after device soft reset
         */
-       ret = apds9300_set_intr_state(data, 0);
+       ret = apds9300_set_intr_state(data, false);
        if (ret < 0)
                goto err;
 
@@ -459,8 +459,8 @@ static void apds9300_remove(struct i2c_client *client)
        iio_device_unregister(indio_dev);
 
        /* Ensure that power off and interrupts are disabled */
-       apds9300_set_intr_state(data, 0);
-       apds9300_set_power_state(data, 0);
+       apds9300_set_intr_state(data, false);
+       apds9300_set_power_state(data, false);
 }
 
 static int apds9300_suspend(struct device *dev)
@@ -470,7 +470,7 @@ static int apds9300_suspend(struct device *dev)
        int ret;
 
        mutex_lock(&data->mutex);
-       ret = apds9300_set_power_state(data, 0);
+       ret = apds9300_set_power_state(data, false);
        mutex_unlock(&data->mutex);
 
        return ret;
@@ -483,7 +483,7 @@ static int apds9300_resume(struct device *dev)
        int ret;
 
        mutex_lock(&data->mutex);
-       ret = apds9300_set_power_state(data, 1);
+       ret = apds9300_set_power_state(data, true);
        mutex_unlock(&data->mutex);
 
        return ret;



>  {
>  	int ret;
>  	u8 cmd;
> 


