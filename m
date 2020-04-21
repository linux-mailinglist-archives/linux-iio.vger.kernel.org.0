Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335921B25F6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDUM1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgDUM1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 08:27:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4760C061A10;
        Tue, 21 Apr 2020 05:27:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b8so6523633pfp.8;
        Tue, 21 Apr 2020 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcPCGo+X4P6lQvnbVXUTULyxTzZEYtZ+EWRiTHYn3DQ=;
        b=M3gZ+WbcJBpiLksSjIr7ws1MN88nDgO/CeBBlKEMVNRzcO/RbKNJcXOz5t745nWda8
         79iPyzLzTW1Ul35gDEFApzY12T8+Z2xoPH1xFgzt7wR5FDC6wpSRTWEci5xz5Okn/Ds7
         /XWuSBBVt2JUS2do0OVxM42uOATmIBV95fSbMquxLyHg4OCl9dpvE/qrXHASkvgv8LmN
         O8Z44QWsmqq/hly2yhS8EssBaia0ds321jcHl1jcS9rkS1HehLEN6On+4i1+F2CfLuds
         OF1S5Z5CCtpyRi3lICYYC1Lec1oeTEIWgyHW2CG0vn9z99SuOk44Sq7zKXCPrNgEfU5q
         4xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcPCGo+X4P6lQvnbVXUTULyxTzZEYtZ+EWRiTHYn3DQ=;
        b=WJNxdBPQ6t4gSPnq0Q1ECFF035jskYnYbup0YRovkczaEhYJlHzJc0hkSuI6ZsUOwA
         7n5kNk9JiiHTGu4SixWVRPK0Nf2U7xZGjxRPgWskBZCX+8/2g9ukgBqVOUhG42BItWfW
         5fBRic2bI/yE5g16dXwyjVVWxlL6pnHZ2ko+ONqny3CwpGFvYnBuk3ZWyiwNKtRhioBP
         kRJOM5krvcU5eqeYV40sO9+sk5m1eqThQ8cGDX86Ytpm2Krj+cyRIH2YPLoEDCL463Hv
         IFU0loZWBF2oYvyrX600S0EzxcWIsGT+N3liIu6XoErDflV8q7/T5PimEWq3c0DKQ846
         yAwA==
X-Gm-Message-State: AGi0PuaNY3MoQIKI9PBBk/RlnV8woT9pPk5BsHIn5jLpjIWiCuaiDcCV
        PdPosX6ZSc2wYO55nsEk2idOJ7iLC1KEUvQr1d7Y6LBQYiA=
X-Google-Smtp-Source: APiQypI0LraROWJfwFObTEG955P+/T7ZlVhrbTl4BiFzplvo1sGDt0epXus0/B89vuQOw30lZ4u8BDnORGSTDX6ZZbI=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr21128973pfa.170.1587472041238;
 Tue, 21 Apr 2020 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200421075532.19192-1-m.othacehe@gmail.com> <20200421075532.19192-5-m.othacehe@gmail.com>
In-Reply-To: <20200421075532.19192-5-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 15:27:14 +0300
Message-ID: <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: vcnl4000: Add buffer support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 21, 2020 at 10:59 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> The VCNL4010 and VCNL4020 chips are able to raise interrupts on data ready.
> Use it to provide triggered buffer support for proximity data.
>
> Those two chips also provide ambient light data. However, they are sampled
> at different rate than proximity data. As this is not handled by the IIO
> framework for now, and the sample frequencies of ambient light data are
> very low, do add buffer support for them.

...

> +static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct vcnl4000_data *data = iio_priv(indio_dev);
> +       const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> +       u16 buffer[8] = {0}; /* 1x16-bit + ts */
> +       bool data_read = false;
> +       unsigned long isr;
> +       int val = 0;
> +       int ret;
> +
> +       ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +       if (ret < 0)
> +               goto end;
> +
> +       isr = ret;
> +
> +       if (test_bit(0, active_scan_mask)) {
> +               if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
> +                       ret = vcnl4000_read_data(data,
> +                                                VCNL4000_PS_RESULT_HI,
> +                                                &val);
> +                       if (ret < 0)
> +                               goto end;
> +
> +                       buffer[0] = val;
> +                       data_read = true;
> +               }
> +       }
> +
> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +                                       isr & VCNL4010_INT_DRDY);

> +       if (ret < 0 || !data_read)

I would split them, because they are logically different checks.

> +               goto end;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +                                          iio_get_time_ns(indio_dev));
> +
>  end:
> +       iio_trigger_notify_done(indio_dev->trig);
>         return IRQ_HANDLED;
>  }

...

> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       struct vcnl4000_data *data = iio_priv(indio_dev);
> +       int ret, ret_disable;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> +       if (ret < 0)
> +               goto end;
> +
> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> +
> +end:

> +       ret_disable = iio_triggered_buffer_predisable(indio_dev);
> +       if (ret == 0)
> +               ret = ret_disable;

What is this?

Can't you rather call IIO API first, and then try to handle the rest?

> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
