Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B94A3862
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiA3TGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:06:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52578 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiA3TF7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:05:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A4E7612E4
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA4C340E4;
        Sun, 30 Jan 2022 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643569558;
        bh=FeclA3e2jqVXDj3H8LNi2gYyFZ1kgMZ7vcTPJxboORk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VEheDNDEv5V+Q5AILAGgT/n0DHHerSJ/Jql/GOcwDwLb2vOJtgsVEqKAk0KsRfrXC
         xJk9YR29yhrhe2CTBFr5ufYq6aG85BWhE/8NPEzQG8BJl8jZOVIQNuy/AOc+Ljk7N5
         JEUbuKWcUiKTYyFXPluCxzACZ0yp3TtzPXZiSw15+KLm6zV8OZOm8KHGrZZf7G9+7G
         dDuQAGOMgB9cBQds+TeX6QTBmyG8iM66tob+ErIQ23prwKnV8YBldjYrcSaxFaPzjB
         pkqsIUMnWnPrIjmJz+UbR2d+82nu63+OQ5oToHTvao7YaNLilAiIloTaf7IYdwD5vP
         zxoKxVL2WNPmg==
Date:   Sun, 30 Jan 2022 19:12:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 34/51] iio:light:us5182: Switch from CONFIG_PM guards
 to pm_ptr() etc
Message-ID: <20220130191224.67c763c1@jic23-huawei>
In-Reply-To: <20220102125617.1259804-35-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-35-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Jan 2022 12:56:00 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Dropping this (for now) from v3 as need to take a closer look at
what we should be doing for the interaction of sleep and runtime
pm ops.  Probably wants to use the force runtime macros but needs
more care than I'm going to give it today!

Jonathan

> ---
>  drivers/iio/light/us5182d.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 96e4a66ddf28..fdabf601d15e 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -916,7 +916,6 @@ static int us5182d_remove(struct i2c_client *client)
>  	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
>  }
>  
> -#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
>  static int us5182d_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -939,11 +938,10 @@ static int us5182d_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops us5182d_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
> -	SET_RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
> +	RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
>  };
>  
>  static const struct acpi_device_id us5182d_acpi_match[] = {
> @@ -969,7 +967,7 @@ MODULE_DEVICE_TABLE(of, us5182d_of_match);
>  static struct i2c_driver us5182d_driver = {
>  	.driver = {
>  		.name = US5182D_DRV_NAME,
> -		.pm = &us5182d_pm_ops,
> +		.pm = pm_ptr(&us5182d_pm_ops),
>  		.of_match_table = us5182d_of_match,
>  		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
>  	},

