Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15FD2BC7A9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgKVSJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 13:09:39 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39872 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgKVSJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 13:09:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B42D29E00EB;
        Sun, 22 Nov 2020 18:09:36 +0000 (GMT)
Date:   Sun, 22 Nov 2020 18:09:34 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 29/46] dt-bindings:iio:adc:atmel,sama9260-adc:
 conversion to yaml from at91_adc.txt
Message-ID: <20201122180934.108d0cd4@archlinux>
In-Reply-To: <20201114153708.0769130d@archlinux>
References: <20201031184854.745828-1-jic23@kernel.org>
        <20201031184854.745828-30-jic23@kernel.org>
        <20201113092205.GH4556@piout.net>
        <20201114153708.0769130d@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 15:37:08 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Nov 2020 10:22:05 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 31/10/2020 18:48:37+0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > This binding raises a few questions.
> > > 1) Do we need #address-cells and #size-cells as the child nodes don't have
> > >    a reg property?  A few dtsi files include these so if we drop the
> > >    requirement we will need to clean those up as well.    
> > 
> > You can drop them.
> >   
> > > 2) Renamed to a specific part.  Given we have another at91 ADC binding
> > >    it is clear now this won't cover all at91 parts so lets name it
> > >    after a specific part.
> > > 3) For atmel,adc-res-names the description is a big vague.  Are other
> > >    resolution names allowed? We don't seem to have any currently.
> > >     
> > 
> > I had a look and this is a legacy mess, I'll send a fix soon.
> >   
> > > There are a few things we would do differently in an ADC binding if we
> > > were starting from scratch but we are stuck with what we have (which
> > > made sense back when this was written!)
> > > 
> > > We may be able to tighten up some elements of this binding in the future
> > > by careful checking of what values properties can actually take.
> > >     
> > 
> > Is there anything generic to select the resolution? I'll be happy to
> > remove atmel,adc-res-names, atmel,adc-res and atmel,adc-use-res as there
> > is no upstream users and the default is to use the highest resolution.  
> 
> Nothing currently defined.  I'm not against it if we have users though.
> 
> If it isn't actually useful in this case, even better to just drop it.
> 
> Jonathan
For reference in this thread, Alexandre has picked this on up as part of
his series cleaning up related stuff in the driver and bindings.

Thanks,

Jonathan

> 
> 
> > 
> >   
> 

