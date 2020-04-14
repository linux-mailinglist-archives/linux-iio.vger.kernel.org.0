Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD51A897D
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgDNS1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbgDNS1D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:27:03 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695D420575;
        Tue, 14 Apr 2020 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586888822;
        bh=hFNLUX5d/6VjCP7/nuZYKMX4WhCYb5wTCkL0pjVz/cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfkRvFH+I62D7vY0osPBoSlwtLFj+YlTQoGNl+0cFfI0eT8RGcsAOzn9YFaFgBr30
         yYmRl17e3QJGZhIT+P46p+34M/AZjL9kgNbvoIAPXaroKE/5s9lvflOytQJkBEaLHD
         z/MAq1RwZ2lakZ8V3g78Ch4POz83wHQ77jekgUKU=
Date:   Tue, 14 Apr 2020 23:56:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
Message-ID: <20200414182652.GA29921@Mani-XPS-13-9360>
References: <20200414153415.957-1-mani@kernel.org>
 <20200414153415.957-3-mani@kernel.org>
 <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com>
 <20200414170547.GB3334@Mani-XPS-13-9360>
 <CAHp75Vfk3aw30j8U+BJiobU6s2KsOis_VyUv4+6csbYLFnV9eg@mail.gmail.com>
 <20200414191259.5fbfdc2a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414191259.5fbfdc2a@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 07:12:59PM +0100, Jonathan Cameron wrote:
> On Tue, 14 Apr 2020 20:54:49 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, Apr 14, 2020 at 8:06 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > On Tue, Apr 14, 2020 at 07:42:24PM +0300, Andy Shevchenko wrote:  
> > > > On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:  
> > 
> > ...
> > 
> > > > > +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > > > > +                                            GPIOD_OUT_LOW);
> > > > > +       if (IS_ERR(reset_gpio)) {  
> > > >  
> > > > > +               dev_err(&client->dev, "Failed to acquire reset gpio\n");  
> > > >
> > > > If it's a deferred probe, it would spam the log.
> > > >  
> > >
> > > Hmm. But error is an error isn't it? Would you recommend doing a debug print
> > > or completely removing the logging?  
> > 
> > I would remove completely, but better to wait for Jonathan to comment.
> > Maybe he prefers something like
> >   if (err != EPROBE_DEFER)
> >     dev_err()
> 
> Not fussed.  Either drop it or do the check for defer - one I leave up to the
> author.
> 

Okay, will just drop it.

Thanks,
Mani

> > 
> > > > > +               return PTR_ERR(reset_gpio);
> > > > > +       }  
> > > >
> > > > ...
> > > >  
> > > > > +               static const u8 reset_seq[] = {
> > > > > +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> > > > > +               };  
> > > >
> > > > I would suggest to comment above from where you got this and the
> > > > meaning of the numbers.
> > > >  
> > >
> > > The datasheet doesn't specify the meaning of these values. But will add a
> > > comment.  
> > 
> > Thanks!
> > 
> > > Btw, just noticed that 0xFF is not needed and only 4 values are
> > > sufficient for SW reset.  
> > 
> > Better to do exactly what datasheet suggests (in case it's not clear
> > or deductible what is going on).
> > 
> 
