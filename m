Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9927037728F
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEHPVg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhEHPVg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 11:21:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECB661026;
        Sat,  8 May 2021 15:20:33 +0000 (UTC)
Date:   Sat, 8 May 2021 16:21:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: mxs-lradc-adc: use iio_device_id() helper
Message-ID: <20210508162129.76a93ad1@jic23-huawei>
In-Reply-To: <20210504075304.148516-1-aardelean@deviqon.com>
References: <20210504075304.148516-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  4 May 2021 10:53:04 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The @id field was moved in commit e58bb7a74dca ("iio: core: move @id from
> struct iio_dev to struct iio_dev_opaque"), however this driver was omitted
> by accident, because the name of the IIO device is 'iio'.
> 
> This was caught by the lkp bot.
> 
> Fixes: e58bb7a74dca ("iio: core: move @id from struct iio_dev to struct iio_dev_opaque")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Thanks.  I applied this as a fixup as that branch hadn't yet gone out as non
rebasing and I don't want to break bisection.

Also chased down how I'd missed this on in my test .config.  

Jonathan

> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index 30e29f44ebd2..1d99170d3328 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -455,7 +455,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
>  	struct mxs_lradc_adc *adc = iio_priv(iio);
>  
>  	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
> -				      iio->id);
> +				      iio_device_id(iio));
>  	if (!trig)
>  		return -ENOMEM;
>  

