Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E409F4E8840
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiC0Ov2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiC0Ov1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 10:51:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054F4091F
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 07:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C25B80BEC
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 14:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD9C340EC;
        Sun, 27 Mar 2022 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648392584;
        bh=SNTTSseWk+lxTtx4lZbxlGpWHAzNNJsy6qL6vT1+8e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TZ+S6X2ar+fSKveCY3w3SywZUr+6RFnVjL8ErYeHfX5npO7EGApNaCSHnEC4pCo71
         0XfnbCaJRfGAT2nH9gs39eEy9A6p8Mxeo7DcyAHMcYmeCiGrksi7D04bFaV2zx4Gaf
         NNE7y9/WuU6NlWV/sk4Kzm2GjJRLcGvUu11EdajPxGw968SUIvf5NhW4ABuo3v4oKb
         sG/9/OeiS/QOV71BhGKHZwSgk93p/VxNzech0JcSTCTEAojt5rAcF7foGHQ+63vzUp
         MXwSCjtWpTSdcjwc93TpQ/BBXwkGLnew7/5TeBFt5YC8y0IJtEuBsw2CaYuqABUPjm
         ecdJO/k48ZKqg==
Date:   Sun, 27 Mar 2022 15:57:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jackie Liu <liu.yun@linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: da9150-gpadc: fix build on mips
 CONFIG_MIKROTIK_RB532=y
Message-ID: <20220327155718.0d00be25@jic23-huawei>
In-Reply-To: <CAHp75VfEyhB92iP8sRyGn+2WLzazFtok=47xzewhCt=bo=a7Zw@mail.gmail.com>
References: <20220324055821.3184872-1-liu.yun@linux.dev>
        <CAHp75VfEyhB92iP8sRyGn+2WLzazFtok=47xzewhCt=bo=a7Zw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 24 Mar 2022 12:18:14 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Mar 24, 2022 at 7:58 AM Jackie Liu <liu.yun@linux.dev> wrote:
> >
> > From: Jackie Liu <liuyun01@kylinos.cn>
> >
> > kernel robot report build fail by randconfig:
> >
> > [...]
> > drivers/iio/adc/da9150-gpadc.c:254:13: error: =E2=80=98DA9150_GPADC_CHA=
N_0x08=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98=
DA9150_GPADC_CHAN_TBAT=E2=80=99?
> >   254 |  .channel =3D DA9150_GPADC_CHAN_##_id,   \
> >       |             ^~~~~~~~~~~~~~~~~~
> > drivers/iio/adc/da9150-gpadc.c:273:2: note: in expansion of macro =E2=
=80=98DA9150_GPADC_CHANNEL=E2=80=99
> >   273 |  DA9150_GPADC_CHANNEL(_id, _hw_id, _type,   \
> >       |  ^~~~~~~~~~~~~~~~~~~~
> > drivers/iio/adc/da9150-gpadc.c:281:2: note: in expansion of macro =E2=
=80=98DA9150_GPADC_CHANNEL_PROCESSED=E2=80=99
> >   281 |  DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE, N=
ULL),
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ =20
>=20
> > make[4]: *** [../scripts/Makefile.build:288: drivers/iio/adc/da9150-gpa=
dc.o] Error 1
> > make[3]: *** [../scripts/Makefile.build:550: drivers/iio/adc] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> > [...] =20
>=20
> These lines are noise and no need to be in the commit message.
>=20
> > +/*
> > + * Workaround for arch/mips/include/asm/mach-rc32434/rb.h
> > + *   #define GPIOD 0x08
> > + */
> > +#undef GPIOD =20
>=20
> Looking at the bottom here the better approach seems to be namespacing
> of GPIO registers in the above mentioned header and corresponding
> users.

Agreed.  Having around it here is just going to the tip of the iceberg long
term.  The header + users need fixing if it's going to be widely enough
included that we can see it in places like this.

=46rom some very basic grepping I 'suspect' you could just push the defines
down into arch/mips/rb532/gpio.c but I may well be wrong...

Jonathan

>=20
> >  /* Supported channels */
> >  static const struct iio_chan_spec da9150_gpadc_channels[] =3D {
> >         DA9150_GPADC_CHANNEL_PROCESSED(GPIOA, GPIOA_6V, IIO_VOLTAGE, NU=
LL), =20
>=20

