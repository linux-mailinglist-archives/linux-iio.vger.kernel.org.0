Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17FB1AEEB1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDRO0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDRO0Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:26:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C932076A;
        Sat, 18 Apr 2020 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219976;
        bh=ktnrLsWQK5RniTFPK28f2WYmfAA2QMMPIbfCR2Ps1gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LLHTrqHtnet+258GGfMbZCooGdvFcQ5Tl2uGspYPkiVM8G7/PF1Pj2NZyh/UcSlca
         fexNUFnZdFsEmPXncTuIR7s5TStXCpWvavS1+WspgPTzDBABZmM4jmbIhLG2Vhy24z
         U8XUDVjPxBghTiUEievSoLYRxYazv7ccZzxfwkcg=
Date:   Sat, 18 Apr 2020 15:26:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Silence deferred-probe
 error
Message-ID: <20200418152611.1a2bf781@archlinux>
In-Reply-To: <CAHp75VdKxRGrmqPDTugVNrc3i_JDyEdJ6gmjyH=t9OiRTGg+AA@mail.gmail.com>
References: <20200417162204.14463-1-digetx@gmail.com>
        <CAHp75VdAn3QYY3gejnsdKuSyaLme1tiksSnoeg9rtzcJNG6S0w@mail.gmail.com>
        <CAHp75VdKxRGrmqPDTugVNrc3i_JDyEdJ6gmjyH=t9OiRTGg+AA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 23:50:37 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 17, 2020 at 11:49 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 17, 2020 at 7:24 PM Dmitry Osipenko <digetx@gmail.com> wrote:  
> > >
> > > It's not uncommon that voltage regulator becomes available later during
> > > kernel's boot process. This patch adds info message about unavailable
> > > regulators in a case of the deferred-probe error and also amends the
> > > error message with a error code.  
> >
> >  
> > > +               if (ret == -EPROBE_DEFER)  
> >  
> > > +                       dev_info(&i2c->dev,
> > > +                                "regulators unavailable, deferring probe\n");  
> >
> > I dunno why you think it is worth to spam log with this?
> > This message will be printed as many times as driver got deferred
> > probe cycle (maybe dozens in worst case).  
> 
> As you may see in other drivers we usually have the opposite check and
> print error message in case of != EPROBE_DEFER.

Definitely is not a good idea to print an info message for deferred.
A debug message maybe but probably not even that.

Jonathan

> 
> 
> >  
> > > +               else
> > > +                       dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);  
> 

