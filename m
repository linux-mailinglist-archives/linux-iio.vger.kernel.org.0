Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11571B8790
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDYP5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDYP5O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:57:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EE020748;
        Sat, 25 Apr 2020 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587830233;
        bh=gA52eZgAsDc84/SjzzV/YYysCpBQGyT9fzrpoeb2il8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J3qu8IPsYTHazwRGf6THITrGZiVnu4IrkmnnC75tWzjvP3+gXXt9+OLb6/olWN0im
         TlLMEosHCrvVmpi5+UIvp4076vKoMXjjKt1v4VuXf5Zhy7XTB2Z2HNZLDiRaESjo6g
         kQbHv6mep7XFvrz2/eCQvNOBBr62XlKe3P+oqhUM=
Date:   Sat, 25 Apr 2020 16:57:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH v4 4/4] iio: vcnl4000: Add buffer support for
 VCNL4010/20.
Message-ID: <20200425165709.27c63f05@archlinux>
In-Reply-To: <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-5-m.othacehe@gmail.com>
        <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 15:27:14 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 21, 2020 at 10:59 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
> >
> > The VCNL4010 and VCNL4020 chips are able to raise interrupts on data ready.
> > Use it to provide triggered buffer support for proximity data.
> >
> > Those two chips also provide ambient light data. However, they are sampled
> > at different rate than proximity data. As this is not handled by the IIO
> > framework for now, and the sample frequencies of ambient light data are
> > very low, do add buffer support for them.  
> 
> ...
> 
> > +static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct vcnl4000_data *data = iio_priv(indio_dev);
> > +       const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> > +       u16 buffer[8] = {0}; /* 1x16-bit + ts */
> > +       bool data_read = false;
> > +       unsigned long isr;
> > +       int val = 0;
> > +       int ret;
> > +
> > +       ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +       isr = ret;
> > +
> > +       if (test_bit(0, active_scan_mask)) {
> > +               if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
> > +                       ret = vcnl4000_read_data(data,
> > +                                                VCNL4000_PS_RESULT_HI,
> > +                                                &val);
> > +                       if (ret < 0)
> > +                               goto end;
> > +
> > +                       buffer[0] = val;
> > +                       data_read = true;
> > +               }
> > +       }
> > +
> > +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> > +                                       isr & VCNL4010_INT_DRDY);  
> 
> > +       if (ret < 0 || !data_read)  
> 
> I would split them, because they are logically different checks.
> 
> > +               goto end;
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> > +                                          iio_get_time_ns(indio_dev));
> > +
> >  end:
> > +       iio_trigger_notify_done(indio_dev->trig);
> >         return IRQ_HANDLED;
> >  }  
> 
> ...
> 
> > +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +       struct vcnl4000_data *data = iio_priv(indio_dev);
> > +       int ret, ret_disable;
> > +
> > +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +       ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> > +
> > +end:  
> 
> > +       ret_disable = iio_triggered_buffer_predisable(indio_dev);
> > +       if (ret == 0)
> > +               ret = ret_disable;  
> 
> What is this?
> 
> Can't you rather call IIO API first, and then try to handle the rest?

There is an additional complexity here. Alex is in the middle of trying
to refactor all drivers to handle this in the same order so as to
ultimately remote the need to explicitly make that call at all.

So until that is sorted, I think that needs to be the last call made
even if there isn't a driver related reason for the ordering.

It's a big job with lots of complex corner cases so will be a little
while yet I guess before we can do the core rework.

Jonathan

> 
> > +       return ret;
> > +}  
> 

