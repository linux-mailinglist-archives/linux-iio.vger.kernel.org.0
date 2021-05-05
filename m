Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879F9373642
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEEI3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 04:29:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2996 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEEI3T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 04:29:19 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FZqQX1XZwz6wj4w;
        Wed,  5 May 2021 16:20:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 10:28:21 +0200
Received: from localhost (10.52.120.138) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 5 May 2021
 09:28:21 +0100
Date:   Wed, 5 May 2021 09:26:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 4/4] hwmon: vcnl3020: add hwmon driver for intrusion
 sensor
Message-ID: <20210505092642.00002035@Huawei.com>
In-Reply-To: <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
        <20210430152419.261757-5-i.mikhaylov@yadro.com>
        <20210430163831.GA3163069@roeck-us.net>
        <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.138]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 May 2021 22:46:53 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> On Fri, 2021-04-30 at 09:38 -0700, Guenter Roeck wrote:
> > On Fri, Apr 30, 2021 at 06:24:19PM +0300, Ivan Mikhaylov wrote:  
> > > Intrusion status detection via Interrupt Status Register.
> > > 
> > > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>  
> > 
> > I think this should, if at all, be handled using the
> > iio->hwmon bridge (or, in other words, require a solution
> > which is not chip specific).  
> 
> Thanks a lot for suggestion, it's actually looks what's needed here instead of
> this driver. Anyways, there is no IIO_PROXIMITY support inside supported types
> in iio_hwmon.c. Should I add additional case inside this driver for
> IIO_PROXIMITY type?
> 
> > I am also not sure if "proximity" is really appropriate to use
> > for intrusion detection in the sense of hardware monitoring.
> > This would require a proximity sensor within a chassis, which
> > would be both overkill and unlikely to happen in the real world.
> > "Intrusion", in hardware monitoring context, means "someone
> > opened the chassis", not "someone got [too] close".
> >   
> 
> I'm not sure either but it exists :) And it's exactly for this purpose:
> "someone opened the chassis", "how near/far is cover?".
> 

Hmm. So we will have somewhat of an impedance mismatch.

In IIO events are push based (typically interrupt driven).
There is also the issue that we don't currently have in kernel
interfaces to allow drivers like iio-hwmon to use them (there
has never been enough demand though it has been discussed a few
times).   As such we'd need to implement the core support for
that as well.   We might get away with some simplifications that
make this not too painful - e.g. avoid the need to filter events
by stating that a consumer may well get events it's not interested
in and it is up to the consumer to check (a later optimization could
then add filtering similar to what we do for main data flows).

Jonathan
