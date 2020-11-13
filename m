Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716222B182E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgKMJYv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 04:24:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57048 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMJYu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 04:24:50 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 729E03AF2F2
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2020 09:22:28 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 64DEB240017;
        Fri, 13 Nov 2020 09:22:05 +0000 (UTC)
Date:   Fri, 13 Nov 2020 10:22:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 29/46] dt-bindings:iio:adc:atmel,sama9260-adc: conversion
 to yaml from at91_adc.txt
Message-ID: <20201113092205.GH4556@piout.net>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-30-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-30-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/10/2020 18:48:37+0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding raises a few questions.
> 1) Do we need #address-cells and #size-cells as the child nodes don't have
>    a reg property?  A few dtsi files include these so if we drop the
>    requirement we will need to clean those up as well.

You can drop them.

> 2) Renamed to a specific part.  Given we have another at91 ADC binding
>    it is clear now this won't cover all at91 parts so lets name it
>    after a specific part.
> 3) For atmel,adc-res-names the description is a big vague.  Are other
>    resolution names allowed? We don't seem to have any currently.
> 

I had a look and this is a legacy mess, I'll send a fix soon.

> There are a few things we would do differently in an ADC binding if we
> were starting from scratch but we are stuck with what we have (which
> made sense back when this was written!)
> 
> We may be able to tighten up some elements of this binding in the future
> by careful checking of what values properties can actually take.
> 

Is there anything generic to select the resolution? I'll be happy to
remove atmel,adc-res-names, atmel,adc-res and atmel,adc-use-res as there
is no upstream users and the default is to use the highest resolution.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
