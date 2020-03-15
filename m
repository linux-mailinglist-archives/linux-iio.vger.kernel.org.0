Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D22185B63
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 10:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgCOJX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 05:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgCOJX3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 05:23:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC83206B1;
        Sun, 15 Mar 2020 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584264208;
        bh=yKjZ/kyJ5+E9mZarp6EgGQbXyqkdJ2EpqBzuXHumchk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TuVSAHLZhmVdwmTShn9T4dY6HMHdlSUXFSrx/iXBNHwzuPuUV+vfcv34JM0JkRjWi
         MY1Nfp2aS5hztMdvi+z6zPEz7HeDgtHxKktJ6KUWDs5FHFhQD+LHfuFX5YuG31zBcP
         RHciE7JQsoVCCaC2f128o8twhRIO+SvNe0+DNMHI=
Date:   Sun, 15 Mar 2020 09:23:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v8 5/8] iio: adc: adi-axi-adc: add support for AXI ADC
 IP core
Message-ID: <20200315092324.22317690@archlinux>
In-Reply-To: <f8478361c8166ac27f539bb1eceac050ab0908ec.camel@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
        <20200306110100.22092-6-alexandru.ardelean@analog.com>
        <20200307145411.720a680d@archlinux>
        <e59eeceb0b1a27c3920e0bcc42bcba20bdfa9ec7.camel@analog.com>
        <f8478361c8166ac27f539bb1eceac050ab0908ec.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...

> > > > +#define REG_RSTN				0x0040  
> > > 
> > > Usual stuff: These should be prefixed with driver relevant prefix
> > > maybe ADI_AXI_  
> > 
> > my only concern [about the prefix] is that it makes the macro-names too long;
> > after re-looking at these reg definitions, what bothered me is that some of
> > the
> > bit-field-names collide; so i went with concatenanting reg-names + reg-
> > bitnames, 
> > which made them look too long [so i removed the prefix]
> > 
> > there's also the possibility of going back to the regmap-doc and shortening
> > these reg-name/bitnames;
> > but they've been like this for a while, and i admit going to the HDL team
> > makes
> > me sometimes lazy;
> > 
> > i'll re-add teh ADI_AXI prefix; and will see how these look  
> 
> i talked to HDL
> so, we'll have a round of renaming these [in the docs];
> 
> but now, i'm wondering if it's ok to drop the regs that are [currently] unused
> and add them when functionality gets later-added;

Absolutely.  Its in theory better to always do that, but sometimes it's
just easier to copy type the whole datasheet register map into a driver
so we tend to let it go.

> in the meantime, the names can be re-worked/shortened/prettify-ed;
> we'll also need to re-do an inventory of the current HDL IP cores and see how
> the regmaps hold-up/match against the docs;

I'd not worry too much on shortening these.  A bit of ugly code never
really hurt anyone if it's just a long define.

Of course, if it makes sense anyway, always good to tidy up naming.

Jonathan
