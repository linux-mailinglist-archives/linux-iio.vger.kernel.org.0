Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA026F7367
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 12:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKLuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 06:50:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfKKLuP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Nov 2019 06:50:15 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE4F7436E77B1BC29BE4;
        Mon, 11 Nov 2019 19:50:11 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 19:50:06 +0800
Date:   Mon, 11 Nov 2019 11:49:55 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        <gwendal@chromium.org>, <egranata@chromium.org>,
        <kernel@collabora.com>, Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20191111114955.00001031@huawei.com>
In-Reply-To: <20191110151408.GB3984@icarus>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
        <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
        <20190826095612.7455cb05@archlinux>
        <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
        <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
        <20191110151408.GB3984@icarus>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Nov 2019 10:14:08 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Sep 24, 2019 at 04:20:51PM +0200, Fabien Lahoudere wrote:
> > Hi all,
> > 
> > After some discussions and investigation, the timestamp is very
> > important for that sync driver.
> > Google team uses that timestamp to compare with gyroscope timestamp.
> > 
> > So the important data is timestamp and counter value is useless.
> > Just the event of counter increment is important to get a timestamp.
> > 
> > In that case, my idea was to just use an IIO driver with a single
> > channel with IIO_TIMESTAMP. We discuss this here and it seems
> > controversial.
> > 
> > So my question to Jonathan is if we have a timestamp coming from the EC
> > itself, can we consider this timestamp as a good IIO driver?
> > 
> > Any other idea is welcome, however Google team would like to manage
> > only IIO drivers if possible.
> > 
> > Thanks  
> 
> Jonathan,
> 
> Should the the timestamp from the EC be introduced as an IIO driver
> using IIO_TIMESTAMP?

It is is a rather odd driver but I suppose it would be fine with lots
of clear docs on why it is how it is...

> 
> Since there is no corresponding EC Counter driver in the baseline right
> now we don't have a conflict yet. If the EC timestamp is introduced as
> an IIO driver then we should make any future EC Counter driver mutually
> exclusive with the IIO driver in order to prevent any memory space
> conflict. At that point we may deprecate the IIO driver and move the
> timestamp functionality to the corresponding Counter driver.

That route does become somewhat of a mess so I suspect we'd have to have
a single driver supporting both userspace interfaces.  If you are happy
that we'd be adding a bit of legacy to support for ever then we can go
that way.

> 
> That's assuming someone is interested in the Count component enough to
> implement an EC Counter driver; otherwise, the IIO driver will serve
> just fine if timestamp is the only data desired from this device.
> 
> William Breathitt Gray


