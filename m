Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1C3125F2
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBGQTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhBGQTG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 11:19:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B9864E3E;
        Sun,  7 Feb 2021 16:18:24 +0000 (UTC)
Date:   Sun, 7 Feb 2021 16:18:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
Message-ID: <20210207161820.28abeb33@archlinux>
In-Reply-To: <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-22-jic23@kernel.org>
        <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Feb 2021 17:00:24 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 2/7/21 4:46 PM, Jonathan Cameron wrote:
> > +required:
> > +  - compatible
> > +  - reg  
> 
> Is vdd-supply really optional the way it is implemented in the driver?

Well sort of.  Obviously VDD isn't optional in the sense that the
device needs power, but it is in the binding because a stub regulator
should be fine.  For those regulator_enable() is a noop on assumption
they are already on.

> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        cdc@48 {
> > +            compatible = "adi,ad7150";
> > +            reg = <0x48>;
> > +            interrupts = <25 2>, <26 2>;  
> 
> I wonder if we should use the symbolic constants for the IRQ type to 
> make the example more clear. E.g.
> 
> interrupts = <25 IRQ_TYPE_EDGE_FALLING>, ...

Sure. I'll update in v2.

> 
> > +            interrupt-parent = <&gpio>;
> > +        };
> > +    };
> > +...  
> 
> 

