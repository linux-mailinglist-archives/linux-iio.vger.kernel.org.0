Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12F3446CAF
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 06:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhKFGCE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Nov 2021 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhKFGCE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Nov 2021 02:02:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F9C061570
        for <linux-iio@vger.kernel.org>; Fri,  5 Nov 2021 22:59:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n128so13138282iod.9
        for <linux-iio@vger.kernel.org>; Fri, 05 Nov 2021 22:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTBTI/LDoYzs2QavYh56wjbv/pLyuCvA72Dda/k0phI=;
        b=Ir7FPfaIggLuApOVDOhQXtDcH0oACyl06B7ykLwlkC/AOxKXCz4ZJZ85YhiL33AV2z
         cwaqlF0XlWeAPiRmkhgb/GVGut9t6MMpCj3UevVFXdV+Uakm5gT34K05cmL1c4d51x6L
         zJ7AowgWsrN+ivCIrMT8f/23P/lEzvZzMBMMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTBTI/LDoYzs2QavYh56wjbv/pLyuCvA72Dda/k0phI=;
        b=ogBHkrE9eA0Bi/rjN4r/OihB/RuKBAAH7kbGFx9QAMe+2F8y6ueHo3AWDpEMYijvKK
         KsqjsoT7VSq5LZw5FPCVCzTsTi3gC12Cnh/amS8Tr1EhA0LNm2LZSt9DIz0Ux8K2hT2I
         mQhv5jx4zHNxtFURMzMt/Q7G6s2DzmgMwZKMjZsoorwUlA1Z+jTmnvp1gNk70EwBViPR
         lKYLdqXtCPg52q6IWUGHU8jSMo6YfLp0s5SCrpG72vb+82m+4LvUH3Ga5IxUVIIwD8zm
         zJN3nHVTXyBa41CHjd60nNj0QecJld62QNXx1SH4EJ0mnhTRdRY5YKVUH9xxDJR1gZ1x
         wEmg==
X-Gm-Message-State: AOAM530R5cUCzAF78IebjBTum5RMFeW3Rb3uBd+Zl0vwmh3pZUZr2v7n
        cXBYDv/9tySgkHG+gsekxhRlKYmOu0t7UIl7DX8HRjSjZc5Rew==
X-Google-Smtp-Source: ABdhPJz7aAD69BJl3EsPml2hFVo1SkoM/vdWFAzyD4Ao7c2/eJwiVa83pmp+KU/EBxtfx8Tfmb1g//NOqgdqGVHKFbs=
X-Received: by 2002:a05:6602:134a:: with SMTP id i10mr2856609iov.7.1636178362508;
 Fri, 05 Nov 2021 22:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211104071303.3604314-1-gwendal@chromium.org> <20211104071303.3604314-6-gwendal@chromium.org>
In-Reply-To: <20211104071303.3604314-6-gwendal@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 5 Nov 2021 22:59:11 -0700
Message-ID: <CAPUE2usjQSTyT+z0E--Zzr3MRQNoYP30qL7TzbsWwVOY-vHzkA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: sx9324: Add dt_bidding support
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I found some errors in this patch, I will release a v3 soon:
- fix commit spelling,
- simplify code when property is not present and only one property per
register: I can break as soon as device_property_read_xxx fails.
- remove "semtech,avg-neg-strength", not needed
- implement "semtech,proxraw-strength" support

