Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7014858C792
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiHHLed (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLec (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:34:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A32EE2D;
        Mon,  8 Aug 2022 04:34:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z7so808085qki.11;
        Mon, 08 Aug 2022 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3j06vb12dhjHnbn8BSngYVpkNm+JImIYoKR1fArmBfA=;
        b=Sf6NPZS+Y9i2bIgZTc1KC/tBYFOajMFP0P2kaWoabw1FNiF7oWnpUia+kfa8GC+HFh
         0hIGwqHguyiAd4Wrk0FDbX270LVqPJlMsxP/vxtxRKO9rdxhHS5m47j/Pi0IrWrHUVEX
         dHCKoEJDNJewRzutffRtN19gVcor8D0xl/DWKyjhodeMtKJrhx5QonpbblCZvHzwjeyW
         T1veBelUj5IjDUIGmdJHQDIMwLH1D8Jm3aZV0tHvYyOhl4cF4ft0Rdu0kIeSiDJy4t24
         A9EYVPMWpBakEhqKQCYRKSgdg8bd86xE+K/CTreLNISCLMT3migsY5VkIGdiQhBuzGMZ
         iFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3j06vb12dhjHnbn8BSngYVpkNm+JImIYoKR1fArmBfA=;
        b=0m4SFdfyJmrKX6lXq5z0bQAl3pw6ZhOVy9neo2aUF6IwIXHu46Cgn6Ts+yvoHQYYAJ
         /ZZFJQIq15yDqFvG1i0oQl2QuHByHO7Kq/bxyfISZXOoQAvPWjTCNXPWUV+N6t4k/wx1
         oWfpe4vAaaGOjKIgqnfW6k1g70TbDmxkkwUgYKtwFsOqeuPeiSRMDz3kSx62a0WHRGmx
         H8FYn0HQCoDzWc1hscSdgfgd0PviCXWsumqUFdeBhZYxGQ8K+Ku0iEHNFkopJvud1DsL
         ZJbDi0SwYR8xoYPh7E3PXB1Sy99w5eHngSIrTWpLF6rc5OpMwrU6kVL3Et+51/1wjk5C
         L6Hg==
X-Gm-Message-State: ACgBeo05pCD341MopKisYhfYnTDhPNK1rzmLJPlZ86ziFaZMQTLvTU9c
        +YsGhxSFNICNcf7xfj4WPkbR/qbml6X43VJDt2k=
X-Google-Smtp-Source: AA6agR55pS+29YKX9ehOCqLfBPkht1D/6ebskcR/uUAtXlQAtvl2W6fZ0pUV0eKSL70iQQh1K7sm7HgSeIKlhlgaf+E=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr14063691qkp.734.1659958469930; Mon, 08
 Aug 2022 04:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <1e1555dd2aee1636f4657899c20a9a92b4fe2d80.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <1e1555dd2aee1636f4657899c20a9a92b4fe2d80.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:33:53 +0200
Message-ID: <CAHp75Vfzg=vEf_GPO=o3805Nstp-7pdnSEJh6jyUHjzYO4Ejnw@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] iio: magnetometer: yas530: Add IIO scaling to "chip_info"
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
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

On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Add IIO scaling to the "chip_info" structure to ease the handling to
> different YAS variants.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 28 ++++++------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 914f7f0a243e..262a36c31616 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -142,6 +142,7 @@ struct yas5xx;
>   * @version_name: version letter or naming
>   * @volatile_reg: device-specific volatile registers
>   * @volatile_reg_qty: quantity of device-specific volatile registers
> + * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
>   */
>  struct yas5xx_chip_info {
>         unsigned int devid;
> @@ -149,6 +150,7 @@ struct yas5xx_chip_info {
>         const char * const *version_name;
>         const int *volatile_reg;
>         int volatile_reg_qty;
> +       u32 scaling_val2;
>  };
>
>  /**
> @@ -514,27 +516,8 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>                 }
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
> -               switch (yas5xx->chip_info->devid) {
> -               case YAS530_DEVICE_ID:
> -                       /*
> -                        * Raw values of YAS530 are in picotesla. Divide by
> -                        * 100000000 (10^8) to get Gauss.
> -                        */
> -                       *val = 1;
> -                       *val2 = 100000000;
> -                       break;
> -               case YAS532_DEVICE_ID:
> -                       /*
> -                        * Raw values of YAS532 are in nanotesla. Divide by
> -                        * 100000 (10^5) to get Gauss.
> -                        */
> -                       *val = 1;
> -                       *val2 = 100000;
> -                       break;
> -               default:
> -                       dev_err(yas5xx->dev, "unknown device type\n");
> -                       return -EINVAL;
> -               }
> +               *val = 1;
> +               *val2 = yas5xx->chip_info->scaling_val2;
>                 return IIO_VAL_FRACTIONAL;
>         default:
>                 /* Unknown request */
> @@ -959,6 +942,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .version_name = yas5xx_version_names[yas530],
>                 .volatile_reg = yas530_volatile_reg,
>                 .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 = 100000000, /* picotesla to Gauss */
>         },
>         [yas532] = {
>                 .devid = YAS532_DEVICE_ID,
> @@ -966,6 +950,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .version_name = yas5xx_version_names[yas532],
>                 .volatile_reg = yas530_volatile_reg,
>                 .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 = 100000, /* nanotesla to Gauss */
>         },
>         [yas533] = {
>                 .devid = YAS532_DEVICE_ID,
> @@ -973,6 +958,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .version_name = yas5xx_version_names[yas533],
>                 .volatile_reg = yas530_volatile_reg,
>                 .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
> +               .scaling_val2 = 100000, /* nanotesla to Gauss */
>         },
>  };
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
