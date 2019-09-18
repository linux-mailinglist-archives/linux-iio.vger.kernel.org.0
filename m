Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25228B640D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfIRNHw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 09:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfIRNHv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Sep 2019 09:07:51 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13AE8218AF;
        Wed, 18 Sep 2019 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568812070;
        bh=rj5WMPvEQEEDlEkrOcuDiRS34WbhKH/4aLvT8LmbHXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HkTpq5+CByuJLJDwSrthSKsjXN0hKpfqPBHUURdLgqFG9pQzMkystKtHtUZkcVRG9
         We5olk9m+0byrycIfNpv0/D3RpKmOUaLK/JMJQA9ww0uMy6aZi+4/Bahh9uhvPX/em
         vADBC0xYeKgnxRru0WPZgYYq+O93auE94vaHAndU=
Received: by mail-ot1-f49.google.com with SMTP id e11so5089450otl.5;
        Wed, 18 Sep 2019 06:07:50 -0700 (PDT)
X-Gm-Message-State: APjAAAWrRDNCiLBFW/7oP+FLXH2ntwqQas6CVjV5XefeqNOcV0Cv3sbE
        /S4QBHEjzgjDG47hw9HJ0r3svEPzm50nVzBLhnY=
X-Google-Smtp-Source: APXvYqwwzw5VrS2kd6JSzP3MY3hp/cDqnCUwn6rD+GogeFn8UDSudHrPnW0AvhgZI930v5OwBzBSAmmjv49Yu3xnlIU=
X-Received: by 2002:a9d:6f08:: with SMTP id n8mr2951063otq.128.1568812069398;
 Wed, 18 Sep 2019 06:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190907092007.9946-1-krzk@kernel.org> <20190907092007.9946-8-krzk@kernel.org>
 <20190918123654.GA318@bogus>
In-Reply-To: <20190918123654.GA318@bogus>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Sep 2019 15:07:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfFS5bA_OK4Zw_2e3T2MEuNETdcBMLMhGRHC-_UYvsLfA@mail.gmail.com>
Message-ID: <CAJKOXPfFS5bA_OK4Zw_2e3T2MEuNETdcBMLMhGRHC-_UYvsLfA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: arm: samsung: Convert Exynos System
 Registers bindings to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Sep 2019 at 14:36, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Sep 07, 2019 at 11:20:04AM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung Exynos System Registers (SYSREG) bindings to DT schema
> > format using json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Example somehow fails:
> > Documentation/devicetree/bindings/arm/samsung/pmu.example.dt.yaml:
> > system-controller@10040000: compatible:0: 'samsung,exynos5250-pmu' is
> > not one of ['samsung,exynos4-sysreg', 'samsung,exynos5-sysreg']
> >
> > It seems that PMU schema is applied to sysreq nodes (and vice-versa).
> > ---
> >  .../bindings/arm/samsung/sysreg.txt           | 19 -----------
> >  .../bindings/arm/samsung/sysreg.yaml          | 33 +++++++++++++++++++
> >  2 files changed, 33 insertions(+), 19 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt b/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
> > deleted file mode 100644
> > index 4fced6e9d5e4..000000000000
> > --- a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -SAMSUNG S5P/Exynos SoC series System Registers (SYSREG)
> > -
> > -Properties:
> > - - compatible : should contain two values. First value must be one from following list:
> > -             - "samsung,exynos4-sysreg" - for Exynos4 based SoCs,
> > -             - "samsung,exynos5-sysreg" - for Exynos5 based SoCs.
> > -             second value must be always "syscon".
> > - - reg : offset and length of the register set.
> > -
> > -Example:
> > -     syscon@10010000 {
> > -             compatible = "samsung,exynos4-sysreg", "syscon";
> > -             reg = <0x10010000 0x400>;
> > -     };
> > -
> > -     syscon@10050000 {
> > -             compatible = "samsung,exynos5-sysreg", "syscon";
> > -             reg = <0x10050000 0x5000>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> > new file mode 100644
> > index 000000000000..a3d44646e441
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/sysreg.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/samsung/sysreg.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung S5P/Exynos SoC series System Registers (SYSREG)
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - samsung,exynos4-sysreg
> > +          - samsung,exynos5-sysreg
> > +      - const: syscon
>
> The problem is this will by default match any node with 'syscon'. You
> have to add a custom 'select' entry. See the LVDS panel bindings for an
> example.
>
> I'd like to kill off 'syscon'...

I see that panels use empty {} match but some other examples use
custom select. The panel approach in my case does not actually check
whether last compatible is syscon. I'll go then with a separate select
approach.

Best regards,
Krzysztof
