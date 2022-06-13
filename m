Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B25548038
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiFMHGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiFMHGD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 03:06:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472418E35;
        Mon, 13 Jun 2022 00:06:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i25so3342809qtq.0;
        Mon, 13 Jun 2022 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=yv1ygT3I3cNrjiki9LWaI9usnmiwYkji5v0xZWzW+js=;
        b=BeUQU7At5w8QXnQumv31sTGFNuryglGKvde6SoIxLoHOJ5t/WGMn1AXz3Eknm6h5AI
         kNL4PEd0uMir3gUr1z6XGSGK1rVD3INLVDD+LZJQYc8d9+62lYvyaguTm78kNak/rSak
         T3okK5/4ndABoNywbeazmrsJmzecZtZstWGrOW2kSrrZPWoL+4bF34YazBYZMgWZX4Tb
         Bt9W4HzigonIOzfvWB+W869hPSh+dfOJ4Kquh0y9Dsp8gm71SNYKkMAx9kDUk/JCp9Zv
         0D3K88QtgS+P4vXBJD6FFG3yQbdUH3SbzIbxx14i72EO5NKMHtU9uCEpi/JGyYCXjqA1
         +OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=yv1ygT3I3cNrjiki9LWaI9usnmiwYkji5v0xZWzW+js=;
        b=Dz8BMJ9ynznAPn48ga4uHAwUUG5WHlJQbPxmLrmcUr7xvebZvw4YnFLmi/GeZW9YAX
         1YQOaO71xpBT3N8biVC8jsw5Jwqn9XOTZwq7lGquh+7/zch72SQqmiNknjadGNUKip4k
         0I0rWNH5+zVCu8Rfkbrj8Dv0j7wOlOic4Oyf9jYM0tCyPvj8H6cddNC3MxEprq0vmJyE
         J/Lm8EuKwGldJ4sxsuqZkBHAizYc1aI1uyCO6AnwU1vseMu+Q0bDrItBL7e06lBgaYdN
         mtfhbxbFfc01HG3fH/stnTS/lTLxiNLukqqiDFLYaKy6StDwn/0i6OvuWeWSAB3qV5FV
         yeYQ==
X-Gm-Message-State: AOAM531TECGMbNUwORQbAV0X948eq+EHpHlYwPUyTe7TMJaCUEFXNEYy
        695lZOWE5aR9+YnlGL5ZnQ8=
X-Google-Smtp-Source: ABdhPJx1ATSZFfuRWjaAT70y9WnEKuNuBqF1XmR5jBeGYYoq9SJ4nRAMyKQM1AWqPTp0l7HO6v7YKg==
X-Received: by 2002:a05:622a:311:b0:2f3:ddb0:4ae6 with SMTP id q17-20020a05622a031100b002f3ddb04ae6mr46319206qtw.140.1655103961023;
        Mon, 13 Jun 2022 00:06:01 -0700 (PDT)
Received: from p200300f6ef062c0090c03b551078f99d.dip0.t-ipconnect.de (p200300f6ef062c0090c03b551078f99d.dip0.t-ipconnect.de. [2003:f6:ef06:2c00:90c0:3b55:1078:f99d])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006a6a1e4aec2sm6086602qkn.49.2022.06.13.00.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:06:00 -0700 (PDT)
Message-ID: <35e7c36c9ecbdc67698b413cf867cf19442ccfa9.camel@gmail.com>
Subject: Re: [PATCH 22/34] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-imx@nxp.com, linux-renesas-soc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Mon, 13 Jun 2022 09:06:49 +0200
In-Reply-To: <20220611161701.46a68837@jic23-huawei>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-23-nuno.sa@analog.com>
         <20220611161701.46a68837@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2022-06-11 at 16:17 +0100, Jonathan Cameron wrote:
> On Fri, 10 Jun 2022 10:45:33 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all()
> > were
> > returning a mix of NULL and error pointers being NULL the way to
>=20
> pointers with NULL being the way to...
>=20
> > "notify" that we should do a "system" lookup for channels. This
> > make
> > it very confusing and prone to errors as commit dbbccf7c20bf
> > ("iio: inkern: fix return value in
> > devm_of_iio_channel_get_by_name()")
> > proves. On top of this, patterns like 'if (channel !=3D NULL) return
> > channel'
> > were being used where channel could actually be an error code which
> > makes the code hard to read.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/inkern.c | 24 +++++++++++-------------
> > =C2=A01 file changed, 11 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 87fd2a0d44f2..31d9c122199a 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -214,7 +214,7 @@ static struct iio_channel
> > *of_iio_channel_get(struct device_node *np, int index)
> > =C2=A0struct iio_channel *of_iio_channel_get_by_name(struct device_node
> > *np,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_channel *chan =3D=
 NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_channel *chan;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Walk up the tree of =
devices looking for a matching iio
> > channel */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (np) {
> > @@ -231,11 +231,11 @@ struct iio_channel
> > *of_iio_channel_get_by_name(struct device_node *np,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0chan =3D of_iio_channel_get(np, index);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -
> > EPROBE_DEFER)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
>=20
> This original behaviour is 'interesting'. If we get a error like -
> ENOMEM
> we should return it rather than carry on.=C2=A0 Do we have enough
> knowledge
> of possible errors here to be more explicit on when we keep looking
> up
> the tree?=C2=A0 I think we can get -ENOENT from
> of_parse_phandle_with_args()
>=20
> That raises an interesting question on whether -ENODEV is the right
> response
> for the previously NULL case or is -ENOENT more consistent with other
> of_ functions?=C2=A0 No device could be thought of as being the case that
> needs
> to defer (in hope it turns up later) whereas no entry means it will
> never
> succeed.

From what I could see, of_parse_phandle_with_args() either returns=C2=A0
-EINVAL or -ENOENT. We also have the internal of_iio_channel_get()
which can return -ENOMEM. So I guess we should only continue looking if
we get -ENOENT?

To be clear, do you still prefer to explicitly return -ENODEV in the
previous NULL cases or should we honor the return code from=20
of_parse_phandle_with_args() and just return chans (and thus ENOENT)?

- Nuno S=C3=A1
