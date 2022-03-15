Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798104DA671
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 00:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352649AbiCOXvS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Mar 2022 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345401AbiCOXvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2022 19:51:17 -0400
X-Greylist: delayed 1400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 16:50:04 PDT
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.51.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6D32C13A
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 16:50:04 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 7554F19CD
        for <linux-iio@vger.kernel.org>; Tue, 15 Mar 2022 18:26:44 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id UGYun7BWPRnrrUGYundI1Y; Tue, 15 Mar 2022 18:26:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FMz4dv/MLCPqxMquT9pFk6KUEVB5ed9lWVOqB/G2Qsw=; b=5lgvZgsRcs9SGWnnx6JtY06wdS
        zNXTyuY4WPr1wuvZdRXTiodbvM++DqqAvJyC19CA1efn2LGgFXA5qswXI8+H5ekOniOW4LesN/j9c
        MOLxvpN0OUjSoIQtD2nynya5Z+MpWX7hY0+xSke5stHgb/hj87kik5FoJ+WSanS7i4229VDCICafa
        FpS6GM3T4sp7pPNRFf1ZKKt7C2hqPvlWWwBvComWpmZ8BAlO2Uh4UK6DwxqNpaxM51BUQSCIFiM/u
        ZNCUOiYA+JF/3hjMpkpc9Whgk7qsXtGL4Z09OfHF1aVB6HSuN8siwqS7wVzAwtMpZY6c+Z9LoMT+5
        fWYrEG3A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54298)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nUGYs-002Vpc-Bh; Tue, 15 Mar 2022 23:26:42 +0000
