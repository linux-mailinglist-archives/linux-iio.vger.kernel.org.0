Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8AA4BC872
	for <lists+linux-iio@lfdr.de>; Sat, 19 Feb 2022 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiBSM5l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Feb 2022 07:57:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiBSM5i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Feb 2022 07:57:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB401D423C;
        Sat, 19 Feb 2022 04:57:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x5so14123403wrg.13;
        Sat, 19 Feb 2022 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=004RvGKVcRtaacMnNgPWZyMs1KimYt08BVFvpI2Eghg=;
        b=gD1gAraVciB/YwYfhzuP9jj1W/mwABUj8cM3Ocbe/yd/CEl7WfhguF/0QWiW4/j3Re
         Vo4mu2I3N8Iq9VM3a8DDCp6hC2eFCq/1VdPUuv854ofnh61P+pblf6EhFBZO3zImM3os
         iF0t1Daq7+wqIF8FmQsLU812rnBjSAZVH8CbhfGyQ6tJd2ey3RwSunTdXPUorsWENAbG
         3httqLVIzRivs83FDgk0SYx4+RX/vPDwBB3bl+55uqNURcBCN7Q515LZYiNWXe3YxiXQ
         A2weaknC4rn2EmguLEatVlMqjoBskHPKgOH/KC1B86ffpl1KDmOizf4k27YvL4e5IJJ+
         KV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=004RvGKVcRtaacMnNgPWZyMs1KimYt08BVFvpI2Eghg=;
        b=vGTDsyl/NxMUBAYuE99qH+qI4nQAQwzaKC5HkQKI81vRzed5aXkp5rKV59lS2Q7zci
         +ZIUcNSgntCKrtJWSgt7fmHz8aMIlLoWD02A5r5lTtlsP3wE5cTih2VVtfXMZpBc1Bht
         kwNlqSeN8T7jMvQTi1UPBbKEYTNXbzEbcAcg/vhUUireCfnY/yofYnwuoZmzWLsebah5
         gi+DY44v/0LnKW+I6bw9899h4ExCgoAoQjCb6pZi/4bpHMMYjyVgZd6eG2soKAtvhM5e
         CBse6LAIKVeex9Kankp29w4v9tFJH82Ok+LUnyhVUPljpdoUcAxm8CmMD9OYDtxrjIrq
         +iJg==
X-Gm-Message-State: AOAM5307HSJdoJSv9M2mFHdI+jQHScrcYz7JGESxWB3YuaGqhlqUTVZ8
        s+OeHzzUCxrb0Tzg5/bNG8B1+RAkfrPBFg==
X-Google-Smtp-Source: ABdhPJxQNSptDPR8wPlyXhURwHq3tExcGCy8sWgqpYqqzlQyN9WVbXaYWbdGpmiGHNXEf2ElbGd6hA==
X-Received: by 2002:adf:82af:0:b0:1e6:80a3:4782 with SMTP id 44-20020adf82af000000b001e680a34782mr9658343wrc.362.1645275436681;
        Sat, 19 Feb 2022 04:57:16 -0800 (PST)
Received: from ?IPv6:2001:a62:412:c601:8041:bf67:30df:b9d4? ([2001:a62:412:c601:8041:bf67:30df:b9d4])
        by smtp.gmail.com with ESMTPSA id p17sm2152993wme.25.2022.02.19.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 04:57:15 -0800 (PST)
Message-ID: <ded0958d9172a3f7558f5b4df3feef1cf7798209.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Sat, 19 Feb 2022 13:57:14 +0100
In-Reply-To: <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
         <20220121142501.151-2-nuno.sa@analog.com>
         <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2022-02-05 at 19:29 +0200, Andy Shevchenko wrote:
