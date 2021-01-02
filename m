Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B62E8796
	for <lists+linux-iio@lfdr.de>; Sat,  2 Jan 2021 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbhABOP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 2 Jan 2021 09:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbhABOPz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Jan 2021 09:15:55 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C01B22482;
        Sat,  2 Jan 2021 14:15:14 +0000 (UTC)
Date:   Sat, 2 Jan 2021 14:15:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x
 ADC driver
Message-ID: <20210102141510.2f6f00bb@archlinux>
In-Reply-To: <60ea32f43ac4485db97684ad9a94cfbf@avl.com>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
        <20201127194240.15060-3-tomislav.denis@avl.com>
        <20201128123417.7259ef13@archlinux>
        <60ea32f43ac4485db97684ad9a94cfbf@avl.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Jan 2021 22:41:35 +0000
"Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com> wrote:

> Hi Jonathan,
> 
> Thanks for great review and hints that you gave me.
> A few comments inline.
> 
> BR,
> 
> Tomislav
> 
Replies inline.

> > > +title: Texas Instruments ADS131E0x 4-, 6-, and 8-Channel ADCs  
> > 
> > Not currently supporting 6 channel variants?  
> 
> It should be working without problem! But since I don't have HW to test I've left it out. 
> 

Personally I'd just be an optimist and put it in.  Seems very unlikely
it won't work given you have variants on either side of it.


> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2]
> > > +    default: 0
> > > +
> > > +  ti,datarate:
> > > +    description: |
> > > +      ADC data rate in kSPS
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 2, 4, 8, 16, 32, 64]
> > > +    default: 1  
> > 
> > Why is this a devicetree element rather than runtime controllable?  
> 
> Number of data bytes per channel depends on data rate. To be able to change data rate 
> dynamically would require to change scan_type.realbits also dynamically! I am not sure
> if that make sense and also if it is possible to do it?

Indeed not possible to do runtime variable resolution currently.  We have talked
about implementing it a few times, but it's rather fiddly to do hence hasn't happened
yet.

hmm. It might be better to control the channel resolution in the device
tree as that feels a bit less like something that ought to be runtime controllable.

From a quick look at the datasheet it looks like you can have the same data width
for 32 and 64 ksps (16 bits) and the same for all the other rates (24 bits)

However, given you are using the same number of storage bits anyway, you could
be more cynical and claim 24 bits for all channels and just rely on the upper
bits being 0 for the 16 bit cases.  That way this would just become a
userspace sampling frequency control with slightly missleading apparent
precision + the need to stash the realbits value you are using for scale
somewhere else. If we do this we end up with entirely standard userspace
interface and no need for this control in DT.

Jonathan
