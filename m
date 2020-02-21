Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8724167A1E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBUKEY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 05:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbgBUKEY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 05:04:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29F1207FD;
        Fri, 21 Feb 2020 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582279463;
        bh=gIRnGOsuqmY14jjFPSkmlspi6zf1wl5xnVR/YigaeDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lWdXrZIPtsnUs//sRLW2Lv2YXcEd/vBPHbnEbeRufppB6CLTw2uOxBWS4YD6sTTOw
         A/xXL+GkXyVXV6czbFchqmcVDHSNFpnU256uw3KrALn/7OHJVigXETggnq0yFKEQwX
         bp4P71PZo1vzPayUhWZh8pG8KEjeoWEPWdlK4FxE=
Date:   Fri, 21 Feb 2020 10:04:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: max1363 etc i2c ADC binding
 conversion
Message-ID: <20200221100419.79900070@archlinux>
In-Reply-To: <20200219221005.GA22158@bogus>
References: <20200208172312.467454-1-jic23@kernel.org>
        <20200219221005.GA22158@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Feb 2020 16:10:05 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Feb 08, 2020 at 05:23:12PM +0000, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Split the binding in two to reflect the threshold monitor capabilities
> > and hence interrupts vs the more straight forward parts that
> > don't have this facility.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../devicetree/bindings/iio/adc/max1363.txt   | 63 ---------------
> >  .../bindings/iio/adc/maxim,max1238.yaml       | 76 +++++++++++++++++++
> >  .../bindings/iio/adc/maxim,max1363.yaml       | 50 ++++++++++++
> >  3 files changed, 126 insertions(+), 63 deletions(-)  
> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max1361,  
> 
> Dangling comma.
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Fixed up and applied.  Thanks Rob

Jonathan

> 
> > +      - maxim,max1362
> > +      - maxim,max1363
> > +      - maxim,max1364  
> 

