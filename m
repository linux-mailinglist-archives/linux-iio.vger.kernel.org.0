Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A899B186B5F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgCPMtJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:49:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2565 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbgCPMtJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 08:49:09 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E6D132FC0547468146FE;
        Mon, 16 Mar 2020 12:49:07 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 12:49:07 +0000
Received: from localhost (10.47.94.88) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 12:49:07 +0000
Date:   Mon, 16 Mar 2020 12:49:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200316124905.00003de8@Huawei.com>
In-Reply-To: <cba4a7c9-68a0-f268-bc78-ad6ab07fc70d@topic.nl>
References: <20200313140415.20266-1-mike.looijmans@topic.nl>
        <20200315120238.18c10af0@archlinux>
        <cba4a7c9-68a0-f268-bc78-ad6ab07fc70d@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.88]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 07:27:12 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 15-03-2020 13:02, Jonathan Cameron wrote:
> > On Fri, 13 Mar 2020 15:04:15 +0100
> > Mike Looijmans <mike.looijmans@topic.nl> wrote:
> >   
> >> The BMI088 is a combined module with both accelerometer and gyroscope.
> >> This adds the accelerometer driver support for the SPI interface.
> >> The gyroscope part is already supported by the BMG160 driver.  
> > 
> > There doesn't seem to be a specific compatible entry in the bmg160 driver.
> > Perhaps we should look to add one?  
> 
> I actually have it already, I'll submit it.
> 
> >   
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> > 
> > For a modern driver I'd normally expect to also see DT bindings.
> > How are you probing this?  
> 
> DT bindings, should I submit those as a separate patch?
> They're pretty trivial.

Yes. Separate patch for those as it means Rob doesn't have to plough through
the whole driver to find them!

> 
> > There is a lot of half implemented code for features that I assume will follow
> > in later patches.  Please rip all that out for now.  A simple initial driver
> > is great but must only include the stuff it actually uses.  
> 
> I'll do some cleanup, didn't notice that.
> 
> Mike.


