Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9CB127FBF
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLTPnu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Dec 2019 10:43:50 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17179 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTPnu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 10:43:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576856617; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LMfAddAC147eF5m77yvmXtqBvWmzPz8EeM2CLg/O2oKsihO159fCaKZNAIdl+JtIqPRpT6QwsyZvE2pyPitqWgFoHWSR8mst+1bZmyhjSXSKwrgNv21iyY60GkBMesduxm3HopdH14oWSjK2+ldR/BxnPJZPPfdh03fYjLnt6jw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576856617; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ELXCfpLFeQLNeL9QjnCCUngKGgfk8dL/TAnQ4db+uqs=; 
        b=fdiUXZnwWeK5DxojtYqIUglgxCAUgdU93kUYA4cRBK67fgNvv5ODmXCr6D9pzABvTz/y9QtJklZkX46F3cJlxFh6FIHkIJnG2KUaAFnqa1aaaux3874olKeYVbPgT+feEiHhYSm1hT5r2vndVTy76Wo7x+N50JGwRFnLth9nTlc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576856616397592.4934687792177; Fri, 20 Dec 2019 07:43:36 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:28:05 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
Message-ID: <20191220152805.GD16415@nessie>
References: <20191219041039.23396-1-dan@dlrobertson.com>
 <20191219041039.23396-3-dan@dlrobertson.com>
 <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com>
 <20191220043220.GA16415@nessie>
 <CAHp75Vec5ADoFH9KoTnU5+uEZvGqS2+NUN+MLTiwzofDtGG0+A@mail.gmail.com>
 <CAHp75VdzE4uKKJ_5g8eMZR+GSX9W+7Lc+kh2OYt5o7_8_NHTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdzE4uKKJ_5g8eMZR+GSX9W+7Lc+kh2OYt5o7_8_NHTpw@mail.gmail.com>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 20, 2019 at 11:32:42AM +0200, Andy Shevchenko wrote:
> On Fri, Dec 20, 2019 at 11:27 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Dec 20, 2019 at 6:48 AM Dan Robertson <dan@dlrobertson.com> wrote:
> > > On Thu, Dec 19, 2019 at 01:02:28PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Dec 19, 2019 at 6:27 AM Dan Robertson <dan@dlrobertson.com> wrote:
> >
> > > > > +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> > > > > +                                            int hz, int uhz)
> > > > > +{
> > > > > +       unsigned int idx;
> > > > > +       unsigned int odr;
> > > > > +       unsigned int val;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> > > > > +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> > > > > +                       return -EINVAL;
> > > > > +
> > > > > +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> > > >
> > > > Again, AFAICS division may be avoided in both cases (% and / above)
> > > > because of is_power_of_2() check below.
> > > > Can you revisit this?
> > >
> > > Yeah I can update this in the next patchset, but I don't know if it is much more
> > > readable this way.
> >
> > You may describe the algo in the comment.
> >
> > Let's see how it might look like
> >
> >   if (uhz)
> >     return -EINVAL;
> >   idx = __ffs(val);
> >   /* We're expecting value to be 2^n * ODR_MIN_WHOLE_HZ */
> >   if ((val >> idx) != BMA400_ACC_ODR_MIN_WHOLE_HZ)
> 
> Okay, this would require trickier conditional for the cases when
> MIN_WHOLE_HZ can be divided by 2^k...
> Still from performance point of view it might be much faster than division.

I think the other checks will ensure we return -EINVAL in those cases. I ran a
basic for loop and verified this.

Cheers,

 - Dan

