Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28FD1102E5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLCQwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 11:52:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbfLCQv7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Dec 2019 11:51:59 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D941CE4FB6CFD69213C3;
        Tue,  3 Dec 2019 16:51:57 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Dec 2019 16:51:57 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Dec 2019
 16:51:57 +0000
Date:   Tue, 3 Dec 2019 16:51:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20191203165154.00005793@Huawei.com>
In-Reply-To: <20191203163850.GN1998@sirena.org.uk>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
        <20191123114119.7b0c3447@archlinux>
        <a55b9c576eded8c91a985aabbba89180561ab156.camel@analog.com>
        <20191201114032.1a972dda@archlinux>
        <20191203163850.GN1998@sirena.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Dec 2019 16:38:50 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sun, Dec 01, 2019 at 11:40:32AM +0000, Jonathan Cameron wrote:
> 
> > +CC Mark as we probably need a more general view point on
> > the question of whether SPI mode should be enforced by binding
> > or in the driver.  
> 
> Not sure I see the question here, I think I was missing a bit of
> the conversation?  It's perfectly fine for a driver to specify a
> mode, if the hardware always uses some unusual mode then there's
> no sense in forcing every single DT to set the same mode.  On the
> other hand if there's some configuration for the driver that was
> handling some board specific configuration that there's already
> some generic SPI support for setting then it seems odd to have a
> custom driver specific configuration mechanism.
> 

If the driver picks a mode because that's what it says on the datasheet
it prevents odd board configurations from working.  The question
becomes whether it makes sense in general to assume those odd board
conditions don't exist until we actually have one, or to assume that
they might and push the burden on to all DT files.

Traditionally in IIO at least we've mostly taken the view the DT
should be right and complete and had bindings state what normal
parameters must be for it to work (assuming no inverters etc)

If we encode it in the driver, and we later meet such a board we
end up with a custom dance to query the DT parameters again and
only override if present.

We can't rely on the core SPI handling because I don't think
there is any means of specifying a default.

We can adopt the view that in general these weird boards with inverters
are weird and just handle them when they occur.  Sounds like that is your
preference, at least for new parts.

For old ones we have no idea if there are boards out there using
them with inverters so easiest is probably to just carry on putting them
in the DT bindings.

Jonathan