> On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:
> > The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> > precision reference. It is guaranteed monotonic and has built in
> > rail-to-rail output buffers that can source or sink up to 20 mA.
> 
> ...
> 
> > +#include <linux/of.h>
> 
> property.h please/
> 
> ...
> 
> > +static int ltc2688_spi_read(void *context, const void *reg, size_t
> > reg_size,
> > +                           void *val, size_t val_size)
> > +{
> > +       struct ltc2688_state *st = context;
> > +       struct spi_transfer xfers[] = {
> > +               {
> > +                       .tx_buf = st->tx_data,
> > +                       .bits_per_word = 8,
> > +                       .len = 3,
> > +                       .cs_change = 1,
> > +               }, {
> > +                       .tx_buf = st->tx_data + 3,
> > +                       .rx_buf = st->rx_data,
> > +                       .bits_per_word = 8,
> > +                       .len = 3,
> > +               },
> > +       };
> > +       int ret;
> 
> > +       memcpy(st->tx_data, reg, reg_size);
> > +
> > +       ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +       if (ret)
> > +               return ret;
> > +
> > +       memcpy(val, &st->rx_data[1], val_size);
> > +
> > +       return 0;
> > +}
> 
> First of all, yuo have fixed len in transfer sizes, so what the
> purpose of the reg_size / val_size?
> Second, why do you need this specific function instead of regmap bulk
> ops against be24/le24?
> 
> ...
> 
> > +unlock:
> 
> out_unlock: ?
> (And in similar cases)
> 
> ...
> 
> > +       if (ret)
> > +               return ret;
> > +
> > +       return len;
> 
> In some cases the return ret ?: len; is used, in some like above.
> Maybe a bit
> of consistency?
> 

