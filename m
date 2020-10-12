Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA10C28BAEC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgJLOez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 10:34:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2973 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgJLOez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 10:34:55 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CBDB73C06FD769ACE20C;
        Mon, 12 Oct 2020 15:34:54 +0100 (IST)
Received: from localhost (10.52.126.145) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 12 Oct
 2020 15:34:54 +0100
Date:   Mon, 12 Oct 2020 15:33:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 00/29] dt-bindings:iio: Another set of yaml conversions.
Message-ID: <20201012143307.00007d5b@Huawei.com>
In-Reply-To: <CAL_JsqK2wUcJgcCTswAU-eqqZDwMJUq5MuMWwwke_UZbtqXJHg@mail.gmail.com>
References: <20201011170749.243680-1-jic23@kernel.org>
        <CAL_JsqK2wUcJgcCTswAU-eqqZDwMJUq5MuMWwwke_UZbtqXJHg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.145]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Oct 2020 08:20:12 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Oct 11, 2020 at 12:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This set mostly consists of low hanging fruit along the way to converting
> > all the existing IIO bindings.
> >
> > A few questions scattered throughout though.  Whilst my skills in these
> > are hopefully improving it seems there are still plenty more corner
> > cases that I'm not sure how to handle!  I'm sure I'll have forgotten
> > something that I should already know as well.
> >
> > I'm expecting some of these to bounce due to changes of addresses etc.
> > If I can't track down up to date emails, I'll switch them maintainer
> > to myself on the basis I'll be reviewing any incoming changes for these
> > anyway.
> >
> > Thanks,
> >
> > Jonathan
> >
> > Jonathan Cameron (29):
> >   dt-bindings:iio:humidity:hdc100x Drop separate doc + add to
> >     trivial-devices
> >   dt-bindings:iio:humidity:htu21 Drop separate doc + add to
> >     trivial-devices
> >   dt-bindings:iio:humidity:st,hts221 yaml conversion.
> >   dt-bindings:iio:humidity:dht11 yaml conversion
> >   dt-bindings:iio:pressure:ms5637 Drop separate doc + add to
> >     trivial-devices
> >   dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
> >   dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
> >   dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
> >   dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
> >   dt-bindings:iio:proximity:st,vl53l0x yaml conversion
> >   dt-bindings:iio:proximity:ams,as3935 yaml conversion
> >   dt-bindings:iio:dac:ti,dac5571 yaml conversion.
> >   dt-bindings:iio:dac:ti,dac7311 yaml conversion
> >   dt-bindings:iio:dac:ti,dac7512 yaml conversion
> >   dt-bindings:iio:dac:ti,dac7612 yaml conversion
> >   dt-bindings:iio:dac:ti,dac082s085 yaml conversion
> >   dt-bindings:iio:dac:adi,ad7303 yaml conversion
> >   dt-bindings:iio:dac:maxim,ds4424 yaml conversion
> >   dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
> >   dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
> >   dt-bindings:iio:dac:maxim,max5821 yaml conversion
> >   dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
> >   dt-bindings:iio:dac:adi,ad5758 yaml conversion
> >   dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
> >   dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
> >   dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
> >   dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
> >   dt-bindings:iio:temperature:maxim_thermocouple.txt to
> >     maxim,max31855k.yaml
> >   dt-bindings:iio:temperature:ti,tmp07 yaml conversion  
> 
> For the series,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Though, you didn't Cc the DT list so no semi-automated checks will run
> which would have pointed out the problem Lars-Peter did.

Gah. Sorry about that.  I'll pick up acks and do a v2 which I'll
make sure goes to the list, as we aren't in a particular rush for these.

Thanks,

Jonathan

> 
> Rob


