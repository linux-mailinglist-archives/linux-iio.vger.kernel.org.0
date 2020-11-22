Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6E2BC855
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKVS7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgKVS7X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 13:59:23 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DF220760;
        Sun, 22 Nov 2020 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606071562;
        bh=7VMONIaiHlDddgXKCm1YnbQvrRQl8p39fbTMzUPb4d8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n8vKWcWalx0UAwaVppLcUIqLR0Ut8zgsPfYgh2Up2cHXUkNZUP5Ag+nRgQR2hZKK5
         iD2EhiW6VgUYBi4pcbO6+aiTewBduyN8tQDZMsC6hmJzaWRUfDFcZH0uwsIrqAaF3P
         7fbLWk7cT2uvVtomClbIyFxf+YsyMNzG0O9zfAOY=
Date:   Sun, 22 Nov 2020 18:59:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Rob Herring <robh@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 00/46] dt-bindings:iio: yet more txt to yam conversions
Message-ID: <20201122185918.52c652b1@archlinux>
In-Reply-To: <20201103172408.0000600c@Huawei.com>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201103163800.GA1791071@bogus>
        <20201103172408.0000600c@Huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 17:24:08 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 3 Nov 2020 10:38:00 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sat, Oct 31, 2020 at 06:48:08PM +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > This set is basically all the stuff bindings where I couldn't come up
> > > with a unifying theme to split them out into smaller more palatble sets.
> > > 
> > > So there is all sorts in here :)  Enjoy.    
> > 
> > Thanks for filling my inbox... :)  
> Always happy to do that :)
> 
> I definitely recall you saying you liked to review them lots at a time.
> *evil laugh*
> 
> Thanks for ploughing through them so quickly.
> 
> Jonathan
> 
Quick status update on this series.

I've applied everything (with fixes as suggested and a few maintainers changed
due to bouncing emails) except:

7, 8 : Andrew's email is bouncing and there are questions open on differences
       between the binding and the driver so I've reached out to him via
       other means.

29:  Going as part of a difference series.

39:  XOR tricks and the question on what syntax will let me drop the definitions
     block as suggested as I can't figure it out! @Rob this is the same question
     raised on the other similar case.

I've applied 9, but couldn't make a simplification I thought should work so have
an open question on that one.

In the interests of making it easier to keep track of what is left, I may well
just pull all the remaining patches from my various series into a single one
one which we can address outstanding questions.  Still a few more to catch up
on before I can do that however!

Thanks,

Jonathan


> 
> >   
> > > There are a few more binding files left after these are done.
> > > * io-channel-mux:  Needs conversion of the mux subsystem bindings
> > > * xilinx-xadc: I think Lars is working on this one already.
> > > * lis302: This one got moved to IIO directory, but reflects a bunch of stuff
> > >   that would not have made it into an IIO binding.  The driver is still in
> > >   misc and in theory has been replaced by the st-sensors driver.
> > >   Need to think what to do about this one.
> > > * mount-matrix.txt:  The binding part is under review for inclusion in
> > >   dt-schema rather than kernel tree, but this document has a wealth of
> > >   information we don't want hidden away there.  As such I'm probably
> > >   going to convert it to general kernel documentation.
> > > 
> > > Final patch in here drops the generic temperatures sensor binding.
> > > Whilst I'm keen on that we only currently have one user.  So I'd
> > > rather we had a second before we went to the effort of defining a
> > > proper yaml binding for that.
> > > 
> > > Jonathan Cameron (46):
> > >   dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
> > >   dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
> > >   dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
> > >   dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml
> > >     conversion
> > >   dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
> > >   dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
> > >   dt-bindings:iio:health:ti,afe4403: txt to yaml binding
> > >   dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
> > >   dt-bindings:iio:health:maxim,max30100: txt to yaml conversion
> > >   dt-bindings:iio:health:maxim,max30102: txt to yaml conversion
> > >   dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
> > >   dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
> > >   dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
> > >   dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
> > >   dt-bindings:iio:light:capella,cm36651: txt to yaml conversion.
> > >   dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
> > >   dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
> > >   dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
> > >   dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
> > >   dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV
> > >     sensor
> > >   dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
> > >   dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
> > >   dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
> > >   dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format
> > >     conversion
> > >   dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml
> > >     conversion.
> > >   dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format
> > >     conversion
> > >   dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
> > >   dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion
> > >   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
> > >     at91_adc.txt
> > >   dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
> > >   dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion
> > >   dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
> > >   dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml
> > >     conversion.
> > >   dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
> > >   dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
> > >   dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
> > >   dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
> > >   dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
> > >   dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
> > >   dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
> > >   dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
> > >   dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
> > >   dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
> > >   dt-bindings:iio:st,st-sensors: txt to yaml conversion.
> > >   dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
> > >   dt-bindings:iio:temperature: Drop generic binding file.    
> > 
> > There's more standard unit properties you can drop the type $ref on and 
> > a the couple of nits I raised. With those fixed,
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> 
> Great.  Thanks again,
> 
> Jonathan
> 

