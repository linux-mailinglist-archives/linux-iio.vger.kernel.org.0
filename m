Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF864E3C6F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiCVK2y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 06:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiCVK2y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 06:28:54 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677D252BE
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:27:26 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 2so10572716vse.4
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jJmINjJKg80LveJCwvqZHfQ8+WlS3IsI9JkMuHyHGPM=;
        b=FYNvS4hpBmJ5P+A2K/e0O7O/yC4JLJTgatjbhmh0v8pPtJqqkt13KbLw5oxPCfEOqG
         fJmnPdEy8/Vg1CLLkBIZnuKH9r06q0o5jzI41BiOg6wNVM9nYPjDHoTzi5xS3NOWf6DT
         V9KlENR1Rwh0TAOSUR8XiMQHSRWZJl7s/gboJm6b6CxUmPCT3TVlJelQucV9QljB6HA8
         3O/HkVeq8ouNG/3gtB43Oxq16aAColnULnQmW8lZCMs8ah/+XlLqlSix0/pzxnxebM4d
         vG9I4DeM4ozTctQrLB++Xhdz1gvgGK+nUq1/c0X21m6HCJYZ/iGOG7ZHnmdqgxZdRt6Y
         bkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jJmINjJKg80LveJCwvqZHfQ8+WlS3IsI9JkMuHyHGPM=;
        b=5CjIAC+uz0zZtjIymhCiwyNMH2LjY4NfBUn7x2iVrh0sydJVEt3H6O8OhhayfsJipZ
         jqi3mfYw3Ztnp9x8Hf4KvqEhLdteJo2EESqE8nrCcUvUAUv2pRd6i95JnQU12ICZYzgI
         LNK2yFKxyXG1co5/UtbTWDL8KjoepQEg/rit+9vhvi9aw7EguG/cc9fABTZLhU/TKDbM
         cD5+bCdWNf6x7bXCInLNDT6aXEc8kpsiE4G9yiRRBlb/y0zgR8mweQZ2DjvJvAhlDtZ2
         95pNSRbXePkloIir02XPcudBylN+sLZ1N5OshyjbNOA2dEOSqx1UhpafdT5a4FN/hNy7
         Aq0A==
X-Gm-Message-State: AOAM532732U1bB73J+gQATDk9nVBru+PkTpLTJhp9e9J9oE4BkPpC3AR
        4PTVgb1AC/4h04UbG415dfUvhxgRR3kDf5F/sIEtWihVqJ4=
X-Google-Smtp-Source: ABdhPJxpP/WNG3Ek47+SUr7Z7CLPmiVFaGBTm5vUnOjclR5aTf64coURTDgdyxzpwfWPyCDhV4mRKKXCLlDETJWbwOg=
X-Received: by 2002:a05:6102:284a:b0:31e:c455:5dee with SMTP id
 az10-20020a056102284a00b0031ec4555deemr8578776vsb.27.1647944845988; Tue, 22
 Mar 2022 03:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-8-andrea.merello@gmail.com> <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
 <20220219174141.4937297a@jic23-huawei>
In-Reply-To: <20220219174141.4937297a@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 22 Mar 2022 11:27:14 +0100
Message-ID: <CAN8YU5OCEBTF37hb6ozaguJ0=svPyv+fmGGsLhoBCPZA5Odgdw@mail.gmail.com>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
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

Il giorno sab 19 feb 2022 alle ore 18:34 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 17 Feb 2022 22:58:14 +0100 (CET)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>
> > On Thu, 17 Feb 2022, Andrea Merello wrote:
> >
> > nice work, minor comments below
>
> I'll review on top of Peter to save on duplication.
>
> Mostly really minor stuff.

:)

As usual, comments inline; OK for all the rest.

> Given this has crossed with the introduction of namespaces to quite
> a few IIO drivers (I have another series to do on that once I get
> caught up with reviews) I'd prefer it if you would move this into
> a symbol namespace (EXPORT_SYMBOL_NS_GPL() and appropriate namespace
> statements in the two bus modules.
>
> Save it being done as a follow up series.  If you prefer not to then
> that's fine too as it'll be a trivial follow up patch.

I'll include it in V4 directly.

[...]

> > > +   case IIO_CHAN_INFO_SCALE:
> > > +           /* Table 3-31: 1 quaternion = 2^14 LSB */
> > > +           if (size < 2)
> > > +                   return -EINVAL;
> > > +           vals[0] = 1;
> > > +           vals[1] = 1 << 14;
> > > +           return IIO_VAL_FRACTIONAL_LOG2;
>
> This doesn't look right.  Not vals[1] = 14 given FRACTIONAL_LOG2?

Hum.. maybe just IIO_VAL_FRACTIONAL ?

> > > +   default:
> > > +           return -EINVAL;
> > > +   }
> > > +}
> > > +

[...]

> > > +static IIO_DEVICE_ATTR_RO(sys_calibration_auto_status, 0);
> > > +static IIO_DEVICE_ATTR_RO(in_accel_calibration_auto_status, 0);
> > > +static IIO_DEVICE_ATTR_RO(in_gyro_calibration_auto_status, 0);
> > > +static IIO_DEVICE_ATTR_RO(in_magn_calibration_auto_status, 0);
> > > +static IIO_DEVICE_ATTR_RO(calibration_data, 0);
>
> This is documented as providing binary data but it's not using
> a binary attribute and that rather surprised me.
>
> Off the top of my head I can't recall why it matters though, so please
> take a look at whether a bin_attribute makes more sense for this.

As far as I can see, it seems that a non-binary attributes only
support to be read at once while the binary attributes read()
operation supports random access i.e. it has the file position
parameter.

The calibration data is "dynamic", it's read from the HW every time,
and I'm not sure it makes any sense to read it in several chunks (what
if we read a chunk and the calibration data is updated by the HW
before reading the second chunk?). So, despide the fitting "binary"
name I'm tempted to stick with regular attribute. However I'm not sure
this is the only difference related to binary attributes.

> > > +
> > > +static IIO_DEVICE_ATTR_RO(serial_number, 0);
> > > +
> > > +static struct attribute *bno055_attrs[] = {
> > > +   &iio_dev_attr_in_accel_range_raw_available.dev_attr.attr,
>
> discussed in ABI documentation review.
> I think these should be range_input to avoid implication they are
> in _raw units (i.e. need _scale to be applied)

They are raw indeed; they need scale to be applied, then they become m/s^2.

I'll fix the doc to clarify this.

[...]

> > > +
> > > +   priv->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > > +   if (IS_ERR(priv->reset_gpio))
> > > +           return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO");
> > > +
> > > +   priv->clk = devm_clk_get_optional(dev, "clk");
> > > +   if (IS_ERR(priv->clk))
> > > +           return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get CLK");
> > > +
> > > +   ret = clk_prepare_enable(priv->clk);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ret = devm_add_action_or_reset(dev, bno055_clk_disable, priv->clk);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   if (priv->reset_gpio) {
> > > +           usleep_range(5000, 10000);
> > > +           gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > > +           usleep_range(650000, 750000);
>
> Not a toggle on the reset?  I'd expect it to be set and then unset after
> a pulse.

Isn't the above devm_gpiod_get_optional() call that also initialize
the initial GPIO value (then just wait and flip here) ?

[...]
