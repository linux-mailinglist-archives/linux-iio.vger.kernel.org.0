Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0853CA3A
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiFCMwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFCMwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 08:52:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53246CE22
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 05:52:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l2-20020a05600c1d0200b0039c35ef94c4so2081046wms.4
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=oM8u510fq95yGh6biC/xKnH8FDTdeNsTm34r3feNkB0=;
        b=mVjun2JcqcRyUtpq0nD3bGqAUVlyIeZBA2i4t66fW3gDoeI7CONSmeQAm6QfVwIWuY
         6uXy3BmSkXDQJMc426/mpqjKCvAwdRK7xBHfvR9ORXuaDSTcG2EjPcwHcU0bSHEamVoB
         mFUzrQAYYhwsk5zYltJBtL2GJ/K2mvzTELNL7eX+wIOOggtWeCmJmPOt8mg1+3kgfq9G
         +vVfhGgUHbszgujyI6tbMlgCZwz5DoP10g8cKrUchfwZqHX3dD+BMrYWBEf+bYHmLtwX
         yGZLxk4D4QVpa04lK3suAqvBjgGflT+miFfk9TuMbhsZlw13rrkoC1qMcBfAYNNwQFh7
         H7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=oM8u510fq95yGh6biC/xKnH8FDTdeNsTm34r3feNkB0=;
        b=gEww335xNoO/+H4lcoXTVp38AMIoOkQcFbRAEwMnafUUmKdSJtD/q8v+3zphhDhsKS
         V1Qa2NWPp3Q4hJ1HiCw27oK89BhHt9R4Ek8KtMbh6eNK5qSm6awT35WTpwWy9M0caQjG
         IAfn6zpUiLSU+hs266l/2wl2gghjHKwWqVsZ2RDJD0R9S/YXOurv5Gh0ffpiGQ8FLyfZ
         vrrSvx8nfQ4Gs4XnzxlRQo0o+A/0rXCv/s3G5oAQD4r1hc2i4+uaOHCPZ8hjlDzeMrF/
         /+cgsC7LG7qJFJZaaLOEXW3EwFkwRmBLEzCGndydH9HpuB2xFlnrdE5IH1sN3bhnqGN2
         ckUQ==
X-Gm-Message-State: AOAM531jHaQAMUd2kOPXCXY106GaewkWgCXVYbwQ1+JOrJ3BQD/13F+E
        3U1Nnl5LkMdl0bx3zrLJT3Q=
X-Google-Smtp-Source: ABdhPJzpRHo7PqJZG5incU6FcIQt/sZ9HBd3JvCy3XAFxSN8CFDghDjSLH1JmmOVWD96hUDPRwpDlg==
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id h14-20020a05600c414e00b0039755aaccc0mr38753613wmm.51.1654260718679;
        Fri, 03 Jun 2022 05:51:58 -0700 (PDT)
Received: from p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b0039c3e6edb0asm2572163wml.2.2022.06.03.05.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:51:58 -0700 (PDT)
Message-ID: <543ab19106938b7655ee2877bf52c8e786c1c55a.camel@gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: inkern: move to fwnode properties
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Patrick Venture <venture@google.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 03 Jun 2022 14:52:51 +0200
In-Reply-To: <CAHp75VeHwqbNTMfWA03-epKaksPNgRrXh3f5hktEE0u6qjPyyw@mail.gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
         <20220602140400.213449-6-nuno.sa@analog.com>
         <CAHp75VeHwqbNTMfWA03-epKaksPNgRrXh3f5hktEE0u6qjPyyw@mail.gmail.com>
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

On Fri, 2022-06-03 at 13:52 +0200, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > This moves the IIO in kernel interface to use fwnode properties and
> > thus
> > be firmware agnostic.
> >=20
> > All the users had to be naturally updated to the new interface
> > exposed by
> > IIO.
>=20
> I think you may split this in an easy way, i.e. convert core to
> fwnode, while providing inliners for of_node cases (like it's done in
> IRQ domain) and then remove them after conversion.
>=20

I see, in our case that might be really simple as we only have one user
of devm_of_iio_channel_get_by_name() which is the only api directly
using OF. of_iio_channel_get_by_name() has no users and all the other
public APIs use 'struct device' so we can do the conversion
internally...

> I think of_xlate is not needed to be touched at all. Let it die with
> OF altogether. Yes, it won't be fully OF-independent, but it will
> down
> the scope of the next change where you can convert of_xlate to
> something agnostic.
>=20
> ...
>=20
> > --- a/drivers/iio/adc/ab8500-gpadc.c
> > +++ b/drivers/iio/adc/ab8500-gpadc.c
> > @@ -39,6 +39,7 @@
> > =C2=A0#include <linux/slab.h>
> > =C2=A0#include <linux/mfd/abx500.h>
> > =C2=A0#include <linux/mfd/abx500/ab8500.h>
> > +#include <linux/fwnode.h>
>=20
> Ordering.
>=20

The ordering is completely wrong anyways. So, I did not cared about
ordering in drivers where it was already bad. Don't mind to fix it
while adding the missing headers (if acceptable).

> ...
>=20
> > --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> > @@ -21,6 +21,7 @@
> > =C2=A0#include <linux/init.h>
> > =C2=A0#include <linux/interrupt.h>
> > =C2=A0#include <linux/regulator/consumer.h>
> > +#include <linux/fwnode.h>
>=20
> Ordering?
>=20
> ...
>=20
> > =C2=A0 * @consumer_channel:=C2=A0 Unique name to identify the channel o=
n the
> > consumer
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 side. This typica=
lly describes the channels
> > use within
>=20
> used / usage ?
>=20
> ...
>=20
> > =C2=A0 * @consumer_channel:=C2=A0 Unique name to identify the channel o=
n the
> > consumer
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 side. This typica=
lly describes the channels
> > use within
>=20
> Ditto.
>=20
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the consumer. E.g=
. 'battery_voltage'
>=20
> ...
>=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 233d2e6b7721..18ca5a7cb154 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -10,13 +10,14 @@
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/cdev.h>
> > =C2=A0#include <linux/iio/types.h>
> > -#include <linux/of.h>
>=20
> You may split this change easily since there is nothing from of.h in
> use. Just add forward declaration as you have done, but for the OF
> case.
>=20
> ...
>=20
> That said, I think what you need is to split this series to three
> logical parts:
> 1) shuffle header inclusions around so, iio.h will use forward
> declaration (on driver basis);
> 2) convert inkern.c to fwnode while providing OF wrappers
> (to_of_node() helps);

Just to be clear, we should still add an fwnode_xlate() callback? So we
have both temporarily and if some new driver needs this interface it
can already use it instead of of_xlate...

> 3) convert of_xlate (on driver basis it might be tricky, up to you).
>=20

Yeah, I might see how easy it is to fully convert the drivers using=20
of_xlate. If easy enough, I'll probably do it...

- Nuno S=C3=A1
