Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE76B310B2B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 13:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhBEMiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 07:38:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2507 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhBEMfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 07:35:24 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DXF9c4xztz67kls;
        Fri,  5 Feb 2021 20:29:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 5 Feb 2021 13:34:40 +0100
Received: from localhost (10.47.29.206) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Feb 2021
 12:34:40 +0000
Date:   Fri, 5 Feb 2021 12:33:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 05/11] iio: buffer: group attr count and attr alloc
Message-ID: <20210205123355.00006e06@Huawei.com>
In-Reply-To: <CA+U=DsotfJ5A44CWtdXW=QYzz3ApvLaUK2PqH=Cs3FdqFJVLEQ@mail.gmail.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
        <20210201145105.20459-6-alexandru.ardelean@analog.com>
        <20210204174942.000013b3@Huawei.com>
        <CA+U=DsotfJ5A44CWtdXW=QYzz3ApvLaUK2PqH=Cs3FdqFJVLEQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.29.206]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> > >
> > > +     attr = kcalloc(buffer_attrcount + ARRAY_SIZE(iio_buffer_attrs) + 1,
> > > +                    sizeof(struct attribute *), GFP_KERNEL);
> > > +     if (!attr) {
> > > +             ret = -ENOMEM;
> > > +             goto error_free_scan_mask;
> > > +     }
> > > +
> > > +     memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
> > > +     if (!buffer->access->set_length)
> > > +             attr[0] = &dev_attr_length_ro.attr;
> > > +
> > > +     if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
> > > +             attr[2] = &dev_attr_watermark_ro.attr;  
> >
> > Again a comment for the future  rather than now, but when we are copying
> > 4 items and then looking at whether to change 2 of them it might be cleaner
> > to just set them directly!  Touch of bit rot here :)  
> 
> So, I've been on-and-off about how to deal with this one.
> I wanted to clean it in various ways using new kernel sysfs APIs.
> Maybe, also remove the readonly variants and use the is_visible()
> property to set RO/RW modes.
> But I also came to the conclusion that this is an idea to address later.
> Trying to address this early-on confused me with other overlapping changes.
Absolutely agree. It's not something to do in this series.

Jonathan
