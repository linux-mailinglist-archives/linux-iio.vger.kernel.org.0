Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D76489AC
	for <lists+linux-iio@lfdr.de>; Fri,  9 Dec 2022 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIUts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Dec 2022 15:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIUts (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2022 15:49:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8CA82FB8
        for <linux-iio@vger.kernel.org>; Fri,  9 Dec 2022 12:49:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bn5so6181039ljb.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2022 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=024DX+2bxKKNOhXWy51UpKLqrEurROJWrWITzj6/Ing=;
        b=AMAxWkH6dXDY+BhjNBCBF4667j6FO92fMaunLeET5MPj9wbXcjSMrjJGHVPjdTs2eF
         upHzHqsMDFefDtJCdCUHJhaqm5xOHP6r4YhvoLinidv8o2Wh13jzHUSmuXs1yeZMba+l
         Z5yKL74L0PDgDW5Ct+724Yf00qYbGI5J19p38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=024DX+2bxKKNOhXWy51UpKLqrEurROJWrWITzj6/Ing=;
        b=fW9+7sMaP+x2gpEYWlm15ncOI0Z9PgVZCaOG+HswZ7eCZRQjkIr77N114cngis0Ir6
         b+mFqwdJRP1iAYHFud7qVHzKLbSeAY8AvZQCbHSd8Xdpwd6zVjTdIjmmOYI8LQPkv78R
         yJV+jGWxEZDbPEbD/ViAnM4+ko+1ZN5XYsfrP5zkGK9eRl+9V7Kutnep5PsQhjlhAob3
         GUGPC9grOrAlqBfkkChkT+x4eGy7LuHXdN5eAT8dEgMMbcwC0MVgyijX61m55cOkLjCx
         5ZGL3qMjKWGuuoh56SpmfFCOtrjblu1oU3pxAcl3X98X0sT3KWttscmg17yT/Gva9L0p
         USOg==
X-Gm-Message-State: ANoB5pnNFAZIhuQIBX0Z1tk0UUDX+9nAsHblWOHU2jCcyLSFpWbAIlcL
        aadBnKwzoRQrLv3UhlHVpC+bNFxzzC9wP8ZSTFuwZ1Z9ygy8vA==
X-Google-Smtp-Source: AA0mqf7ltxEwobxFR98pJKZS8nAr7455KY1zjDo8J7iSeEXXOD7neZk0zuHO2OH+5fGkLTDey6Wsb/Cj1kgi39u+0p0=
X-Received: by 2002:a2e:a367:0:b0:27a:2a6d:73a with SMTP id
 i7-20020a2ea367000000b0027a2a6d073amr707214ljn.27.1670618984699; Fri, 09 Dec
 2022 12:49:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Dec 2022 15:49:44 -0500
MIME-Version: 1.0
In-Reply-To: <20221208184812.53754-1-gwendal@chromium.org>
References: <20221208184812.53754-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 9 Dec 2022 15:49:44 -0500
Message-ID: <CAE-0n53QRknko+ipDFW1DptpJsth0HLpn6SuOMDJC1BBvv3VLg@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx_common: Add old register mapping
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, victording@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-12-08 10:48:12)
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 0e4747ccd3cf7..e8f8c727d2467 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -871,6 +873,8 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>                                         20000, 2000000);
>  }
>
> +extern const struct acpi_device_id sx9324_acpi_match[];
> +

Put this extern in common.h?

> @@ -888,7 +892,10 @@ sx9324_get_default_reg(struct device *dev, int idx,
>         int ret, count, ph, pin;
>         const char *res;
>
> +

Remove?

>         memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
> +       sx_common_get_raw_register_config(dev, sx9324_acpi_match, reg_def);
> +
>         switch (reg_def->reg) {
>         case SX9324_REG_AFE_PH0:
>         case SX9324_REG_AFE_PH1:
> @@ -1116,7 +1123,7 @@ static int sx9324_resume(struct device *dev)
>
>  static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
>
> -static const struct acpi_device_id sx9324_acpi_match[] = {
> +const struct acpi_device_id sx9324_acpi_match[] = {
>         { "STH9324", SX9324_WHOAMI_VALUE },
>         { }
>  };
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 7fa2213d23baf..95c2df36729e2 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -715,6 +715,8 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
>                                        20000, 2000000);
>  }
>
> +extern const struct acpi_device_id sx9360_acpi_match[];
> +

Put this extern in common.h?

> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index d70a6b4f0bf86..ce8f99b6fc3d9 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -424,6 +424,7 @@ static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
>         .postdisable = sx_common_buffer_postdisable,
>  };
>
> +
>  static void sx_common_regulator_disable(void *_data)
>  {
>         struct sx_common_data *data = _data;

Remove this hunk?

> @@ -431,6 +432,31 @@ static void sx_common_regulator_disable(void *_data)
>         regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
>  }
>
> +void sx_common_get_raw_register_config(struct device *dev,
> +               const struct acpi_device_id *acpi_ids,
> +               struct sx_common_reg_default *reg_def)
> +{
> +       const struct acpi_device_id *id;
> +       u32 raw = 0, ret;
> +       char prop[80];
> +
> +       if (!reg_def->property)
> +               return;
> +
> +       for (id = acpi_ids; id->id[0]; id++) {
> +               scnprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s",
> +                               id->id, reg_def->property);
> +               ret = device_property_read_u32(dev, prop, &raw);
> +               if (ret)
> +                       continue;
> +
> +               reg_def->def = raw;
> +               break;
> +       }
> +}
> +EXPORT_SYMBOL_NS_GPL(sx_common_get_raw_register_config, SEMTECH_PROX);
> +
> +

Remove one newline here?

>  #define SX_COMMON_SOFT_RESET                           0xde
>
>  static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> index 5d3edeb75f4e0..ba6472eb9988d 100644
> --- a/drivers/iio/proximity/sx_common.h
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -24,6 +24,7 @@ struct sx_common_data;
>  static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
>
>  struct sx_common_reg_default {
> +       const char *property;

Can you add it at the end of the struct so we don't have to update all
the lines that don't really change? Or is this to save on alignment?

>         u8 reg;
>         u8 def;
>  };
