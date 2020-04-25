Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C11B8725
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDYOtk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 10:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYOtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:49:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B29620704;
        Sat, 25 Apr 2020 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587826179;
        bh=ThRxazgu0GnMamTGTu7DXguxYUMDttvRFkBqDcMi1xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UHgKxx858atr1UQSnwzYD0eeCrdg+aAQ0Zv7GKN+kWITXAj1FVFiyoWwTJspfe0Rc
         EbxabUXYTIifPl5vRz5Q6lRViv+SYsYALTvid5BEZs/HpMh3jpk0iQlB5pb9eCZ5uh
         7s721/KKk9AvprbVH7byDRhtCsEZrPrZnsynfW54=
Date:   Sat, 25 Apr 2020 15:49:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Message-ID: <20200425154935.5da9efd3@archlinux>
In-Reply-To: <CAHp75VfRV4eLun7CoY0WORxzczjyT5GCB3f1d561LrLMx644Ng@mail.gmail.com>
References: <20200419150206.43033-1-jic23@kernel.org>
        <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
        <03f6eb6e7cf61c6dfd8bcd9aeaaf6977cb095191.camel@analog.com>
        <20200420164832.00004065@Huawei.com>
        <CAHp75VfRV4eLun7CoY0WORxzczjyT5GCB3f1d561LrLMx644Ng@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:50:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Apr 20, 2020 at 6:49 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 20 Apr 2020 06:22:09 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:  
> > > On Mon, 2020-04-20 at 06:04 +0000, Ardelean, Alexandru wrote:  
> > > > On Sun, 2020-04-19 at 16:01 +0100, jic23@kernel.org wrote:  
> 
> > > One thing I noticed in the series.
> > > No idea if it is needed or not; a build would tell:
> > >    Is '#include <linux/mod_devicetable.h>' required for this change?
> > > Most patches add it, but I don't feel it is needed; I could be wrong though.  
> >
> > I addressed this in reply to patch 7.  It's mainly obtained via
> > i2c.h and spi.h in these drivers.  They don't have any particular need
> > to include it as they could deal with an opaque pointer.
> >
> > However, seems unlikely that'll get tidied up any time soon and
> > debatable whether there is any point in doing so.  
> 
> I would use the simple rule, we include header if we have direct user of it.
Sensible and easy to understand basis to make the decision. Let's go
with that (though I don't want to see lots of isolated 'fixes' for
'missing' headers!)

> 
> > > What I noticed is that all 'linux/of.h' , 'linux/of_device.h' &
> > > 'linux/of_platform.h' include it.  
> >
> > True, but we shouldn't include any of them unless we have reason to do
> > so. They bring baggage we don't need for these drivers.  
All applied with patch 7 amended to add the include.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with them.

Thanks,

Jonathan

> 
> 
> --
> With Best Regards,
> Andy Shevchenko

