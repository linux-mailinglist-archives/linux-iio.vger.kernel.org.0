Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF403634D5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 13:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhDRL0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 07:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhDRL0e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 07:26:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5B561207;
        Sun, 18 Apr 2021 11:26:03 +0000 (UTC)
Date:   Sun, 18 Apr 2021 12:26:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
Message-ID: <20210418122635.64938200@jic23-huawei>
In-Reply-To: <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
        <20210416134546.38475-3-tomas.melin@vaisala.com>
        <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 17 Apr 2021 15:39:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >
> > Add initial support for Murata SCA3300 3-axis industrial
> > accelerometer with digital SPI interface. This device also
> > provides a temperature measurement.
> >
> > Device product page including datasheet can be found at:
> > https://www.murata.com/en-global/products/sensor/accel/sca3300  
> 
> Can you create a tag out of it, i.e.
> 
> Datasheet: <URL>
> 
> ?
> 
> > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>  
> 
> ...
> 
> >  obj-$(CONFIG_SCA3000)          += sca3000.o
> > +obj-$(CONFIG_SCA3300)          += sca3300.o  
> 
> How much difference between them?

Enormous :)  The sca3000 series were much more exciting parts with fifos
and other fun a long time before anyone else had them.  That part drove
a lot of the weirder corners of IIO in the early days and had features
that didn't show up anywhere else for quite a few years.

The sca3100 onwards were much simpler (from software point of view) - I guess
Murata have a different focus than VTI did.

Jonathan


