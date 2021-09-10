Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0421406A55
	for <lists+linux-iio@lfdr.de>; Fri, 10 Sep 2021 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhIJKst (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Sep 2021 06:48:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3767 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhIJKst (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Sep 2021 06:48:49 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H5XZw1Rrpz67Nln;
        Fri, 10 Sep 2021 18:45:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 10 Sep 2021 12:47:35 +0200
Received: from localhost (10.52.123.213) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 11:47:35 +0100
Date:   Fri, 10 Sep 2021 11:47:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] iio: ABI: Document in_concentration_co2_scale
Message-ID: <20210910114733.0000446c@Huawei.com>
In-Reply-To: <YToGpTR0aJ97GxG0@smile.fi.intel.com>
References: <20210909094537.218064-1-jacopo@jmondi.org>
        <20210909094537.218064-5-jacopo@jmondi.org>
        <YToGpTR0aJ97GxG0@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.213]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Sep 2021 16:05:41 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Sep 09, 2021 at 11:45:37AM +0200, Jacopo Mondi wrote:
> > Document the 'in_concentration_co2_scale' standard IIO attribute.  
> 
> ...
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale  
> 
> I don't know the history of the discussion about this attribute but it seems
> too specific to have in list of kinda generic ones.
> 
> Shouldn't be rather air / gas / etc used instead of CO2?
> 
I'm not following.  The sensor is measuring c02 concentration (in the air) so
we need to call that out.  Making it more general would mean we couldn't then
handle a sensor that had channels for c02 and oxygen for example.
We don't bother to distinguish the difference between concentration in gas or
liquid because it seemed unneeded.  This is sort of similar to the fact we
don't distinguish gas temperature (say in a humidity sensor) from object temperature
in an IR thermometer.  We could do so if there is a strong reason for it.

Using c02 as a modifier on a concentration channel is in line with how we
handled things like different light frequency ranges ir, visible, red, green, blue.

Jonathan
