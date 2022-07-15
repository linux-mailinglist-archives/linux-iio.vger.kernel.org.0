Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F7576914
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 23:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiGOVkU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiGOVkT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 17:40:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D787343
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 14:40:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so8399054wrd.13
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J6BSJtpNWZ2Z1cUANVaPa8k/01zDYr+V4xutkYf54NQ=;
        b=EiZ/Jmkz5DdkNRwJGtK9gVoZ3BcJ8ejMk3yeeSneUGJiCM2csICY8AdW61vGapRVcY
         UVEs2lvDUtUmSWhTy5Riy+DiODr1rNBvvUK4wbrRLT25XjOXefr0/051txgAy4PBorpi
         GKNcSgswr6pLYwYHFSVzvB34JMrg+jT1ikpzno4L0ZOP0gQXJvWnMhCAGwkPbk+zk4T6
         NHUHFy/WsEuLp1Gd3GTwIoolQEUdfvT1tqqUGbfp80W8fFmVfSTmouc1u2k89r7uyeR9
         nYK4zK2wqlmEsLRHEwqRtcub6mC9oo2ROYXHqnHla+d+LumXFIkgFPThdJfozfzXSQFb
         VGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J6BSJtpNWZ2Z1cUANVaPa8k/01zDYr+V4xutkYf54NQ=;
        b=yqwMMuZ0Tjbpoj3q2tkl1l/y5YeYxgh8/ZcjSuk1sBAUEIDWuwQxDZIvalQDsyIHbL
         BPCrxmgGKa6xfhEjPzAkhgLB+3scWeimyLQ7lVWiuOUgA7obQHxPTfPmHwBTMUNYWYak
         QrogB8X/mkgqrAFo2mwOUqixxR3C0af9sfXz4EkFJBpe83+h5oLiaIhOd6z+/sELrJEW
         VUxVUa4mPlyRmXQxDld2D3Z9CgybaYAa5aEzK48KtlOtNV7Ra/jbodFbUaE/putEUO+1
         KZJtfwih1wOpbxeMzGrCulefLR/5yxn0+fJHPkv5BA1/t8ZekKNzMQr5k4JKV9itqDXS
         6k9g==
X-Gm-Message-State: AJIora8YKah5MI425y0/jEF46ea0D7AcNzdA8oIedDx+tGclzcm+sKPO
        11EE0ueBC1OQiZUNyk7aqlEmGQ==
X-Google-Smtp-Source: AGRyM1vl55wMLC6v4FE7361A1EgLL5IjuxGDiU+pOGyn8ZoWrdHGmzM+ZMQkW7lv66vojAGIB7e/MQ==
X-Received: by 2002:a5d:4e04:0:b0:21d:6ec3:38a2 with SMTP id p4-20020a5d4e04000000b0021d6ec338a2mr14182586wrt.362.1657921215858;
        Fri, 15 Jul 2022 14:40:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id j27-20020a05600c1c1b00b0039c4ba160absm17678280wms.2.2022.07.15.14.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:40:15 -0700 (PDT)
Message-ID: <563e92de-68aa-7382-2564-c1ccc270c571@linaro.org>
Date:   Fri, 15 Jul 2022 23:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 06/15] thermal: qcom: qcom-spmi-adc-tm5: convert to IIO
 fwnode API
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        openbmc@lists.ozlabs.org, linux-imx@nxp.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Patrick Venture <venture@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Benson Leung <bleung@chromium.org>,
        Nancy Yuen <yuenn@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
 <20220715122903.332535-7-nuno.sa@analog.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220715122903.332535-7-nuno.sa@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/07/2022 14:28, Nuno Sá wrote:
> Make usage of the new firmware agnostic API
> 'devm_of_iio_channel_get_by_name()' to get the IIO channel.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index d9c9c975f931..0b8543c627f0 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -825,7 +825,8 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>   	}
>   	channel->adc_channel = args.args[0];
>   
> -	channel->iio = devm_of_iio_channel_get_by_name(adc_tm->dev, node, NULL);
> +	channel->iio = devm_fwnode_iio_channel_get_by_name(adc_tm->dev,
> +							   of_fwnode_handle(node), NULL);
>   	if (IS_ERR(channel->iio)) {
>   		ret = PTR_ERR(channel->iio);
>   		if (ret != -EPROBE_DEFER)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
