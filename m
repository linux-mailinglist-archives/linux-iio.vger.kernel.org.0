Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097647505B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 02:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhLOBN1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 20:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhLOBN0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 20:13:26 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7342DC061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:13:26 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso23037095otf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lbRR0F/43b8/gyB2hjn6VY9EQ0CQtAXhBmCsvvSUlJo=;
        b=MlUABH6Dnqea2ga1h5EQESO6FYLC9eKZRITXXzuvO5lC/TjdVzmHSRxTetWmrq/kfq
         F0iRqJj+wS390viJa/nAMVaQU6O9zOhdJ44os+7P7iiSKGSndRXMgTURDuWFeHHZuhsk
         985E8fOmg34oJRU0I0CUtbk5N731pSUrlQ7Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lbRR0F/43b8/gyB2hjn6VY9EQ0CQtAXhBmCsvvSUlJo=;
        b=CE+zj/8jtu4Xu+4vi7E6ofSnixIJB+mpIlwT81/huhQV4gsO88VGSwXnupMH8uxSPB
         hp7fWvWqAsg+zSc43+85slVDAkpG9hVNA8hZtQZsfr0BXkAWK+akP7EHhF3CU280VOTU
         JfnvSb3bTPN/s1CLVemm4vtYb25zmDbm4b1/Yxax0w0BcmD2hRrXV8Cl2B3awutaRjaG
         Uc/Q9TOkOoZmraiSOdTi1qr8mXIXf8oo8do8FG/KvMuOKV59hTXvaA08tbJ5Fss/wzto
         Zie1W54LrNF6NXvWPvdc/U8sRJbrTeUtRopIopqurk/bvIZkACblhMbtFkr/Gg3jPvf1
         ZXYw==
X-Gm-Message-State: AOAM532ENohdabGYNsK2Ucf+rvAqOpneSMdxHeqypzk0QWh7mEOepJ22
        +mETCO23xfvSniVlfMJU2q5qfVtBxMC5MQT5NECcoA==
X-Google-Smtp-Source: ABdhPJz3V5bn/6ygn+RCFzKoAu5fyFXF1a/nE8aUoJZMq4skSgN0D1EzER+QrC+Y5kVlg2ZApeBpbNr8cXlMToJO1G8=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr6934950ota.126.1639530805844;
 Tue, 14 Dec 2021 17:13:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 02:13:25 +0100
MIME-Version: 1.0
In-Reply-To: <20211210192328.2844060-6-gwendal@chromium.org>
References: <20211210192328.2844060-1-gwendal@chromium.org> <20211210192328.2844060-6-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 02:13:25 +0100
Message-ID: <CAE-0n51VSmRNiNeU09ygGmWfyg2F8DN4ujf9gUv4c3QRsmdLHA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] iio: sx9324: Add dt_binding support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-12-10 11:23:28)
> Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
> retrieving sensor hardware property and alter default values.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index ed7ac30e1915d5..78a173aeccf5ac 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -77,6 +77,7 @@
>  #define SX9324_REG_PROX_CTRL0          0x30
>  #define SX9324_REG_PROX_CTRL0_GAIN_MASK        GENMASK(5, 3)
>  #define SX9324_REG_PROX_CTRL0_GAIN_1           0x80
> +#define SX9324_REG_PROX_CTRL0_RAWFILT_MASK     GENMASK(2, 0)
>  #define SX9324_REG_PROX_CTRL0_RAWFILT_1P50     0x01
>  #define SX9324_REG_PROX_CTRL1          0x31
>  #define SX9324_REG_PROX_CTRL2          0x32
> @@ -753,6 +754,74 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
>         return -EINVAL;
>  }
>
> +static const struct sx_common_reg_default sx9324_default_regs[] = {
> +       { SX9324_REG_IRQ_MSK, 0x00 },
> +       { SX9324_REG_IRQ_CFG0, 0x00 },
> +       { SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
> +       { SX9324_REG_IRQ_CFG2, 0x00 },
> +       { SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
> +       /*
> +        * The lower 4 bits should not be set as it enable sensors measurements.
> +        * Turning the detection on before the configuration values are set to
> +        * good values can cause the device to return erroneous readings.
> +        */
> +       { SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
> +
> +       { SX9324_REG_AFE_CTRL0, 0x00 },
> +       { SX9324_REG_AFE_CTRL3, 0x00 },
> +       { SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> +               SX9324_REG_AFE_CTRL4_RES_100 },
> +       { SX9324_REG_AFE_CTRL6, 0x00 },
> +       { SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> +               SX9324_REG_AFE_CTRL4_RES_100 },
> +
> +       /* TODO(gwendal): PHx use chip default or all grounded? */
> +       { SX9324_REG_AFE_PH0, 0x29 },
[...]
> +       { SX9324_REG_ADV_CTRL11, 0x00 },
> +       { SX9324_REG_ADV_CTRL12, 0x00 },
> +       /* TODO(gwendal): SAR currenly disabled */

s/currenly/currently/

Is there a plan to resolve these todos? Or should they simply be
removed and then we can deal with the defaults?

> +       { SX9324_REG_ADV_CTRL13, 0x00 },
> +       { SX9324_REG_ADV_CTRL14, 0x00 },
