Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA311FFC7F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 01:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRAke (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Nov 2019 19:40:34 -0500
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17489 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfKRAke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2019 19:40:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574037613; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kKHJB/JBkpXuND1ewDxFWAtjDkqh7l8RaaPwENsSTY/VXPL1aWVT5A1umGdzimqVjBYGpg8DENuiwSSJFf1YzxwkBAH9KEdoqL+q7gN4C9O0c/i6y1NqvTyywQKMVLgd8TXguc00mIZrTac+2rAchj/m6cYywRBpH19hgR3HCww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574037613; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vVcG7rj1gM7TqVyTSElkhfI8bRKA28swvF9hvZnjE/E=; 
        b=lUAppPjb9lSX7PXHWpmn1STXlFQHKNvr5pUhZ5HP6N1EL3DulzAFY3cH6i6sbmo7m8fdl9KwdvCp4A8G5lYDO5pvCvlvZ9i2j30q0TwxN36c44QN0Ws/zw6QJ6D95uk+dqkrCwP6+O7nYmisE/jyOHIIpjzKeCsgAPdjCQCP94U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1574037611136714.0698210392902; Sun, 17 Nov 2019 16:40:11 -0800 (PST)
Date:   Mon, 18 Nov 2019 00:25:04 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20191118002504.GA29469@nessie>
References: <20191018031848.18538-1-dan@dlrobertson.com>
 <20191018031848.18538-3-dan@dlrobertson.com>
 <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
 <20191019024351.GB8593@nessie>
 <20191021162016.531e6a2e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021162016.531e6a2e@archlinux>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry for the incredibly late reply. Before I submit the next patchset version,
I have a question from the last set of reviews.

On Mon, Oct 21, 2019 at 04:20:16PM +0100, Jonathan Cameron wrote:
> On Sat, 19 Oct 2019 02:43:51 +0000
> Dan Robertson <dan@dlrobertson.com> wrote:
> > On Fri, Oct 18, 2019 at 10:23:38AM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 18, 2019 at 6:44 AM Dan Robertson <dan@dlrobertson.com> wrote:  
> > > > +static const int bma400_osr_table[] = { 0, 1, 3 };  
> > >   
> > > > +/* See the ACC_CONFIG1 section of the datasheet */
> > > > +static const int bma400_sample_freqs[] = {
> > > > +       12,  500000,
> > > > +       25,  0,
> > > > +       50,  0,
> > > > +       100, 0,
> > > > +       200, 0,
> > > > +       400, 0,
> > > > +       800, 0,
> > > > +};  
> > > 
> > > This can be replaced by a formula(s).  
> > 
> > Yeah I think I can implement the get, set, and read functions for sample_freq
> > with a formula, but the scale and sample frequency tables are needed by the
> > implementation of read_avail. A implementation of read_avail with a range and
> > a step would be ideal, but I couldn't find any documentation on implementing
> > read_avail where the step value of the range is a multiple. Please correct
> > me if I've missed something.
> 
> Indeed. We've only defined it as being fixed intervals.
> I'm not keen to expand the options for the userspace interface any
> further.  
> 
> You could compute the values at startup and store it in your state structure
> I think (or compute them on demand, but you'd need to have the space somewhere
> non volatile).
> 

I ended up writing an implementation that uses a formula for the get/set
functions of the sample frequency and scale, but uses a table for the
implementation of the read_avail function. While it does work, I worry
that this makes the driver less maintainable and would make it harder to
add support for a new hypothetical future BMA4xx device. Also, the majority
of drivers seem to use a table for the raw value to user input conversion,
so a move from this might make the code less "familiar".

If we do stick with the translation table, would it be better to have two
tables (a translation table and a read_avail table) so that we do not have
a step distance of two? This would mean we would need to maintain two
tables, but would simplify the code.

Random workflow question:

The sampling ratio, frequency, etc code seems to be the most complicated part
of the driver. Is it typically recommended to upstream a more minimal driver
that might assume the defaults?

Cheers,

 - Dan