Hmm, when doing some changes for v4 I realized why I used the ternary
operator here (typically I'm not a fan). The thing is that we already
check the error condition after calling regmap_update_bits() which is
not the last code executed. Hence, I didn't want to do again

if (ret)
	return ret

after unlocking the mutex.

In the other places the error check is always on the last lines where
nothing else will happen (either return error or len). 

Alternatively, to remove the ternary operator, I would prefer to
actually remove the label and goto and after regmap_update_bits(), do:

if (ret) {
	mutex_unlock();
	return ret;
}

It might be not consistent with other places were goto is used but this
function also has it's differencies...

- Nuno Sá

> ...
> 
> > +       if (private == LTC2688_INPUT_B_AVAIL)
> > +               return sysfs_emit(buf, "[%u %u %u]\n",
> > ltc2688_raw_range[0],
> > +                                 ltc2688_raw_range[1],
> > +                                 ltc2688_raw_range[2] / 4);
> 
> Is it standard form "[A B C]" for ranges in IIO? I haven't looked
> into the code
> deeply (and datasheet at all) to understand meaning. To me range is
> usually out
> of two numbers.
> 
> > +       if (private == LTC2688_DITHER_OFF)
> > +               return sysfs_emit(buf, "0\n");
> 
> > +       ret = ltc2688_dac_code_read(st, chan->channel, private,
> > &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return sysfs_emit(buf, "%u\n", val);
> 
> These three types of output for one sysfs node? Seems it's not align
> with the
> idea behind sysfs. It maybe that I missed something.
> 
> ...
> 
> > +       ret = kstrtou16(buf, 10, &val);
> 
> In other function you have long, here u16. I would expect that the
> types are of
> the same class, e.g. if here you have u16, then there something like
> s32 / s64.
> Or here something like unsigned short.
> 
> A bit of elaboration why u16 is chosen here?
> 
> ...
> 
> > +       .info_mask_separate_available =
> > BIT(IIO_CHAN_INFO_RAW),         \
> > +       .ext_info =
> > ltc2688_ext_info                                    \
> 
> + Comma
> 
> ...
> 
> > +static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
> > +                                struct ltc2688_chan *chan,
> > +                                struct device_node *np, int tgp)
> > +{
> > +       unsigned long rate;
> > +       struct clk *clk;
> > +       int ret, f;
> > +
> > +       clk = devm_get_clk_from_child(&st->spi->dev, np, NULL);
> > +       if (IS_ERR(clk))
> 
> Make it optional for non-OF, can be done as easy as
> 
>         if (IS_ERR(clk)) {
>                 if (PTR_ERR(clk) == -ENOENT)
>                         clk = NULL;
>                 else
>                         return dev_err_probe(...);
>         }
> 
> > +               return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
> > +                                    "failed to get tgp clk.\n");
> > +
> > +       ret = clk_prepare_enable(clk);
> > +       if (ret)
> > +               return dev_err_probe(&st->spi->dev, ret,
> > +                                    "failed to enable tgp
> > clk.\n");
> > +
> > +       ret = devm_add_action_or_reset(&st->spi->dev,
> > ltc2688_clk_disable, clk);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (chan->toggle_chan)
> > +               return 0;
> > +
> > +       /* calculate available dither frequencies */
> > +       rate = clk_get_rate(clk);
> > +       for (f = 0; f < ARRAY_SIZE(chan->dither_frequency); f++)
> > +               chan->dither_frequency[f] = DIV_ROUND_CLOSEST(rate,
> > ltc2688_period[f]);
> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > +{
> > +       struct device *dev = &st->spi->dev;
> > +       struct device_node *child;
> > +       u32 reg, clk_input, val, tmp[2];
> > +       int ret, span;
> > +
> > +       for_each_available_child_of_node(dev->of_node, child) {
> 
> device_for_each_child_node()
> 
> > +               struct ltc2688_chan *chan;
> > +
> > +               ret = of_property_read_u32(child, "reg", &reg);
> > +               if (ret) {
> > +                       of_node_put(child);
> > +                       return dev_err_probe(dev, ret,
> > +                                            "Failed to get reg
> > property\n");
> > +               }
> > +
> > +               if (reg >= LTC2688_DAC_CHANNELS) {
> > +                       of_node_put(child);
> > +                       return dev_err_probe(dev, -EINVAL,
> > +                                            "reg bigger than:
> > %d\n",
> > +                                            LTC2688_DAC_CHANNELS);
> > +               }
> > +
> > +               val = 0;
> > +               chan = &st->channels[reg];
> > +               if (of_property_read_bool(child, "adi,toggle-
> > mode")) {
> > +                       chan->toggle_chan = true;
> > +                       /* assume sw toggle ABI */
> > +                       st->iio_chan[reg].ext_info =
> > ltc2688_toggle_sym_ext_info;
> > +                       /*
> > +                        * Clear IIO_CHAN_INFO_RAW bit as toggle
> > channels expose
> > +                        * out_voltage_raw{0|1} files.
> > +                        */
> 
> > +                       clear_bit(IIO_CHAN_INFO_RAW,
> > +                                 &st-
> > >iio_chan[reg].info_mask_separate);
> 
> Do you need atomic operation here?
> 
> > +               }
> > +
> > +               ret = of_property_read_u32_array(child,
> > "adi,output-range-microvolt",
> > +                                                tmp,
> > ARRAY_SIZE(tmp));
> > +               if (!ret) {
> > +                       span = ltc2688_span_lookup(st, (int)tmp[0]
> > / 1000,
> > +                                                  tmp[1] / 1000);
> > +                       if (span < 0) {
> > +                               of_node_put(child);
> > +                               return dev_err_probe(dev, -EINVAL,
> > +                                                    "output range
> > not valid:[%d %d]\n",
> > +                                                    tmp[0],
> > tmp[1]);
> > +                       }
> > +
> > +                       val |= FIELD_PREP(LTC2688_CH_SPAN_MSK,
> > span);
> > +               }
> > +
> > +               ret = of_property_read_u32(child, "adi,toggle-
> > dither-input",
> > +                                          &clk_input);
> > +               if (!ret) {
> > +                       if (clk_input >= LTC2688_CH_TGP_MAX) {
> > +                               of_node_put(child);
> > +                               return dev_err_probe(dev, -EINVAL,
> > +                                                    "toggle-
> > dither-input inv value(%d)\n",
> > +                                                    clk_input);
> > +                       }
> > +
> > +                       ret = ltc2688_tgp_clk_setup(st, chan,
> > child, clk_input);
> > +                       if (ret) {
> > +                               of_node_put(child);
> > +                               return ret;
> > +                       }
> > +
> > +                       /*
> > +                        * 0 means software toggle which is the
> > default mode.
> > +                        * Hence the +1.
> > +                        */
> > +                       val |= FIELD_PREP(LTC2688_CH_TD_SEL_MSK,
> > clk_input + 1);
> > +
> > +                       /*
> > +                        * If a TGPx is given, we automatically
> > assume a dither
> > +                        * capable channel (unless toggle is
> > already enabled).
> > +                        * On top of this we just set here the
> > dither bit in the
> > +                        * channel settings. It won't have any
> > effect until the
> > +                        * global toggle/dither bit is enabled.
> > +                        */
> > +                       if (!chan->toggle_chan) {
> > +                               val |=
> > FIELD_PREP(LTC2688_CH_MODE_MSK, 1);
> > +                               st->iio_chan[reg].ext_info =
> > ltc2688_dither_ext_info;
> > +                       } else {
> > +                               /* wait, no sw toggle after all */
> > +                               st->iio_chan[reg].ext_info =
> > ltc2688_toggle_ext_info;
> > +                       }
> > +               }
> > +
> > +               if (of_property_read_bool(child, "adi,overrange"))
> > {
> > +                       chan->overrange = true;
> > +                       val |= LTC2688_CH_OVERRANGE_MSK;
> > +               }
> > +
> > +               if (!val)
> > +                       continue;
> > +
> > +               ret = regmap_write(st->regmap,
> > LTC2688_CMD_CH_SETTING(reg),
> > +                                  val);
> > +               if (ret) {
> > +                       of_node_put(child);
> > +                       return dev_err_probe(dev, -EINVAL,
> > +                                            "failed to set chan
> > settings\n");
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +struct regmap_bus ltc2688_regmap_bus = {
> > +       .read = ltc2688_spi_read,
> > +       .write = ltc2688_spi_write,
> > +       .read_flag_mask = LTC2688_READ_OPERATION,
> > +       .reg_format_endian_default = REGMAP_ENDIAN_BIG,
> > +       .val_format_endian_default = REGMAP_ENDIAN_BIG
> 
> + Comma.
> 
> > +};
> > +
> > +static const struct regmap_config ltc2688_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 16,
> > +       .readable_reg = ltc2688_reg_readable,
> > +       .writeable_reg = ltc2688_reg_writable,
> > +       /* ignoring the no op command */
> > +       .max_register = LTC2688_CMD_UPDATE_ALL
> 
> Ditto.
> 
> > +};
> 
> ...
> 
> > +       vref_reg = devm_regulator_get_optional(dev, "vref");
> 
> > +       if (!IS_ERR(vref_reg)) {
> 
> Why not positive conditional check (and hence standard pattern --
> error
> handling first)?
> 
> > +               ret = regulator_enable(vref_reg);
> > +               if (ret)
> > +                       return dev_err_probe(dev, ret,
> > +                                            "Failed to enable vref
> > regulators\n");
> > +
> > +               ret = devm_add_action_or_reset(dev,
> > ltc2688_disable_regulator,
> > +                                              vref_reg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = regulator_get_voltage(vref_reg);
> > +               if (ret < 0)
> > +                       return dev_err_probe(dev, ret, "Failed to
> > get vref\n");
> > +
> > +               st->vref = ret / 1000;
> > +       } else {
> > +               if (PTR_ERR(vref_reg) != -ENODEV)
> > +                       return dev_err_probe(dev,
> > PTR_ERR(vref_reg),
> > +                                            "Failed to get vref
> > regulator");
> > +
> > +               vref_reg = NULL;
> > +               /* internal reference */
> > +               st->vref = 4096;
> > +       }
> 

