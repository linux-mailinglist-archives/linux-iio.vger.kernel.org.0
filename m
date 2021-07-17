Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509323CC481
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhGQQpM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 12:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhGQQpL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 12:45:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D1E61159;
        Sat, 17 Jul 2021 16:42:08 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:44:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] iio: mtk-auxadc: add mutex_destroy
Message-ID: <20210717174432.7e69e4e9@jic23-huawei>
In-Reply-To: <20210715093523.29844-2-hui.liu@mediatek.com>
References: <20210715093523.29844-1-hui.liu@mediatek.com>
        <20210715093523.29844-2-hui.liu@mediatek.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Jul 2021 17:35:23 +0800
Hui Liu <hui.liu@mediatek.com> wrote:

> Add mutex_destroy when probe fail and remove device.
> 
> Signed-off-by: Hui Liu <hui.liu@mediatek.com>
Hi Hui Liu,

We very very rarely bother to call mutex_destroy().  The reason is
that it is only a non noop in when mutex debugging is enabled and
that is only useful if there is a plausible route in which it could
be used after the mutex_destroy.   Given these are both at the ends
of removal paths, I don't think this is useful.  That's why you will
rarely find mutex_destroy() being called.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mt6577_auxadc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 79c1dd68b909..d57243037ad6 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -289,6 +289,7 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to register iio device\n");
> +		mutex_destroy(&adc_dev->lock);
>  		goto err_power_off;
>  	}
>  
> @@ -313,6 +314,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  			      0, MT6577_AUXADC_PDN_EN);
>  
>  	clk_disable_unprepare(adc_dev->adc_clk);
> +	mutex_destroy(&adc_dev->lock);
>  
>  	return 0;
>  }

