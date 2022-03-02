Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33C84CACE7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Mar 2022 19:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiCBSFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244283AbiCBSFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 13:05:23 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A43CA4F;
        Wed,  2 Mar 2022 10:04:39 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id l25so2428870oic.13;
        Wed, 02 Mar 2022 10:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKMQkGeL8hSEJHjE1ly5n4/Lmb0Jg4MK9h9Z9NR67z0=;
        b=Sj+X2ZvOkQ9xdGiEIbXorlfZqauxyI/KMAeawyLOA1bQ/JFqy5Mv8i8NHp04XmKo5/
         yYzFNTbma3Mr6DUR6Mfbp5FL7yTZsZQc8iXn8eHUsg5Mbo+xfMAniXRZGUROnria+m4/
         e07n10sW2iQWlL8qAinEKT8yxbqtjOJafgooD9vD/yQcsTqxgUdjugbzpt8/GIJHW/kB
         zbjo13Y3kzz68v7sHYqejBMQT/LOXEUHgqg2wqbXKcvwnwFzhB1oGW43RqOuOSCXMj4H
         hi/ESqxCoehIB5yaz2BeTjb5Fp7nwYlvaueRNWJDruTHf7DcEAHw+Bl4PmBGgjq8H24W
         2kVg==
X-Gm-Message-State: AOAM531nW5lt6/F6YeIIdw9ix/pGHWhqezmjlqSAyFn+/xZF3Jkx8HlX
        soypGqKGz1QMSNL5dEXcgWVbwMr3dA==
X-Google-Smtp-Source: ABdhPJx8L8MF5QsuehmfjzHb5fwFctMBiii9azFP6XwyZYEd2AHJmRwIVDs1XD/pPfVZjR2OZ8Kbbw==
X-Received: by 2002:a05:6808:13d6:b0:2d6:7f1a:9390 with SMTP id d22-20020a05680813d600b002d67f1a9390mr921148oiw.159.1646244279294;
        Wed, 02 Mar 2022 10:04:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w5-20020a4a5d05000000b0031c67a9b54bsm8082255ooa.45.2022.03.02.10.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:04:37 -0800 (PST)
Received: (nullmailer pid 3974426 invoked by uid 1000);
        Wed, 02 Mar 2022 18:04:36 -0000
Date:   Wed, 2 Mar 2022 12:04:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: st,st-sensors add LIS302DL
Message-ID: <Yh+xtBrEal111OVO@robh.at.kernel.org>
References: <20220301225432.60844-1-absicsz@gmail.com>
 <20220301225432.60844-2-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301225432.60844-2-absicsz@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 02, 2022 at 12:54:30AM +0200, Sicelo A. Mhlongo wrote:
> Update st,st-sensors bindings for STMicroelectronics LIS302DL variant
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
