Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29CC3A6315
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhFNLJK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 14 Jun 2021 07:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234827AbhFNLGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:06:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7E56193D;
        Mon, 14 Jun 2021 10:45:44 +0000 (UTC)
Date:   Mon, 14 Jun 2021 11:47:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
Message-ID: <20210614114744.011e5abc@jic23-huawei>
In-Reply-To: <20210614093722.rurmqljcvzvlxpjp@pengutronix.de>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
        <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
        <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
        <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com>
        <CAHp75VfqUftwaGrJVR0qAkLG=-=qNLEV=9fLAC5SCNtt2i_bJg@mail.gmail.com>
        <20210614093722.rurmqljcvzvlxpjp@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 11:37:22 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Mon, Jun 14, 2021 at 11:57:46AM +0300, Andy Shevchenko wrote:
> > +Uwe Kleine-König
> > 
> > On Mon, Jun 14, 2021 at 11:24 AM Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:  
> > > On 6/13/21 1:36 PM, Andy Shevchenko wrote:  
> > > > On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> > > > <jarkko.nikula@linux.intel.com> wrote:  
> > > >>
> > > >> Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev);  
> > > >
> > > > ...
> > > >  
> > > >> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> > > >> +       struct pci_dev *pdev = to_pci_dev(dev);
> > > >>          struct intel_qep *qep = pci_get_drvdata(pdev);  
> > > >
> > > > Why not change both lines to dev_get_drvdata()?
> > > >  
> > > I thought it before and Uwe had a good point why it isn't necessarily a
> > > good idea:
> > >
> > > https://www.spinics.net/lists/linux-pwm/msg15325.html  
> > 
> > I understand this point, but the problem is that we often use
> > different callbacks for different layers. For example, the PM
> > callbacks are operating with generic 'struct device' and using the PCI
> > device there is non-flexible layering violation, so in my opinion it's
> > the opposite to what Uwe says. I.o.w. we need to use corresponding API
> > to what we have in the callbacks. If the callback comes from generic
> > level ==> generic APIs more appropriate.  
> 
> Without having looked at the driver in question: I (think I) understand
> both sides here and both variants have their own downside.
> 
>  - Using dev_get_drvdata() makes use of the fact that pci_set_drvdata()
>    is a wrapper around dev_set_drvdata for the pcidev's struct device.
> 
>  - Using pci_get_drvdata() adds overhead (for humans only though, the
>    compiler doesn't care and creates the same code) and having the pci
>    device in the callback isn't necessary.
> 
> My personal opinion is: The first is the graver layer violation because
> it relies on an implementation detail in the PCI framework. The latter
> is relying on a fact that is local to the driver only: All devices this
> driver is bound to are pci devices. The main benefit of explicitly using
> pci_get_drvdata ∘ to_pci_dev I see is that someone having only shallow
> knowledge of the PCI stuff can easier match a pci_get_drvdata() to the
> pci_set_drvdata() called in .probe() than a dev_get_drvdata() and so
> while it uses a function call/code line more, it is more explicit and
> more obviously correct.
> 
> And regarding your argument about the matching API: I think the above
> code uses the matching API, that is make a pci_dev from a device using
> to_pci_dev().
> 
> So this is about weighting up- and downsides. How you judge them is
> subjective. (Though my judgement is naturally the better one :-)

Personally I'm happy with either

dev_set_drvdata / dev_get_drvdata
or 
pci_set_drvdata / pci_get_drvdata

In this particular case there is a convenient struct device *dev local
variable anyway in the probe() (IIRC) so could have done option 1 with
no loss of readability and a tiny saving in code.

Not worth changing it though is my 0.02€

Jonathan

> 
> Just my 0.02€
> Uwe
> 

