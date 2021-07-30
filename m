Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0FF3DB98F
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhG3NpO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 09:45:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3542 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhG3NpN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 09:45:13 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbpLq3j0vz6G9mJ;
        Fri, 30 Jul 2021 21:35:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:45:06 +0200
Received: from localhost (10.47.1.48) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 30 Jul
 2021 14:45:06 +0100
Date:   Fri, 30 Jul 2021 14:44:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hui Liu <hui.liu@mediatek.com>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] iio: mtk-auxadc: add mutex_destroy
Message-ID: <20210730144439.00005e26@Huawei.com>
In-Reply-To: <20210729080135.17436-2-hui.liu@mediatek.com>
References: <20210729080135.17436-1-hui.liu@mediatek.com>
        <20210729080135.17436-2-hui.liu@mediatek.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.48]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Jul 2021 16:01:35 +0800
Hui Liu <hui.liu@mediatek.com> wrote:

> Add mutex_destroy when probe fail and remove device.
> 
> Signed-off-by: Hui Liu <hui.liu@mediatek.com>

Hi Hui Liu,

Two things here.

1) You need to explain with a clear example flow when this would serve a
   useful purpose.  As I explained before, we do no in general put mutex_destroy()
   in remove paths as it is usually just noise.

2) It's in the wrong order logically. mutex init is between the clk_prepare_enable
   and iio_device_register, hence if we are going to have mutex destroy it must also
   be in that that location (remove should be reverse of probe or there should be
   a clear comment explaining why we need to do things in a different order.

3) If touching this code at all, please move all of the probe / remove to devm_
   managed code so that we don't need to get this ordering right at all because
   it will be done automatically.

So I won't apply this without 1 and even if I accepted the principle, it's
still in the wrong place in remove.

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

