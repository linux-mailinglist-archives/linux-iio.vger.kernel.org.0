Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024A558C79E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiHHLht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiHHLhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:37:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09DCCD;
        Mon,  8 Aug 2022 04:37:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e23so6229920qts.1;
        Mon, 08 Aug 2022 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QEISwwbpUJ9eIW72QcDBvXKKiWafFLPECWJ8pKBtm7Y=;
        b=HafsLBa+b8Gqv4da8k5EFJNLPGBkSUzkL5EV4iWMlGXWTREwOvejesXz2byeJFDFWp
         lhV65ls/mwC/ByjBtvW06TOlnYvrnGysB7FCBqdrcYi0C+IUc1sbrWHZGH3hM+2iMo90
         3zi7RZ40ZQPxb3UJUpLuP2ddaiXXhnmAX47UugMy632dCVQFfHZBqAmXD2H3PGK0Djhf
         nyt0NOV+eqd4/sAuY+FVIRidKhNIbl0OBpUeO62Zg9wbxiH4eUmvxXELpNjw+p4njwCj
         fcRqS4If/3Y9oTF+tFFvxKdlQC50N3/eXjDnGmTYLi9xcIVsRQRr+S5R3CU0/46/BIkP
         lnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QEISwwbpUJ9eIW72QcDBvXKKiWafFLPECWJ8pKBtm7Y=;
        b=rcSvut14wiBCUg8/f5yIyMTHAme3WHryQoWVgflxyxgS64/1/zoj/9v1TJi/I+pwUM
         OiOV5zXX1VzMAg7gnNyB9wqFy49Wi7x/B85qBRSMuHZPLpht4WfaGJBMf2+4HsF1ra4n
         4iR06KNP3GG2znnVxE8IM3U2rjUHG3/BZrc7KXNN/QRoXrnPoRkucjv8WCkS8r+JA+N8
         X+g47CtEbpMFoj8j8GmE/R4KH8O56eggWah/IUaAMkXPgt5ButJJpwDB8VGYZX6NhNVc
         Ksp91JIEVCgvIQ//bRII4xqIRQFHUZoC1QgK9UZHgNXXZJ0fL2VZbTrgJ5uQYgdXXxxG
         pcSw==
X-Gm-Message-State: ACgBeo1r8tmcXCVD7Tiktlez9pnpMapijZq8K9c+SjydMcIEjV+yTXXj
        UMusUFCvwCoWF0KqTDqef+ZtGShap0F0VXR7+5A=
X-Google-Smtp-Source: AA6agR6YbMK/pT3YHi/vNifD+KNIoQnLMeBdb9PdXxR2doJNU1zXlZoDuCuGHWK08Q96QS6n3nBw3jLnPlLjvZTqOto=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr15590008qta.429.1659958665938; Mon, 08
 Aug 2022 04:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <20ad0e793df229e71575c4e7d0bc4f6a5fb49f29.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <20ad0e793df229e71575c4e7d0bc4f6a5fb49f29.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:37:09 +0200
Message-ID: <CAHp75VdW1gtcH-S1O6FFPWF2hZrryDxL2hq+P4ncGpsKKuS6GQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] iio: magnetometer: yas530: Add function pointers
 to "chip_info"
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
> Add funtion pointers to the "chip_info" structure to ease the handling of

function

