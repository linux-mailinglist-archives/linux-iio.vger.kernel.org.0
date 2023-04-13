Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690606E0B31
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 12:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDMKOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDMKOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 06:14:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1569EE6
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:13:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h14so3136040qvr.7
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681380817; x=1683972817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5wq7bjd8MawqcAJWbNargmuSvwYWvhPB/jI6KHJiIjE=;
        b=S8e4+585eoKBFFQkYHU9980VH82rcplU9MLKLUmssmofIr7/gG7m0AYXzD5AoKuHEv
         EFU0jmaohRMgjkRIIpbkIfM8bLw4BBPbS5m5/RlqXlcA2iZ5DKUYfxmA+HgCpz60QKzI
         LTGBZgX3mU3UUPY+sei1+Uk4NrRJPLmVJaPiZ4cGWguj1qc8Wl3iVfTcO5GMlRA9z1yY
         9p384tAkRLRn7czlyp2C9DyjIbja6W6EhLaStL5gHvCNgNvRRKU0rVx3J0DmowbTyeTE
         E8qjXbbVln560X3BayMBuS9gq0F4JUZRG5+/0TfxLYa8H0//fkMpQVrnztbWj5rFlKY4
         97qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380817; x=1683972817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wq7bjd8MawqcAJWbNargmuSvwYWvhPB/jI6KHJiIjE=;
        b=IFjC+Prt2WyKtIJzE/1qeoi+wHGvnE4ZMBkgyZcXHZFeZD6FiE2sLeC6ozu6IRvIe/
         JiLLy1fcGQ5hnukcPwna5MPDn2w6C+Y6eKEt713DSwDSkj648hSAMO10WNCJ/vmoglji
         pUZOX3upcXsf3ImaopOzAVv5khJIi1Zz0oYm9LcaipaBHuMfKtP+0+WJDeky+FJhjZiG
         /rGKKVGWFeG0jOIlbmQ+mLw+yfKTlu9A1gntJKOI8KgfJ6HdYNdBHyajzPte8KwLj7GN
         GbwhIxj2nCD/cmIq86u+9AQQln6fz588/4U+0fkb1/UO6L0w1JdP7R+NePzdDZLIXpKT
         Zobw==
X-Gm-Message-State: AAQBX9fmkzN2XH9ljxJ8JmvCEo6D6RDFkBdm3Owvt6HEpSt4kwHdH11u
        7ED/o1yEidWtmsPsE7blsAoNQaL/3p7T6YTK
X-Google-Smtp-Source: AKy350berdC6miLwK1mIs/J87LSA7uYX1WXckJMdjubq95ycY2cSiNmM6jyaVfOeYvfMKB4hAGIpDQ==
X-Received: by 2002:a05:6214:cca:b0:5ef:512d:2d34 with SMTP id 10-20020a0562140cca00b005ef512d2d34mr845081qvx.11.1681380817355;
        Thu, 13 Apr 2023 03:13:37 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id n5-20020ad444a5000000b005dd8b934576sm338817qvt.14.2023.04.13.03.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:13:36 -0700 (PDT)
Message-ID: <ae323663d6f8306dff8283b192e014eba25af160.camel@gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 13 Apr 2023 12:15:42 +0200
In-Reply-To: <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
         <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
         <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
         <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2023-04-13 at 10:36 +0200, Fabrizio Lamarque wrote:
