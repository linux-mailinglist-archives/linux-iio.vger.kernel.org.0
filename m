Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231474A384F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355503AbiA3TBp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:01:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47468 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA3TBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:01:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A0B612D0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBECC340E4;
        Sun, 30 Jan 2022 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643569304;
        bh=uF98jJhnxyZ/+TXkA3dmkQEMUi1I7SJmNmY9SW27UIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LMsNyfyIOy+uRNVdUKCxXACnbSOVzvi2AHs8Mr620+1daRd77zIth5mrrPOg961Jf
         nXYFGLfDr5pPFjbb2NNikOUNG/ccSu/ktzHXTky6AoemQtaodlXjHQByRbpsMlpSi1
         rZPGg6qqoQKO4Q8/DFCQoLW2Rw0njY4QkI8cJB2xHC1H//tu88P9k6wtwl4fi1WEN/
         S4WfB7TdZFRIPqWLLQR+vZ2yhD0C2gW7IPKhStI2U5/WFfPVYHJ1TcPJ6Sj25N9V/z
         XmfoIxPqoIgtmLp5T38Wm9JhJ3cD9fk8tqj6vEN5EeQnRwVktqWfDB8dkZUTOwJ9zW
         wyiYb0zX9QwMQ==
Date:   Sun, 30 Jan 2022 19:08:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/51] iio:accel:kxsd9: Switch from CONFIG_PM guards
 to pm_ptr() etc
Message-ID: <20220130190808.6654d37c@jic23-huawei>
In-Reply-To: <20220102125617.1259804-11-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-11-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  2 Jan 2022 12:55:36 +0000
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
I'm going to drop this from v3 because of the clash with the namespace
patch that is already on list.

Once that's in I'll post an updated version with the a precursor patch
to add new PM macros to export the pm_ops in a namespace.

Jonathan

> ---
>  drivers/iio/accel/kxsd9-i2c.c | 2 +-
>  drivers/iio/accel/kxsd9-spi.c | 2 +-
>  drivers/iio/accel/kxsd9.c     | 8 ++------
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 274b41a6e603..ffe8066b4025 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -55,7 +55,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
>  	.driver = {
>  		.name	= "kxsd9",
>  		.of_match_table = kxsd9_of_match,
> -		.pm = &kxsd9_dev_pm_ops,
> +		.pm = pm_ptr(&kxsd9_dev_pm_ops),
>  	},
>  	.probe		= kxsd9_i2c_probe,
>  	.remove		= kxsd9_i2c_remove,
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index 441e6b764281..44edf39fc5ff 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, kxsd9_of_match);
>  static struct spi_driver kxsd9_spi_driver = {
>  	.driver = {
>  		.name = "kxsd9",
> -		.pm = &kxsd9_dev_pm_ops,
> +		.pm = pm_ptr(&kxsd9_dev_pm_ops),
>  		.of_match_table = kxsd9_of_match,
>  	},
>  	.probe = kxsd9_spi_probe,
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 552eba5e8b4f..39059ddca441 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -492,7 +492,6 @@ void kxsd9_common_remove(struct device *dev)
>  }
>  EXPORT_SYMBOL(kxsd9_common_remove);
>  
> -#ifdef CONFIG_PM
>  static int kxsd9_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -508,13 +507,10 @@ static int kxsd9_runtime_resume(struct device *dev)
>  
>  	return kxsd9_power_up(st);
>  }
> -#endif /* CONFIG_PM */
>  
>  const struct dev_pm_ops kxsd9_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
> -			   kxsd9_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	RUNTIME_PM_OPS(kxsd9_runtime_suspend, kxsd9_runtime_resume, NULL)
>  };
>  EXPORT_SYMBOL(kxsd9_dev_pm_ops);
>  

