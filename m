Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48F6FA59C
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjEHKLT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjEHKLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 06:11:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B0398B1
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 03:11:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ad1ba5dff7so20172161fa.3
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683540673; x=1686132673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8u6WB6jtixs7X6y9FDxOX9g5fZTvKGDvv+p9yLL1Vks=;
        b=e8klmY4Cy/DY4lgolcoyCswAy4Ix6hUPD0Fef1ihMp5cCAP51N8XF1ExEWTOkCYWE/
         r7xPlc2mp2hEd4Cys1XudNMWP12lHHZ+V8e9gTaLV17jYwoCM3AQRYLqzKkumpbhYccB
         vUBqp6YmCMCRdZcLxDqGobLoHYOxXhlU7GiBGZgPlX4rvVhTaelIz26nVzIpESJjbPP2
         bQJTjwdufr/MezN4/QwOk92WHViLJkQGmQbosk0My3Q6voE4NaI/rl4yKD2EvPU23A6N
         SBDwpkWM2iD+ao9jw4knhRrsE/rhrUlYywzBsZiMf4Hf3iAKEk85mshgntENGoUcQ6Di
         +Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683540673; x=1686132673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8u6WB6jtixs7X6y9FDxOX9g5fZTvKGDvv+p9yLL1Vks=;
        b=FGzCa1JZA7Xqx7O+PbZ1Y6CmS/ShFIOSkanhuz5hpCNSnJ5bRSYJ9UyErBUsEjW4Wd
         INngrz7XEghFFk+091lQittfnDVLoxB+z/2kA7zQqZdzH5PhZccFjZmge83q7rZAxMv3
         5cBSWR7XZJ0EJwGGNg+z0w/AGI0b9i2TcFcsLDtbQggdoarl6R6M3+t70mts9suf71NR
         nqC7vo4Zkp/gqUbn/VP+KIXmMQAytILLylPlC5RcOZU+9Lsp79CeofOr5W0vFuMr8sHd
         Z4J+07E91PYe8N1CZ4ygwb64d9/HHc+zM+WHYMM2RhtzBe5hISLrdKChUn/EqIkbawLM
         dU4w==
X-Gm-Message-State: AC+VfDxehzW02nZoUA5137SI9JC9qR2zbRYIj5uHkW20KM+SkFOr5yom
        0VKSIlEslhv1KvvF4QGSsWRQeHl/nOdKaNnaemj4jA==
X-Google-Smtp-Source: ACHHUZ5/lJIRYmcTNM+S8EysGihAI1KmX0Wfsre2tZZrF51czrkMka3TX8UV/CkG9EjnlpvYXEfd0HXMern19vUb8uE=
X-Received: by 2002:a2e:9545:0:b0:2a8:c87f:d220 with SMTP id
 t5-20020a2e9545000000b002a8c87fd220mr3091732ljh.5.1683540673468; Mon, 08 May
 2023 03:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de> <20230507184649.39290-5-marex@denx.de>
