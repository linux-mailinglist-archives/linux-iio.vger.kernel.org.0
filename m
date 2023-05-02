Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0396F3D88
	for <lists+linux-iio@lfdr.de>; Tue,  2 May 2023 08:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjEBGeU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 May 2023 02:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBGeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2023 02:34:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B71FDE;
        Mon,  1 May 2023 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683009257; x=1714545257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BR4pOk50AuJACYyIx65LcARG4wlTe4CEGYiKtvQu1c=;
  b=NR1ufUqPjmX9PM8JBcHM5UKfM0PK5dBxrVJhy1VIdfEfSz37ZkF7wcpu
   1vl6mp/uqDgeo1fcylhY1ZGJuhVv/eMC9GP94HkI9ug/eVHysZoRwdHDN
   Zmo9UBK6jW+FW8+ivzuvQlD0HPV1AEqbHhNo4lOYWQ5lGKLqyJYVQY/xA
   Ir+Kqc/ld5O6jH23vrAJJ8lTrDpi9h7gmo/10i7KbM/jmu37ywMU7ecT/
   kJM+8SVRe3LPgQ5EmIoqpsjtv4Kioyr+48FRfksW9mCFUCfCwd65Rk+cV
   eNHK0z+PwuYyLkxt4tzDM+rEVKMXDFn6THLjAa/L/HPxtGK7BHSB8iiGU
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677538800"; 
   d="scan'208";a="30654676"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 May 2023 08:34:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 02 May 2023 08:34:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 02 May 2023 08:34:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683009255; x=1714545255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BR4pOk50AuJACYyIx65LcARG4wlTe4CEGYiKtvQu1c=;
  b=SxY6tBHht9vZGLH1ksclaWP2SUOF9cZ2S/1RgaJnn1knhAadmhVGExoR
   qYNEikJIPPW1Y56u9fIx6x7MJIH7Z9P2yKBr98XZmrT3CpwOO/OZAuk+8
   uu1MkdJJgspCg0vkMH8HpjzY/9W689MwhwweoLlqsEZklreXwwlf2mwbb
   76rB3UAxYh5ZQ02cSVsQsSkh0M7qk6wrYMK26o+cU6Nc7zE7Uq02R3WYD
   Zr6Rqu5PCaAWSXrPNg92tMosLfblWR4VQKJQ2TTcFncWPgiNiZwMBRATr
   5Haqg9ooA7qWMq94zlNX1w5n5eXzfGj2/xCv9ktOGic+5Tayu/rMKE6WA
   w==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677538800"; 
   d="scan'208";a="30654675"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 May 2023 08:34:14 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id ACCAA280056;
        Tue,  2 May 2023 08:34:14 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/1] dt-bindings: iio: imx8qxp-adc: add missing vref-supply
Date:   Tue, 02 May 2023 08:34:12 +0200
Message-ID: <5671528.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230430181558.7614cbfc@jic23-huawei>
References: <20230424092312.61746-1-alexander.stein@ew.tq-group.com> <20230430181558.7614cbfc@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Sonntag, 30. April 2023, 19:15:58 CEST schrieb Jonathan Cameron:
> On Mon, 24 Apr 2023 11:23:12 +0200
>=20
> Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > this ADC has two internal reference voltages, which the driver currently
> > doesn't make use of.
> >=20
> > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation =
for
> > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > <alexander.stein@ew.tq-group.com>
>=20
> Interesting that we are talking her only about vrefh, what about vrefp?
> I guess the assumption is that will be wired to 0V?

What's vrefp? The only other signal related to ADC is vrefl.

> The first reference I found didn't seem to imply that was necessarily the
> case. https://www.mouser.com/pdfDocs/IMX8QXPAEC.pdf

Assuming you are talking about vrefh and vrefl, how is this a problem? Even=
 if=20
vrefl is not 0V, the voltage difference is what the ADC uses as reference=20
voltage, so this should be supplied in the DT then.

Best regards
Alexander

> Jonathan
>=20
> > ---
> > Thanks for your inputs. This improved descritpion should make it clear
> > that this property is only about the external reference voltage, not
> > about the optional, internal voltages.
> >=20
> > Changes in v2:
> > * Improved commit message subject as suggested
> > * Add hint about feature flag regarding multiple, internal, reference
> >=20
> >   voltages
> > =20
> >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml       | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml index
> > 63369ba388e4..878e67054d7c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> >=20
> > @@ -39,6 +39,12 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >=20
> > +  vref-supply:
> > +    description: |
> > +      External ADC reference voltage supply on VREFH pad. If VERID[MVI]
> > is
> > +      set, there are additional, internal reference voltages selectabl=
e.
> > +      VREFH1 is always from VREFH pad.
> > +
> >=20
> >    "#io-channel-cells":
> >      const: 1
> >=20
> > @@ -72,6 +78,7 @@ examples:
> >              assigned-clocks =3D <&clk IMX_SC_R_ADC_0>;
> >              assigned-clock-rates =3D <24000000>;
> >              power-domains =3D <&pd IMX_SC_R_ADC_0>;
> >=20
> > +            vref-supply =3D <&reg_1v8>;
> >=20
> >              #io-channel-cells =3D <1>;
> >         =20
> >          };
> >     =20
> >      };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