Message-ID: <4af362d3-999d-cc3c-50e2-5a91d888f09f@roeck-us.net>
Date:   Tue, 15 Mar 2022 16:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 03/16] hwmon: Make use of devm_clk_get_enabled()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?Andr=c3=a9_Gustavo_Nakagomi_Lopez?= <andregnl@usp.br>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
 <20220314141643.22184-4-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220314141643.22184-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nUGYs-002Vpc-Bh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54298
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 7
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/14/22 07:16, Uwe Kleine-König wrote:
> Several drivers manually register a devm handler to disable their clk.
> Convert them to devm_clk_get_enabled().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Let's see if it goes anywhere this time.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/axi-fan-control.c | 15 +--------------
>   drivers/hwmon/ltc2947-core.c    | 17 +----------------
>   drivers/hwmon/mr75203.c         | 26 +-------------------------
>   drivers/hwmon/sparx5-temp.c     | 19 +------------------
>   4 files changed, 4 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
> index d2092c17d993..ce404ed9c53e 100644
> --- a/drivers/hwmon/axi-fan-control.c
> +++ b/drivers/hwmon/axi-fan-control.c
> @@ -393,11 +393,6 @@ static int axi_fan_control_init(struct axi_fan_control_data *ctl,
>   	return ret;
>   }
>   
> -static void axi_fan_control_clk_disable(void *clk)
> -{
> -	clk_disable_unprepare(clk);
> -}
> -
>   static const struct hwmon_channel_info *axi_fan_control_info[] = {
>   	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
>   	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_LABEL),
> @@ -477,20 +472,12 @@ static int axi_fan_control_probe(struct platform_device *pdev)
>   	if (IS_ERR(ctl->base))
>   		return PTR_ERR(ctl->base);
>   
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(clk)) {
>   		dev_err(&pdev->dev, "clk_get failed with %ld\n", PTR_ERR(clk));
>   		return PTR_ERR(clk);
>   	}
>   
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev, axi_fan_control_clk_disable, clk);
> -	if (ret)
> -		return ret;
> -
>   	ctl->clk_rate = clk_get_rate(clk);
>   	if (!ctl->clk_rate)
>   		return -EINVAL;
> diff --git a/drivers/hwmon/ltc2947-core.c b/drivers/hwmon/ltc2947-core.c
> index 5423466de697..626f5bf2c9c7 100644
> --- a/drivers/hwmon/ltc2947-core.c
> +++ b/drivers/hwmon/ltc2947-core.c
> @@ -956,13 +956,6 @@ static struct attribute *ltc2947_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(ltc2947);
>   
> -static void ltc2947_clk_disable(void *data)
> -{
> -	struct clk *extclk = data;
> -
> -	clk_disable_unprepare(extclk);
> -}
> -
>   static int ltc2947_setup(struct ltc2947_data *st)
>   {
>   	int ret;
> @@ -989,7 +982,7 @@ static int ltc2947_setup(struct ltc2947_data *st)
>   		return ret;
>   
>   	/* check external clock presence */
> -	extclk = devm_clk_get_optional(st->dev, NULL);
> +	extclk = devm_clk_get_optional_enabled(st->dev, NULL);
>   	if (IS_ERR(extclk))
>   		return dev_err_probe(st->dev, PTR_ERR(extclk),
>   				     "Failed to get external clock\n");
> @@ -1007,14 +1000,6 @@ static int ltc2947_setup(struct ltc2947_data *st)
>   			return -EINVAL;
>   		}
>   
> -		ret = clk_prepare_enable(extclk);
> -		if (ret)
> -			return ret;
> -
> -		ret = devm_add_action_or_reset(st->dev, ltc2947_clk_disable,
> -					       extclk);
> -		if (ret)
> -			return ret;
>   		/* as in table 1 of the datasheet */
>   		if (rate_hz >= LTC2947_CLK_MIN && rate_hz <= 1000000)
>   			pre = 0;
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 1ba1e3145969..0c691f291a64 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -461,24 +461,6 @@ static int pvt_get_regmap(struct platform_device *pdev, char *reg_name,
>   	return 0;
>   }
>   
> -static void pvt_clk_disable(void *data)
> -{
> -	struct pvt_device *pvt = data;
> -
> -	clk_disable_unprepare(pvt->clk);
> -}
> -
> -static int pvt_clk_enable(struct device *dev, struct pvt_device *pvt)
> -{
> -	int ret;
> -
> -	ret = clk_prepare_enable(pvt->clk);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, pvt_clk_disable, pvt);
> -}
> -
>   static void pvt_reset_control_assert(void *data)
>   {
>   	struct pvt_device *pvt = data;
> @@ -515,16 +497,10 @@ static int mr75203_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	pvt->clk = devm_clk_get(dev, NULL);
> +	pvt->clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(pvt->clk))
>   		return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
>   
> -	ret = pvt_clk_enable(dev, pvt);
> -	if (ret) {
> -		dev_err(dev, "failed to enable clock\n");
> -		return ret;
> -	}
> -
>   	pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
>   	if (IS_ERR(pvt->rst))
>   		return dev_err_probe(dev, PTR_ERR(pvt->rst),
> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
> index 98be48e3a22a..04fd8505e5d6 100644
> --- a/drivers/hwmon/sparx5-temp.c
> +++ b/drivers/hwmon/sparx5-temp.c
> @@ -26,13 +26,6 @@ struct s5_hwmon {
>   	struct clk *clk;
>   };
>   
> -static void s5_temp_clk_disable(void *data)
> -{
> -	struct clk *clk = data;
> -
> -	clk_disable_unprepare(clk);
> -}
> -
>   static void s5_temp_enable(struct s5_hwmon *hwmon)
>   {
>   	u32 val = readl(hwmon->base + TEMP_CFG);
> @@ -113,7 +106,6 @@ static int s5_temp_probe(struct platform_device *pdev)
>   {
>   	struct device *hwmon_dev;
>   	struct s5_hwmon *hwmon;
> -	int ret;
>   
>   	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
>   	if (!hwmon)
> @@ -123,19 +115,10 @@ static int s5_temp_probe(struct platform_device *pdev)
>   	if (IS_ERR(hwmon->base))
>   		return PTR_ERR(hwmon->base);
>   
> -	hwmon->clk = devm_clk_get(&pdev->dev, NULL);
> +	hwmon->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(hwmon->clk))
>   		return PTR_ERR(hwmon->clk);
>   
> -	ret = clk_prepare_enable(hwmon->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(&pdev->dev, s5_temp_clk_disable,
> -				       hwmon->clk);
> -	if (ret)
> -		return ret;
> -
>   	s5_temp_enable(hwmon);
>   
>   	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,

