Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE675B6B1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGTSYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGTSYm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 14:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2767A2D6D
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 11:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7965D61BCD
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 18:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E52EC433C8;
        Thu, 20 Jul 2023 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877474;
        bh=j6roh86w0wqMDaRHLfYK6RyFNcvUKUKczN6VMLN9uA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KmcHuJ7sdwa0kFdc3KUH/f/VFrACU5123HkW99KiZYCrxof2niVHD3Gt5sUFxoI5l
         QWcPI0lzhVGefGSd7aG7xCh1pO7y7KYZBhVbNpsWuW78HSILof6yvHEvzFAIBrIV/s
         6yQdth8+l+QbrlXy0awDEfIJoEypc0MwRpE1CS5RPDcbxLb6kx3kvm+ZMtUipfEdHL
         AEZwr55iJ2oph39jUAui+rSWIdveSUoAOX0SlwfK5S2dBb2OSUNQbzfFOIR/Iak9kT
         Yk3hm7oNdna1jNXwl7hng1DRi496kQrN7l4JRPY+pNiodLZj4eAx2Y+WJI5nxXV5yh
         kJ4PdOEXilCyw==
Date:   Thu, 20 Jul 2023 19:24:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
Message-ID: <20230720192428.2faaaf68@jic23-huawei>
In-Reply-To: <20230716144223.0d9260d3@jic23-huawei>
References: <20230710042723.46084-1-kimseer.paller@analog.com>
        <20230710042723.46084-2-kimseer.paller@analog.com>
        <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
        <11c30a02df784ca78be271fdf9190dad@analog.com>
        <CAHp75VegvKFUXoJoJnuXstJa_L66M2Ah9yf1aEQ8-ET1QczDtQ@mail.gmail.com>
        <fe0cd5348f864a6392a7e0e5ca93bec5@analog.com>
        <CAHp75VcpguSN9DkuCtpaB+_=sY7+Ot1MGPWToe-2pYjFXC9=4Q@mail.gmail.com>
        <20230716144223.0d9260d3@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jul 2023 14:42:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 11 Jul 2023 12:08:04 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Tue, Jul 11, 2023 at 9:55=E2=80=AFAM Paller, Kim Seer
> > <KimSeer.Paller@analog.com> wrote: =20
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > On Mon, Jul 10, 2023 at 11:17=E2=80=AFAM Paller, Kim Seer
> > > > <KimSeer.Paller@analog.com> wrote:   =20
> >=20
> > ...
> >  =20
> > > > Hence instead of v10, reply with a draft of the comment in the code=
 (I
> > > > have asked before) that explains these bit twiddlers.   =20
> > >
> > > In patch v9, regarding with my bit arrangement comments, is it somewh=
at correct
> > > or do I need to totally replace it?
> > >
> > > I am not yet familiar with the terminologies, so I hope you can provi=
de some
> > > suggestions and I'll definitely send the draft first.   =20
> >=20
> > I'm not sure I understand what comments you are referring to.
> > The v9 does not explain the algorithm clearly.
> >=20
> > What you need is to cite or retell what the datasheet explains about
> > bit ordering along with the proposed algo (in AN as far as I
> > understood). Because I haven't got, why do you need to use be16 +
> > bitrev if your data is le16 (and that's my understanding of the
> > datasheet). Is it because of the answer from the device? I don't
> > remember if it keep the bit order the same (i.e. D0...D9) as on the
> > wire.
> >=20
> > For the terminology, use what the datasheet and AN provide you. Also
> > good to put those URLs to the code and datasheet as Datasheet: tag in
> > the commit message.
> >  =20
>=20
> Absolutely agree.  The data format is weird enough we need the
> info to be available for anyone who tries to work out what is going
> on in the future.  This is a case where I'd rather see too much detail
> in the comments than too little!
>=20
> Jonathan

Note that I had applied (and forgotten I'd done so) this driver.
Given the outstanding questions and a build issue with clang, I'm dropping
it for now.  Hopefully that doesn't cause anyone too many problems (those
based on my togreg branch which rarely rebases)

Jonathan
