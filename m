Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D542BFE80
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 04:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKWDDN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 22:03:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38503 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgKWDDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 22:03:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id j10so3969030lja.5;
        Sun, 22 Nov 2020 19:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njcEpx2yCvJNcE61ngSH8L3BnOTf+sc74gZJYAGfKCA=;
        b=rhx0P4z122TAgMef0IFk/2XD0sjBxP8t6yZdjN5rDvTppLIJaHdYvN0ah4jc3q8LJK
         MHJ52aZ1byFbUwUJHJ9Iqj4hdOeV6ClHnpmTJvjSak+0m0kyGZQeZJ5mCbgIc/sj1VRP
         B6DSWTTkSE7zn6zODRSvj9y/oaQ/ewW0s5tGypodwgwnqO4CFQWub1hgO3L6nyXmPbzF
         KmgTQgnJJTwrl8eXmlyzsouPCkRRkdwygrVqZjE/7gOnCVZgaSjAJEWEJeYlRvkMALME
         PIqObNx+/uoQP8mSjB6sVlDTacA7H7wWC8nstDalaQb+oxjsakTo7obwaGFyStHayO+5
         0j5Q==
X-Gm-Message-State: AOAM533mTkNXrZgtsJP1HUylRTaq3XMtZbeNP02AKM3GNBP5DMRD1fyY
        od7QVYWS4xukfySb5C3iB26hRbR66exD/g==
X-Google-Smtp-Source: ABdhPJzGGeUuLQ8OGLPEjlezaAMMOGFtxoqn/HP4LkffagPJ2nEt/WN+R6pC45nfubKCdnmblLL3YQ==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr2659071ljk.286.1606100589363;
        Sun, 22 Nov 2020 19:03:09 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j23sm291974lfh.88.2020.11.22.19.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 19:03:08 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id d17so21706597lfq.10;
        Sun, 22 Nov 2020 19:03:08 -0800 (PST)
X-Received: by 2002:a19:ca05:: with SMTP id a5mr11488392lfg.571.1606100588348;
 Sun, 22 Nov 2020 19:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-32-jic23@kernel.org>
 <20201122181525.52410a84@archlinux>
In-Reply-To: <20201122181525.52410a84@archlinux>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 23 Nov 2020 11:02:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64KwkN5z_3nH-kUhJSAMeUfrU+zzn2tivJniT7c38BeAA@mail.gmail.com>
Message-ID: <CAGb2v64KwkN5z_3nH-kUhJSAMeUfrU+zzn2tivJniT7c38BeAA@mail.gmail.com>
Subject: Re: [PATCH 31/46] dt-bindings:iio:adc:x-powers,axp209-adc: txt to
 yaml conversion
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Nov 23, 2020 at 2:22 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sat, 31 Oct 2020 18:48:39 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This is a very small binding.  It might make sense at some stage
> > to just roll it into the parent mfd.  For now, converted as is.
> > The main advantage of this document is the identification of the
> > channel index values when this is used as a provider of ADC channels
> > to consumers.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Quentin Schulz <quentin.schulz@bootlin.com>
> Quentin's email address is boucing so for now I've put myself as maintainer
> of this binding.
>
> +CC Chen-Yu Tsai who 'might' be the a better choice.

Yes you can list me as the maintainer if you yourself don't wish to be.
I am listed as the maintainer for all AXP hardware, excluding the AXP288.

ChenYu


> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to poke at it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../bindings/iio/adc/axp20x_adc.txt           | 48 -------------
> >  .../bindings/iio/adc/x-powers,axp209-adc.yaml | 67 +++++++++++++++++++
> >  2 files changed, 67 insertions(+), 48 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> > deleted file mode 100644
> > index 7a6313913923..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
> > +++ /dev/null
> > @@ -1,48 +0,0 @@
> > -* X-Powers AXP ADC bindings
> > -
> > -Required properties:
> > -  - compatible: should be one of:
> > -    - "x-powers,axp209-adc",
> > -    - "x-powers,axp221-adc",
> > -    - "x-powers,axp813-adc",
> > -  - #io-channel-cells: should be 1,
> > -
> > -Example:
> > -
> > -&axp22x {
> > -     adc {
> > -             compatible = "x-powers,axp221-adc";
> > -             #io-channel-cells = <1>;
> > -     };
> > -};
> > -
> > -ADC channels and their indexes per variant:
> > -
> > -AXP209
> > -------
> > - 0 | acin_v
> > - 1 | acin_i
> > - 2 | vbus_v
> > - 3 | vbus_i
> > - 4 | pmic_temp
> > - 5 | gpio0_v
> > - 6 | gpio1_v
> > - 7 | ipsout_v
> > - 8 | batt_v
> > - 9 | batt_chrg_i
> > -10 | batt_dischrg_i
> > -
> > -AXP22x
> > -------
> > - 0 | pmic_temp
> > - 1 | batt_v
> > - 2 | batt_chrg_i
> > - 3 | batt_dischrg_i
> > -
> > -AXP813
> > -------
> > - 0 | pmic_temp
> > - 1 | gpio0_v
> > - 2 | batt_v
> > - 3 | batt_chrg_i
> > - 4 | batt_dischrg_i
> > diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> > new file mode 100644
> > index 000000000000..288a5ac31a16
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/x-powers,axp209-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: X-Powers AXP ADC bindings
> > +
> > +maintainers:
> > +  - Quentin Schulz <quentin.schulz@bootlin.com>
> > +
> > +description: |
> > +  ADC is frequently used as a provider to consumers of the ADC channels.
> > +  Device is a child of an axp209 multifunction device
> > +  ADC channels and their indexes per variant:
> > +
> > +  AXP209
> > +  ------
> > +   0 | acin_v
> > +   1 | acin_i
> > +   2 | vbus_v
> > +   3 | vbus_i
> > +   4 | pmic_temp
> > +   5 | gpio0_v
> > +   6 | gpio1_v
> > +   7 | ipsout_v
> > +   8 | batt_v
> > +   9 | batt_chrg_i
> > +  10 | batt_dischrg_i
> > +
> > +  AXP22x
> > +  ------
> > +   0 | pmic_temp
> > +   1 | batt_v
> > +   2 | batt_chrg_i
> > +   3 | batt_dischrg_i
> > +
> > +  AXP813
> > +  ------
> > +   0 | pmic_temp
> > +   1 | gpio0_v
> > +   2 | batt_v
> > +   3 | batt_chrg_i
> > +   4 | batt_dischrg_i
> > +
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - x-powers,axp209-adc
> > +      - x-powers,axp221-adc
> > +      - x-powers,axp813-adc
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    axp221 {
> > +        adc {
> > +            compatible = "x-powers,axp221-adc";
> > +            #io-channel-cells = <1>;
> > +        };
> > +    };
> > +...
>
