Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C90107E6C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKWMvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMvl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:51:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFF9D20658;
        Sat, 23 Nov 2019 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574513500;
        bh=VcQqBg6GDNAXOn4fAhOKNH28W07HsOtsOWrG/Qk4LGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i7flcV814pcX83luI7s0sZh/Nn3WTIhDkvVjsjr7mE8pW5x7bN/WcV1duu1OuvWmz
         78iyCoYx0ROh1GKPt5Bqy4/PklM2o88tOZ67AYbG0BC6icJzm8QCinNh9oHmqI9K4r
         e/WkKWqMAFHryuBiYvFT2HKkRNEAobUttnQyK1fQ=
Date:   Sat, 23 Nov 2019 12:51:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191123125135.4c7efcb0@archlinux>
In-Reply-To: <20191118002504.GA29469@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
        <20191018031848.18538-3-dan@dlrobertson.com>
        <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
        <20191019024351.GB8593@nessie>
        <20191021162016.531e6a2e@archlinux>
        <20191118002504.GA29469@nessie>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 00:25:04 +0000
Dan Robertson <dan@dlrobertson.com> wrote:

> Sorry for the incredibly late reply. Before I submit the next patchset version,
> I have a question from the last set of reviews.
> 
> On Mon, Oct 21, 2019 at 04:20:16PM +0100, Jonathan Cameron wrote:
> > On Sat, 19 Oct 2019 02:43:51 +0000
> > Dan Robertson <dan@dlrobertson.com> wrote:  
> > > On Fri, Oct 18, 2019 at 10:23:38AM +0300, Andy Shevchenko wrote:  
> > > > On Fri, Oct 18, 2019 at 6:44 AM Dan Robertson <dan@dlrobertson.com> wrote:    
> > > > > +static const int bma400_osr_table[] = { 0, 1, 3 };    
> > > >     
> > > > > +/* See the ACC_CONFIG1 section of the datasheet */
> > > > > +static const int bma400_sample_freqs[] = {
> > > > > +       12,  500000,
> > > > > +       25,  0,
> > > > > +       50,  0,
> > > > > +       100, 0,
> > > > > +       200, 0,
> > > > > +       400, 0,
> > > > > +       800, 0,
> > > > > +};    
> > > > 
> > > > This can be replaced by a formula(s).    
> > > 
> > > Yeah I think I can implement the get, set, and read functions for sample_freq
> > > with a formula, but the scale and sample frequency tables are needed by the
> > > implementation of read_avail. A implementation of read_avail with a range and
> > > a step would be ideal, but I couldn't find any documentation on implementing
> > > read_avail where the step value of the range is a multiple. Please correct
> > > me if I've missed something.  
> > 
> > Indeed. We've only defined it as being fixed intervals.
> > I'm not keen to expand the options for the userspace interface any
> > further.  
> > 
> > You could compute the values at startup and store it in your state structure
> > I think (or compute them on demand, but you'd need to have the space somewhere
> > non volatile).
> >   
> 
> I ended up writing an implementation that uses a formula for the get/set
> functions of the sample frequency and scale, but uses a table for the
> implementation of the read_avail function. While it does work, I worry
> that this makes the driver less maintainable and would make it harder to
> add support for a new hypothetical future BMA4xx device. Also, the majority
> of drivers seem to use a table for the raw value to user input conversion,
> so a move from this might make the code less "familiar".
> 
> If we do stick with the translation table, would it be better to have two
> tables (a translation table and a read_avail table) so that we do not have
> a step distance of two? This would mean we would need to maintain two
> tables, but would simplify the code.

If a function is your preferred route you could also just use it to compute
the values for the available table at startup?

Otherwise, its fine to just use a table for both.

> 
> Random workflow question:
> 
> The sampling ratio, frequency, etc code seems to be the most complicated part
> of the driver. Is it typically recommended to upstream a more minimal driver
> that might assume the defaults?

Often people upstream a first version that just uses defaults, then follow
up (if they care) with later series adding the more fiddly elements.

Sometimes those more fiddly bits never come as a particular author
never needed them.  That's absolutely fine.  It's a rare driver
that supports all the features on a non trivial device!

Thanks,

Jonathan

> 
> Cheers,
> 
>  - Dan
> 

