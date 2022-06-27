Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6860155D89F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiF0Mgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiF0Mgf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 08:36:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697EDF10
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 05:36:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k22so12863281wrd.6
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i1ndzNgCY4GqkVEeX6RYo9rjFL0JkDe5I7FI/QcOSjM=;
        b=Kfo3AdhOwldgdZ27USi62BeBQlR9du9sDVboRXzq5ECBOFl408Bkc7ZLPNhPOd+LI5
         t+skT06kwKkuFjVR0dowaN5FwY45YGwaDIsLp87OBsz6bQ/vtZCF2h+drDvHvSzB5IA4
         1qr7EAd7Rs8GOPnJUAsSjBRhNo5+OQbuHFWp6p1um9pu2eMAi2Dh/ys0xiH/pDjs8fGR
         dbSVkM9lVsuN/jvEnbCC/vivLPXQn1P+NIQbs5Ep8msLKSkCVi4kxGiRmGlkHWWnM2y+
         pxqLTEZcs6/nneQTWNpNKtzCDfI9hLcRgsRiAobmzylaSGyL0+0pVP0W9nCTgm8T+mgk
         C3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i1ndzNgCY4GqkVEeX6RYo9rjFL0JkDe5I7FI/QcOSjM=;
        b=UlMNNrtj4J/ZZ7T29esoG+qCv2AGwXomJePnAadpsDuDPQhAaYld/mVMwUGevflW1R
         gv9amHuFmAGoOg9bKaWvgvO2hkosHDTu93QNkmNkg0ogEQEiwoQEekQifUNsIRzDrK/d
         lfdvYdyFdBwelUzd/Z6ZCeotz527R1flQzgoRalBME2bG8p3BT65BjeCVKCw2/MQcbkz
         iS4Svre32vf4yZXS0ssQsfmhk0Jjf2kIATdaYqCo3kRjif6iboDM+txvbJn81L6a/pNs
         RKDbG6bNixpRUmR/V4L1X6Ah8F1QKfHgpRsDNE/0sWh8lWobql4d5xsFya1Lp81TINlS
         vkeg==
X-Gm-Message-State: AJIora9GXTPo1xdh7dwJnZjF+H6K1Cof1anOyAYeubcyplwzqtQsXvFb
        P36iOgQfMDiUavXBc/b9U8iokg==
X-Google-Smtp-Source: AGRyM1stzio1TY+sexJ0uCww5Nmk/BPGjw9oft61lO5oZjJtB5x0jk41hl29kaB9wKgzj5JxAFjubA==
X-Received: by 2002:a05:6000:15ca:b0:21b:baca:5902 with SMTP id y10-20020a05600015ca00b0021bbaca5902mr12689887wry.294.1656333392022;
        Mon, 27 Jun 2022 05:36:32 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c158400b0039c457cea21sm12501452wmf.34.2022.06.27.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:36:31 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:36:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mfd: mp2629: Add support for mps mp2733 battery
 charger
Message-ID: <YrmkTSnOjB7tlGM/@google.com>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615145357.2370044-4-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jun 2022, Saravanan Sekar wrote:

> mp2733 is updated version of mp2629 battery charge management
> device for single-cell Li-ion or Li-polymer battery. Additionally
> supports USB fast-charge and higher range of input voltage.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/mfd/mp2629.c       | 5 ++++-
>  include/linux/mfd/mp2629.h | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