> Added undocumented properties:
>=20
> - adi,clock-xtal
> - adi,int-clock-output-enable
>=20
> Removed clocks from required properties.
> Renamed avdd-supply to vreg-supply, while keeping backward compatibility
> (deprecated avdd-supply).
>=20
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---
> =C2=A0.../bindings/iio/adc/adi,ad7192.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++++----
> =C2=A0drivers/iio/adc/ad7192.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 18 ++++++------
> =C2=A02 files changed, 32 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index d521d516088b..5dc7a7eea5f9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -32,7 +32,9 @@ properties:
>=20
> =C2=A0=C2=A0 clocks:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> -=C2=A0=C2=A0=C2=A0 description: phandle to the master clock (mclk)
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phandle to the external master clock (mcl=
k). If not defined, internal
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock is selected.
>=20
> =C2=A0=C2=A0 clock-names:
> =C2=A0=C2=A0=C2=A0=C2=A0 items:
> @@ -45,7 +47,23 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0 description: DVdd voltage supply
>=20
> =C2=A0=C2=A0 avdd-supply:
> -=C2=A0=C2=A0=C2=A0 description: AVdd voltage supply
> +=C2=A0=C2=A0=C2=A0 description: Phandle to reference voltage regulator. =
Use
> vref-supply instead.
> +=C2=A0=C2=A0=C2=A0 deprecated: true
> +
> +=C2=A0 vref-supply:
> +=C2=A0=C2=A0=C2=A0 description: Phandle to reference voltage regulator
> +
> +=C2=A0 adi,clock-xtal:
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit selects whether an external crys=
tal oscillator or an external
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock is applied as master (mclk) clock. =
It is ignored when clocks
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 property is not set.
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +

It looks like you could use a dependency... Grep for "dependencies:" in the
bindings folder.

> +=C2=A0 adi,int-clock-output-enable:
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When internal clock is selected, this bit=
 enables clock out pin.
> +=C2=A0=C2=A0=C2=A0 type: boolean
>=20
> =C2=A0=C2=A0 adi,rejection-60-Hz-enable:
> =C2=A0=C2=A0=C2=A0=C2=A0 description: |
> @@ -84,11 +102,9 @@ properties:
> =C2=A0required:
> =C2=A0=C2=A0 - compatible
> =C2=A0=C2=A0 - reg
> -=C2=A0 - clocks
> -=C2=A0 - clock-names
> =C2=A0=C2=A0 - interrupts
> =C2=A0=C2=A0 - dvdd-supply
> -=C2=A0 - avdd-supply
> +=C2=A0 - vref-supply
> =C2=A0=C2=A0 - spi-cpol
> =C2=A0=C2=A0 - spi-cpha
>=20
> @@ -114,7 +130,7 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
interrupts =3D <25 0x2>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
interrupt-parent =3D <&gpio>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dvdd-supply =3D <&dvdd>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 avdd-=
supply =3D <&avdd>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vref-=
supply =3D <&vref>;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
adi,refin2-pins-enable;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
adi,rejection-60-Hz-enable;
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c

You should not mix bindings changes with driver changes... They should go i=
n
separate patches.

> index 5a9c8898f8af..a0cac9b60ea8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -176,7 +176,7 @@ struct ad7192_chip_info {
>=20
> =C2=A0struct ad7192_state {
> =C2=A0=C2=A0=C2=A0=C2=A0 const struct ad7192_chip_info=C2=A0=C2=A0=C2=A0 =
*chip_info;
> -=C2=A0=C2=A0=C2=A0 struct regulator=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *avdd;
> +=C2=A0=C2=A0=C2=A0 struct regulator=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *vref;
> =C2=A0=C2=A0=C2=A0=C2=A0 struct clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *mclk;
> =C2=A0=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int_vref_mv;
> =C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclk;
> @@ -1000,17 +1000,19 @@ static int ad7192_probe(struct spi_device *spi)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&st->lock);
>=20
> -=C2=A0=C2=A0=C2=A0 st->avdd =3D devm_regulator_get(&spi->dev, "avdd");
> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->avdd))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->avdd);
> +=C2=A0=C2=A0=C2=A0 st->vref =3D devm_regulator_get(&spi->dev, "vref");
> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vref))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref =3D devm_regulator_g=
et(&spi->dev, "avdd");
> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vref))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->vref);
>=20
I'm also not sure this will work as you expect. If no regulator is found, y=
ou'll
still get a dummy one which means you won't ever reach the point to get "av=
dd".
Look here:

https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L21=
37

So I guess you could devm_regulator_get_optional() for "vref" and then move
forward to look for "avdd" if you get -ENODEV from the first call. But usin=
g=20
devm_regulator_get_optional() like this is really an __hack__ and not how i=
t's
supposed to be used. So maybe this is cumbersome enough to just let it be a=
s
before? You can just update the description in the bindings.

- Nuno S=C3=A1

