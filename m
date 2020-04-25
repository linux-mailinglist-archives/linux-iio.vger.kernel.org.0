Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF881B8710
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDYOfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 10:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOfa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:35:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2914D2084D;
        Sat, 25 Apr 2020 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587825330;
        bh=abCHIYAoKnN3TIvLuIRX/P0Xun4KiGw4fv8aoOkrL24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kvKTm58J3ocCA0Dle8Zz79+wuHQzeyQ03hU2ywU10tmYrVKkxKZTF8sHeseNK5/3M
         ekRNkugSJ9iRNCACznYCo6JC00Zf/Kxse5uf7tHHUvRE1vkRjxcTZx2G/zQTxAxWKQ
         5lyMGWtOsgd9WrIiKLefTauUhjOce0p8kLa8pxmI=
Date:   Sat, 25 Apr 2020 15:35:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.Ardelean@analog.com
Subject: Re: [PATCH 3/3] iio: accel: mma8452: Drop of_match_ptr macro
Message-ID: <20200425153526.048a502e@archlinux>
In-Reply-To: <20200424224439.5601-4-nish.malpani25@gmail.com>
References: <20200424224439.5601-1-nish.malpani25@gmail.com>
        <20200424224439.5601-4-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 04:14:39 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Enables ACPI DSDT to probe via PRP0001 and the compatible property.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

No on this one.  There is a whole load of device tree specific code in
the driver.  Now that could be moved over to the device properties 
approach but that's a much less trivial job.  Its probably too major
to do without someone giving a tested-by, or whoever does it
having the device to test - or setting up emulation to check
everything works as expected before and after the change.

So far I've been restricting this tidying up to the drivers that are
really simple to review (no other device tree functions called).

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 00e100fc845a..66217fbcc7af 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1815,7 +1815,7 @@ MODULE_DEVICE_TABLE(i2c, mma8452_id);
>  static struct i2c_driver mma8452_driver = {
>  	.driver = {
>  		.name	= "mma8452",
> -		.of_match_table = of_match_ptr(mma8452_dt_ids),
> +		.of_match_table = mma8452_dt_ids,
>  		.pm	= &mma8452_pm_ops,
>  	},
>  	.probe = mma8452_probe,

