Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A374FEC1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jul 2023 07:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGLFhr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jul 2023 01:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGLFhq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jul 2023 01:37:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5E41724
        for <linux-iio@vger.kernel.org>; Tue, 11 Jul 2023 22:37:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso10612045e87.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Jul 2023 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689140263; x=1691732263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pDAwsES6/UJGMRnoH6Hw6ybZSO8OTJt1TeRcdDP7sc=;
        b=aJtz6FNUeRcV1954EDvaz2DjKt0ooaO6XkF2f3HAIeuTpNylBKocZGx7tyt82eKCax
         7j7TZayLViSKP/vwaG3NeGCXPvnFPyrIDLAKW21qpfmNLkLKWWxeeKFrrMN0R6hPEjMw
         wsduODQAySQvq2EIzb8Wm7C6A39Dx4oGk+QHjfl0pgeuXAswYseoLyzux4tUtWep1tJX
         BcbIXcuSCT3VsvHyFourgbu1CeukdgF6/42swclh+kWobVB3xigJAhvgk9tux9iMsvuX
         i/W/weC7ErGg/PlyhkROoAAxXYSFYA6O6F+p2X/QS8QcROfF22lnWdCc/AExjAk1ySUY
         reXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140263; x=1691732263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pDAwsES6/UJGMRnoH6Hw6ybZSO8OTJt1TeRcdDP7sc=;
        b=WRyA14dnSPL15xVNoUUcYt9kiuE+qTwq7zNLqPz/KJ+68vdR/A7I9mm+oo3pyHfjNI
         2dYx2nMZLa0o1+QVbSGuZxpwHazHsbBscsNRk9TtzRpv9NX+hO0SM5NcGcevFci4jAJU
         fGy3NtA0liHQSBMjF0QNmmM1fn2TiRrxJKlJi8+hP3G57dhndowPiOGJTJqUEkBH5Zaw
         yDcG21zg2VB9XElT7LaI80qejPnTUd7A7Bizk6H2OIGwDQlbl3awD6kMClCrFdQTtpqO
         NfhG0BySAe6awvDLJy5God2lg02fU0/SwvJ+aE/JTOqQyvx4EN626tk3YNYmGP4ebTKD
         6nwA==
X-Gm-Message-State: ABy/qLbpz2b36DrV0HpO5LLVbMxo/aftSo+llWsjgNCX8zf+Cf2K0eZz
        4mDuiHr4N56DMj74gfBZOezR+A==
X-Google-Smtp-Source: APBJJlEwqhkXOyt65V84KWLF0TrTw7ci9mw3/uJcSEo60JbAasj5LSNrmdrbPO3QWDCuzxL6PufJWg==
X-Received: by 2002:ac2:51bb:0:b0:4fb:90c6:c31a with SMTP id f27-20020ac251bb000000b004fb90c6c31amr12514057lfk.14.1689140262956;
        Tue, 11 Jul 2023 22:37:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7ce12000000b0051ddfb4385asm2199187edv.45.2023.07.11.22.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:37:42 -0700 (PDT)
Message-ID: <b3723443-2a27-0a51-babd-b36eef095913@linaro.org>
Date:   Wed, 12 Jul 2023 07:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/4] iio: adc: Kconfig change description for Allwinner
 GPADC
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-iio@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
 <20230619154252.3951913-2-bigunclemax@gmail.com>
 <2148594.irdbgypaU6@jernej-laptop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2148594.irdbgypaU6@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/07/2023 20:14, Jernej Škrabec wrote:
> Dne ponedeljek, 19. junij 2023 ob 17:42:24 CEST je Maksim Kiselev napisal(a):
>> This patch adds SoCs names to Allwinner GPADC description to
>> make it more informative.
> 
> Please reword to remove "This patch".
> 
>>
>> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> 
> I'm fine with the patch in general, but does this really warrant fixes tag?
> 

No, it's some fake fix. There is no bug here.

Best regards,
Krzysztof

