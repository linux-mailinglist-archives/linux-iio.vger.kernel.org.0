Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7638A2A1F05
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKAP0T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKAP0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Nov 2020 10:26:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4832223F;
        Sun,  1 Nov 2020 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604244378;
        bh=sO/BhhhWk73lCPqOD2LkH0FElhbSvayPANIXgF8THrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IkHzdAFr+gN+bE5Rmn+o8SQ5TRbGxfHOJSxY33KKHx730V47g3bnrya8dr8uEbac1
         fXaodmjOeeQAunZLo67G+ZrM1eBHZ2sm2HbPSkOodFNZqwo+nvFKBxlWvQzNqkHwFh
         h9oKdjPWs4/gnKsGuHm2TSP716upGRvdmN1GfBGo=
Date:   Sun, 1 Nov 2020 15:26:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     andy.shevchenko@gmail.com, wsa@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201101152613.2c37581a@archlinux>
In-Reply-To: <20201018195357.GA814864@ubuntu>
References: <20201018195357.GA814864@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Oct 2020 01:23:57 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> Add i2c_device_id table for the vcnl4035 driver,
> enabling device instantiation using i2c_new_client_device()
> or from userspace in cases where device-tree based description
> is not possible now, like device(s) on a gbphy i2c adapter
> created by greybus.
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Applied,

Thanks,

Jonathan

> ---
>  v4:
> 	-update commit message, add punctuation.
>  v3:
> 	-modify commit message for readability
> 	 as suggested by Jonathan Cameron
>  v2:
> 	-fix commit message
>  drivers/iio/light/vcnl4035.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 765c44adac57..73a28e30dddc 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
>  			   vcnl4035_runtime_resume, NULL)
>  };
>  
> +static const struct i2c_device_id vcnl4035_id[] = {
> +	{ "vcnl4035", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> +
>  static const struct of_device_id vcnl4035_of_match[] = {
>  	{ .compatible = "vishay,vcnl4035", },
>  	{ }
> @@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
>  	},
>  	.probe  = vcnl4035_probe,
>  	.remove	= vcnl4035_remove,
> +	.id_table = vcnl4035_id,
>  };
>  
>  module_i2c_driver(vcnl4035_driver);

