Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9F5FE94A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJNHPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJNHPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 03:15:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5B43329
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 00:15:38 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id z18so2737162qvn.6
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2022 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYtbU9ms8NkjJbi68Okb7u6sI1m59iHxzpbVIBkT+wo=;
        b=VM5Br9btJnO5Or80K2Tnd0MiryHbsv2mn7Azi5cT9xLhOsn0KObCj5sSjgl71zmpc4
         WBeRjqt+HSDxDmgZ+NwG/MYAS0iXUQZH9B9ktyxZVWnkHbcY/sWJjLHKVC/iOPDvfEdp
         fhy6jWRldRuT/VxDt06WJeRhJUMmsA+4pysgq1GU6bxwQHMwqnDdB9pEoi8Ix+zJW0D/
         AQZzDJDGPYoFaP0WtWo8BIk5fTAbeE/Nw9wTlwZT7cvhM02g7+2e1eS+32zP6qlQZxXz
         OWBKdWtSzE5aKfEIPniPwmCaIqJv8XgEzdk10bQnDXPwHkh0vZuGt8iSq3RTzQZCBo6U
         I61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYtbU9ms8NkjJbi68Okb7u6sI1m59iHxzpbVIBkT+wo=;
        b=44Gcdsz3QeD3X36/ryEz+5ES8bXj+5voTmETtT2KMHDA0PyBn/+7OCo+JeDmgkYlbF
         eAuwvUAU8CtIb3h/2rJT5+hUjntoeiKFlx5oR24fxe71Nx3CSXe2LsaYMmIqiNxGTwgD
         U5idGr5rNPH0MVglJExioubBlEHHJT9skqhO6BKCfNrLc5GCLVvI2ZA8oOqSop/cQHSh
         Xfh4CZu8vCm9MUirE9fyzXeGc9DhVsBkzeLE2Oojspe2+6j9QWxikbz8JIy/Y4sHgSWK
         z5XOxdcCr+g2ZdOj9UH3axiUdoQUktRAR+/Dp2vRgw7iuMovgnuSK006e9nAqBzTYG1q
         ESXQ==
X-Gm-Message-State: ACrzQf1MY3q3P56tSBrH7UvUYr5iL2P7HMuYuUURjDH2RzbVfKF0iU9q
        1lvxzr/69RQH4kPHN0cI12w=
X-Google-Smtp-Source: AMsMyM7+27HWk7xlt9ESBGEEwHheCABdyw3FB5apKO4+/9SYLUarNP9cXY2bycf/BdWqNXDePDDpHw==
X-Received: by 2002:a05:6214:c45:b0:4b4:442d:f91c with SMTP id r5-20020a0562140c4500b004b4442df91cmr2886943qvj.24.1665731737192;
        Fri, 14 Oct 2022 00:15:37 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006e6a7c2a269sm1901693qkp.22.2022.10.14.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:15:36 -0700 (PDT)
Message-ID: <7ab31b13e625773976f4eb4b639d3287ee0f9efa.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] iio: health: max30100: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Date:   Fri, 14 Oct 2022 09:16:55 +0200
In-Reply-To: <CAHp75Vc=TMsFBR8PUb7tifgM_b8foRhiAwy3VEDsX4hTOjKP=Q@mail.gmail.com>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
         <20221012151620.1725215-3-nuno.sa@analog.com>
         <CAHp75Vc=TMsFBR8PUb7tifgM_b8foRhiAwy3VEDsX4hTOjKP=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2022-10-12 at 20:46 +0300, Andy Shevchenko wrote:
> On Wed, Oct 12, 2022 at 6:15 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > The pattern used in this device does not quite fit in the
> > iio_device_claim_direct_mode() typical usage. In this case,
> > iio_buffer_enabled() was being used not to prevent the raw access
> > but to
> > allow it. Hence, let's make use of the new
> > iio_device_claim_buffer_mode() API to make sure we stay in buffered
> > mode
> > during the complete read.
> >=20
> > Note that we are shadowing the error code returned by
> > iio_device_claim_buffer_mode() so that we keep the original one
> > (-EAGAIN). The reason is that some userspace stack might already be
> > relying on this particular code so that we are not taking chances
> > and
> > leave it alone.
>=20
> The above line widths seem a bit arbitrary to me. But I think it's
> due
> to function names in them.
> Perhaps you can make them less deviated by shuffling a bit, like
> moving "but to" to the next line.
>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/health/max30100.c | 9 +++------
> > =C2=A01 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/iio/health/max30100.c
> > b/drivers/iio/health/max30100.c
> > index 2cca5e0519f8..6ac49901c9da 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -387,18 +387,15 @@ static int max30100_read_raw(struct iio_dev
> > *indio_dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Temperature reading can only be acquired whil=
e
> > engine
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is running
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mutex_lock(&indio_dev->mlock);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!iio_buffer_enabled(indio_dev))
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (iio_device_claim_buffer_mode(indio_dev)) {
>=20
> I think a summary of replacing error code is good to have here, like
>=20
> /*
> =C2=A0* Replacing -EBUSY or other error code
> =C2=A0* returned by iio_device_claim_buffer_mode()
> =C2=A0* because user space may rely on the current
> =C2=A0* one.
> =C2=A0*/
>=20

This might make sense... I'll wait for Jonathan's review to see how
strong he feels about this. Maybe he can also add it when applying.

- Nuno S=C3=A1
>=20

