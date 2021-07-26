Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900433D5BC8
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhGZN4d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbhGZN4d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 09:56:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD915C061757;
        Mon, 26 Jul 2021 07:37:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a8001b029017700de3903so127753pjn.1;
        Mon, 26 Jul 2021 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mqmbUYgq5LcNs7/1sZ2TSj7vj+M/0feWm6C3LofmbEY=;
        b=VOJRIBHCVhv2xRu8nSkP5HNhh1qjzEQTo8VGTJMIdARYUU4RpWNt4UhhjoJBOQJKL5
         h44u+Mq45fQjk4ZilNRJjTNnPz+5f65lkw0dBnnN/yxh/TyxRryeL96HFsW190v26tFR
         CuJUtLZsa+lfeyefE44qZp8IcE034PMV3Q86f7k49fYerhhSnTupMzT7dZNJcD++W3rK
         FOPjWMJh1L9hVCCwyGa+IypsXBatfrilMHY6HlPnYKXAt2oEwmhF8wlqfBG9ZacHJMwB
         ItMaWF/WECl8qEEEj/KnWopbaPJ4N1N6t9m9F3pGFCBG4ZM/UhgRf6NfigOLP37n1ism
         cblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mqmbUYgq5LcNs7/1sZ2TSj7vj+M/0feWm6C3LofmbEY=;
        b=RpbuUB8TO7uHC5qIwZtR/Tons2LCbrkWmCtzdtK1WJ+XvcdZ9K2XllRAJzxvmzGHwy
         DJnF+k4lnLzZzkxrutsQtvpdoAqjP1Ihbfcgx7RKqGqxwgqvCPi0NGRXaiiR1C4mTzw7
         i7tODZnL0/cRbS/cid9enjGbbTRB5zNijFASzjqrZ5uCYHwHyv7CcmcSRUsxQbN7cEA1
         Rj/hwBAtMF4yhGqLKObo6BAho3lvdESoIAAkPtG5lmgOWKdKaRIRjlno/FJx8BApoSrr
         tEJh2dIHdbi43R92Jp1BAsZaai+0jIGKfdGMybUbT/zsBFN4USogsbXyIJgFG+P6c4vJ
         LyZg==
X-Gm-Message-State: AOAM530k/vXnuGG9ysiMf5AxwEQPez7t+XfxllhN2RobvfeJdisfxbf+
        rSXCg+IwWZVxbiLytBUJvFh9t+ECmELKMWUCahg=
X-Google-Smtp-Source: ABdhPJxdl6BzQzJ7nxYmCaaugamghmySa3zitoUwQT6DRQr9u3IP5ZtwU6YDsag6n21rzkl/PaQinorsV7obdNcNMSY=
X-Received: by 2002:aa7:8284:0:b029:312:1c62:cc0f with SMTP id
 s4-20020aa782840000b02903121c62cc0fmr18670937pfm.75.1627310221366; Mon, 26
 Jul 2021 07:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <20210717163236.1553fbfa@jic23-huawei>
 <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com> <20210724180823.692b203f@jic23-huawei>
In-Reply-To: <20210724180823.692b203f@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 26 Jul 2021 16:36:49 +0200
Message-ID: <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

just a few of in-line comment below; OK for all the rest of your
comment, thanks!

> > > > +static int bno055_reg_write(struct bno055_priv *priv,
> > > > +                         unsigned int reg, unsigned int val)
> > > > +{
> > > > +     int res = regmap_write(priv->regmap, reg, val);
> > > > +
> > > > +     if (res && res != -ERESTARTSYS) {
> > >
> > > I think Andy asked about these, so I won't repeat...
> > > Nice to get rid of those and just be able to make the regmap calls inline though...
> >
> > Ok for inline. I've just answered in another mail to Andy's comments
> > for the rest.

Indeed, so far I couldn't understand what do you really mean. Should I
move those check+dev_err() inside the regmap core layer ?

> > > > +     /*
> > > > +      * Start in fusion mode (all data available), but with magnetometer auto
> > > > +      * calibration switched off, in order not to overwrite magnetometer
> > > > +      * calibration data in case one want to keep it untouched.
> > >
> > > Why might you? good to have a default that is what people most commonly want...
> > > If there is a usecase for this then it may be better to have a 'disable autocalibration
> > > and manually reload a fixed calibration' path.
> >
> > I'm not sure whether disabling autocalibration for magnetometer is
> > just a matter of saving some power, or whether this has the purpose of
> > carefully doing the calibration far from magnetic disturbances,
> > avoiding screwing the calibration every time you briefly pass by a
> > piece of iron. I think I found some clues for this second
> > interpretation poking on the internet, but I don't know whether they
> > were right.
>
> It's possible if the calibration routines have much faster response than
> you'd normally expect.

This HW function is called "Fast Magnetometer Calibration".. But I
don't know how fast is it..


> > > > +     &iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > > > +     &iio_dev_attr_in_anglvel_range_available.dev_attr.attr,
> > >
> > > Hmm. Range typically maps to something else (normally scale, but these smart
> > > sensors can do weird things)
> >
> > Here the scaling doesn't change, just the range. I *think* that by
> > changing range you also get better or worse precision.
>
> oh goody.  Make sure the default is maximum range + when you document this
> we will have to be careful to make it clear we don't want this to be used in
> drivers where scale is an option.  Perhaps we just put it in a device
> specific ABI file.
>

The default is to run the IMU with fusion mode enabled; in this mode
those parameters are locked by the HW to a given value (which is not
the maximum e.g. in case of accelerometer range).

If the user disables the fusion mode, then those parameters become
tweakable, but shouldn't they just remain at their previous values
(the one set by fusion mode), unless the user change also them?

I.o.w the only chance we have for assigning them a "default" value is
when the fusion is switched off, but this would mean that switching
off fusion mode also has a side effect on those values (which I'm
unsure if we really want to happen).

Andrea
