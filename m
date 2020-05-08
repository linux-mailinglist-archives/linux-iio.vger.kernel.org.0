Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66421CABE4
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgEHMsB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 08:48:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729607AbgEHMr6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 08:47:58 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 708D1EDF60E665A57672;
        Fri,  8 May 2020 13:47:56 +0100 (IST)
Received: from localhost (10.47.95.97) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 8 May 2020
 13:47:55 +0100
Date:   Fri, 8 May 2020 13:47:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Subject: Re: [PATCH 0/5] iio: accel: Add bma023 support to bma180
Message-ID: <20200508134733.0000233a@Huawei.com>
In-Reply-To: <BN6PR04MB0660BD7ABF64EC0C19A65A03A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <BN6PR04MB0660046ABD79433EA94A85A9A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
        <CACRpkdbb89q2FRJZ1=2QoQs8JFYcwWpNZwJUbnjsVvZYEE-LKw@mail.gmail.com>
        <BN6PR04MB0660BD7ABF64EC0C19A65A03A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.97]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 May 2020 20:49:17 -0700
Jonathan Bakker <xc-racer2@live.ca> wrote:

> Hi Linus,
> 
> On 2020-05-06 5:47 a.m., Linus Walleij wrote:
> > On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> >   
> >> This patchset adds support for the bma023 three axis accelerometer
> >> to the bma180 IIO driver.  The bma023 is found on several ~2010
> >> phones, including the first-gen Galaxy S series.
> >>
> >> The bma023 differs from later chips (bma180, bma25x) in that it
> >> has no low power but still working mode and no temperature
> >> channel.
> >>
> >> The bma023 is already supported by a misc input driver (bma150), so
> >> when both are enabled, the iio driver is preferred.  The bma150
> >> is very similar to the bma023, but has a temperature channel.
> >> Support for the bma150 is not added in this patchset.  
> > 
> > I'd say, if it's not too much trouble please also patch in
> > support for BMA150 and SMB380 to the IIO driver so
> > we can delete this old Input driver, we have done this
> > before and thes "input drivers" are just causing headaches
> > and wasting time for the Input maintainer.
> >   
> 
> Looking at the bma150, it looks the same.  The temperature is implemented
> slightly differently than on the bma180+ (unsigned vs signed) but should
> be quite easy to add.  I'll add a new patch for it in v2.

Great.  Series looks fine to me as well, so should be fine to apply v2.
(subject to Dmitry Ack).

Jonathan

> 
> > It can be in a separate patch set from this one if you
> > don't want to get stuck on this.
> > 
> > Yours,
> > Linus Walleij
> >   
> 
> Thanks,
> Jonathan


