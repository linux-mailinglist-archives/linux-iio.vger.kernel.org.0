Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC72E9BC9
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jan 2021 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhADRMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jan 2021 12:12:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2289 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhADRMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2021 12:12:32 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8hsW6yZ6z67XTR;
        Tue,  5 Jan 2021 01:08:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 18:11:50 +0100
Received: from localhost (10.47.65.160) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 17:11:49 +0000
Date:   Mon, 4 Jan 2021 17:11:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
Message-ID: <20210104171114.000042df@Huawei.com>
In-Reply-To: <CACRpkdbOx0AiFOejZ5gtjQwQNo-qzuRRNVDhjAbAk1pGLMj8Yw@mail.gmail.com>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
        <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
        <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
        <20201213121615.55a86f77@archlinux>
        <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se>
        <20201214150728.00001fa7@Huawei.com>
        <e755c671-a212-e93c-427c-66ab031289c3@axentia.se>
        <20201214163423.00005e6c@Huawei.com>
        <CACRpkdbOx0AiFOejZ5gtjQwQNo-qzuRRNVDhjAbAk1pGLMj8Yw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.160]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Jan 2021 15:45:07 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Dec 14, 2020 at 5:34 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 14 Dec 2020 16:30:22 +0100 Peter Rosin <peda@axentia.se> wrote:  
> 
> > > >> And that gets transformed by the
> > > >> rescaler into the processed values being presented as raw, with rescaling
> > > >> added on top, but with the read_avail info for this new raw channel being
> > > >> completely wrong.
> > > >>
> > > >> For the intended driver (ab8500-gpadc) this is not the case (it has no
> > > >> read_avail for its raw channel). But it does have a raw channel, so adding
> > > >> read_avail seems easy and I can easily see other drivers already doing it.
> > > >> Haven't checked that though...  
> > > >
> > > > Drat. I'd failed to register this is one of those corner cases.  
> > >
> > > I'm not sure, I just browsed the code. Maybe I misread it?  
> >
> > It's doing both - you were right.  I think there are only a small number of
> > drivers that have that history.
> >
> > Looks superficially like it's easy enough to catch this corner case and
> > block it - so lets do that.  
> 
> Sorry if I am a bit confused here. I don't understand what I am supposed
> to do to proceed with using this driver with the ab8500 GPADC...
> 
> Shall I fix something in the AB8500 GPADC as a prerequisite?
> In that case I think I need some more pointers...

I confess I'm a bit lost, but I 'think' the problem we had
left was around read_avail which doesn't play well if we
it defined for the _raw value in the provider, but not the _processed value.

So if we detect their is a _processed channel (which we are going to use) we
just need to make sure that we don't pass the read_avail for _raw through
to be exposed by the rescale driver as the consumer as it will be garbage.
Best plan is probably to just pretend the read_avail for the provider doesn't
exist in this case.

@Peter, does that cover it of are there other similar cases?

It definitely also wants a big fat comment saying why we are hiding this!

Jonathan


> 
> Yours,
> Linus Walleij

