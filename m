Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EA12CAB8
	for <lists+linux-iio@lfdr.de>; Sun, 29 Dec 2019 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfL2UJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Dec 2019 15:09:12 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17814 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfL2UJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Dec 2019 15:09:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1577650129; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DnJNwNbmRl7RjLFhqmncyH4Re5uqGpTrX8B/4NYw6C5FrVOd6VfxhqgHcavchsn/Azb3Sf5niECx6vkziJV9TL+f1R0CimaToaRiUJmTta0r7Que3sdJhH9FniYt546pNvXABzGXxZO8xOJG/eJJPaxOdchcHk0k+jpuKlZuqdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1577650129; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EuONeAtWAISP85b0HoLOqO+kvuMF7nTdb489a5FgFIg=; 
        b=nxMiFJ0bMI7EI3cUD4sgpES/5rucN3WzxNF1qFBgFZVgy9EisTcK9aLmVlko/AiqVpZPDa/0M4uXzXcMp6KwthtEmHTjDNR5uGd/pugkDRaZe0He8ttMNReRMbnEsEHijLaRZQnOHL0SfzQR+pMSUL74o5osvDaJUL/k93cUYt8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1577650117807460.3664883416958; Sun, 29 Dec 2019 12:08:37 -0800 (PST)
Date:   Sun, 29 Dec 2019 19:52:57 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191229195257.GA3169@nessie>
References: <20191220160051.26321-1-dan@dlrobertson.com>
 <20191220160051.26321-2-dan@dlrobertson.com>
 <20191226230359.GA29435@bogus>
 <20191229152014.3e269c9f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229152014.3e269c9f@archlinux>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 29, 2019 at 03:20:14PM +0000, Jonathan Cameron wrote:
> On Thu, 26 Dec 2019 16:03:59 -0700
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Fri, Dec 20, 2019 at 04:00:49PM +0000, Dan Robertson wrote:
> > > Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> > > accelerometer sensor.
> > > 
> > > Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> > > ---
> > >  .../bindings/iio/accel/bosch,bma400.yaml      | 54 +++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > > new file mode 100644
> > > index 000000000000..e87cb636b3e2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Bosch BMA400 triaxial acceleration sensor
> > > +
> > > +maintainers:
> > > +  - Dan Robertson <dan@dlrobertson.com>
> > > +
> > > +description: |
> > > +  Acceleration and temerature iio sensors with an i2c interface  
> > 
> > checkpatch reports a typo here.
> > 
> > Otherwise,
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> Fixed up and tag added.  Thanks,

Thanks for fixing this. Wasn't sure if this would necessitate another patchset
version.

Cheers,

 - Dan

