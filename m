Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA8A4FF8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 09:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfIBHdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 03:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfIBHdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Sep 2019 03:33:09 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB9D23429;
        Mon,  2 Sep 2019 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567409587;
        bh=y+5P1hfsjPzrRBsALGIpfJYlar+9I+2fVRqvl/HSQTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QKqxAFiFMTGmiMZ0/LvnCoo5ZLM0zJCWzNG28Mofr9l21Pyj+1eurBat3X5NEw8MF
         YzjZs8z9Ah+WkcxJas2h1q0XdP4mNbx8aymPGnSjRoEy2q8UM9e+d4ARul0ap28wjX
         5Wexrc1iczyxyHJea/1/ZvMB4AQJ5pwfVVTPkH3Q=
Received: by mail-lf1-f50.google.com with SMTP id n19so9629836lfe.13;
        Mon, 02 Sep 2019 00:33:07 -0700 (PDT)
X-Gm-Message-State: APjAAAV2cMJtOnhcbMCcAmCjLGP6uzvsiWtoHB+L4cX9FjD6Bac7NE/S
        THfF6vzUHKB5u7jHSMoO5/59mIJBmCGJJ/KAo98=
X-Google-Smtp-Source: APXvYqxyCOaje6SB6iyH0FEun/HB6V5vap2fk9lKIYMBx39ku0q4v/vm5YLNUtuW61t8JypAaE9I4vwRijQrRIsdcgQ=
X-Received: by 2002:a19:c649:: with SMTP id w70mr16648593lff.33.1567409585243;
 Mon, 02 Sep 2019 00:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190823145356.6341-1-krzk@kernel.org> <CAL_Jsq+5MpPSjRtFp-xf8P0rBuArMFbum7yadcHNBQz_N=Ergg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+5MpPSjRtFp-xf8P0rBuArMFbum7yadcHNBQz_N=Ergg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 2 Sep 2019 09:32:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcFCxa5+ut0S5Rc1sGRa==Og+UmKKqr4Ap4rd4qNi=JWg@mail.gmail.com>
Message-ID: <CAJKOXPcFCxa5+ut0S5Rc1sGRa==Og+UmKKqr4Ap4rd4qNi=JWg@mail.gmail.com>
Subject: Re: [RFC 1/9] dt-bindings: arm: samsung: Convert Samsung board/soc
 bindings to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, notify@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Aug 2019 at 13:38, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Aug 23, 2019 at 9:54 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Convert Samsung S5P and Exynos SoC bindings to DT schema format using
> > json-schema.  This is purely conversion of already documented bindings
> > so it does not cover all of DTS in the Linux kernel (few S5P/Exynos and
> > all S3C are missing).
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > If the schema looks sensible, I will continue on converting other
> > SoC and driver bindings and later adding missing schemas (S3C
> > SoCs).
>
> Looks pretty good.
>
> > ---
> >  .../bindings/arm/samsung/samsung-boards.txt   |  83 --------
> >  .../bindings/arm/samsung/samsung-boards.yaml  | 188 ++++++++++++++++++
> >  2 files changed, 188 insertions(+), 83 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
>
>
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
> > new file mode 100644
> > index 000000000000..e963fd70c436
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
> > @@ -0,0 +1,188 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/samsung/samsung-boards.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung Exynos and S5P SoC based boards
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: S5PV210 based Aries boards
> > +        items:
> > +          - enum:
> > +              - samsung,fascinate4g             # Samsung Galaxy S Fascinate 4G (SGH-T959P)
> > +              - samsung,galaxys                 # Samsung Galaxy S (i9000)
> > +          - const: samsung,aries
> > +          - const: samsung,s5pv210
> > +
> > +      - description: Exynos3250 based boards
> > +        items:
> > +          - enum:
> > +              - samsung,monk                    # Samsung Simband
> > +              - samsung,rinato                  # Samsung Gear2
> > +          - const: samsung,exynos3250
> > +          - const: samsung,exynos3
> > +
> > +      - description: Samsung ARTIK5 boards
> > +        items:
> > +          - enum:
> > +              - samsung,artik5-eval             # Samsung ARTIK5 eval board
> > +          - const: samsung,artik5               # Samsung ARTIK5 module
> > +          - const: samsung,exynos3250
> > +          - const: samsung,exynos3
> > +
> > +      - description: Exynos4210 based boards
> > +        items:
> > +          - enum:
> > +              - insignal,origen                 # Insignal Origen
> > +              - samsung,smdkv310                # Samsung SMDKV310 eval
> > +              - samsung,trats                   # Samsung Tizen Reference
> > +              - samsung,universal_c210          # Samsung C210
> > +          - const: samsung,exynos4210
> > +          - const: samsung,exynos4
> > +
> > +      - description: Exynos4412 based boards
> > +        items:
> > +          - enum:
> > +              - friendlyarm,tiny4412            # FriendlyARM TINY4412
> > +              - hardkernel,odroid-u3            # Hardkernel Odroid U3
> > +              - hardkernel,odroid-x             # Hardkernel Odroid X
> > +              - hardkernel,odroid-x2            # Hardkernel Odroid X2
> > +              - insignal,origen4412             # Insignal Origen
> > +              - samsung,smdk4412                # Samsung SMDK4412 eval
> > +              - topeet,itop4412-elite           # TOPEET Elite base
> > +          - const: samsung,exynos4412
> > +          - const: samsung,exynos4
> > +
> > +      - description: Samsung Midas family boards
> > +        items:
> > +          - enum:
> > +              - samsung,i9300                   # Samsung GT-I9300
> > +              - samsung,i9305                   # Samsung GT-I9305
> > +              - samsung,n710x                   # Samsung GT-N7100/GT-N7105
> > +              - samsung,trats2                  # Samsung Tizen Reference
> > +          - const: samsung,midas
> > +          - const: samsung,exynos4412
> > +          - const: samsung,exynos4
> > +
> > +      - description: Exynos5250 based boards
> > +        items:
> > +          - enum:
> > +              - google,snow-rev5                # Google Snow Rev 5+
> > +              - google,spring                   # Google Spring
> > +              - insignal,arndale                # Insignal Arndale
> > +              - samsung,smdk5250                # Samsung SMDK5250 eval
> > +          - const: samsung,exynos5250
> > +          - const: samsung,exynos5
> > +
> > +      - description: Google Snow Boards (Rev 4+)
> > +        items:
> > +          - enum:
> > +              - google,snow-rev4
>
> const here as I wouldn't expect this list to grow.

