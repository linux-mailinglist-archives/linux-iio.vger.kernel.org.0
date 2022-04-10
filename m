Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C94FAE27
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiDJOPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 10:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiDJOPX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 10:15:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3730E1838C
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 07:13:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t25so2610033edt.9
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiASZOpaKbZxgV4H6ymmLMIpeUeD2grL6bPTvrqRDEQ=;
        b=J8aDzh+6zd1HqOKxGM9WIGr6ghhEqQ12QBvdfpPL02nl/n+7mepixuLqs+nhlnEkjI
         zFx1YKACl6UgKolZ4ZhSTEmJlRlZEmIOVTe0HdFIGsl1mBEUN+UXXTMWJOORBQkyU9Ot
         Op62VrEYa9zN4yzNCKQXt3a0RRjlB+znSH9VpvsEX+HsY/o9xuDKWX2WfydO/o8sVYIu
         Lx+BPlN6OnaRnV6ZvaIVAt6Icio5dsYIGtobtnPRtGUROK32BMBP4VGWwNosttXQW9jO
         YC9sjt7dMf94dAkwRQl4WU2oNJ5LmlIbh6rsCejZa5PWzM5uMcgmYitsQnN8UECjZdz1
         B3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiASZOpaKbZxgV4H6ymmLMIpeUeD2grL6bPTvrqRDEQ=;
        b=sRQFKksVic/1QbmC50kEo3TuO38Gff6U8wKm0onQwrm2QJHf4NW7SohtA4dqxjcdTY
         n0vsf0tL7fcivDxJwrFhdtVsBSyiFlSUdHEafX+0pprqLJ/GRTpZXSGtKVW3REtHkLdd
         eu/nN4+054hYhd7eXNiGaUVXBL9Pb6EyQ8nRxZOE9OlRnha/KU4uOztwQX22CXI60ogY
         rxWLMN3TA22w8xRzv49+Q1g42Zv3O+U5hKbiPOJtYHr2bR3yPff2kgWb8m8AziMjLofG
         fIdUYzcZC0lWF+jnIF9raR44OID9mR66MGwnNWfvn7lc4Va3V/h5tCib/rDfT7CUL1c+
         jPUQ==
X-Gm-Message-State: AOAM53345tmnlp/xhBsEEOipprJQV4EmXQOgQsUG7AY07RVPry18JGWC
        XQ1oHO7v4G2B4n6g8edVEWrxtFcHu7zuGOdBHGg=
X-Google-Smtp-Source: ABdhPJxfFKMXJ/psFh+PMhl6ZCAC5Tx24l19zOHf/fHgNxC1A7hIa4NYb7d9rwsWmY7co+6XfmS0nzO6vvBJjM82UlY=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr28682489ede.218.1649599989584; Sun, 10
 Apr 2022 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220409105812.2113895-1-lars@metafoo.de>
In-Reply-To: <20220409105812.2113895-1-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Apr 2022 17:12:33 +0300
Message-ID: <CAHp75VeVVbWL80S8JZd3-d5z9iW6g-xwrsU-oykHgg6GEOc5RA@mail.gmail.com>
Subject: Re: [PATCH] iio: Replace strtobool() with kstrtobool()
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
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

