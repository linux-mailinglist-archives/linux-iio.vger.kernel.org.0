Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DD5F509D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJEIIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 04:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJEIIO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 04:08:14 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58F70E62
        for <linux-iio@vger.kernel.org>; Wed,  5 Oct 2022 01:08:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j10so9531318qtv.4
        for <linux-iio@vger.kernel.org>; Wed, 05 Oct 2022 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=IO0LVild74/mfqPHFPHXSTTABQ/rsCldzeWn8+3PjVQ=;
        b=FDZS9qui2faSwsVV3cjLcPNwh5vsiqPsdCwLDXNl0yxJIyVDli1zLYa+oNLoXPPHI/
         Dd/VQBOyE8zbVD2Geveu+3RKwrkpzTm5a59cYGdaQFEwVAtfIFGPDYeML4r7dwsTBBjf
         MnP+Dv0jWIeJAEeh9gvEQ19l4M9AkVncsF/hh9FicRwkveEyc++kxasALszHJa2heKRL
         YVCG3BtLN8TfKLc3hWPZlKfF9myql3b0me1uh6QBcNA3lwTMPhyXcK3Sm6AAGGOZAF/P
         bLZTxwE+bnXD84w7uIgYU+FIdRHp9mj0JRdQIkf1B69Ro8+uLKYH4f+FOZUvcYLuqGRX
         ZcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=IO0LVild74/mfqPHFPHXSTTABQ/rsCldzeWn8+3PjVQ=;
        b=FksuaCxW+GRlDDXYOzonXDsduj346IxRtM2hmherHpgbFhWWNne4aMXHiXN1Mz/+Hx
         VtN0v6bnqOJxhNwlQrLumB/BAha624JBy9RPqPeAtsW6+l+J9yGp8TfUn2iWImZqmnsa
         FEQGf1Cc5mkKPEuPf/ehb0wukqgvU/38+lUjlmDnS9j2eSQtUVIO0t13hMZxkM/Zs/Vc
         Wj6FyQE+JAo13dIrzVZap9JEIMLA3HiFz7QayEpTVkzjkCSrBzprb2F0mu2anj+1TJ/z
         RZ1JSPOSmeh8Ill6KUVipQIW9m2l8YI6LP55yiSLOlxaKioUM0Hon0e5JwlF23JHP1iB
         qTbQ==
X-Gm-Message-State: ACrzQf2k1BHwkHDJa8dkAYOL1GQFUKh09/y7VsOvVvXdUYAJyiENSYPt
        oMEa4BmpHvLwsPekIuLw2zw00JblON0iKaf9
X-Google-Smtp-Source: AMsMyM7KKu8RFTXOAcGz3XKD+YAlWeFFXKBbyfKnT8ZDlqUqQ5OtmZQODuuWcH2Ct9njCTWQP0/z4Q==
X-Received: by 2002:ac8:5887:0:b0:35b:b700:8990 with SMTP id t7-20020ac85887000000b0035bb7008990mr22423332qta.450.1664957292793;
        Wed, 05 Oct 2022 01:08:12 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id dm42-20020a05620a1d6a00b006e2f0ebad01sm872757qkb.113.2022.10.05.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:08:11 -0700 (PDT)
Message-ID: <0bad9d1ef45d0a85b7d25a4ee50914ea93936bb2.camel@gmail.com>
Subject: Re: [PATCH v2 14/16] iio: health: max30100: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 05 Oct 2022 10:09:29 +0200
In-Reply-To: <CAHp75Vfv4BntoDPOo_MXZ33dVEKYj1KW_Ocd5QL_Ez06HJ33iw@mail.gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-15-nuno.sa@analog.com>
         <CAHp75Vfv4BntoDPOo_MXZ33dVEKYj1KW_Ocd5QL_Ez06HJ33iw@mail.gmail.com>
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

On Tue, 2022-10-04 at 17:13 +0300, Andy Shevchenko wrote:
> On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > The pattern used in this device does not quite fit in the
> > iio_device_claim_direct_mode() typical usage. In this case,
> > iio_buffer_enabled() was being used not to prevent the raw access
> > but to
> > allow it. Hence, let's make use of the new
> > iio_device_claim_buffer_mode() API to make sure we stay in buffered
> > mode
> > during the complete read.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (iio_device_claim_buffer_mode(indio_dev)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EAGAIN;
>=20
> Why is the error code shadowed? Isn't it better to return exactly the
> one you resend to the upper caller(s)? Each unclear error code
> shadowing should be at least explained.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

I'm keeping the same error that was returned before. Changing the error
code returned to userspace can break some apps relying on it. But if
everyone is ok with assuming the risk and changing it, fine by me.


- Nuno S=C3=A1
