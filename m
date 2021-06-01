Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2EC397784
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFAQJS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:09:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3123 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbhFAQJR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:09:17 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvcDw5znPz6M4Ps;
        Tue,  1 Jun 2021 23:55:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:07:34 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:07:33 +0100
Date:   Tue, 1 Jun 2021 17:07:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Peter Rosin <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 9/9] dt-bindings: iio: afe: add binding for
 temperature-sense-amplifier
Message-ID: <20210601170729.000066b1@Huawei.com>
In-Reply-To: <20210601170251.00002ddf@Huawei.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-10-liambeguin@gmail.com>
        <0286de71-1b04-0956-be4e-f38573c6fea2@axentia.se>
        <CBRHJM8ANOSE.2Q5C1FVQS5QOA@shaak>
        <20210601170251.00002ddf@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.71]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Jun 2021 17:02:51 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 31 May 2021 10:03:23 -0400
> "Liam Beguin" <liambeguin@gmail.com> wrote:
> 
> > Hi Peter,
> > 
> > On Mon May 31, 2021 at 3:32 AM EDT, Peter Rosin wrote:  
> > > Hi!
> > >
> > > On 2021-05-30 02:59, Liam Beguin wrote:    
> > > > From: Liam Beguin <lvb@xiphos.com>
> > > > 
> > > > An ADC is often used to measure other quantities indirectly. This
> > > > binding describe one cases, the measurement of a temperature through a
> > > > voltage sense amplifier such as the LTC2997.
> > > > 
> > > > Signed-off-by: Liam Beguin <lvb@xiphos.com>    
> > >
> > > What's the significant difference between this and the RTD binding? Does
> > > not both simply scale/offset a voltage to a temperature?  
> 
> I'm lost: what RTD binding?
Ignore this email - I was reading the series backwards and thought we were
talking about a preexisting binding.

> 
> > >    
> > 
> > The way I looked at it was one binding per sensor type (resistance
> > driven, current driven, and voltage driven).
> > 
> > Thinking about it more, these three bindings could be factorized into
> > one if the user is required to enter parameters "by hand".  
> 
> Don't. They are effectively different types of devices and we just end
> up with a more complex binding if we try to cover them all.
Ignore that as well. If the bindings combine fairly easily it is nice
to do so, but be careful not to throw too many things in together and
make it very hard to write the binding. However, I'm not keen on entirely
generic bindings and would like the channel type at least to come from
the compatible.

> 
> There is an argument to go the other way and actually have bindings for
> individual temperature sensors like the LTC2997.  Then the parameters
> become a driver problem rather than one for the binding.
> 
> Jonathan
> 
> 
> > 
> > These could become something like:
> > - sense-gain-mult
> > - sense-gain-div
> > - sense-offset
> > 
> > I like the idea of having the "datasheet parameters" in the devicetree,
> > but this would be a lot more versatile.
> > 
> > What do you think?
> > 
> > Cheers,
> > Liam
> >   
> > > Cheers,
> > > Peter    
> >   
> 

