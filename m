Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833551E98A7
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgEaPqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 11:46:18 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:51683 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgEaPqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 May 2020 11:46:18 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.191])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 7F74754B9C51;
        Sun, 31 May 2020 17:46:15 +0200 (CEST)
Received: from localhost (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 31 May
 2020 17:46:14 +0200
Date:   Sun, 31 May 2020 17:44:06 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200531154406.GA27246@arch>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
 <20200530213630.87159-5-tomasz.duszynski@octakon.com>
 <20200531111914.56dbff8b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200531111914.56dbff8b@archlinux>
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 15080021879647853650
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeffedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhepleekkeeuhfdtleehlefgffeltedthfekveefueevteeuvdejgeejtdetueffgeefnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkpheptddrtddrtddrtddpkeelrdejtddrudektddruddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehpmhgvvghrfiesphhmvggvrhifrdhnvght
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 31, 2020 at 11:19:14AM +0100, Jonathan Cameron wrote:
> On Sat, 30 May 2020 23:36:30 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Add SCD30 sensor binding file.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  .../iio/chemical/sensirion,scd30.yaml         | 68 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> > new file mode 100644
> > index 000000000000..34cc3925d64d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/chemical/sensirion,scd30.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sensirion SCD30 carbon dioxide sensor
> > +
> > +maintainers:
> > +  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > +
> > +description: |
> > +  Air quality sensor capable of measuring co2 concentration, temperature
> > +  and relative humidity.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,scd30
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  sensirion,sel-gpios:
> > +    description: GPIO connected to the SEL line
> > +    maxItems: 1
> > +
> > +  sensirion,pwm-gpios:
> > +    description: GPIO connected to the PWM line
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    # include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      scd30@61 {
>
> Nodes should have generic names.  Not sure we have an appropriate
> one in the spec, but as main focus of people using this will be
> c02 herpas
>
> 	c02@61?
>

There are already a few recommended node names ending with '-sensor' on the list
like air-pollution-sensor or temperature-sensor. I'd say co2-sensor would work
here.

> Rob may well have a better suggestion!
>
> > +        compatible = "sensirion,scd30";
> > +        reg = <0x61>;
> > +        vdd-supply = <&vdd>;
> > +        interrupt-parent = <&gpio0>;
> > +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +      };
> > +    };
> > +  - |
> > +    # include <dt-bindings/interrupt-controller/irq.h>
> > +    serial {
> > +      scd30 {
> > +        compatible = "sensirion,scd30";
> > +        vdd-supply = <&vdd>;
> > +        interrupt-parent = <&gpio0>;
> > +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +      };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5db4b446c8ba..0ab9cf39e051 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15140,6 +15140,7 @@ F:	include/uapi/linux/phantom.h
> >  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
> >  M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
> >  S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> >  F:	drivers/iio/chemical/scd30.h
> >  F:	drivers/iio/chemical/scd30_core.c
> >  F:	drivers/iio/chemical/scd30_i2c.c
>
