Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681002D8F00
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406162AbgLMRSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405500AbgLMRSZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:18:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A582313B;
        Sun, 13 Dec 2020 17:17:43 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:17:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio:pressure:ms5637: limit available sample
 frequencies
Message-ID: <20201213171740.66079670@archlinux>
In-Reply-To: <CAHp75Vf7A7e4RC2_wjizsPiGn3EjSPhxq4RA2vSQ0BtKaU1T0Q@mail.gmail.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
        <20201209234857.1521453-4-alexandre.belloni@bootlin.com>
        <CAHp75Vf7A7e4RC2_wjizsPiGn3EjSPhxq4RA2vSQ0BtKaU1T0Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Dec 2020 20:26:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 2:03 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Avoid exposing all the sampling frequencies for chip that only support a
> > subset.  
> 
> > +static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +       struct ms_tp_dev *dev_data = iio_priv(indio_dev);
> > +       int i, len = 0;
> > +
> > +       for (i = 0; i <= dev_data->hw->max_res_index; i++)
> > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%u ", ms5637_samp_freq[i]);  
> 
> Doesn't IIO core have a helper?
read_avail() callback and matching masks provide the infrastructure to do this.
It's not a huge saving in code by the time you've wired it up, but has the
advantage that consumer drivers can get hold of the values.  Mind you
I'm not sure what consumers we are likely to get for pressure drivers any
time soon.

> Also, it's better to use sysfs_emit().

New one to me. Thanks.  sysfs_emit_at() here I guess.

Nice.

Jonathan

> 
> > +       buf[len - 1] = '\n';
> > +
> > +       return len;
> > +}  
> 

