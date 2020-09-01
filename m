Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A5258F5B
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgIANrK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 09:47:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728241AbgIANrG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 09:47:06 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AA6FADA0A00693C13AF8;
        Tue,  1 Sep 2020 14:46:57 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 14:46:57 +0100
Date:   Tue, 1 Sep 2020 14:45:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Doug Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] iio: sx9310: Prefer async probe
Message-ID: <20200901144520.0000576c@Huawei.com>
In-Reply-To: <159894383586.334488.2938301456606601581@swboyd.mtv.corp.google.com>
References: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
        <20200829161230.398e0051@archlinux>
        <CAD=FV=W3=kRFH0TzEAX0DWS7jb113LuWUJqVS686EyRzexvoRA@mail.gmail.com>
        <20200829181754.52d3cc3b@archlinux>
        <CAD=FV=VWrXwDwoxBK9y2ZeFEoG-edO4WktdSW0MFZLfbcS2hLQ@mail.gmail.com>
        <159894383586.334488.2938301456606601581@swboyd.mtv.corp.google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Sep 2020 00:03:55 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Doug Anderson (2020-08-31 11:59:37)
> > On Sat, Aug 29, 2020 at 10:18 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > Agreed. However, I'd like a comment next to the place we turn it on
> > > saying what delays we are trying to mitigate by enabling it in this
> > > driver.  
> > 
> > OK, I used function graph to get a trace.  Some of the time is simply
> > i2c transfers, which we do A LOT of during initialization (and i2c
> > transfers aren't known for being instant).  However, that's not the
> > big problem.  Check out the regmap_read_poll_timeout() in
> > sx9310_init_compensation().  20 ms per sleep with a 2 second timeout.
> > This seems to eat over around 220 ms of the time on my system.
> > 
> > So how do you want to do this?  Do you want me to re-post the patch
> > and mention the regmap_read_poll_timeout() in the commit message?  Do
> > you want to just add that to the commit message yourself?
> >   
> 
> I think the suggestion is to put a comment next to the
> PROBE_PREFER_ASYNCHRONOUS flag indicating that
> sx9310_init_compensation() can take a while. 

Yup. That's what I meant. Sorry for lack of clarity.
A comment in the code stops others copying it without making sure they
understand whether it is relevant in their case.  No one is going
to look in commit messages.

> Should the compensation be
> delayed even further though to some time when userspace opens the device
> node?

It's tricky because we may hit it on an individual sysfs read.
We could spin off a thread to do it I suppose, though that would be
more or less the same as allowing async probe.

Jonathan


