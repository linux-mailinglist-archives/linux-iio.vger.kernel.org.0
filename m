Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B521C2782
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgEBSRa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgEBSRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 14:17:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD6D206F0;
        Sat,  2 May 2020 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588443449;
        bh=tC+oiAKeTHrk/rRn4g4syFenvDMA51mQIsE0Awbapec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sxRIYewMyfZrqEaIV6jrfcvdj4l1ezcFSrgwiqJYt9zEqAV+tM33YEVvC6hcj9Z1n
         T0hkhuFYBFfeZV9cECVXU0qEmSICpMmRscJT1Rpg1ZxBnR/5rLu8ynT6cAy+xQHM4J
         7Yv5xXyiM0w6mXHIORE8MHrfA0DwjC/2i0V54pcE=
Date:   Sat, 2 May 2020 19:17:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maitysanchayan@gmail.com, robh@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: vf610: Fix an error handling path in
 'vf610_dac_probe()'
Message-ID: <20200502191725.10eabc8a@archlinux>
In-Reply-To: <20200426194403.41913-1-christophe.jaillet@wanadoo.fr>
References: <20200426194403.41913-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Apr 2020 21:44:03 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> A call to 'vf610_dac_exit()' is missing in an error handling path.
> 
> Fixes: 1b983bf42fad ("iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

I'll count this one as 'obviously' correct, though happy to have input
from sanchayan if possible.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> Un-tested.
> Proposal based on function names and functions called in the remove function
> ---
>  drivers/iio/dac/vf610_dac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
> index 71f8a5c471c4..7f1e9317c3f3 100644
> --- a/drivers/iio/dac/vf610_dac.c
> +++ b/drivers/iio/dac/vf610_dac.c
> @@ -223,6 +223,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error_iio_device_register:
> +	vf610_dac_exit(info);
>  	clk_disable_unprepare(info->clk);
>  
>  	return ret;

