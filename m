Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC768565F2A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiGDVrE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 17:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiGDVrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 17:47:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F875FDA
        for <linux-iio@vger.kernel.org>; Mon,  4 Jul 2022 14:47:01 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c8340a6f7so51212727b3.4
        for <linux-iio@vger.kernel.org>; Mon, 04 Jul 2022 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1SPueTkK4EKv1rEorRVyqGHcOz4+KmWsaoz0+duAf4=;
        b=X04A/CfFcMflTg/y9BCsKH1w8VK7vvrMkVU4IjEnWngHAv80ILbI6N7Dg7pfLcfzze
         eZAFUwd5xFyq5tBNWSWy7CTQhtjr55C6duQeMJUZxiRwjL6zmVBznNicqu77NAZg1meW
         M/ONXNN8z/uqhxNL66OldGrITqm+18atzHaa3DDOL2BUtu2wqt765vaguwmYzhLoXix1
         lM2dc+AfWj+mXzPcSOnjnCG+GCSZ4kz8KZziG1mPILUedlrGdEzGD0Tqf5qQuqEUAC2J
         ElWi4G73HiO6kjSUvqer7Vf2bn9jek6O+on8ZG0aEVEZ7Nyppk98W62sKcTHP+iKIH4t
         uvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1SPueTkK4EKv1rEorRVyqGHcOz4+KmWsaoz0+duAf4=;
        b=anzZh8wddtry0bHa3tvIuL1JwLYhmwF0EXefakVI6AdTppuQnb5JRcwmBdHf/PzuKp
         NhunLN/v03DyLkmxec9MuoFjAV2a19zGbqu5Jur8ygQ57ToXluW4Ofq4n0yeIqNxuYK2
         O3WnXRx2SC1Prp9ArQMlNyMZ/wIMqYaE9GXg8vSQWZhT3cHXHeaSkrmi8m1cnvS7+j42
         PO3jc7m0W0+7vBD6Bbk7SiV4MYte+7oR7cf5fBtxOOp/VxdytXetq4XR9jqW/x2l8PHY
         HDPvSILj5vhFCCrNiLcXtdl/Qt0bT8bfA6jQBuD7LZ28WrlZK5sQ9PuCtmZJtm8b5bpE
         KL5g==
X-Gm-Message-State: AJIora/+cdSUowAVsUNfhvSWe9kPAg2HY46jS5YI9/Bw1m76oj+T1nUb
        yTCgYLV/hHiMRZfK/OmVLP6whLE8swG8tLgrpLI=
X-Google-Smtp-Source: AGRyM1s37vX3H+nBg8HBQwi1+4vebkRCfk8yOCBRmSvjvrLA3YLIYoTmBkYCqbGA4byisPUOj0sYeWQ2bYlAFmGliqk=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr34390469ywa.277.1656971220695; Mon, 04
 Jul 2022 14:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220704105400.106-1-Ibrahim.Tilki@analog.com>
In-Reply-To: <20220704105400.106-1-Ibrahim.Tilki@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:46:23 +0200
Message-ID: <CAHp75Vc93yhKL+6FwfgvrV7QpDvP3OZt2LLZvSQcgO5PkYcaJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: add max11410 adc driver
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Nurettin.Bolucu@analog.com
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

On Mon, Jul 4, 2022 at 12:58 PM Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
>
> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
>
> Device has digital filter that is controlled by custom sysfs attribute.

a digital
a custom

> User has four options to choose from: fir50/60, fir50, fir60 and sinc4.
> Digital filter selection affects sampling frequency range so driver
> has to consider configured filter when configuring sampling frequency.

Either 'filters'
Or 'the configured'

...

> +#define                PGA_SIG_PATH_BUFFERED   (0x00 << PGA_SIG_PATH_POS)
> +#define                PGA_SIG_PATH_BYPASS     (0x01 << PGA_SIG_PATH_POS)
> +#define                PGA_SIG_PATH_PGA        (0x02 << PGA_SIG_PATH_POS)

If it's bits, use BIT(), otherwise plain decimal numbers and shifts.

...

> +enum max11410_filter {
> +       FILTER_FIR5060,
> +       FILTER_FIR50,
> +       FILTER_FIR60,
> +       FILTER_SINC4

Here and everywhere else in the code (a dozen of places). When it's
not a terminating antry, add a comma. It will help in the future in
case this will be extended.

> +};

...

> +                       .endianness = IIO_LE

+ Comma

...

> +       /* This driver only needs to write 8bit registers */

8-bit

...

> +static int max11410_read_reg(struct max11410_state *st,
> +                            unsigned int reg,
> +                            int *val)
> +{
> +       u32 data;

u8 data[3];

> +       int ret;
> +
> +       if (max11410_reg_size(reg) == 3) {
> +               ret = regmap_bulk_read(st->regmap, reg, &data, 3);
> +               if (!ret)

if (ret)
  return ret;

> +                       *val = be32_to_cpu(data << 8);

get_unaligned_be24();

> +               return ret;
> +       }
> +
> +       return regmap_read(st->regmap, reg, val);
> +}

...

> +static const struct regmap_config regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = 0x39

+ Comma

> +};

...

> +               /* Wait for interrupt. */

