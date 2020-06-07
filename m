Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D731F0D29
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgFGQex (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 12:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgFGQex (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 12:34:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B732067B;
        Sun,  7 Jun 2020 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591547692;
        bh=sOThE1IKe9KBjuIXTWEJeaPX99JKbVjdIbglgHpFnYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tori27Qxc6eVrPCDaK1Ef0g+MdEo/lMT0btUGMBNqg3nZgYKneK8/VH3E6RIEXNix
         zVlUZpwIV+42YsQX4Vsb1090Bp+2Z/cwQZC+Ia6Bpg9bBUagoAi1NFBQZAvoz/mukB
         OWoVgxyFXsw/tBXNAFXwxxBTVVyOd27UEr1CSpVo=
Date:   Sun, 7 Jun 2020 17:34:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/32] iio: accel: kxsd9: Fix alignment of local buffer.
Message-ID: <20200607173449.5d357e3b@archlinux>
In-Reply-To: <CAHp75Ves+9VpAN80RgML=-_2=AyrpYM72Pi6sM6CWxdptiAn2Q@mail.gmail.com>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-2-jic23@kernel.org>
        <CAHp75Ves+9VpAN80RgML=-_2=AyrpYM72Pi6sM6CWxdptiAn2Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 19:05:15 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 7, 2020 at 6:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
> > is not guaranteed by an array of smaller elements.
> >
> > Note that whilst in this particular case the alignment forcing
> > of the ts element is not strictly necessary it acts as good
> > documentation.  
> 
> ...
> 
> > +       struct {
> > +               __be16 chan[4];
> > +               s64 ts __aligned(8);
> > +       } hw_values;  
> 
> I'm not sure what __aligned can do better here? It's naturally will be
> 8 alignment (struct itself due to s64 followed by 4*__be16).
> 
Mainly I put it in all cases even when not needed to ensure that
copy and paste versions keep the alignment statement.  Here I agree
it does nothing but if someone adds another channel to a driver
they might miss that they also need to then add the __aligned(8)
for the timestamp.

Jonathan

