Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC427734315
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jun 2023 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjFQSh0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jun 2023 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFQShZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jun 2023 14:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856C19A3;
        Sat, 17 Jun 2023 11:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BEF660B5A;
        Sat, 17 Jun 2023 18:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ACFC433C8;
        Sat, 17 Jun 2023 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027043;
        bh=0gXitJCRhwNZ9Hvgsis90nxHbGGP+Fap5swbmod0VXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QHsuxD7r4OSzwnmlVvStlH4wUNHu11qxRTL4ZHrU3yjWlrTqkKVHpgwu15D642Uym
         7LcSVxOiQtr3SqEEkAixLNTXURcqF+gwQAnMcmVJeyHS/nQ/DSbzaKcd/j3qsO+Kys
         W6axLT+rbFAulYWP4fm582NZ4yd3JSmKI/GnRIj47B73ZhgDY4e4f6sfao9/MliHE0
         iOR76vV5tzXIHgv7PzIFk1gVxecoQdYaAo6tyY2+mbt5dPQqpDdTD7qw8BTGkauOu+
         ulfUe8Qd3qShNmAvOzVsH+vQ5qsHkQ+LVzs1qx+M85HPIhH38dC72OsrmWEjU6GHtj
         pTsvgu31hd3pg==
Date:   Sat, 17 Jun 2023 19:37:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: adc: max14001: New driver
Message-ID: <20230617193715.20d0c048@jic23-huawei>
In-Reply-To: <20230617193423.42a4d66c@jic23-huawei>
References: <20230614004857.134980-1-kimseer.paller@analog.com>
        <20230614004857.134980-2-kimseer.paller@analog.com>
        <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
        <a6488485909d40b3810ad15787cd2100@analog.com>
        <CAHp75VdQJ39Uw8bPD+y7GS7W2iJhjs2D4L-=-Fo0Jeb+8Ffn8g@mail.gmail.com>
        <20230617193423.42a4d66c@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 17 Jun 2023 19:34:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 14 Jun 2023 14:53:12 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Wed, Jun 14, 2023 at 1:43=E2=80=AFPM Paller, Kim Seer
> > <KimSeer.Paller@analog.com> wrote: =20
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Wednesday, June 14, 2023 5:12 PM   =20
> >=20
> > ...
> >  =20
> > > > > +               /* select external voltage reference source for t=
he ADC */
> > > > > +               ret =3D max14001_reg_update(st, MAX14001_CFG,
> > > > > +                                         MAX14001_CFG_EXRF, 1);
> > > > > +
> > > > > +               ret =3D regulator_get_voltage(vref);
> > > > > +               if (ret < 0)
> > > > > +                       return dev_err_probe(dev, ret,
> > > > > +                                            "Failed to get vref\=
n");   =20
> > > >
> > > > Is it important to choose the external reference source _before_ ge=
tting the
> > > > voltage of the regulator? If not, I would swap these calls, otherwi=
se the
> > > > comment is needed to explain why the sequence is important in the w=
ay it's
> > > > written.   =20
> > >
> > > It is not important. These calls can be swap without any issues.   =20
> >=20
> > If you send a new version, please swap, otherwise I hope Jonathan can
> > do it when applying.
> >  =20
>=20
> I made these changes whilst applying...
>=20
> --- a/drivers/iio/adc/max14001.c
> +++ b/drivers/iio/adc/max14001.c
> @@ -290,16 +290,19 @@ static int max14001_probe(struct spi_device *spi)
>                 if (ret)
>                         return ret;
> =20
> -               /* select external voltage reference source for the ADC */
> -               ret =3D max14001_reg_update(st, MAX14001_CFG,
> -                                         MAX14001_CFG_EXRF, 1);
> -
>                 ret =3D regulator_get_voltage(vref);
>                 if (ret < 0)
>                         return dev_err_probe(dev, ret,
>                                              "Failed to get vref\n");
> =20
>                 st->vref_mv =3D ret / 1000;
> +
> +               /* select external voltage reference source for the ADC */
> +               ret =3D max14001_reg_update(st, MAX14001_CFG,
> +                                         MAX14001_CFG_EXRF, 1);
> +
> +               if (ret < 0)
> +                       return ret;
>         }
> =20
>         mutex_init(&st->lock);
>=20
>=20
> Note that whilst I've applied this to the togreg branch of iio.git - it i=
s just
> a tiny bit too late to make the merge window that starts in about a week.
> As such I'll only push this out as testing until I can rebase the tree
> on rc1 once available.

Actually nope. Dropped it again because a question came up in my build test=
s.

I'll address that in a separate reply.

Jonathan

>=20
> Thanks,
>=20
> Jonathan

