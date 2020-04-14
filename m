Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF81A7A61
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgDNMKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 08:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbgDNMKW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 08:10:22 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.102.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09300206A2;
        Tue, 14 Apr 2020 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586866221;
        bh=9nLijrfFYT0Yv0LLGW5g9Cnrm+SAsUFzF6rXqjQvE9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfD6ULUK00pKiRiq73UbKHBodLii08HNnSGkJDWXcXFt630iGbxxo8Hyzf6qqoj+G
         FUwHuWtVAqgHGoqKHTOXzWfruB6qPXAdYB14cwMu28ceC/p3FX8PXPqbmSUMXwk5UR
         XSiXFSry0KNmgxv7CkqzOYhS09dMwT60kU0Sp2Hk=
Date:   Tue, 14 Apr 2020 17:40:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: chemical: Add binding for CCS811
 VOC sensor
Message-ID: <20200414121009.GA28866@Mani-XPS-13-9360>
References: <20200412183658.6755-1-mani@kernel.org>
 <20200412183658.6755-2-mani@kernel.org>
 <20200413175323.7f41b766@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413175323.7f41b766@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 05:53:23PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Apr 2020 00:06:56 +0530
> mani@kernel.org wrote:
> 
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > This commit adds devicetree binding for AMS CCS811 VOC sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> Great to see this driver getting some more attention.
> 
> A few things inline
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/chemical/ams,ccs811.yaml     | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > new file mode 100644
> > index 000000000000..564208af7b2b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Preferred that all new binding docs are dual licensed with BSD as well
> to allow there use by things other than the kernel.
> 

Okay will do.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS CCS811 VOC Sensor
> > +
> > +maintainers:
> > +  - Narcisa Vasile <narcisaanamaria12@gmail.com>
> > +
> > +description: |
> > +  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ams,ccs811
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: GPIO connected to the nRESET line. This is an active low
> > +                 input to CCS811.
> > +    maxItems: 1
> > +
> > +  wakeup-gpios:
> > +    description: GPIO connected to the nWAKE line. This is an active low
> > +                 input to CCS811.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      ccs811@5b {
> Hmm. Not sure we have a generic name in the dt spec for voc sensor.
> Even so we should try for something appropriate.
> 
> Could go with voc@5b?
> 

Sounds good to me.

Thanks,
Mani

> > +        compatible = "ams,ccs811";
> > +        reg = <0x5b>;
> > +        reset-gpios = <&gpioa 11 GPIO_ACTIVE_LOW>;
> > +        wakeup-gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
> > +      };
> > +    };
> > +
> > +...
> 
