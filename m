Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549B62A193B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgJaSMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgJaSMA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:12:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CA42068D;
        Sat, 31 Oct 2020 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604167919;
        bh=a2tTiyfCvUvsXaeN/w/sZPvAAYjI4kxRXWB/i1x9Sg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xXdQam3Bf5n9jdoSser7w4TIT0afwOuhZhEgVDZOyWA6GL7Hpbu7zi8jFKhWhpS1G
         XOLABUtpcSCi13J0qXLFDhII6vTN3DIcBE/8CU3o8r//DSxXFsj6Z6Hjk2BabaiwTM
         9NWZViWmmyx43CMB5Qlh5CzxDSyKvQCXVcXSWTVI=
Date:   Sat, 31 Oct 2020 18:11:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml
 conversion
Message-ID: <20201031181155.08e0288d@archlinux>
In-Reply-To: <20201031165836.GA12341@wunner.de>
References: <20201031134110.724233-1-jic23@kernel.org>
        <20201031134110.724233-17-jic23@kernel.org>
        <20201031165836.GA12341@wunner.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 17:58:36 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Sat, Oct 31, 2020 at 01:40:57PM +0000, Jonathan Cameron wrote:
> > +  spi-cpha: true
> > +  spi-cpol:
> > +    description:
> > +      Should be either spi-cpha, or spi-cpol but not both.  
> 
> Do the YAML files follow RFC 2119 terminology?  If so, this is a
> "must", not a "should".  (As it was in the txt file.)

I'll fix that whilst applying if it is all we have outstanding.
This is an information comment only as the actual enforcement is
below.


> 
> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply  
> 
> This is missing "spi-cpha xor spi-cpol", not sure if it can be
> specified here using the xor YAML trick.

It has to be specified in a separate block as far as I can tell.
That is done further down the file.  I've tested all the combinations
and xor is enforced.

+allOf:
+  - $ref: '#/definitions/cpolXORcpha'
+
+definitions:
+  cpolXORcpha:
+    not:
+      required: [spi-cpha, spi-cpol]
+    oneOf:
+      - required:
+          - spi-cpha
+      - required:
+          - spi-cpol
+

> 
> Thanks,
> 
> Lukas