OK

>
> > +          - const: google,snow
> > +          - const: samsung,exynos5250
> > +          - const: samsung,exynos5
> > +
> > +      - description: Exynos5260 based boards
> > +        items:
> > +          - enum:
> > +              - samsung,xyref5260               # Samsung Xyref5260 eval
> > +          - const: samsung,exynos5260
> > +          - const: samsung,exynos5
> > +
> > +      - description: Exynos5410 based boards
> > +        items:
> > +          - enum:
> > +              - hardkernel,odroid-xu            # Hardkernel Odroid XU
> > +              - samsung,smdk5410                # Samsung SMDK5410 eval
> > +          - const: samsung,exynos5410
> > +          - const: samsung,exynos5
> > +
> > +      - description: Exynos5420 based boards
> > +        items:
> > +          - enum:
> > +              - insignal,arndale-octa           # Insignal Arndale Octa
> > +              - samsung,smdk5420                # Samsung SMDK5420 eval
> > +          - const: samsung,exynos5420
> > +          - const: samsung,exynos5
> > +
> > +      - description: Google Peach Pit Boards (Rev 6+)
> > +        items:
> > +          - enum:
> > +              - google,pit-rev16
>
> const

OK

>
> > +          - const: google,pit-rev15
> > +          - const: google,pit-rev14
> > +          - const: google,pit-rev13
> > +          - const: google,pit-rev12
> > +          - const: google,pit-rev11
> > +          - const: google,pit-rev10
> > +          - const: google,pit-rev9
> > +          - const: google,pit-rev8
> > +          - const: google,pit-rev7
> > +          - const: google,pit-rev6
> > +          - const: google,pit
> > +          - const: google,peach
> > +          - const: samsung,exynos5420
> > +          - const: samsung,exynos5
> > +
> > +      - description: Exynos5800 based boards
> > +        items:
> > +          - enum:
> > +              - hardkernel,odroid-xu3           # Hardkernel Odroid XU3
> > +              - hardkernel,odroid-xu3-lite      # Hardkernel Odroid XU3 Lite
> > +              - hardkernel,odroid-xu4           # Hardkernel Odroid XU4
> > +              - hardkernel,odroid-hc1           # Hardkernel Odroid HC1
> > +          - const: samsung,exynos5800
> > +          - const: samsung,exynos5
> > +
> > +      - description: Google Peach Pi Boards (Rev 10+)
> > +        items:
> > +          - enum:
> > +              - google,pi-rev16
> > +          - const: google,pi-rev15
> > +          - const: google,pi-rev14
> > +          - const: google,pi-rev13
> > +          - const: google,pi-rev12
> > +          - const: google,pi-rev11
> > +          - const: google,pi-rev10
> > +          - const: google,pi
> > +          - const: google,peach
> > +          - const: samsung,exynos5800
> > +          - const: samsung,exynos5
> > +
> > +      - description: Exynos5433 based boards
> > +        items:
> > +          - enum:
> > +              - samsung,tm2                     # Samsung TM2
> > +              - samsung,tm2e                    # Samsung TM2E
> > +          - const: samsung,exynos5433
> > +
> > +  firmware:
>
> This should be moved to its own file.

Indeed, thanks for the review.

Best regards,
Krzysztof