In-Reply-To: <20230507184649.39290-5-marex@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 May 2023 12:10:36 +0200
Message-ID: <CAKv63utbVqRjmyP_cN=d2Jewpp6hgVHzSJdm4gjKBkaHKb2LuQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: mlx90614: Add MLX90615 support
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 May 2023 at 20:47, Marek Vasut <marex@denx.de> wrote:
>
> Add support for MLX90615 Infra Red Thermometer, which seems to be
> the predecesor of MLX90614 . There are significant differences in
> the register layout compared to MLX90614, but the functionality
> of the device is virtually identical.
>
> The following differences have been identified:
> - RAM/EEPROM/SLEEP access opcodes are different
> - RAM/EEPROM registers are at different offsets
> - EEPROM emissivity and configuration registers are at different offsets
> - EEPROM configuration register bits are shuffled around
> - EEPROM emissivity settings are 14 bit on MLX90615 , 16 bit on MLX90614
> - MLX90615 can only ever support one sensor, MLX90614 could support two
> - FIR filter is set to fixed settings on MLX90615
> - IIR filter coefficients are different
>
> This patch fills in the MLX90615 specific description and quirk handling.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: The IIR coefficients need to be checked
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: Split the patch up into cleanups, abstraction and MLX90615 addition
> ---
>  drivers/iio/temperature/mlx90614.c | 49 +++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index d6d2a5afaf8c0..5bcd323921db5 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
> + * mlx90614.c - Support for Melexis MLX90614/MLX90615 contactless IR temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   * Copyright (c) 2015 Essensium NV
>   * Copyright (c) 2015 Melexis
>   *
> - * Driver for the Melexis MLX90614 I2C 16-bit IR thermopile sensor
> + * Driver for the Melexis MLX90614/MLX90615 I2C 16-bit IR thermopile sensor
> + *
> + * MLX90614 - 17-bit ADC + MLX90302 DSP
> + * MLX90615 - 16-bit ADC + MLX90325 DSP
>   *
>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>   *
> @@ -35,6 +38,10 @@
>  #define MLX90614_OP_EEPROM     0x20
>  #define MLX90614_OP_SLEEP      0xff
>
> +#define MLX90615_OP_EEPROM     0x10
> +#define MLX90615_OP_RAM                0x20
> +#define MLX90615_OP_SLEEP      0xc6
> +
>  /* Control bits in configuration register */
>  #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
>  #define MLX90614_CONFIG_IIR_MASK (0x7 << MLX90614_CONFIG_IIR_SHIFT)
> @@ -43,11 +50,16 @@
>  #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
>  #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
>
> +#define MLX90615_CONFIG_IIR_SHIFT 12 /* IIR coefficient */
> +#define MLX90615_CONFIG_IIR_MASK (0x7 << MLX90615_CONFIG_IIR_SHIFT)
> +
>  /* Timings (in ms) */
>  #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
>  #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
>  #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
>
> +#define MLX90615_TIMING_WAKEUP 22 /* time to hold SCL low for wake-up */
> +
>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>
>  /* Magic constants */
> @@ -306,8 +318,8 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>                         *val2 = ret * chip_info->emissivity_res;
>                 }
>                 return IIO_VAL_INT_PLUS_NANO;
> -       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
> -                                                            FIR = 1024 */
> +       /* IIR setting with FIR=1024 (MLX90614) or FIR=65536 (MLX90615) */
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>                 ret = mlx90614_power_get(data, false);
>                 if (ret < 0)
>                         return ret;
> @@ -666,14 +678,43 @@ static const struct mlx_chip_info mlx90614_chip_info = {
>         },
>  };
>
> +static const struct mlx_chip_info mlx90615_chip_info = {
> +       .op_eeprom_emissivity           = MLX90615_OP_EEPROM | 0x03,
> +       .op_eeprom_config1              = MLX90615_OP_EEPROM | 0x02,
> +       .op_ram_ta                      = MLX90615_OP_RAM | 0x06,
> +       .op_ram_tobj1                   = MLX90615_OP_RAM | 0x07,
> +       .op_ram_tobj2                   = MLX90615_OP_RAM | 0x08,
> +       .op_sleep                       = MLX90615_OP_SLEEP,
> +       .dual_channel                   = false,
> +       .wakeup_delay_ms                = MLX90615_TIMING_WAKEUP,
> +       .emissivity_max                 = 16383,
> +       .emissivity_res                 = 1000000000 / 16383,
This makes me wonder if we could just drop the emissivity_res and have
it calculate it using emissivity_max, since both chips will do it.

> +       .fir_config_mask                = 0,    /* MLX90615 FIR is fixed */
> +       .iir_config_mask                = MLX90615_CONFIG_IIR_MASK,
> +       /* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
> +       .iir_valid_offset               = 1,
> +       .iir_values                     = { 723, 77, 42, 31, 28, 20, 18 },
> +       .iir_freqs                      = {
> +               { 0, 180000 },  /* 14% ~= 0.18 Hz */
> +               { 0, 200000 },  /* 17% ~= 0.20 Hz */
> +               { 0, 280000 },  /* 20% ~= 0.28 Hz */
> +               { 0, 310000 },  /* 25% ~= 0.31 Hz */
> +               { 0, 420000 },  /* 33% ~= 0.42 Hz */
> +               { 0, 770000 },  /* 50% ~= 0.77 Hz */
> +               { 7, 230000 },  /* 100% ~= 7.23 Hz */
> +       },
> +};
> +
>  static const struct i2c_device_id mlx90614_id[] = {
>         { "mlx90614", .driver_data = (kernel_ulong_t)&mlx90614_chip_info },
> +       { "mlx90615", .driver_data = (kernel_ulong_t)&mlx90615_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
>
>  static const struct of_device_id mlx90614_of_match[] = {
>         { .compatible = "melexis,mlx90614", .data = &mlx90614_chip_info },
> +       { .compatible = "melexis,mlx90615", .data = &mlx90615_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mlx90614_of_match);
> --
> 2.39.2
>
