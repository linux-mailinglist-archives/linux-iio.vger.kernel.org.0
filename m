Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C396154B56F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356250AbiFNQHv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356436AbiFNQHt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 12:07:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689A3150E;
        Tue, 14 Jun 2022 09:07:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me5so18163451ejb.2;
        Tue, 14 Jun 2022 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZw0jF1RzWruPQzSEOS2ghPpQvpmA3rAgfxC+562YQU=;
        b=BZKyF+B5adcc7aQKaDiDdkqRf2ztfmOHaqLbPl+ckeJeejsP0R6c0HLV+VxWK6bPVj
         lKITteq8x2RIWT76F9IsBb5cKbXD9HVq3sNBwhcq7l3440U34J0daYSEtVHAg1kIJgkn
         7HmmFch2spGpSD7Z1O7bcLjKwcILJRq8eAl1QTE+MCe49eNuJ+0V6y3xMkBQspfwIsJR
         qgO21lAD6Fb2krwZqewMLy9ZJWG99JIc4XYF33sbtOR4hAQw4gPx0MqQwcrjeHWzo2sO
         UoT0WvUCaAjjzBiGZAi1SZHd/s8qX9lEsW2BDC3YougF/bKiMWBz/poqncVv3KmWUdW1
         CVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZw0jF1RzWruPQzSEOS2ghPpQvpmA3rAgfxC+562YQU=;
        b=Oydx0DoBJhXjJSKrmSAUUKW1n+AsY2MoyPFHfVlk8NJr6OKnA13iyyWxdABsDLrZty
         SVKMJvDKi85uqWWolyHrRoqpsKu5bK+AVzINZtNvMI93/L/CS+tYdXBCbKZHsWxgUg8a
         ERGipRASL+iPCqwEX7GDfuHMkgVHoZ+LzntoOY2E1JlgFhoZ5qlFM/eYM8/qlomj/vEP
         VjYVO0DbtACJf69liNiMZRkZDYsMRcLvlefmaa1yLdurdQRbtZ7mzWwxmpi6dEqhAb7X
         uyvTmgSvujmVB45mN4541O37ujAdSvTnlxnb8mAoBK71OLqwyJl+SDeBmTf/C0kuOqPJ
         jFbA==
X-Gm-Message-State: AOAM532ZyK8dv387AmvA6dkxBeVOOxSE4Yw7bL65PdaBMxq0AHqLEs33
        KrLfmXUdtojx71fI4FCYv5n9TBDc5yBN9nnvV5o=
X-Google-Smtp-Source: ABdhPJzNKGVdXMp3XNg8fP9gutBnRvANlyRbF/RUzRozg2dO7+ptPp+Qzf9wekl2asAS+fZsxu88c2r7UW4nZ33wdLE=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr5031903ejh.497.1655222866932; Tue, 14 Jun
 2022 09:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220614151722.2194936-1-sravanhome@gmail.com> <20220614151722.2194936-4-sravanhome@gmail.com>
In-Reply-To: <20220614151722.2194936-4-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 18:07:09 +0200
Message-ID: <CAHp75VdwA0Hk_Eiku74O6b5fAM4znhTO5DFGEbh85DW05vT77g@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: mp2629: restrict input voltage mask for mp2629
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 14, 2022 at 5:17 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> add support for mp2733 which is updated version of mp2629
> with higher range of input voltage.

a higher

...

> +               if (chan->channel == MP2629_INPUT_VOLT &&
> +                   ddata->chip_id == CHIP_ID_MP2629)
>                         rval &= GENMASK(6, 0);

> +

(Semi-?)stray change. Up to you and Jonathan.

>                 *val = rval;


-- 
With Best Regards,
Andy Shevchenko