On Thu, Nov 4, 2021 at 12:13 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
> retrieving sensor hardware property and alter default values.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
> - Use new interface.
>
>  drivers/iio/proximity/sx9324.c | 157 +++++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 943a243a4d71c..4a12b6c8c2c3a 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -756,6 +756,74 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
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
> +       { SX9324_REG_AFE_PH1, 0x26 },
> +       { SX9324_REG_AFE_PH2, 0x1a },
> +       { SX9324_REG_AFE_PH3, 0x16 },
> +
> +       { SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
> +       { SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
> +
> +       { SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +               SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> +       { SX9324_REG_PROX_CTRL1, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +               SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> +       { SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
> +       { SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
> +               SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
> +       { SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_1P50 |
> +               SX9324_REG_PROX_CTRL3_AVGPOS_FILT_1P256},
> +       { SX9324_REG_PROX_CTRL5, 0x00 },
> +       { SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> +       { SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> +       { SX9324_REG_ADV_CTRL0, 0x00 },
> +       { SX9324_REG_ADV_CTRL1, 0x00 },
> +       { SX9324_REG_ADV_CTRL2, 0x00 },
> +       { SX9324_REG_ADV_CTRL3, 0x00 },
> +       { SX9324_REG_ADV_CTRL4, 0x00 },
> +       { SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
> +               SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1 },
> +       { SX9324_REG_ADV_CTRL6, 0x00 },
> +       { SX9324_REG_ADV_CTRL7, 0x00 },
> +       { SX9324_REG_ADV_CTRL8, 0x00 },
> +       { SX9324_REG_ADV_CTRL9, 0x00 },
> +       /* Body/Table threshold */
> +       { SX9324_REG_ADV_CTRL10, 0x00 },
> +       { SX9324_REG_ADV_CTRL11, 0x00 },
> +       { SX9324_REG_ADV_CTRL12, 0x00 },
> +       /* TODO(gwendal): SAR currenly disabled */
> +       { SX9324_REG_ADV_CTRL13, 0x00 },
> +       { SX9324_REG_ADV_CTRL14, 0x00 },
> +       { SX9324_REG_ADV_CTRL15, 0x00 },
> +       { SX9324_REG_ADV_CTRL16, 0x00 },
> +       { SX9324_REG_ADV_CTRL17, 0x00 },
> +       { SX9324_REG_ADV_CTRL18, 0x00 },
> +       { SX9324_REG_ADV_CTRL19, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> +       { SX9324_REG_ADV_CTRL20, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> +};
> +
>  /* Activate all channels and perform an initial compensation. */
>  static int sx9324_init_compensation(struct iio_dev *indio_dev)
>  {
> @@ -780,6 +848,93 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>         return ret;
>  }
>
> +static const struct sx_common_reg_default *
> +sx9324_get_default_reg(struct device *dev, int idx,
> +                      struct sx_common_reg_default *reg_def)
> +{
> +#define SX9324_PIN_DEF "semtech,ph0-pin"
> +#define SX9324_RESOLUTION_DEF "semtech,resolution01"
> +       unsigned int pin_defs[SX9324_NUM_PINS];
> +       char prop[] = SX9324_RESOLUTION_DEF;
> +       u32 start = 0, raw = 0, pos = 0;
> +       int ret, count, ph, pin;
> +
> +       memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
> +       switch (reg_def->reg) {
> +       case SX9324_REG_AFE_PH0:
> +       case SX9324_REG_AFE_PH1:
> +       case SX9324_REG_AFE_PH2:
> +       case SX9324_REG_AFE_PH3:
> +               ph = reg_def->reg - SX9324_REG_AFE_PH0;
> +               scnprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> +
> +               count = device_property_count_u32(dev, prop);
> +               if (count != ARRAY_SIZE(pin_defs))
> +                       break;
> +               ret = device_property_read_u32_array(dev, prop, pin_defs,
> +                                                    ARRAY_SIZE(pin_defs));
> +               for (pin = 0; pin < SX9324_NUM_PINS; pin++)
> +                       raw |= (pin_defs[pin] << (2 * pin)) &
> +                              SX9324_REG_AFE_PH0_PIN_MASK(pin);
> +               reg_def->def = raw;
> +               break;
> +       case SX9324_REG_AFE_CTRL4:
> +       case SX9324_REG_AFE_CTRL7:
> +               if (reg_def->reg == SX9324_REG_AFE_CTRL4)
> +                       strncpy(prop, "semtech,resolution01", ARRAY_SIZE(prop));
> +               else
> +                       strncpy(prop, "semtech,resolution23", ARRAY_SIZE(prop));
> +
> +               ret = device_property_read_u32(dev, prop, &raw);
> +               if (ret)
> +                       raw = FIELD_GET(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
> +                                       reg_def->def);
> +               else
> +                       raw = ilog2(raw);
> +
> +               reg_def->def &= ~SX9324_REG_AFE_CTRL4_RESOLUTION_MASK;
> +               reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
> +                                          raw);
> +               break;
> +       case SX9324_REG_ADV_CTRL5:
> +               ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
> +               if (ret)
> +                       break;
> +
> +               reg_def->def &= ~SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK;
> +               reg_def->def |= FIELD_PREP(SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK,
> +                                          start);
> +               break;
> +       case SX9324_REG_PROX_CTRL4:
> +               ret = device_property_read_u32(dev, "semtech,avg-neg-strength", &pos);
> +               if (ret) {
> +                       raw = FIELD_GET(SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK,
> +                                       reg_def->def);
> +               } else {
> +                       /* Powers of 2, except for a gap between 16 and 64 */
> +                       raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
> +               }
> +               reg_def->def &= ~SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK;
> +               reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK,
> +                                          raw);
> +
> +               ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
> +               if (ret) {
> +                       raw = FIELD_GET(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
> +                                       reg_def->def);
> +               } else {
> +                       /* Powers of 2, except for a gap between 16 and 64 */
> +                       raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
> +               }
> +               reg_def->def &= ~SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK;
> +               reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
> +                                          raw);
> +               break;
> +       }
> +
> +       return reg_def;
> +}
> +
>  static int sx9324_check_whoami(struct device *dev,
>                                struct iio_dev *indio_dev)
>  {
> @@ -821,12 +976,14 @@ static const struct sx_common_chip_info sx9324_chip_info = {
>         .mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK,
>         .irq_msk_offset = 3,
>         .num_channels = SX9324_NUM_CHANNELS,
> +       .num_default_regs = ARRAY_SIZE(sx9324_default_regs),
>
>         .ops = {
>                 .read_prox_data = sx9324_read_prox_data,
>                 .check_whoami = sx9324_check_whoami,
>                 .init_compensation = sx9324_init_compensation,
>                 .wait_for_sample = sx9324_wait_for_sample,
> +               .get_default_reg = sx9324_get_default_reg,
>         },
>
>         .iio_channels = sx9324_channels,
> --
> 2.33.1.1089.g2158813163f-goog
>
