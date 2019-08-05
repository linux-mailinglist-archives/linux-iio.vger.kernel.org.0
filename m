Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860F7823B8
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHERM7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 13:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfHERM7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 13:12:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E28208E3;
        Mon,  5 Aug 2019 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565025178;
        bh=6yjVKWPUFOxwA8zJj/J+Ue0Uov6l8f2Foajl870T97Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wpXa3IL7o9MNvGeCAQsN2jRt1b1C9cQfXWYl/r5oCtyG6+b30Mtc+YbSS5XvtD4bo
         RHA0eB3MYptGCsJMHBVd5LV064hcHwpMUUv6o77pGym89iBKIl97qSCnLTdNfmdEe7
         GZnKP/jmk2B68oKjMz5drXPrL1csN/R/XKLZYTUU=
Date:   Mon, 5 Aug 2019 18:12:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Fix temperature reading in probe
Message-ID: <20190805181244.663585ac@archlinux>
In-Reply-To: <20190805155515.22621-1-jacopo+renesas@jmondi.org>
References: <20190805155515.22621-1-jacopo+renesas@jmondi.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Aug 2019 17:55:15 +0200
Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:

> The max9611 driver reads the die temperature at probe time to validate
> the communication channel. Use the actual read value to perform the test
> instead of the read function return value, which was mistakenly used so
> far.
> 
> The temperature reading test was only successful because the 0 return
> value is in the range of supported temperatures.
> 
> Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Applied to the fixes-togreg branch of iio.git and marked for
stable.  That'll be a bit fiddly given other changes around this
so we may need to do backports.


> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 917223d5ff5b..e9f6b1da1b94 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -480,7 +480,7 @@ static int max9611_init(struct max9611_dev *max9611)
>  	if (ret)
>  		return ret;
> 
> -	regval = ret & MAX9611_TEMP_MASK;
> +	regval &= MAX9611_TEMP_MASK;
> 
>  	if ((regval > MAX9611_TEMP_MAX_POS &&
>  	     regval < MAX9611_TEMP_MIN_NEG) ||
> --
> 2.22.0
> 

