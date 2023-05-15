Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80E702456
	for <lists+linux-iio@lfdr.de>; Mon, 15 May 2023 08:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjEOGSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 May 2023 02:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjEOGS0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2023 02:18:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5D1FE0
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2023 23:18:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so22868230a12.1
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2023 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684131502; x=1686723502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsn+9t9oVdV6VsJksU9eG/4JyWhhvtoT+WJssMz6Kqk=;
        b=IaxJvjTC9o2itPehQq+Fh3w60a6Z3j7hL5QJ+hrh3bl84WOTypS4In51mPjFyGiYm4
         6mKPKxMqNLTmVFXDhDWpkCS6rt3kkAb8w2MAWvlrvefURGJyUdEsP2hSshZY9iH1G0kX
         m402++3rcCuBf6fKZ8tjYe2JHo7EzyPrSTvHhK8hgPDe8oAeaAjzcNm54tMcwrktF8o5
         FUfBduSosyBSqdMwYJGd5mCeJ8I3k0HpHG91DE1h/wh4pqBQn81vRU9zlRFVjZVu/VUa
         sZg80j2zaiV+UNCx3prJ6VdIJ/hzwqjuKerymez+V1cl1M9q/IUw5azAvnqrfF7IkNbQ
         0Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684131502; x=1686723502;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsn+9t9oVdV6VsJksU9eG/4JyWhhvtoT+WJssMz6Kqk=;
        b=TG/Ttqwe90e42Us8g+y31vQfyXO128xY3Oh9UPE/QAs0YHEgUT8nBoXazhOQmJ4OfZ
         ixOWhZCH9uk70l0Spq9Agw17wjLjV+Zx+c3VvQ7ttuSXxwcxEUDwWjHwgNUW+3rzJ7By
         qCwUID4sqlQnHr4ee+soqZhmbyKQqC53YqpsKig/UuTOto5vJeu0a4ZUDFxLxLwo+AsF
         JCTSXpzYiQaM6NZeD6H4OpUkxXfHUXC4pxOYm9/Ji5RJ6FycTCUvN9Xd3LSsx3DAJ+1Q
         uXgVh2T0XTQrDuoFRsByOigG9OJnxuZ5vTyYRg2IT6eyenApMgrSC6KNR89PzlEn5GHC
         ZVNw==
X-Gm-Message-State: AC+VfDwVDMNVWpCZ4cXLhFEMguS/3clttjJRidlsUEw5/tzBJ5TpSnyq
        MqDBOosLrCYeRKMJEr2HzGd/mg==
X-Google-Smtp-Source: ACHHUZ4oVzGPtamm9pgZntqiXiY0OraZvsaEW1dnClbV9M3ieJqpsTcbFb10UO9ZQOKGAwkSNtvfgQ==
X-Received: by 2002:a17:907:97c9:b0:96a:1348:7a27 with SMTP id js9-20020a17090797c900b0096a13487a27mr20117942ejc.12.1684131501689;
        Sun, 14 May 2023 23:18:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id d1-20020a170907272100b0094bb4c75695sm9056804ejl.194.2023.05.14.23.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:18:21 -0700 (PDT)
Message-ID: <1a72facf-422e-7a1a-032e-8760424b012d@linaro.org>
Date:   Mon, 15 May 2023 08:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] iio: temperature: tmp006: Add OF device matching
 support
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1684089997.git.anupnewsmail@gmail.com>
 <d0114a66fa3e9fb07a98dde3cc0bd87c526a3753.1684089997.git.anupnewsmail@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d0114a66fa3e9fb07a98dde3cc0bd87c526a3753.1684089997.git.anupnewsmail@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 14/05/2023 21:03, Anup Sharma wrote:
> Adds an of_device_id table entry to the driver, enabling
> device matching through device tree. With this update, the driver
> can now match devices using both the i2c_device_id entry and the
> newly added of_device_id table.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  drivers/iio/temperature/tmp006.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index cdf08477e63f..2b1782263cc9 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/bitops.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -272,15 +273,22 @@ static int tmp006_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
>  
> +static const struct of_device_id tmp006_of_match[] = {
> +	{ .compatible = "ti,tmp006", },
> +	{ }
> +};
> +

Drop blank line.

> +MODULE_DEVICE_TABLE(of, tmp006_of_match);
> +
>  static const struct i2c_device_id tmp006_id[] = {
>  	{ "tmp006", 0 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(i2c, tmp006_id);

This should stay.


Best regards,
Krzysztof

