Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA81B4BA9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDVRZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 13:25:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2083 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgDVRZn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 13:25:43 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 02D717413FAEC5D030D6;
        Wed, 22 Apr 2020 18:25:42 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 22 Apr
 2020 18:25:41 +0100
Date:   Wed, 22 Apr 2020 18:25:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: inquiry: where to place iio/ bandpass filter driver
Message-ID: <20200422182540.0000410f@huawei.com>
In-Reply-To: <a67b5e24-94df-cc84-73ae-004c0a27a26a@gtsys.com.hk>
References: <55472b69-c587-ca04-d3b9-c8615e6a652d@gtsys.com.hk>
        <20200417102350.00003a28@Huawei.com>
        <a67b5e24-94df-cc84-73ae-004c0a27a26a@gtsys.com.hk>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 08:37:13 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Jonathan,
> 
> On 17/4/2020 5:23 pm, Jonathan Cameron wrote:
> > On Thu, 16 Apr 2020 11:48:31 +0800
> > Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
> >  
> >> Hi,
> >>
> >> I'm working on implementation for ltc6602 dual match bandpass
> >> filter spi driver.
> >> The driver tree has a iio/frequency which has PLLs at time beeing
> >> and I wondering to drop my driver there or have a new directory
> >> freqfilter or bpf ?
> >>
> >> This isn't urgent, but would be nice to know.
> >>  
> > Perhaps iio/afe?  It's a type of analog front end (or might be used
> > as such). Is the intent to wrap these up as a consumer of an ADC?
> > So they ultimately provide a unified device presentation to
> > userspace of the ADC + filters. Or are we looking at simply
> > controlling a filter which doesn't connect to an ADC or DAC visible
> > to us?
> >
> > I'm not against a new directory for filters though.  Don't be
> > specific on the type unless we need to be :)
> >
> > Jonathan  
> I place the driver into afe, makes totally sense to me, but have to
> create a directory
> linux/iio/afe which is not existing while I write this.

curious.  It was introduced in 4.18.

What tree are you working on top of?

> 
> will be then:
> drivers/iio/afe/ltc6602.c
> include/linux/iio/afe/ltc6602.h

possibly on the header, but most IIO drivers don't have their own
header. For kernel code it is preferred to put as much as possible
directly in the c file.  The exceptions are drivers needing multiple
files or where the header is used in conjunction with a DT binding.

> add entry to drivers/iio/afe/Kconfig + Makefile.
> 
> If i have the driver ready and checked I send my patches

Great.

Jonathan
> 
> Cheers
> Chris
> 
> >> Regards
> >> Chris  
> >  
> 

