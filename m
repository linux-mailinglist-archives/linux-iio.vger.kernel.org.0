Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C272C703B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgK1Rz4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 12:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgK1ERu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 23:17:50 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97492C0613D3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2020 20:09:25 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id v202so7978933oia.9
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2020 20:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RQ32THJAgzk/g+0fz9fFMpn2nsurcrio7fOwJN4HhE0=;
        b=AJXFp55mKdFrves/zgdHNzY9dzK1u5qX/vlAqz+g0rAf2CAdKRXRpOfWYCLOm12up+
         2tYYw7RqfNlPjOfjObJLgnWnghU7on96rhnr3QoBkIa8Jxabgo+aBFHhnocJ4OUicgCs
         fjKP1IL5u2wlpjYtMt5TfuQyC/Me8y44lZAfvsNoH43xCJCHSF1+f5JpsBT8VM+DlC40
         nmLM+cMqMGRQas9sX8CM6Ju7wJTKsUel2pRaXa+5oL0uHNP28evSJgLZMqymtohj1OMb
         XcwhAVdYsq6c//tGd0YiOseW2Lx7vG77dJs+tshykHw2gfeZpfDQZ9mr0Z9m+yDwO33n
         Q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQ32THJAgzk/g+0fz9fFMpn2nsurcrio7fOwJN4HhE0=;
        b=hwFWcXDDRcENtz+Y8z12iUuzW98PpyK9aUi7rrqFZrdNvy+BuVY3+AMABih40xpRue
         2PfcUXQp7fiGJGFcoYvMjbjFUKuhjkxmr9wMfyvMEtm7+l3Y2DSfD24cYtgwr4PRjQY6
         mmBrTMDc+ruywj1x0PJ9Qg8UqexZ6hVs0DmKs1daj7hFhu8tNfuBCgZ6mbth9JBGRAsh
         wHQG/NyjEr5LmNIGy+DJWYCvWQvQRPg43p7E5U59rjTSi7XShcSeLlRsVAeJip2s/lQW
         96d0LZPe1bUS6Ptc4oDYdCpXW11b5H7lTc9ZLF54ealGXiSs91xMgIqr/P1dvtNF0Z7C
         LBqg==
X-Gm-Message-State: AOAM533IK8s0HwVoSPB2NZdzmrtaBzcIH61x3G7TxxFf2b0j+kEQe/iV
        uiOKH2W6kBCYSv4+I9oa3pgVWg==
X-Google-Smtp-Source: ABdhPJxCxa1IqjsKIOyOC7KWtjILCHCUlRB2itoqFfBxbLeno4VQhZIwF/j0ZUS3ebdcaeYsqAS3JA==
X-Received: by 2002:aca:54ca:: with SMTP id i193mr7788504oib.42.1606536564766;
        Fri, 27 Nov 2020 20:09:24 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l1sm5511706otj.17.2020.11.27.20.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 20:09:24 -0800 (PST)
Date:   Fri, 27 Nov 2020 22:09:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
Message-ID: <X8HNcg4fQKbo8yd5@builder.lan>
References: <20201128004038.883289-1-linus.walleij@linaro.org>
 <20201128004038.883289-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128004038.883289-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri 27 Nov 18:40 CST 2020, Linus Walleij wrote:

> This adds an IIO magnetometer driver for the Yamaha
> YAS53x magnetometer/compass chips YAS530 and YAS532.
> A quick survey of the source code released by different
> vendors reveal that we have these variants in the family
> with some deployments listed:
> 
>  * YAS529 MS-3C (2005 Samsung Aries)
>  * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
>  * YAS532 MS-3R (2011 Samsung Galaxy S4)
>  * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
>  * (YAS534 is a magnetic switch)
>  * YAS535 MS-6C
>  * YAS536 MS-3W
>  * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5)
>  * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
> 
> The YAS529 is so significantly different from the
> YAS53x variants that it will require its own driver.
> The YAS537 and YAS539 have slightly different register
> sets but have strong similarities so a common driver
> will probably be reasonable.
> 
> The source code for Samsung Galaxy A7's YAS539 is not
> that significantly different from the YAS530 in the
> Galaxy S Advance, so I believe we will only need this
> one driver with quirks to handle all of them.
> 
> The YAS539 is actively announced on Yamaha's devices
> site:
> https://device.yamaha.com/en/lsi/products/e_compass/
> 
> This is a driver written from scratch using buffered
> IIO and runtime PM handling regulators and reset.
> 

Looks quite nice, just spotted some small things as I was skimming
through the patch.

> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v3:
> - This is posted along with the DT bindings which are
>   in v3 so just number everything as v3.

$subject still says v2...

[..]
> diff --git a/drivers/iio/magnetometer/yamaha-yas53x.c b/drivers/iio/magnetometer/yamaha-yas53x.c
[..]
> +/* On YAS532 the x, y1 and y2 values are 13 bits */
> +static u16 yas532_extract_axis(u8 *data)
> +{
> +	u16 val;
> +
> +	/*
> +	 * These are the bits used in a 16bit word:
> +	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
> +	 *    x  x  x  x  x  x  x  x  x  x  x  x  x
> +	 */
> +	val = get_unaligned_be16(&data[0]);
> +	val >>= 2;
> +	val &= GENMASK(12, 0);

Wouldn't it be easier to follow if you GENMASK out the bits you document
above, then shift them right?

> +	return val;
> +}
[..]
> +/**
> + * yas5xx_measure() - Make a measure from the hardware*
> + * @yas5xx: The device state
> + * @t: the raw temperature measurement
> + * @x: the raw x axis measurement
> + * @y1: the y1 axis measurement
> + * @y2: the y2 axis measurement

* Return: 

To complete the kerneldoc.

> + */
> +static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
> +{
[..]
> +/**

This will result in someone feeling inclined to send a patch to fix the
incomplete kerneldoc.

So please either fill it out, or drop the second '*'.

> + * yas5xx_get_measure() - Measure a sample of all axis and process
> + *
> + * Returned valued are in nanotesla according to some code.
> + */
> +static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
> +{
[..]
> +static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct yas5xx *yas5xx = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(yas5xx->regs), yas5xx->regs);
> +	if (ret) {
> +		dev_err(dev, "cannot enable regulators\n");

regulator_bulk_enable() will log which of the regs it failed ot enable,
so you can omit this.

Regards,
Bjorn
