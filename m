Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32A5FC93A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJLQ1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLQ1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 12:27:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C0F87FC;
        Wed, 12 Oct 2022 09:27:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29CGR5Ap081558;
        Wed, 12 Oct 2022 11:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665592025;
        bh=eEflHbY1KhW3sZo2AHyNqzl4B6Y/mZETpmBCk/G9yGY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=MLMfbwnQfXO7O0lfz9NY58tmwUQtsZnhkQuVASZBmQvQadbbP5+7vZ7/mvoGWNhzG
         yO1DmMfEqlyVppx3RQ0vcJ2bzjL0hxKRGgF8El0cJ67i4qRQkj4COP+gvMRfHXbdPg
         IFgCAbF5NgeGS31xLBT1yCkr/zXfniFgZ5OHeRIY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29CGR5Df015385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Oct 2022 11:27:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 12
 Oct 2022 11:27:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 12 Oct 2022 11:27:05 -0500
Received: from [10.250.234.181] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29CGR06C079753;
        Wed, 12 Oct 2022 11:27:01 -0500
Message-ID: <a559e9fa-b560-06fb-8555-5af22f47539e@ti.com>
Date:   Wed, 12 Oct 2022 21:57:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] counter: ti-ecap-capture: fix IS_ERR() vs NULL check
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Julien Panis <jpanis@baylibre.com>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <Y0bUbZvfDJHBG9C6@kili>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <Y0bUbZvfDJHBG9C6@kili>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 12/10/22 8:21 pm, Dan Carpenter wrote:
> The devm_counter_alloc() function returns NULL on error.  It doesn't
> return error pointers.
> 
> Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Thanks for the fix!

> ---
>  drivers/counter/ti-ecap-capture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index af10de30aba5..8104d02bb5a4 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -479,8 +479,8 @@ static int ecap_cnt_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
> -	if (IS_ERR(counter_dev))
> -		return PTR_ERR(counter_dev);
> +	if (!counter_dev)
> +		return -ENOMEM;
>  
>  	counter_dev->name = ECAP_DRV_NAME;
>  	counter_dev->parent = dev;
