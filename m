Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70E71DFF6B
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgEXOjv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 10:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXOjv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:39:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6382E20776;
        Sun, 24 May 2020 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590331191;
        bh=uzw2U9MXx7/SSnPJjfPgYOwU900QJmKOm93E6D2+T/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bnze/FeK59mNe8SUMuVCPGcZrkgam8Q2lGt334y8UuguY4bVNZiLO0gNreoFUQftq
         LeRspM+TZN6eNlbz0BKgErtjfSlPG5oTMz7qpM6Kfc+4HjHvznHCdwkbe9HTRXtqJV
         6Wj1fN9kHZvxmP5e3A97pY48XYww3JehwRKikVWI=
Date:   Sun, 24 May 2020 15:39:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] iio: light: tsl2563: pass iio device as i2c_client
 private data
Message-ID: <20200524153947.5d39dc20@archlinux>
In-Reply-To: <20200522070801.28480-1-alexandru.ardelean@analog.com>
References: <20200522070801.28480-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 10:08:01 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We may want to get rid of the iio_priv_to_dev() helper. That's a bit
> uncertain at this point. The reason is that we will hide some of the
> members of the iio_dev structure (to prevent drivers from accessing them
> directly), and that will also mean hiding the implementation of the
> iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> 
> For this driver, it implies passing the IIO device on the i2c client
> private data. The implementation of iio_priv() will not be affected by the
> rework/hiding of iio_priv_to_dev().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied. Thanks,

J
> ---
>  drivers/iio/light/tsl2563.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 27a5c28aac7f..2987a7a79a97 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -713,7 +713,7 @@ static int tsl2563_probe(struct i2c_client *client,
>  
>  	chip = iio_priv(indio_dev);
>  
> -	i2c_set_clientdata(client, chip);
> +	i2c_set_clientdata(client, indio_dev);
>  	chip->client = client;
>  
>  	err = tsl2563_detect(chip);
> @@ -797,8 +797,8 @@ static int tsl2563_probe(struct i2c_client *client,
>  
>  static int tsl2563_remove(struct i2c_client *client)
>  {
> -	struct tsl2563_chip *chip = i2c_get_clientdata(client);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct tsl2563_chip *chip = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	if (!chip->int_enabled)
> @@ -816,7 +816,8 @@ static int tsl2563_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int tsl2563_suspend(struct device *dev)
>  {
> -	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct tsl2563_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
>  	mutex_lock(&chip->lock);
> @@ -834,7 +835,8 @@ static int tsl2563_suspend(struct device *dev)
>  
>  static int tsl2563_resume(struct device *dev)
>  {
> -	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct tsl2563_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
>  	mutex_lock(&chip->lock);

