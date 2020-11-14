Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7D2B2E10
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKNPhO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 10:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgKNPhN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 10:37:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FCB22263;
        Sat, 14 Nov 2020 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605368232;
        bh=Y0RfyQFyftFe9adOwoPVrHSMPUabcjibr2sRChUuLC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H0ZXnwZUDrEb2bB8ZMp2c9ZIn1stm3xcVXqAgjPkBKu9K7GC8Dp81V+03KZyi+iCr
         2skHAeEMFQBqrfzWegBl0Fq0lIG8a8mrEOU3y2hr4p9ppqtESjLRj+Ti+4uYP71guX
         falsYko6qIp2ZL5MECs4VVHqy0ZLytt5J4X+UJRI=
Date:   Sat, 14 Nov 2020 15:37:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 29/46] dt-bindings:iio:adc:atmel,sama9260-adc:
 conversion to yaml from at91_adc.txt
Message-ID: <20201114153708.0769130d@archlinux>
In-Reply-To: <20201113092205.GH4556@piout.net>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-30-jic23@kernel.org>
        <20201113092205.GH4556@piout.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 10:22:05 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 31/10/2020 18:48:37+0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This binding raises a few questions.
> > 1) Do we need #address-cells and #size-cells as the child nodes don't have
> >    a reg property?  A few dtsi files include these so if we drop the
> >    requirement we will need to clean those up as well.  
> 
> You can drop them.
> 
> > 2) Renamed to a specific part.  Given we have another at91 ADC binding
> >    it is clear now this won't cover all at91 parts so lets name it
> >    after a specific part.
> > 3) For atmel,adc-res-names the description is a big vague.  Are other
> >    resolution names allowed? We don't seem to have any currently.
> >   
> 
> I had a look and this is a legacy mess, I'll send a fix soon.
> 
> > There are a few things we would do differently in an ADC binding if we
> > were starting from scratch but we are stuck with what we have (which
> > made sense back when this was written!)
> > 
> > We may be able to tighten up some elements of this binding in the future
> > by careful checking of what values properties can actually take.
> >   
> 
> Is there anything generic to select the resolution? I'll be happy to
> remove atmel,adc-res-names, atmel,adc-res and atmel,adc-use-res as there
> is no upstream users and the default is to use the highest resolution.

Nothing currently defined.  I'm not against it if we have users though.

If it isn't actually useful in this case, even better to just drop it.

Jonathan


> 
> 

