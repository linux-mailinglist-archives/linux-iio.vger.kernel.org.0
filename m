Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4B12C318
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2019 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfL2PUU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Dec 2019 10:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfL2PUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Dec 2019 10:20:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EC22071E;
        Sun, 29 Dec 2019 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577632820;
        bh=PPnoXB1UAkWKl8kUep2gTd+3XC7c2Idguvr66bp/Mmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=az91ijJeVSklF1YwLWGMNkuKUqWsooo3cA2evics5KJhPEg2NWiRR0Sn7GYy0CbF5
         VWdMaPFqOD9Y9de5Vtsijzcx1GLc52LIb8pBdz/6eBpIJ9vOKs0y+AeHR+eLAO2tO4
         jMTknGF0DYzFNojE2xm/gmeHUREFoQ4BM6fPOwT4=
Date:   Sun, 29 Dec 2019 15:20:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Robertson <dan@dlrobertson.com>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191229152014.3e269c9f@archlinux>
In-Reply-To: <20191226230359.GA29435@bogus>
References: <20191220160051.26321-1-dan@dlrobertson.com>
        <20191220160051.26321-2-dan@dlrobertson.com>
        <20191226230359.GA29435@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Dec 2019 16:03:59 -0700
Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 20, 2019 at 04:00:49PM +0000, Dan Robertson wrote:
> > Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> > accelerometer sensor.
> > 
> > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> > ---
> >  .../bindings/iio/accel/bosch,bma400.yaml      | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > new file mode 100644
> > index 000000000000..e87cb636b3e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BMA400 triaxial acceleration sensor
> > +
> > +maintainers:
> > +  - Dan Robertson <dan@dlrobertson.com>
> > +
> > +description: |
> > +  Acceleration and temerature iio sensors with an i2c interface  
> 
> checkpatch reports a typo here.
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Fixed up and tag added.  Thanks,

Jonathan

