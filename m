Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869E03FACEA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhH2Pyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235738AbhH2Pyc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:54:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E772E60F42;
        Sun, 29 Aug 2021 15:53:37 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:56:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: fix an error code in probe()
Message-ID: <20210829165653.36c65f7c@jic23-huawei>
In-Reply-To: <20210816183954.GB2068@kili>
References: <20210816183954.GB2068@kili>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Aug 2021 21:39:54 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If we have an unexpected number of channels then return -EINVAL instead
> of returning success.
> 
> Fixes: df38a4a72a3b ("iio: dac: add TI DAC5571 family support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Given I'm not going to be doing another fixes pull for 5.14 (bit late afterall!)
I've rebased the fixes-togreg branch to match staging/staging-next which will
go in during the merge window + applied this on top.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ti-dac5571.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 2a5ba1b08a1d..546a4cf6c5ef 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -350,6 +350,7 @@ static int dac5571_probe(struct i2c_client *client,
>  		data->dac5571_pwrdwn = dac5571_pwrdwn_quad;
>  		break;
>  	default:
> +		ret = -EINVAL;
>  		goto err;
>  	}
>  

