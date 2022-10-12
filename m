Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A85FC898
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJLPnq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJLPno (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 11:43:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1581CE0732
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 08:43:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so26778703wrp.10
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhkgU256B/oUeYJAL3eaRMpfYWwB1CJIkfgtBEPJ4RQ=;
        b=d/9uqGIt3Wp0b9FXKJ1FOhFYukXmV0PdcYu3zskeacDqfT4ZtQTBJ+klC8XgRboqhV
         iCYhuzam1adXhPjlPPoyFvwt39rpOvlJpWMKQTNkMTWj4biufZLEIVdbKASoLoMNXWiB
         V7M7P5jZecIUyTMZGpbqU5MIpI/RueK7OFPSwbII0xrLTb5DmTrDb+PeRGGly2hWnB00
         +LZKucb//OWjJIA2NPyx06t9yIi/uBDUeBQGFZoRwcdXw63s0KGreoFq8ab2iibyR/wL
         cn4IbOm1yUTM5bp0aGEwAmmPq9xuQGbiyxNOP2e0UnZ4TkcaCaiAuU1ykSk03A7r4fom
         u1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhkgU256B/oUeYJAL3eaRMpfYWwB1CJIkfgtBEPJ4RQ=;
        b=uuoi4PgLpifypNmKp/isxDU7HZZvJSLym6LqAJB9WF6S0fxY+Y9KjJviYxIGGm4uhc
         QnSdba2U66ohiC1m+yW4qyHFxaYgsXVB6bt9G0VUtfcFBOFuT2Ig1mx+sIt9Lxjt60ll
         7cAH5/zRoEEfzNIrneitAPYWC7B5L5Fse7vT7EOzcfXsZiVEnt/8JlKIlwf58wJLE3Bb
         dfpHFzmTDlTg6ZpdOYvuPdq+mJZszqdm06C/EVg18AgEkuP9vvYJPKddhkK3y4M8KL2w
         p81zN5HpPWHHlEWm5IQpPecmCdKpBsgAdubpS/DbeW7Kw41P44/v64o8vqPuDkP4ZxYX
         SlPg==
X-Gm-Message-State: ACrzQf3eS7P0ZTV6EW0zUQ/mZHRm/Pi+GxmI8GCnJXK32YiMYjNeqW/K
        DMI/MBezxNL1s2zNaZKdzZHeRA==
X-Google-Smtp-Source: AMsMyM6jty9lmeuOVljOXoUvb1UFooemPZzxQxp3ktKh/rH4Eozxog62MQWNbzmpEodRCPG2UixE7w==
X-Received: by 2002:adf:fb10:0:b0:22a:f1d8:18d2 with SMTP id c16-20020adffb10000000b0022af1d818d2mr18473654wrr.483.1665589420658;
        Wed, 12 Oct 2022 08:43:40 -0700 (PDT)
Received: from [192.168.1.70] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003c6b874a0dfsm2642794wms.14.2022.10.12.08.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:43:40 -0700 (PDT)
Message-ID: <e845b4d0-b3e7-6b0f-fb5a-9c0d1f61aeb3@baylibre.com>
Date:   Wed, 12 Oct 2022 17:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] counter: ti-ecap-capture: fix IS_ERR() vs NULL check
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <Y0bUbZvfDJHBG9C6@kili>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Y0bUbZvfDJHBG9C6@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Julien Panis <jpanis@baylibre.com>

On 12/10/2022 16:51, Dan Carpenter wrote:
> The devm_counter_alloc() function returns NULL on error.  It doesn't
> return error pointers.
>
> Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/counter/ti-ecap-capture.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index af10de30aba5..8104d02bb5a4 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -479,8 +479,8 @@ static int ecap_cnt_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
> -	if (IS_ERR(counter_dev))
> -		return PTR_ERR(counter_dev);
> +	if (!counter_dev)
> +		return -ENOMEM;
>   
>   	counter_dev->name = ECAP_DRV_NAME;
>   	counter_dev->parent = dev;

