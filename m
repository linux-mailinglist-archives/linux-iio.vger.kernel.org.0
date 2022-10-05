Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C345F5103
	for <lists+linux-iio@lfdr.de>; Wed,  5 Oct 2022 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJEIjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Oct 2022 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJEIjA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Oct 2022 04:39:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2C75CDB
        for <linux-iio@vger.kernel.org>; Wed,  5 Oct 2022 01:38:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d15so2254993qtw.8
        for <linux-iio@vger.kernel.org>; Wed, 05 Oct 2022 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=TnA6JzSn4arjpTN/bPqQkDRPYmsMIf2Li73dTR0mpO0=;
        b=ONwEbApRuyxgWRIpd/fuFOKiSWN/+DWE/CtRuW4q35CKbmuam6lJ8FPZbbXaCzNt7e
         vlh8GTfwRQfxaUnQddKYrrlQawscqr07zE+f/YKbTNKGKkI7VP2Pt49F8vGDFt/+AGEA
         gxJ6f0Y6JmtNxu2UQWhInCK2YbakqcdGNFaWRuWyGZIKwnUTuIY8xpORzDFXGfQLb34f
         wZ2JiMfOhxmc1Fd0idbk7b+UqAtfxO+4YS/x97eXfPi80WYqE8T4LYLi7XDZjg3TU9zM
         QBXDBiemVCqT4KCs2iTZM52aiaVRYm4c3daguXStjBa7zGXi/l4fqRJUjIY1ok5NnWYi
         XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TnA6JzSn4arjpTN/bPqQkDRPYmsMIf2Li73dTR0mpO0=;
        b=VxDgOGy2p6H4Cr851R8BC8F/pdNsw3Re+7xGb9nAyewdaJQo46u+iB9r3DsOxaS4gd
         tqb3ugImgprTE4m8bhqwAUtfjw3xBgpfIO9YamIGatmgqjjOYrhgr3EZC7l4WbTNEyvA
         /tCJZNQQNJcKlPpDVeyLABe8CM+tG2QmlvODAkz6l5OQhdoRT3980C7eQu1/4cNAMW3x
         H+qi5/evp56nv/MgpwWQYPlztSAW8+3rnwX/H81im37HpBVL08PME+vGAIiFvtztNxfe
         Nxqp6/gWhzWqSDsAOv7jSGX64wFqlqGYwSzDV/Fzl8JSnpVAFtVT3k7Td4nTuIvTk9VH
         EQcg==
X-Gm-Message-State: ACrzQf0+/v8nr+V8HRpOE/RQv8moZmDtKACZbukkfIxz7BoOM4vNmVX4
        JClRPc4VUGmTpsROV8ccKgw=
X-Google-Smtp-Source: AMsMyM5S1zbtIP8pge6aYNhqSMP45dSoxmOnek1iAfkzj/AA75VShoWoiBhyIqiEwOtZAz7Gfw7d9w==
X-Received: by 2002:a05:622a:8c:b0:35d:44d5:58f6 with SMTP id o12-20020a05622a008c00b0035d44d558f6mr22701862qtw.315.1664959125734;
        Wed, 05 Oct 2022 01:38:45 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8580c000000b0035d4f68232esm14575313qtg.3.2022.10.05.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:38:45 -0700 (PDT)
Message-ID: <f25507c2bfce7933684a2f1bfd00eb14609cd8b2.camel@gmail.com>
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct
 iio_dev_opaque'
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
Date:   Wed, 05 Oct 2022 10:40:03 +0200
In-Reply-To: <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-17-nuno.sa@analog.com>
         <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
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

On Tue, 2022-10-04 at 17:21 +0300, Andy Shevchenko wrote:
> On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > Now that there are no more users accessing 'mlock' directly, we can
> > move
> > it to the iio_dev private structure. Hence, it's now explicit that
> > new
> > driver's should not directly this lock.
>=20
> use this
>=20
>=20
> I like the end result!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> P.S. Shouldn't we annotate the respective APIs with might_sleep() and
> Co (if it's not done yet)?
>=20
>=20

Hmm, I would say this is the same story as with sparse annotations... I
guess, at least, might_sleep() would make sense but I think we should
probably do it for the complete IIO subsystem where it makes sense
instead of having it in just this new API.

- Nuno S=C3=A1=20

