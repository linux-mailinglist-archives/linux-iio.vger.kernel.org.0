Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3818F939
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 17:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCWQFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 12:05:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:46754 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgCWQFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 12:05:34 -0400
IronPort-SDR: t/H1DBiayEHmqAkdDEAoeAGIG4Ez1Aax5SU24Fn9IRHigGJ0q7+WqNXxwASdxg6cxohpjejQun
 +NBivTErJfBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 09:05:33 -0700
IronPort-SDR: 7O/Nrp0ZmN2eUWqYaSNVfMn+7z3XKsjRcZ2D6zOChIXsFrixHltSjKSGQKeMNLmc6hj0/jdKmS
 lWbogD1KkJLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="246241169"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2020 09:05:30 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jGPa0-00CHXi-RE; Mon, 23 Mar 2020 18:05:32 +0200
Date:   Mon, 23 Mar 2020 18:05:32 +0200
From:   'Andy Shevchenko' <andy.shevchenko@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
Message-ID: <20200323160532.GS1922688@smile.fi.intel.com>
References: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
 <20200322002542.GA2826015@smile.fi.intel.com>
 <5e77017a.1c69fb81.dc341.8ab9@mx.google.com>
 <CAHp75VddtJs1ZCk1XAZ2WJLhWQDcVwiiN5gDpK9oYPEOS=c_ZQ@mail.gmail.com>
 <81821e142e3c48febb7ab357dd200992@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81821e142e3c48febb7ab357dd200992@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 03:04:23PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 22 March 2020 10:27
> > On Sun, Mar 22, 2020 at 8:11 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> > >
> > > On Sun, Mar 22, 2020 at 02:25:42AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Mar 18, 2020 at 08:25:22PM +0530, Rohit Sarkar wrote:
> > > > > scnprintf returns the actual number of bytes written into the buffer as
> > > > > opposed to snprintf which returns the number of bytes that would have
> > > > > been written if the buffer was big enough. Using the output of snprintf
> > > > > may lead to difficult to detect bugs.
> > > >
> > > > Nice. Have you investigate the code?
> > > >
> > > > > @@ -96,7 +96,7 @@ static ssize_t adis16136_show_serial(struct file *file,
> > > > >     if (ret)
> > > > >             return ret;
> > > > >
> > > > > -   len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> > > > > +   len = scnprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> > > > >             lot3, serial);
> > > > >
> > > > >     return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> > > >
> > > > The buffer size is 20, the pattern size I count to 19. Do you think snprintf()
> > > > can fail?
> > > That might be the case, but IMO using scnprintf can be considered as a
> > > best practice. There is no overhead with this change and further if the
> > > pattern is changed by someone in the future they might overlook the
> > > buffersize
> > 
> > If we cut the string above we will give wrong information to the user space.
> > I think scnprintf() change is a noise and does not improve the situation anyhow.
> 
> If, for any reason, any of the values are large the user will get
> corrupt data.

> But you don't want to leak random kernel memory to the user.

How? Kernel already got crashed at this point.

> 
> So while you may be able to prove that this particular snprintf()
> can't overflow, in general checking it requires knowledge of the code.

Here it's still a noise.

> With scnprintf() you know nothing odd will happen.

...and quite likely hide a lot of issues.

Really any "micro" / "small" correction / optimization to be very carefully
thought through.

> FWIW I suspect the 'standard' return value from snprintf() comes
> from the return value of the original user-space implementations
> which faked-up a FILE structure on stack and just silently discarded
> the output bytes that wouldn't fit in the buffer (they'd usually
> by flushed to a real file).
> The original sprintf() just specified a very big length so the
> flush would never be requested.

-- 
With Best Regards,
Andy Shevchenko


