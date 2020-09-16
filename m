Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361026C819
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgIPSlV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:41:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbgIPSlM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:41:12 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3CB896F93DAAF862A3D7;
        Wed, 16 Sep 2020 11:35:39 +0100 (IST)
Received: from localhost (10.52.126.84) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 16 Sep
 2020 11:35:38 +0100
Date:   Wed, 16 Sep 2020 11:34:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Shawn Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, <fugang.duan@nxp.com>
Subject: Re: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion
 to yaml.
Message-ID: <20200916113401.00006d86@Huawei.com>
In-Reply-To: <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-2-jic23@kernel.org>
        <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.84]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 14:45:58 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 9, 2020 at 12:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > A simple conversion of this freescale ADC binding from txt to yaml.
> > For maintainer I went with Fugang Duan as the original author of the
> > binding. Would be great to have confirmation of this.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fugang Duan <B38611@freescale.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81 +++++++++++++++++++
> >  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
> >  2 files changed, 81 insertions(+), 36 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > new file mode 100644
> > index 000000000000..99b6b55fd0a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/fsl,vf610-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADC found on Freescale vf610 and similar SoCs
> > +
> > +maintainers:
> > +  - Fugang Duan <B38611@freescale.com>  
> 
> I assume you got a bunch of bounces on this series, too? Looks like 1,
> 4, 7, 9, 13, 16, 19, and 20 bounced. Please fix those addresses before
> applying.

Yup. I missed them on v1, but have saved the set for v2 to be able to
fix those I can.

for some I can make a reasonable stab at a suitable maintainer
as covered by a catch all.  For the others if I can't find a newer address
I'll cover them myself until someone else steps up.
I think that's just 9 and 13.  For 4 I didn't get a bounce but can add that
to my list!

For this particular one looks like fugang duan is still active but now
with an NXP address so I'll update that. I've changed the cc on this
mail.

Thanks,

Jonathan


> 
> Rob


