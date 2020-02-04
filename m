Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5209A151EE8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgBDRGn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 12:06:43 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727347AbgBDRGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Feb 2020 12:06:43 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 11EA85ECC9E3C7B82B70;
        Tue,  4 Feb 2020 17:06:39 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Feb 2020 17:06:23 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 4 Feb 2020
 17:06:23 +0000
Date:   Tue, 4 Feb 2020 17:06:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dylan Howey <Dylan.Howey@tennantco.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Temperature support for FXLS8471Q accelerometer
Message-ID: <20200204170622.0000132d@Huawei.com>
In-Reply-To: <20200204163515.GA25185@tennantco.com>
References: <20200129193237.GA14494@tennantco.com>
        <c19b2b3b-a1b9-352e-9abc-e52597512158@metafoo.de>
        <20200204163515.GA25185@tennantco.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Feb 2020 10:35:17 -0600
Dylan Howey <Dylan.Howey@tennantco.com> wrote:

> Any accel tests I should run before submitting changes? E.g. when I sent
> changes to RTC I ran rtc-test first.
> 
We don't have a formal test suite yet.  So normally just
check the sysfs files return what you expect + if the driver
supports it, checkout buffered mode using iio_generic_buffer
in tools/iio

Make sure it'll do buffered capture with and without temp
(if that is supported by your patches - often temp is captured
via a different path to other channels, so its fine if not)

Jonathan

> On 01/30/2020 21:35, Lars-Peter Clausen wrote:
> > On 1/29/20 8:32 PM, Dylan Howey wrote:  
> > > Hi all,
> > > 
> > > The mma8452 driver supports MMA845x, MMA865x and FXLS8471Q devices.
> > > 
> > > The FXLS8471Q is unique among these devices in that it has the
> > > additional ability to measure temperature.
> > > 
> > > Currently there is no support in mma8452 to measure temperature when
> > > the device is FXLS8471Q. Would anyone be opposed to me adding support?
> > > I have hardware and would be able to test my changes.  
> > 
> > Hi,
> > 
> > Support for new devices is always welcomed :)
> > 
> > If you have any questions about the IIO framework let us know.
> > 
> > - Lars
> >   
> 


