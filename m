Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AC18E805
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 11:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCVK1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 06:27:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38748 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVK1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 06:27:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so5590557pgh.5;
        Sun, 22 Mar 2020 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RAxGHRXwEXJ3h4vDKdrVJV5D7I4VTDkjCteTqg0DE4=;
        b=ATE6Wt1XqdxMdfB6ou2BNReL2AzFsbSGPTn5HoGlIN4Q6h7cfr0WqFjvEvVjrY30yT
         Jb+wYwsT8bxXm4+Sh7wct5MsDaHkeXrFnOkd93E0ZBw8hymUaMeV4TTLt5SV4EPYeVsR
         iPaPZQ6ctkYq6Mjq05DnsrrCy5Foxz19G/vbybFsZ3N5OhGga/yCIkeY1GjbIcdq1w+g
         Ju2qRnzfvi9BgDK1piO4F7jg1H3K+iiSM5QON+uLXKbczFZg+drHIrbmKO6ma24Nmpmk
         /da4ek4CdMZKcqANCcRayKiUjjJAa6aRB3qt19mNUTBu2JV+go4LRUC4zxl5901vAZ5h
         Sn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RAxGHRXwEXJ3h4vDKdrVJV5D7I4VTDkjCteTqg0DE4=;
        b=pXGhojYWX7839IPrc+ZvB+q3N+RKzQYcbWbvEdSFbA6ywkbWhJ7/iowSaty8mrA1Q9
         meb7L7RHb0nzBMFDY/KB75FJdohaoZtzPHmHYDE1li7qULg41bSFJLV0rGDp+ioV6x5z
         r9w5JnpPp3hVVmN9fPLtL/lh+nLzlYto1RziQ2MMYQwGOlhePk90Mb+TvGL5SbVZ+6tO
         qSCW1Gm/HplGMT+5eUgY/INXDPoylQPM+jI+Txq5acLV+7BjMcHwZIdk8qbO2gf8nvuc
         /FfhC3Otry3SVZm/G6oAfJRE5OnjZb8D4QQaOU+GiTkvNBIMcHaNdixQyXnCTjIFQ8tM
         /wug==
X-Gm-Message-State: ANhLgQ2iy/H3HOQyYEa1Njav3nxHKpQwRO/mT9zuKL05HgS5DXuIsQAs
        d8HAiTHqr0wGw6lHcTDom1JTxdoEgz8wfJWn51s=
X-Google-Smtp-Source: ADFU+vsOBdai13yG5KtkS+8b8BWb50/R/N+cQ1nIdFkd26CYl5CiTZpnHfGQVrzjz6buvXEsIGim5HwlmqFXmONvLCc=
X-Received: by 2002:a63:798a:: with SMTP id u132mr17648380pgc.203.1584872859132;
 Sun, 22 Mar 2020 03:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <5e723666.1c69fb81.3545b.79c3@mx.google.com> <20200322002542.GA2826015@smile.fi.intel.com>
 <5e77017a.1c69fb81.dc341.8ab9@mx.google.com>
In-Reply-To: <5e77017a.1c69fb81.dc341.8ab9@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 12:27:27 +0200
Message-ID: <CAHp75VddtJs1ZCk1XAZ2WJLhWQDcVwiiN5gDpK9oYPEOS=c_ZQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, dragos.bogdan@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 8:11 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> On Sun, Mar 22, 2020 at 02:25:42AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 18, 2020 at 08:25:22PM +0530, Rohit Sarkar wrote:
> > > scnprintf returns the actual number of bytes written into the buffer as
> > > opposed to snprintf which returns the number of bytes that would have
> > > been written if the buffer was big enough. Using the output of snprintf
> > > may lead to difficult to detect bugs.
> >
> > Nice. Have you investigate the code?
> >
> > > @@ -96,7 +96,7 @@ static ssize_t adis16136_show_serial(struct file *file,
> > >     if (ret)
> > >             return ret;
> > >
> > > -   len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> > > +   len = scnprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> > >             lot3, serial);
> > >
> > >     return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> >
> > The buffer size is 20, the pattern size I count to 19. Do you think snprintf()
> > can fail?
> That might be the case, but IMO using scnprintf can be considered as a
> best practice. There is no overhead with this change and further if the
> pattern is changed by someone in the future they might overlook the
> buffersize

If we cut the string above we will give wrong information to the user space.
I think scnprintf() change is a noise and does not improve the situation anyhow.

So, when anybody modifying such code the test should be performed.


-- 
With Best Regards,
Andy Shevchenko
