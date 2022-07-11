Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8275704FD
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGKOEi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGKOEg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 10:04:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF11BE86;
        Mon, 11 Jul 2022 07:04:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk26so7131548wrb.11;
        Mon, 11 Jul 2022 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=DIAFLfCCstVMeweX2Ab1siE9p1+/OUf9lkXY0wvZIus=;
        b=doyN/EGzYQwmb31Qvui4RHoImYKN2mpxrS770rB7oqfTCwtKecAYk7XK5nHAyciB9j
         nA1APLtNitFKoReEa8OSAA36uhyQeBRn5HCTYGjxKPKrruw1/RVlPVlVw2Rtyl8Tdr+h
         cQ/iXqqjSrnqPkrGbEyq3ZoVd8/03nR/nA1cD5qcH6XmGBErXPoWjWp43sDJpzR39FEp
         W0mUeX/ZlJd79U4JcII4j+dn4hWjMQHfmlsXLW5buyknCb71XUrhQGs078ea/zqNArwN
         ThisRukKDtbypj9of180SnLkYj6JucCgS0In0PztOFDgkKr/2YAXJEs11HdAV+LN89U2
         Q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=DIAFLfCCstVMeweX2Ab1siE9p1+/OUf9lkXY0wvZIus=;
        b=pjUiBMD3MrZRAp36H12BPDEMbrWQ2bAroIRD5IMMV5n6qh3SJ/GebiJ4EV/Z3GIKDo
         +HSJU6s6BvaTW5aFUVAelRjn4EfbrbHqKREK++n6B9e/F/fc6/3jyFLebvDuf3u5222i
         06/homs1DW9jdwIsrwLsHjG9rv/asu82U2vsvegWv8Kw56zXbdc7lhXXT8rjYGYtjxye
         tDxUYllW+j8xEUoY1VUFTVOIhMpcGjdDAQ2jNC8XNMH2Bliid5L/9DI2X/J0NyzAXTPs
         O6Xq+i4MbaM5tmtOc4NbT1dMDZNOtb4nxWs2fKgze3/WTPlLA0D3r9vREr5bx74YnoZE
         ZNmg==
X-Gm-Message-State: AJIora9yXUQ5oVZ9JRrf58DzqfPIpNmpo0ITiNT6Gd3Ov/r3yi7oGMCZ
        sXYs2PB0nUVlnMbqUhSwlcc=
X-Google-Smtp-Source: AGRyM1sfP4B2ggRzwlFtNzE5njlcJb0xyrOh+fqSIvv7emKj99E0h8HP5nFdmlvCbmam0md1QXj4iw==
X-Received: by 2002:adf:fa04:0:b0:21d:1864:3172 with SMTP id m4-20020adffa04000000b0021d18643172mr18334198wrr.292.1657548270179;
        Mon, 11 Jul 2022 07:04:30 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d4f0f000000b0021d8faf57d5sm5849112wru.74.2022.07.11.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:04:29 -0700 (PDT)
Message-ID: <d060ab80fcf8ede50466069c9021eda97e239fb6.camel@gmail.com>
Subject: Re: [PATCH v2 15/15] iio: inkern: fix coding style warnings
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 16:05:31 +0200
In-Reply-To: <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
         <20220711123835.811358-16-nuno.sa@analog.com>
         <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
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

On Mon, 2022-07-11 at 15:15 +0200, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 2:40 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > Just cosmetics. No functional change intended...
>=20
> ...
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name =3D=3D NULL && channel_n=
ame =3D=3D NULL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!name && !channel_name)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENODEV);
>=20
> After this change in place, I think it's better to convert it to
>=20
> =C2=A0 if (!(name || channel_name))
>=20
> which shows intentions clearer.
>=20

No strong feelings from my side so I can do that if a v3 is needed
(which, most likely, will be needed).

- Nuno S=C3=A1
