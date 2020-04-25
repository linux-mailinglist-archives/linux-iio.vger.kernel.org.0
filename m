Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625831B87A1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYQJR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQJR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:09:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BA32071E;
        Sat, 25 Apr 2020 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587830957;
        bh=D7BBrL9B2g9quMzqYC+c4PGNXXBaDGjBMYSEbY32ULE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xeQTsz2HowrC1MlzlTj2hmjl0g1HBpL4QMQd4eQQgwiFaPnQ7oo0eo7dmBauz4T6o
         WyGw0T6zCQL5UTFRIer4KBtK7MiIvEhSX8Ar0sDZZs8y61zG4OM9UCX1JhpKisa0au
         X9EPrFUPlxq9/11HGewHL9ipn+z3Qbrosh3ReYCA=
Date:   Sat, 25 Apr 2020 17:09:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] iio: vcnl4000: Add buffer support for
 VCNL4010/20.
Message-ID: <20200425170912.17c3435a@archlinux>
In-Reply-To: <87tv1cos2q.fsf@gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-5-m.othacehe@gmail.com>
        <CAHp75VfXBgQad1oCBe+oqcC_oRa-3q8OBYcAOV8WfCo7n1wXWw@mail.gmail.com>
        <87tv1cos2q.fsf@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 10:14:21 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> >> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
> >> +{
> >> +       struct vcnl4000_data *data = iio_priv(indio_dev);
> >> +       int ret, ret_disable;
> >> +
> >> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> >> +       if (ret < 0)
> >> +               goto end;
> >> +
> >> +       ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> >> +
> >> +end:  
> >  
> >> +       ret_disable = iio_triggered_buffer_predisable(indio_dev);
> >> +       if (ret == 0)
> >> +               ret = ret_disable;  
> >
> > What is this?
> >
> > Can't you rather call IIO API first, and then try to handle the rest?  
> 
> Well, iio_triggered_buffer_predisable will call free_irq which requires
> that the interruption source is disabled, hence this strange pattern.
> 
> However, this may be some misunderstanding from me, but I noticed
> something strange here. In a configuration with one CPU and
> CONFIG_PREEMPT disabled, I have kernel lockups when disabling the
> buffer.
> 
> This is because free_irq calls synchronize_irq that will wait for any
> IRQ handler to be over. If the kthread handling the interruption is
> still running, it has no chances to terminate, and synchronize_irq waits
> forever. So maybe I'm missing something.

That is indeed worrying.  The synchronize_irq is documented as
sleeping if we have a threaded interrupt.  From a quick look I'd have
expected the wait in there to result in the interrupt thread being able
to complete whether or not we had preemption enabled.

I wonder what I'm missing...

Jonathan


> 
> Anyway, I'll send a v5 addressing your remarks.
> 
> Thanks,
> 
> Mathieu

