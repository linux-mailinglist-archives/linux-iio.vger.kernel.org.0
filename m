Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C497215FF7E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgBORXD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 12:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgBORXD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 12:23:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA5C2083B;
        Sat, 15 Feb 2020 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581787382;
        bh=nfM191w0Sh5w5E6NATjEcPv0GKTwCey0X3MIbp3gwxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tc9H8M9CAOWSdbzGz5bVqn+RTGy11nYdiW4kPGZPs6K+hM5M6SfX73xM0BO22Z/sn
         jngvJGXqJpCmVtpD7wHMOO0uyk/PV0nL5XQwjbM5zlmGPG0gSMq7Sa9aKnLiZGG2OI
         7Oihx1P0gYm0i4k+Wxqzli0Jxi5L75dCv4Isp+94=
Date:   Sat, 15 Feb 2020 17:22:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iio: light: al3320a allow module autoload and
 polish
Message-ID: <20200215172258.3fd063a8@archlinux>
In-Reply-To: <20200211191201.1049902-8-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
        <20200211191201.1049902-8-david@ixit.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:12:01 +0100
David Heidelberg <david@ixit.cz> wrote:

> - allow autoloading when build as module and defined inside DT
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> v4
>  - dropping of init.h header moved to previous patches
> 
>  drivers/iio/light/al3320a.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 49e73e24fff6..e7c4899a4313 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -15,6 +15,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -241,9 +242,16 @@ static const struct i2c_device_id al3320a_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, al3320a_id);
>  
> +static const struct of_device_id al3320a_of_match[] = {
> +	{ .compatible = "dynaimage,al3320a", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, al3320a_of_match);
> +
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
> +		.of_match_table = al3320a_of_match,
>  		.pm = &al3320a_pm_ops,
>  	},
>  	.probe		= al3320a_probe,

