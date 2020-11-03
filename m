Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2463E2A4CA7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKCRYL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 12:24:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3035 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728700AbgKCRYL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 12:24:11 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id CAFFBF4C6387FBBC7DE2;
        Tue,  3 Nov 2020 17:24:09 +0000 (GMT)
Received: from localhost (10.52.125.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 17:24:09 +0000
Date:   Tue, 3 Nov 2020 17:24:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 00/46] dt-bindings:iio: yet more txt to yam conversions
Message-ID: <20201103172408.0000600c@Huawei.com>
In-Reply-To: <20201103163800.GA1791071@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201103163800.GA1791071@bogus>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.233]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 10:38:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:48:08PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This set is basically all the stuff bindings where I couldn't come up
> > with a unifying theme to split them out into smaller more palatble sets.
> > 
> > So there is all sorts in here :)  Enjoy.  
> 
> Thanks for filling my inbox... :)
Always happy to do that :)

I definitely recall you saying you liked to review them lots at a time.
*evil laugh*

Thanks for ploughing through them so quickly.

Jonathan


> 
> > There are a few more binding files left after these are done.
> > * io-channel-mux:  Needs conversion of the mux subsystem bindings
> > * xilinx-xadc: I think Lars is working on this one already.
> > * lis302: This one got moved to IIO directory, but reflects a bunch of stuff
> >   that would not have made it into an IIO binding.  The driver is still in
> >   misc and in theory has been replaced by the st-sensors driver.
> >   Need to think what to do about this one.
> > * mount-matrix.txt:  The binding part is under review for inclusion in
> >   dt-schema rather than kernel tree, but this document has a wealth of
> >   information we don't want hidden away there.  As such I'm probably
> >   going to convert it to general kernel documentation.
> > 
> > Final patch in here drops the generic temperatures sensor binding.
> > Whilst I'm keen on that we only currently have one user.  So I'd
> > rather we had a second before we went to the effort of defining a
> > proper yaml binding for that.
> > 
> > Jonathan Cameron (46):
> >   dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
> >   dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
> >   dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
> >   dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml
> >     conversion
> >   dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
> >   dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
> >   dt-bindings:iio:health:ti,afe4403: txt to yaml binding
> >   dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
> >   dt-bindings:iio:health:maxim,max30100: txt to yaml conversion
> >   dt-bindings:iio:health:maxim,max30102: txt to yaml conversion
> >   dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
> >   dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
> >   dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
> >   dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
> >   dt-bindings:iio:light:capella,cm36651: txt to yaml conversion.
> >   dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
> >   dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
> >   dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
> >   dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
> >   dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV
> >     sensor
> >   dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
> >   dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
> >   dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
> >   dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format
> >     conversion
> >   dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml
> >     conversion.
> >   dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format
> >     conversion
> >   dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
> >   dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion
> >   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
> >     at91_adc.txt
> >   dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
> >   dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion
> >   dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
> >   dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml
> >     conversion.
> >   dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
> >   dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
> >   dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
> >   dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
> >   dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
> >   dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
> >   dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
> >   dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
> >   dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
> >   dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
> >   dt-bindings:iio:st,st-sensors: txt to yaml conversion.
> >   dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
> >   dt-bindings:iio:temperature: Drop generic binding file.  
> 
> There's more standard unit properties you can drop the type $ref on and 
> a the couple of nits I raised. With those fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Great.  Thanks again,

Jonathan

