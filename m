Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5991B4CA2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVS1Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 14:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgDVS1Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 14:27:24 -0400
Received: from Mani-XPS-13-9360 (unknown [157.46.59.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28802098B;
        Wed, 22 Apr 2020 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587580043;
        bh=aX7ErMuTRR6KxWw7n67/xp1KzVfow6ube4HmuPuKO0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUomHkfmo3+5bmLFETG93ObUl5KqABnNCzS/TOFpYf7ErUDdk5JyhpWWCxI2b3MW2
         AHaquTr297uPb89AdGe3+onWMQxTO5Xh8mFj2rGGvNh+UNsOT+AL633dVF1qp6Fejd
         +mP0vHTYslEPPuLVL5uJWr2vCHk6/+VM1W8Kg98c=
Date:   Wed, 22 Apr 2020 23:57:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     jic23@kernel.org
Cc:     Rob Herring <robh@kernel.org>, narcisaanamaria12@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [RESEND PATCH v3 1/3] dt-bindings: iio: chemical: Add binding
 for CCS811 VOC sensor
Message-ID: <20200422182715.GA27920@Mani-XPS-13-9360>
References: <20200414184930.5576-1-mani@kernel.org>
 <20200414184930.5576-2-mani@kernel.org>
 <20200420211111.GA754@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420211111.GA754@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 20, 2020 at 04:11:11PM -0500, Rob Herring wrote:
> On Wed, Apr 15, 2020 at 12:19:28AM +0530, mani@kernel.org wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > This commit adds devicetree binding for AMS CCS811 VOC sensor.
> > 
> > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  .../bindings/iio/chemical/ams,ccs811.yaml     | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > new file mode 100644
> > index 000000000000..5cb068666a3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
> 
> Add:
> 
> additionalProperties: false
> 

Hi Jonathan,

Do you want me to spin another series or you can add it while applying?

Thanks,
Mani

> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