> different YAS variants.
>
> In the function yas5xx_probe(), the function call for "measure_offsets" was
> added as a conditional "if (yas5xx->chip_info->measure_offsets)". This is a
> preparatory step for YAS537, as this variant doesn't need an offset
> measurement.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 65 +++++++++++++++---------
>  1 file changed, 40 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 780c7f4d1eff..62d5f23d8e08 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -168,6 +168,11 @@ struct yas5xx;
>   * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
>   * @t_ref: number of counts at reference temperature
>   * @min_temp_x10: starting point of temperature counting in 1/10:s degrees Celsius
> + * @get_measure: function pointer to get a measurement
> + * @get_calibration_data: function pointer to get calibration data
> + * @dump_calibration: function pointer to dump calibration for debugging
> + * @measure_offsets: function pointer to measure the offsets
> + * @power_on: function pointer to power-on procedure
>   */
>  struct yas5xx_chip_info {
>         unsigned int devid;
> @@ -178,13 +183,18 @@ struct yas5xx_chip_info {
>         u32 scaling_val2;
>         u16 t_ref;
>         s16 min_temp_x10;
> +       int (*get_measure)(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo);
> +       int (*get_calibration_data)(struct yas5xx *yas5xx);
> +       void (*dump_calibration)(struct yas5xx *yas5xx);
> +       int (*measure_offsets)(struct yas5xx *yas5xx);
> +       int (*power_on)(struct yas5xx *yas5xx);
>  };
>
>  /**
>   * struct yas5xx - state container for the YAS5xx driver
>   * @dev: parent device pointer
>   * @chip: enumeration of the device variant
> - * @chip_info: device-specific data
> + * @chip_info: device-specific data and function pointers
>   * @version: device version
>   * @calibration: calibration settings from the OTP storage
>   * @hard_offsets: offsets for each axis measured with initcoil actuated
> @@ -488,7 +498,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>         case IIO_CHAN_INFO_PROCESSED:
>         case IIO_CHAN_INFO_RAW:
>                 pm_runtime_get_sync(yas5xx->dev);
> -               ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
> +               ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
>                 pm_runtime_mark_last_busy(yas5xx->dev);
>                 pm_runtime_put_autosuspend(yas5xx->dev);
>                 if (ret)
> @@ -528,7 +538,7 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
>         int ret;
>
>         pm_runtime_get_sync(yas5xx->dev);
> -       ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
> +       ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
>         pm_runtime_mark_last_busy(yas5xx->dev);
>         pm_runtime_put_autosuspend(yas5xx->dev);
>         if (ret) {
> @@ -941,6 +951,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .scaling_val2 = 100000000, /* picotesla to Gauss */
>                 .t_ref = t_ref_counts[yas530],
>                 .min_temp_x10 = min_temp_celsius_x10[yas530],
> +               .get_measure = yas530_get_measure,
> +               .get_calibration_data = yas530_get_calibration_data,
> +               .dump_calibration = yas530_dump_calibration,
> +               .measure_offsets = yas530_measure_offsets,
> +               .power_on = yas530_power_on,
>         },
>         [yas532] = {
>                 .devid = YAS532_DEVICE_ID,
> @@ -951,6 +966,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .scaling_val2 = 100000, /* nanotesla to Gauss */
>                 .t_ref = t_ref_counts[yas532],
>                 .min_temp_x10 = min_temp_celsius_x10[yas532],
> +               .get_measure = yas530_get_measure,
> +               .get_calibration_data = yas532_get_calibration_data,
> +               .dump_calibration = yas530_dump_calibration,
> +               .measure_offsets = yas530_measure_offsets,
> +               .power_on = yas530_power_on,
>         },
>         [yas533] = {
>                 .devid = YAS532_DEVICE_ID,
> @@ -961,6 +981,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .scaling_val2 = 100000, /* nanotesla to Gauss */
>                 .t_ref = t_ref_counts[yas533],
>                 .min_temp_x10 = min_temp_celsius_x10[yas533],
> +               .get_measure = yas530_get_measure,
> +               .get_calibration_data = yas532_get_calibration_data,
> +               .dump_calibration = yas530_dump_calibration,
> +               .measure_offsets = yas530_measure_offsets,
> +               .power_on = yas530_power_on,
>         },
>  };
>
> @@ -1031,35 +1056,25 @@ static int yas5xx_probe(struct i2c_client *i2c,
>                 goto assert_reset;
>         }
>
> -       switch (yas5xx->chip_info->devid) {
> -       case YAS530_DEVICE_ID:
> -               ret = yas530_get_calibration_data(yas5xx);
> -               if (ret)
> -                       goto assert_reset;
> -               break;
> -       case YAS532_DEVICE_ID:
> -               ret = yas532_get_calibration_data(yas5xx);
> -               if (ret)
> -                       goto assert_reset;
> -               break;
> -       default:
> -               ret = -ENODEV;
> -               dev_err(dev, "unhandled device ID %02x\n",
> -                       yas5xx->chip_info->devid);
> +       ret = yas5xx->chip_info->get_calibration_data(yas5xx);
> +       if (ret)
>                 goto assert_reset;
> -       }
>
>         dev_info(dev, "detected %s %s\n", yas5xx->chip_info->product_name,
>                  yas5xx->chip_info->version_name[yas5xx->version]);
>
> -       yas530_dump_calibration(yas5xx);
> -       ret = yas530_power_on(yas5xx);
> -       if (ret)
> -               goto assert_reset;
> -       ret = yas530_measure_offsets(yas5xx);
> +       yas5xx->chip_info->dump_calibration(yas5xx);
> +
> +       ret = yas5xx->chip_info->power_on(yas5xx);
>         if (ret)
>                 goto assert_reset;
>
> +       if (yas5xx->chip_info->measure_offsets) {
> +               ret = yas5xx->chip_info->measure_offsets(yas5xx);
> +               if (ret)
> +                       goto assert_reset;
> +       }
> +
>         indio_dev->info = &yas5xx_info;
>         indio_dev->available_scan_masks = yas5xx_scan_masks;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1155,7 +1170,7 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
>         usleep_range(31000, 40000);
>         gpiod_set_value_cansleep(yas5xx->reset, 0);
>
> -       ret = yas530_power_on(yas5xx);
> +       ret = yas5xx->chip_info->power_on(yas5xx);
>         if (ret) {
>                 dev_err(dev, "cannot power on\n");
>                 goto out_reset;
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
