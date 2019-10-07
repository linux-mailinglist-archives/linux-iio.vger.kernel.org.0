Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B613ACE0C4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfJGLo7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 07:44:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJGLo7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 07:44:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3237FB0442398126F672;
        Mon,  7 Oct 2019 19:44:56 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 19:44:54 +0800
Date:   Mon, 7 Oct 2019 12:44:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] iio: adc: max1027: Make it optional to use
 interrupts
Message-ID: <20191007124443.00006082@huawei.com>
In-Reply-To: <20191007120122.6d41532f@xps13>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-3-miquel.raynal@bootlin.com>
        <20191006111837.33fdfe25@archlinux>
        <20191007120122.6d41532f@xps13>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 12:01:22 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
> 
> Jonathan Cameron <jic23@kernel.org> wrote on Sun, 6 Oct 2019 11:18:37
> +0100:
> 
> > On Thu,  3 Oct 2019 19:33:56 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > The chip has a 'start conversion' and a 'end of conversion' pair of
> > > pins. They can be used but this is absolutely not mandatory as regular
> > > polling of the value is totally fine with the current internal
> > > clocking setup. Turn the interrupts optional and do not error out if
> > > they are not inquired in the device tree. This has the effect to
> > > prevent triggered buffers use though.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>    
> > 
> > Hmm. I haven't looked a this in a great deal of depth but if we support
> > single channel reads it should be possible to allow the use of a
> > trigger from elsewhere.  Looks like a fair bit of new code would be needed
> > to support that though.  So perhaps this is a good first step.
> > 
> > It's a bit annoying that the hardware doesn't provide a EOC bit
> > anywhere in the registers.  That would have allowed us to be a bit
> > cleverer.  
> 
> I totally agree. Actually, this chip does not support any 'register
> read', the only things we can read are measures (temperature/voltages).

Ah. Good point.  Shall we polled reading of channels which is what
I meant ;)

Jonathan

> 
> 
> Thanks,
> Miquèl


