Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012F7425700
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbhJGPtT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 11:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232870AbhJGPtP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 11:49:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D9F61074;
        Thu,  7 Oct 2021 15:47:18 +0000 (UTC)
Date:   Thu, 7 Oct 2021 16:51:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v6 4/6] drivers: iio: dac: ad5766: Fix dt property name
Message-ID: <20211007165123.023ecbc1@jic23-huawei>
In-Reply-To: <20211007080035.2531-5-mihail.chindris@analog.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-5-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Oct 2021 08:00:34 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> In the documentation the name for the property is
> output-range-microvolts which is a standard name, therefore this name
> must be used.
> 
> Fixes: fd9373e41b9ba ("iio: dac: ad5766: add driver support for AD5766")
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Applied this one to the fixes-togreg branch of iio.git and marked it for stable.

Thankfully this is (I think) far enough from the other changes that we
should be able to take the other patches through the togreg tree and have
them all meet up in linux-next / upstream.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5766.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index 3104ec32dfac..dafda84fdea3 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -503,13 +503,13 @@ static int ad5766_get_output_range(struct ad5766_state *st)
>  	int i, ret, min, max, tmp[2];
>  
>  	ret = device_property_read_u32_array(&st->spi->dev,
> -					     "output-range-voltage",
> +					     "output-range-microvolts",
>  					     tmp, 2);
>  	if (ret)
>  		return ret;
>  
> -	min = tmp[0] / 1000;
> -	max = tmp[1] / 1000;
> +	min = tmp[0] / 1000000;
> +	max = tmp[1] / 1000000;
>  	for (i = 0; i < ARRAY_SIZE(ad5766_span_tbl); i++) {
>  		if (ad5766_span_tbl[i].min != min ||
>  		    ad5766_span_tbl[i].max != max)