On Sat, Apr 9, 2022 at 1:58 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> strtobool() is deprecated and just a wrapper around kstrtobool().Replace
> it with kstrtobool() so the deprecated function can be removed eventually.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/ad7192.c                                  | 4 ++--
>  drivers/iio/adc/ad7280a.c                                 | 2 +-
>  drivers/iio/adc/ina2xx-adc.c                              | 2 +-
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  drivers/iio/dac/ad5064.c                                  | 2 +-
>  drivers/iio/dac/ad5360.c                                  | 2 +-
>  drivers/iio/dac/ad5380.c                                  | 2 +-
>  drivers/iio/dac/ad5446.c                                  | 2 +-
>  drivers/iio/dac/ad5504.c                                  | 2 +-
>  drivers/iio/dac/ad5624r_spi.c                             | 2 +-
>  drivers/iio/dac/ad5686.c                                  | 2 +-
>  drivers/iio/dac/ad5755.c                                  | 2 +-
>  drivers/iio/dac/ad5791.c                                  | 2 +-
>  drivers/iio/dac/ad7303.c                                  | 2 +-
>  drivers/iio/dac/ltc2632.c                                 | 2 +-
>  drivers/iio/dac/max5821.c                                 | 2 +-
>  drivers/iio/dac/mcp4725.c                                 | 4 ++--
>  drivers/iio/dac/stm32-dac.c                               | 2 +-
>  drivers/iio/dac/ti-dac082s085.c                           | 2 +-
>  drivers/iio/dac/ti-dac5571.c                              | 2 +-
>  drivers/iio/dac/ti-dac7311.c                              | 2 +-
>  drivers/iio/frequency/ad9523.c                            | 2 +-
>  drivers/iio/industrialio-buffer.c                         | 6 +++---
>  drivers/iio/industrialio-event.c                          | 2 +-
>  drivers/staging/iio/cdc/ad7746.c                          | 2 +-
>  25 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 770b4e59238f..335366c31743 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -225,7 +225,7 @@ static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
>         bool sys_calib;
>         int ret, temp;
>
> -       ret = strtobool(buf, &sys_calib);
> +       ret = kstrtobool(buf, &sys_calib);
>         if (ret)
>                 return ret;
>
> @@ -457,7 +457,7 @@ static ssize_t ad7192_set(struct device *dev,
>         int ret;
>         bool val;
>
> -       ret = strtobool(buf, &val);
> +       ret = kstrtobool(buf, &val);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index ef9d27759961..2834e9d0aa28 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -488,7 +488,7 @@ static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
>         bool readin;
>         int ret;
>
> -       ret = strtobool(buf, &readin);
> +       ret = kstrtobool(buf, &readin);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 8d902a32a0fd..1ed474e854a1 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -550,7 +550,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
>         bool val;
>         int ret;
>
> -       ret = strtobool(buf, &val);
> +       ret = kstrtobool(buf, &val);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index b2725c6adc7f..bf91675db8ce 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -413,7 +413,7 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
>         int ret, i;
>         bool calibrate;
>
> -       ret = strtobool(buf, &calibrate);
> +       ret = kstrtobool(buf, &calibrate);
>         if (ret < 0)
>                 return ret;
>         if (!calibrate)
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 27ee2c63c5d4..d87cf14daabe 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -288,7 +288,7 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
>         bool pwr_down;
>         int ret;
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index ecbc6a51d60f..22b000a40828 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -284,7 +284,7 @@ static ssize_t ad5360_write_dac_powerdown(struct device *dev,
>         bool pwr_down;
>         int ret;
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 82e1d9bd773e..a44c83242fb1 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -96,7 +96,7 @@ static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
>         bool pwr_down;
>         int ret;
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 14cfabacbea5..c6e685c6f6ea 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -114,7 +114,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
>         bool powerdown;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 8507573aa13e..a0817e799cc0 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -182,7 +182,7 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
>         int ret;
>         struct ad5504_state *st = iio_priv(indio_dev);
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
> index 371e812850eb..7e6f824de299 100644
> --- a/drivers/iio/dac/ad5624r_spi.c
> +++ b/drivers/iio/dac/ad5624r_spi.c
> @@ -129,7 +129,7 @@ static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
>         int ret;
>         struct ad5624r_state *st = iio_priv(indio_dev);
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index f78dd3f33199..15361d8bbf94 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -73,7 +73,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>         unsigned int val, ref_bit_msk;
>         u8 shift, address = 0;
>
> -       ret = strtobool(buf, &readin);
> +       ret = kstrtobool(buf, &readin);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 7a62e6e1d5f1..1a63b8456725 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -502,7 +502,7 @@ static ssize_t ad5755_write_powerdown(struct iio_dev *indio_dev, uintptr_t priv,
>         bool pwr_down;
>         int ret;
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index 2b14914b4050..339564fe47d1 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -188,7 +188,7 @@ static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
>         int ret;
>         struct ad5791_state *st = iio_priv(indio_dev);
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 91eaaf793b3e..03edf046dec6 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -77,7 +77,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>         bool pwr_down;
>         int ret;
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index aed46c80757e..7f1a9900a359 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -149,7 +149,7 @@ static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
>         int ret;
>         struct ltc2632_state *st = iio_priv(indio_dev);
>
> -       ret = strtobool(buf, &pwr_down);
> +       ret = kstrtobool(buf, &pwr_down);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index fce640b7f1c8..540f9ea7cada 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -116,7 +116,7 @@ static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
>         bool powerdown;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 842bad57cb88..7fcb86288823 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -80,7 +80,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
>         bool state;
>         int ret;
>
> -       ret = strtobool(buf, &state);
> +       ret = kstrtobool(buf, &state);
>         if (ret < 0)
>                 return ret;
>
> @@ -178,7 +178,7 @@ static ssize_t mcp4725_write_powerdown(struct iio_dev *indio_dev,
>         bool state;
>         int ret;
>
> -       ret = strtobool(buf, &state);
> +       ret = kstrtobool(buf, &state);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index b20192a071cb..daa42bcbae83 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -220,7 +220,7 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
>         bool powerdown;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
> index 4e1156e6deb2..106ce3546419 100644
> --- a/drivers/iio/dac/ti-dac082s085.c
> +++ b/drivers/iio/dac/ti-dac082s085.c
> @@ -133,7 +133,7 @@ static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
>         bool powerdown;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 4a3b8d875518..ed27fb7078d9 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -178,7 +178,7 @@ static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
>         bool powerdown;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
> index e10d17e60ed3..4afc411725d9 100644
> --- a/drivers/iio/dac/ti-dac7311.c
> +++ b/drivers/iio/dac/ti-dac7311.c
> @@ -123,7 +123,7 @@ static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
>         u8 power;
>         int ret;
>
> -       ret = strtobool(buf, &powerdown);
> +       ret = kstrtobool(buf, &powerdown);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index a0f92c336fc4..942870539268 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -516,7 +516,7 @@ static ssize_t ad9523_store(struct device *dev,
>         bool state;
>         int ret;
>
> -       ret = strtobool(buf, &state);
> +       ret = kstrtobool(buf, &state);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9d..129452598e83 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -510,7 +510,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
>         struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>         struct iio_buffer *buffer = this_attr->buffer;
>
> -       ret = strtobool(buf, &state);
> +       ret = kstrtobool(buf, &state);
>         if (ret < 0)
>                 return ret;
>         mutex_lock(&indio_dev->mlock);
> @@ -557,7 +557,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>         bool state;
>
> -       ret = strtobool(buf, &state);
> +       ret = kstrtobool(buf, &state);
>         if (ret < 0)
>                 return ret;
>
> @@ -1300,7 +1300,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>         struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>         bool inlist;
>
> -       ret = strtobool(buf, &requested_state);
> +       ret = kstrtobool(buf, &requested_state);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index ce8b102ce52f..b5e059e15b0a 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -274,7 +274,7 @@ static ssize_t iio_ev_state_store(struct device *dev,
>         int ret;
>         bool val;
>
> -       ret = strtobool(buf, &val);
> +       ret = kstrtobool(buf, &val);
>         if (ret < 0)
>                 return ret;
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 71c709771676..52b8957c19c9 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -290,7 +290,7 @@ static inline ssize_t ad7746_start_calib(struct device *dev,
>         int ret, timeout = 10;
>         bool doit;
>
> -       ret = strtobool(buf, &doit);
> +       ret = kstrtobool(buf, &doit);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