for an

...

> +static struct attribute *max11410_attributes[] = {
> +       &iio_dev_attr_filter.dev_attr.attr,
> +       &iio_const_attr_filter_available.dev_attr.attr,
> +       NULL

Here a comma is not needed (as in the code now) because it's a
terminator. That I pointed out for the sake of example to show the
difference.

> +};

...

> +       if (chan->differential)
> +               ret = max11410_set_input_mux(st, chan->channel, chan->channel2);
> +       else
> +               ret = max11410_set_input_mux(st, chan->channel, AINN_GND);

> +

A blank line is not needed here.

Ditto for other few cases.

> +       if (ret)
> +               return ret;

...

> +               if (cfg.bipolar)
> +                       *val = -(1 << (chan->scan_type.realbits - 1));

Missed type of the constant, so strictly speaking this might be UB.
Btw, BIT() has not such issue.

> +               else
> +                       *val = 0;

...

> +               *val = 1 << cfg.gain;

Ditto.

BIT() ?

...

> +               for (i = 0; i < ARRAY_SIZE(max11410_hwgain_list); ++i) {
> +                       if (val == max11410_hwgain_list[i])
> +                               break;
> +               }

> +

It seems in plenty of places you added redundant blank lines. No need,
please, make your code shorter.

> +               if (i == ARRAY_SIZE(max11410_hwgain_list))
> +                       return -EINVAL;

...

> +               for (i = 0; i < max11410_sampling_len[filter]; ++i) {
> +                       if (val == max11410_sampling_rates[filter][i][0] &&
> +                           val2 == max11410_sampling_rates[filter][i][1])
> +                               break;
> +               }

> +

Ditto and so on.

> +               if (i == max11410_sampling_len[filter])
> +                       return -EINVAL;

...

> +static irqreturn_t max11410_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct max11410_state *st = iio_priv(indio_dev);
> +       struct {
> +               int data;
> +               s64 ts __aligned(8);
> +       } scan = {0};

Why do you need an assignment here?
Even memcpy() in IRQ context is a burden.

> +       int ret;
> +
> +       ret = max11410_read_reg(st, REG_DATA0, &scan.data);
> +       if (!ret)
> +               iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +                                                  iio_get_time_ns(indio_dev));
> +
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

...

> +       for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
> +               ++enabled_channels;

x++ will suffice

> +       }

{} are not needed.

...

> +static const struct iio_buffer_setup_ops max11410_buffer_ops = {
> +       .postenable = &max11410_buffer_postenable,
> +       .predisable = &max11410_buffer_predisable,
> +       .validate_scan_mask = &max11410_validate_scan_mask

In dozens of places, you missed commas. Think about development of
this driver in case it gets extended to support something new. Think
about backporting that if needed.

> +};

...

> +       channels = devm_kzalloc(dev,
> +                               num_ch * sizeof(struct iio_chan_spec),
> +                               GFP_KERNEL);

kcalloc()

No error check?!

...

> +       st->channels = devm_kzalloc(dev,
> +                                   num_ch * sizeof(struct max11410_channel_config),
> +                                   GFP_KERNEL);

Ditto.

...

> +                       ret = fwnode_property_read_u32_array(child,
> +                                                            "diff-channels",
> +                                                            inputs, 2);

sizeof() ?

> +                       if (ret)
> +                               return ret;

...

> +                       inputs[1] = 0;

Why not assign it after an error check?

> +                       ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
> +                       if (ret)
> +                               return ret;

...

> +               if (!ret) {

Why not positive conditional?
Ditto for all  if (!x) {}  else {} cases.

> +                       if (reference > REFSEL_MAX)
> +                               return dev_err_probe(&indio_dev->dev,
> +                                                    -EINVAL,
> +                                                    "Invalid adi,reference value for %s, should be less than %d.\n",
> +                                                    fwnode_get_name(child),
> +                                                    REFSEL_MAX + 1);
> +
> +                       cfg->refsel = reference;
> +               } else {
> +                       cfg->refsel = REFSEL_AVDD_AGND;
> +               }

...

> +               /* Enable hardwaregain property if input mode is PGA */

hardware gain

...

> +       struct regulator *reg = devm_regulator_get_optional(dev, id);

Split assignment and move it closer to its user.

> +
> +       if (IS_ERR(reg)) {
> +               *vref = NULL;
> +               return 0;
> +       }

...

> +       ret = max11410_write_reg(st, REG_CAL_START, cal_type);
> +       if (ret)
> +               return ret;

+ blank line.

> +       /* Wait for status register Calibration Ready flag */
> +       return read_poll_timeout(max11410_read_reg, ret,
> +                                ret || (val & STATUS_CAL_READY_BIT),
> +                                50000, CALIB_TIMEOUT_MS * 1000, true,
> +                                st, REG_STATUS, &val);

...

> +static int max11410_probe(struct spi_device *spi)
> +{
> +       struct max11410_state *st;
> +       struct iio_dev *indio_dev;

> +       int ret = 0;

Is this assignment needed?

...

> +               .name   = "max11410",
> +               .of_match_table = max11410_spi_of_id

+ Comma.

-- 
With Best Regards,
Andy Shevchenko
