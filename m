Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98EE22ADA2
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 13:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGWL0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 07:26:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2515 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbgGWL0j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Jul 2020 07:26:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 22BAC2894B74D64CF18C;
        Thu, 23 Jul 2020 12:26:38 +0100 (IST)
Received: from localhost (10.52.125.229) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 12:26:37 +0100
Date:   Thu, 23 Jul 2020 12:25:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 08/27] iio:light:si1145: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200723122517.000070cf@Huawei.com>
In-Reply-To: <CAHp75VcL+-jxYiNVkXi=s8WDRvDuSVJ9w9AtKsKVp2eN_TEtXA@mail.gmail.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-9-jic23@kernel.org>
        <CAHp75VdFQYtkA-g2S=Vcvk3Sxp7duTihr3XGfzbUEB5xM4UbTg@mail.gmail.com>
        <CAHp75VcL+-jxYiNVkXi=s8WDRvDuSVJ9w9AtKsKVp2eN_TEtXA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.229]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 22:45:59 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jul 22, 2020 at 10:43 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > One of a class of bugs pointed out by Lars in a recent review.
> > > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > > this driver which uses a 24 byte array of smaller elements on the stack.
> > > As Lars also noted this anti pattern can involve a leak of data to
> > > userspace and that indeed can happen here.  We close both issues by
> > > moving to a suitable array in the iio_priv() data with alignment
> > > explicitly requested.  This data is allocated with kzalloc so no
> > > data can leak appart from previous readings.
> > >
> > > Depending on the enabled channels, the  location of the timestamp
> > > can be at various aligned offsets through the buffer.  As such we
> > > any use of a structure to enforce this alignment would incorrectly
> > > suggest a single location for the timestamp.  
> >
> > ...
> >  
> > > +       /* Ensure timestamp will be naturally aligned if present */
> > > +       u8 buffer[24] __aligned(8);  
> >
> > Why can't we use proper structure here?
> >  
> > > @@ -445,7 +447,6 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
> > >          *   6*2 bytes channels data + 4 bytes alignment +
> > >          *   8 bytes timestamp
> > >          */
> > > -       u8 buffer[24];  
> >
> > Seems even the old comment shows how it should look like...  
> 
> I think I understand now. Basically it's a dynamic amount of channels
> (up to 6) before you get a timestamp.
> 
Exactly.  Comment is giving the largest it can be, not what is needed for
a given configuration of the device.

Should indeed drop that comment.  Obviously went into automated mode and stopped
actually reading what was in front of me.

Jonathan


