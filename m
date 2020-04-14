Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B31A88D1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503592AbgDNSNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503582AbgDNSNE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:13:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B67D2076B;
        Tue, 14 Apr 2020 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887983;
        bh=MxhcnlW81VsV17mkWy15j+5bMW2ccK4uq1z9d7Gyt30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rkSGqsd+MOUZtr5bJdl0CYKZlO1iMXVNnBSkKtqwQjN4byXGPLyVjzL0sd4VHex8s
         v9028qp/IP9VM8GjEbKhLFnMM7Jri2eD4EKHBu06HwT3ROuE8WhWgZKjuau2UFHWML
         RUUHut1mYQXH8pS+pnHzx8YHrLGMOK1LuIh7h1Ik=
Date:   Tue, 14 Apr 2020 19:12:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset
 and Wakeup in CCS811
Message-ID: <20200414191259.5fbfdc2a@archlinux>
In-Reply-To: <CAHp75Vfk3aw30j8U+BJiobU6s2KsOis_VyUv4+6csbYLFnV9eg@mail.gmail.com>
References: <20200414153415.957-1-mani@kernel.org>
        <20200414153415.957-3-mani@kernel.org>
        <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com>
        <20200414170547.GB3334@Mani-XPS-13-9360>
        <CAHp75Vfk3aw30j8U+BJiobU6s2KsOis_VyUv4+6csbYLFnV9eg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 20:54:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 14, 2020 at 8:06 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Tue, Apr 14, 2020 at 07:42:24PM +0300, Andy Shevchenko wrote:  
> > > On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:  
> 
> ...
> 
> > > > +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > > > +                                            GPIOD_OUT_LOW);
> > > > +       if (IS_ERR(reset_gpio)) {  
> > >  
> > > > +               dev_err(&client->dev, "Failed to acquire reset gpio\n");  
> > >
> > > If it's a deferred probe, it would spam the log.
> > >  
> >
> > Hmm. But error is an error isn't it? Would you recommend doing a debug print
> > or completely removing the logging?  
> 
> I would remove completely, but better to wait for Jonathan to comment.
> Maybe he prefers something like
>   if (err != EPROBE_DEFER)
>     dev_err()

Not fussed.  Either drop it or do the check for defer - one I leave up to the
author.

> 
> > > > +               return PTR_ERR(reset_gpio);
> > > > +       }  
> > >
> > > ...
> > >  
> > > > +               static const u8 reset_seq[] = {
> > > > +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> > > > +               };  
> > >
> > > I would suggest to comment above from where you got this and the
> > > meaning of the numbers.
> > >  
> >
> > The datasheet doesn't specify the meaning of these values. But will add a
> > comment.  
> 
> Thanks!
> 
> > Btw, just noticed that 0xFF is not needed and only 4 values are
> > sufficient for SW reset.  
> 
> Better to do exactly what datasheet suggests (in case it's not clear
> or deductible what is going on).
> 

