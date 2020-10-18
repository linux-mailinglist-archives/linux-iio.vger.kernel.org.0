Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03283291724
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJRLVo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 07:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgJRLVo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 07:21:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF8E21582;
        Sun, 18 Oct 2020 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603020103;
        bh=+2+FsSKnH6CMQcWGkMhnPM4N/U6XMQGUBu37VRkxilI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T5KySgIMGI6NLgJLM+ynb+fcdtwkO5kKJ6rrhcHS3PxadKHkWYIatKIhlERLw8H6e
         ytm17PgFDyNJdsO3rGxxUzFvTcIjQZz7sLC0n8PZ6mEhxQlPkSx3vVzVGHiRZ/0buS
         m26cXU4aolVUOjnmOZHrJ4kjaImQWyw3VjDTo6Pw=
Date:   Sun, 18 Oct 2020 12:21:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
        drew@beagleboard.org, robertcnelson@beagleboard.org,
        rajkovic@mikroe.com
Subject: Re: [PATCH] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201018122137.6f2d0f6c@archlinux>
In-Reply-To: <20201016184422.GA15952@ubuntu>
References: <20201016184422.GA15952@ubuntu>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 17 Oct 2020 00:14:59 +0530
Vaishnav M A <vaishnav@beagleboard.org> wrote:

> This patch aims to add i2c_device_id for the
> vcnl4035 driver, while going through the initial driver
> submission patches, noticed that the i2c_device_id was removed
> on suggestion (https://lore.kernel.org/patchwork/patch/970970/),
> will it be possible to consider this patch add the i2c_device_id,
> so that the device can be instantiated using i2c_new_client_device
> or say from the userspace?.This will be really helpful in cases
> where the device tree based description is not possible now(Eg. 
> a device on a gbphy i2c adapter created by greybus).
> 
> The particular usecase here is described over this RFC Patch
> for the mikroBUS driver:
> https://lore.kernel.org/patchwork/patch/1290148/
> 
> Thanks and Regards,
> 
> Vaishnav M A
If you send out a v2 of a patch without there having been any replies
please reply your self to say you have done so.

That avoids reviewers looking at the wrong version!

Thanks

Jonathan



> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> ---
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

