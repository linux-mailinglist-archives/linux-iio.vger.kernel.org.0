Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1329EE82
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgJ2OkM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 10:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgJ2OkM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 10:40:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C85020838;
        Thu, 29 Oct 2020 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603982411;
        bh=bQCsa4tywjj3qn+ltSe7J4RPmQOxSf8VWYxqoPQig6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WUalWVfd3F1cqzet3Uw+4PmoFYBgo2ng6C2FTDryDKomIsEighYI6js+8rzl3xWTr
         kWym88BhxNp0iZ8eldM2NFQyhtjYPSQcMruCSMOm+yUtuXRVjlFRRxmjzCAPhRAQta
         D1nmQccmmFnSmZLQE9UVR0++1U4Qv3/78+rQw0sM=
Date:   Thu, 29 Oct 2020 14:40:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 01/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201029144007.77d967b0@archlinux>
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Oct 2020 15:48:56 +0800
Coiby Xu <coiby.xu@gmail.com> wrote:

> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
Hi Coiby, 

Please put a cover letter on your next series explaining the context.
In this particular case some of the replies you have gotten are
general at it is a lot easier to find these sorts of things via
replying to the cover letter.

Jonathan

> ---
>  drivers/iio/accel/da311.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> index 3b3df620ba27..55d4891556ca 100644
> --- a/drivers/iio/accel/da311.c
> +++ b/drivers/iio/accel/da311.c
> @@ -263,7 +263,6 @@ static int da311_remove(struct i2c_client *client)
>  	return da311_enable(client, false);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int da311_suspend(struct device *dev)
>  {
>  	return da311_enable(to_i2c_client(dev), false);
> @@ -273,7 +272,6 @@ static int da311_resume(struct device *dev)
>  {
>  	return da311_enable(to_i2c_client(dev), true);
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
>  

