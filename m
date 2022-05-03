Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60A1517B67
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiECBMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 May 2022 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiECBMN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2022 21:12:13 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6903388E
        for <linux-iio@vger.kernel.org>; Mon,  2 May 2022 18:08:34 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id g21so17629806iom.13
        for <linux-iio@vger.kernel.org>; Mon, 02 May 2022 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J01ulpJYuD85Ua2b4Z3CSKv7anNmbjAMoLL+x9ZEpM=;
        b=NClZTO1lrag4qnroLMDkkbP3isGuZ96PhtjlMZj1F0gnm+ax+Xj8U85biRRxbeFUy4
         7Z39bmQ2sP99StT//gfXtj6MyuFynilZ67Oy2Rcy/kmmSvIlLx/hnwdjd7B3x4zlomA2
         b6kgxvm8ub5U1185hSRCTnkl4b+ME1h+jNO00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J01ulpJYuD85Ua2b4Z3CSKv7anNmbjAMoLL+x9ZEpM=;
        b=a6CAu84aG5QaySQuGHtpm6azhZRSYmFug1vI/jovRyIdQYhcsgpdPdtFWmqweR2Rbm
         MYXu3v3Iq3SWw2lqkmNJR3dtjph9qn+Wo4oUqUorw1MJX6hzzJnXbCJUyP4IMMSdx4S+
         0x/eAyZEFnYJb5O8GRgs4FdYOiH1II7FNXX6dNhw9v0OaJDgqR71YA9trARYhXBHbVqa
         xknLBStiImpAxtmMXzya6WPX9ZDmLkNOugy5BX4gPIYqmVKgFOdgTvt3KxkMBbh46vTO
         tRTmSoQPQXiX4IaZzJkqyrvCBJDBS532Zq1ly2Krvpn4xoqpzw4kAo51QcMYfATnJFaj
         Hgog==
X-Gm-Message-State: AOAM533gMB/ldYIFwD0yHRP0lx8Au6Dcg9rE+GFz0x3dQN9nqiYez0yz
        xuo+BmJJ/6PqqyPzAB1EUdb+7alRCZm40CE8IpR3ADVAdFWvEw==
X-Google-Smtp-Source: ABdhPJwRFgrMh1pooiPeQoY3V/x6VQ9V4gTsYXNEYYLcxTsk9rJSzar3B8D3rxcceDM7NfH0Ukgctl/xhPy5vBiLNuw=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr5054846ion.63.1651539057290; Mon, 02
 May 2022 17:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220503004156.3559940-1-swboyd@chromium.org> <20220503004156.3559940-3-swboyd@chromium.org>
In-Reply-To: <20220503004156.3559940-3-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 2 May 2022 17:50:46 -0700
Message-ID: <CAPUE2uvQ0cg0HJ5GrCtUR0v2+BKtSD044NEjB-eGJXS8fExBcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: sx9324: Add setting for CS idle mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

On Mon, May 2, 2022 at 5:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Based on device tree setting, set the CS idle mode.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 7f367f63e362..79683f0d4e9a 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -57,6 +57,11 @@
>         GENMASK(SX9324_REG_AFE_CTRL0_RINT_SHIFT + 1, \
>                 SX9324_REG_AFE_CTRL0_RINT_SHIFT)
>  #define SX9324_REG_AFE_CTRL0_RINT_LOWEST       0x00
> +#define SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT      4
> +#define SX9324_REG_AFE_CTRL0_CSIDLE_MASK \
> +       GENMASK(SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT + 1, \
> +               SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT)
> +#define SX9324_REG_AFE_CTRL0_RINT_LOWEST       0x00
>  #define SX9324_REG_AFE_CTRL1           0x21
>  #define SX9324_REG_AFE_CTRL2           0x22
>  #define SX9324_REG_AFE_CTRL3           0x23
> @@ -872,6 +877,8 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  {
>         static const char * const sx9324_rints[] = { "lowest", "low", "high",
>                 "highest" };
> +       static const char * const sx9324_csidle[] = { "hz", "hz", "gnd",
> +               "vdd" };
>  #define SX9324_PIN_DEF "semtech,ph0-pin"
>  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
>  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> @@ -901,6 +908,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
>                 reg_def->def = raw;
>                 break;
>         case SX9324_REG_AFE_CTRL0:
> +               ret = device_property_read_string(dev,
> +                               "semtech,cs-idle-sleep", &res);
> +               if (!ret)
> +                       ret = match_string(sx9324_csidle, ARRAY_SIZE(sx9324_csidle), res);
> +               if (ret >= 0) {
> +                       reg_def->def &= ~SX9324_REG_AFE_CTRL0_CSIDLE_MASK;
> +                       reg_def->def |= ret << SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT;
> +               }
> +
>                 ret = device_property_read_string(dev,
>                                 "semtech,int-comp-resistor", &res);
>                 if (ret)
> --
> https://chromeos.dev
>
