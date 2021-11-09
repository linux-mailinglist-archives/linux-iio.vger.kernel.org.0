Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8144B1BA
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhKIRId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 12:08:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4078 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbhKIRI2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 12:08:28 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HpZ4P24n3z67ts3;
        Wed, 10 Nov 2021 01:00:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 18:05:40 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Tue, 9 Nov
 2021 17:05:39 +0000
Date:   Tue, 9 Nov 2021 17:05:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrea Merello <andrea.merello@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 04/10] iio: add modifiers for linear acceleration
Message-ID: <20211109170538.0000446c@Huawei.com>
In-Reply-To: <CAN8YU5M1-tqXaAokjzZJ5aLY_PwK7-3O3PtEFEQ+ONwTLcK44Q@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-5-andrea.merello@gmail.com>
        <20211028114557.5b4db778@jic23-huawei>
        <CAN8YU5M1-tqXaAokjzZJ5aLY_PwK7-3O3PtEFEQ+ONwTLcK44Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 10:58:19 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno gio 28 ott 2021 alle ore 12:41 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Thu, 28 Oct 2021 12:18:34 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > This patch is preparatory for adding the Bosh BNO055 IMU driver.
> > > The said IMU can report raw accelerations (among x, y and z axis)
> > > as well as the so called "linear accelerations" (again, among x,
> > > y and z axis) which is basically the acceleration after subtracting
> > > gravity.
> > >
> > > This patch adds IIO_MOD_ACCEL_LINEAR_X, IIO_MOD_ACCEL_LINEAR_Y and
> > > IIO_MOD_ACCEL_LINEAR_Z modifiers to te IIO core.
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>  
> >
> > They sometimes get forgotten but we should also update
> > tools/iio/iio_event_montitor.c to handle these new modifiers.  
> 
> I'm not so familiar with this tool, but it seems like it has to do
> with IIO events, which the bno055 driver doesn't use. On the other
> hand the modifiers I would add are not used by any other driver right
> now.
> 
> So I would say that it would end up in adding things that I couldn't
> test.. Or is there any test infrastructure for this? It seems trivial,
> just a matter of a few defines, so it shouldn't be an issue indeed..
> 
> > That can be a separate patch, but also fine to do it in this one.
> >  
> > > ---
> > >  drivers/iio/industrialio-core.c | 3 +++
> > >  include/uapi/linux/iio/types.h  | 4 +++-
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 2dbb37e09b8c..a79cb32207e4 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
> > >       [IIO_MOD_ETHANOL] = "ethanol",
> > >       [IIO_MOD_H2] = "h2",
> > >       [IIO_MOD_O2] = "o2",
> > > +     [IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
> > > +     [IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
> > > +     [IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
> > >  };
> > >
> > >  /* relies on pairs of these shared then separate */
> > > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > > index 48c13147c0a8..db00f7c45f48 100644
> > > --- a/include/uapi/linux/iio/types.h
> > > +++ b/include/uapi/linux/iio/types.h
> > > @@ -95,6 +95,9 @@ enum iio_modifier {
> > >       IIO_MOD_ETHANOL,
> > >       IIO_MOD_H2,
> > >       IIO_MOD_O2,
> > > +     IIO_MOD_ACCEL_LINEAR_X,
> > > +     IIO_MOD_ACCEL_LINEAR_Y,
> > > +     IIO_MOD_ACCEL_LINEAR_Z,  
> >
> > It might be useful for other channel types, so probably drop the ACCEL
> > part of the name.
> >
> > I'll admit I can't immediately think of what, but you never know.. :)  
> 
> But in this case what should I write in the ABI documentation? If I
> state that this is something that makes the gravity not being included
> then isn't it intrinsically tied to be an acceleration?  Or, I do
> that, and if someone eventually finds another use, then she/he will
> change the ABI doc?

The ABI docs are only documenting the complete ABI, not separately
the modifier so you will be documenting the same thing whatever
we call the modifier inside the code.

I'm just suggesting you call the enum entries the more generic
IIO_MOD_LINEAR_X, etc, not a change to the resulting string.

Jonathan

> 
> > >  };
> > >
> > >  enum iio_event_type {
> > > @@ -114,4 +117,3 @@ enum iio_event_direction {
> > >  };
> > >
> > >  #endif /* _UAPI_IIO_TYPES_H_ */
> > > -  
> > ?
> >
> >  

