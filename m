Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B602A4BB7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKCQiC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:38:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33493 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgKCQiC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:38:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id i18so11809964ots.0;
        Tue, 03 Nov 2020 08:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59IJmq7Vl2AfPKDgcRU0N9k37tngMdjRk3zQgRaKoWY=;
        b=jqUw5NT6PB6HRqJMtPv6mRf0kdt3C+wYem1/vXvQnzMrKgiKY1TgFaXpkp6w7F4rB6
         ku55BxVTL5qcn/IfOkHOmxJhu92+ZEGJqmrV/XDBJrmRBDKDqhdUqZV677PlB0gwVFmb
         AylTZCnQFLIz9vAn3KDDuhzeJGG9OePPgc5HJHPUR1gd3MuyOJGQJiaPJDbLb1g9dJc9
         0OZKSjFjvPqi2b99XxV4ku5JcdALkkmQrTo9LEAjaVmgBLeH7SL6exgECYBLIhb6Pn08
         k4E7G0EHaK8ueWzuV076vZlTeJf/6jKN3IIIP5oCyiVsAHaQjRxVICp/68I21lOG6vgt
         KVdA==
X-Gm-Message-State: AOAM533qCus3sEWoH2RFBQTTR+UWzhR5bfv4df6FnMQQzE93D4OgmTFu
        LGLg7cfNdZJ6wh104mnneg==
X-Google-Smtp-Source: ABdhPJyVLAKe9DgtCT7gHfyxtMmdzeKN/UVv9QJ4OLfOVPu4yakjMH+LpSjWJmHTu0YYAHG3jtgoUQ==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr16059023otq.208.1604421481294;
        Tue, 03 Nov 2020 08:38:01 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l89sm4406296otc.6.2020.11.03.08.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:38:00 -0800 (PST)
Received: (nullmailer pid 1793668 invoked by uid 1000);
        Tue, 03 Nov 2020 16:38:00 -0000
Date:   Tue, 3 Nov 2020 10:38:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/46] dt-bindings:iio: yet more txt to yam conversions
Message-ID: <20201103163800.GA1791071@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:08PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This set is basically all the stuff bindings where I couldn't come up
> with a unifying theme to split them out into smaller more palatble sets.
> 
> So there is all sorts in here :)  Enjoy.

Thanks for filling my inbox... :)

> There are a few more binding files left after these are done.
> * io-channel-mux:  Needs conversion of the mux subsystem bindings
> * xilinx-xadc: I think Lars is working on this one already.
> * lis302: This one got moved to IIO directory, but reflects a bunch of stuff
>   that would not have made it into an IIO binding.  The driver is still in
>   misc and in theory has been replaced by the st-sensors driver.
>   Need to think what to do about this one.
> * mount-matrix.txt:  The binding part is under review for inclusion in
>   dt-schema rather than kernel tree, but this document has a wealth of
>   information we don't want hidden away there.  As such I'm probably
>   going to convert it to general kernel documentation.
> 
> Final patch in here drops the generic temperatures sensor binding.
> Whilst I'm keen on that we only currently have one user.  So I'd
> rather we had a second before we went to the effort of defining a
> proper yaml binding for that.
> 
> Jonathan Cameron (46):
>   dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
>   dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
>   dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
>   dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml
>     conversion
>   dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
>   dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
>   dt-bindings:iio:health:ti,afe4403: txt to yaml binding
>   dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
>   dt-bindings:iio:health:maxim,max30100: txt to yaml conversion
>   dt-bindings:iio:health:maxim,max30102: txt to yaml conversion
>   dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
>   dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
>   dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
>   dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
>   dt-bindings:iio:light:capella,cm36651: txt to yaml conversion.
>   dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
>   dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
>   dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
>   dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
>   dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV
>     sensor
>   dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
>   dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
>   dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
>   dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format
>     conversion
>   dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml
>     conversion.
>   dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format
>     conversion
>   dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
>   dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion
>   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
>     at91_adc.txt
>   dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
>   dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion
>   dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
>   dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml
>     conversion.
>   dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
>   dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
>   dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
>   dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
>   dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
>   dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
>   dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
>   dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
>   dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
>   dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
>   dt-bindings:iio:st,st-sensors: txt to yaml conversion.
>   dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
>   dt-bindings:iio:temperature: Drop generic binding file.

There's more standard unit properties you can drop the type $ref on and 
a the couple of nits I raised. With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
