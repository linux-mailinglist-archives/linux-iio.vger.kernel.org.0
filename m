Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F2D1B8DE7
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZI3y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 04:29:54 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:43733 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbgDZI3y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 04:29:54 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.157])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id C5AB15AE098D;
        Sun, 26 Apr 2020 10:29:50 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 26 Apr
 2020 10:29:50 +0200
Date:   Sun, 26 Apr 2020 10:28:25 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200426082825.GA3282@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-6-tomasz.duszynski@octakon.com>
 <20200425202341.53e614d8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200425202341.53e614d8@archlinux>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5079497430882606162
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 08:23:41PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2020 16:11:34 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Add SCD30 sensor binding file.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  .../iio/chemical/sensirion,scd30.yaml         | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> > new file mode 100644
> > index 000000000000..b092b2530c76
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> Dual license preferred with BSD for bindings.
>

Okay.

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
> > +  - vdd-supply
>
> Only enable it I think in the driver.  Should be fine with a stub regulator
> as provided if we don't specify one in the dt binding because it's not
> controllable and we are lazy.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    # include <dt-bindings/gpio/gpio.h>
> > +    # include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      scd30@61 {
> > +        compatible = "sensirion,scd30";
> > +        reg = <0x61>;
> > +        vdd-supply = <&vdd>;
> > +        interrupt-parrent = <&gpio0>;
> > +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +      };
> > +    };
> > +  - |
> > +    # include <dt-bindings/gpio/gpio.h>
>
> Why gpio?
>

That shouldn't be here. I have some local changes where I use sel-gpios hence
this include.

> > +    # include <dt-bindings/interrupt-controller/irq.h>
> > +    serial {
> > +      scd30 {
> > +        compatible = "sensirion,scd30";
> > +        vdd-supply = <&vdd>;
> > +        interrupt-parrent = <&gpio0>;
> > +        interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +      };
> > +    };
> > +
> > +...
>
