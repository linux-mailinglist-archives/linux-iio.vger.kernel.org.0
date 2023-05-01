Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A256F3340
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEAP7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEAP7w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 11:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEC129
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 08:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B2460ECF
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 15:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DD8C433EF;
        Mon,  1 May 2023 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956790;
        bh=h5Q7LB3ZfBoVF07uJPStlfwwHruHONcxZiGaEqJ8yZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JrDhTkNT6j8pRGB8HqARGu0rV59pRYA5wRv/yzvvy+7JMhSlDa4nQyVxeTAzKwGbk
         2FeB3stDprlmM3uQz2Z8JIWDjqK81RLsDCKHn6WwOXum8SPrTugRs/OZrfgVef2psX
         /FAz4/tDdOyuseGxJ9RTevWZ/SLHsWnP75fiIxrmdroc/UIP0DhoYQRGPhZYRuTNCQ
         KcjVXLdfam98lR8dwd/aIRsD72XY4bDhnVAORYqQaZw8M6dZQdy/NP2QiGD8RuOAjY
         6bc/O9m9EcfocHe3o2r4Q7AW/d9SSxoW1JkbtOGsTLWUCQuv8Pf+97yND9LbvnagCl
         NO/PuCur6AO4g==
Date:   Mon, 1 May 2023 17:15:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] iio: buffer: fix coding style warnings
Message-ID: <20230501171536.266e0c56@jic23-huawei>
In-Reply-To: <20230304130351.7b6965c2@jic23-huawei>
References: <20230216101452.591805-1-nuno.sa@analog.com>
        <20230216101452.591805-4-nuno.sa@analog.com>
        <b0e25164a712c816f5dc227b5da21c653c57c4f1.camel@gmail.com>
        <20230304130351.7b6965c2@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Mar 2023 13:03:51 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 27 Feb 2023 08:39:37 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2023-02-16 at 11:14 +0100, Nuno S=C3=A1 wrote: =20
> > > Just cosmetics. No functional change intended...
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-buffer.c | 98 +++++++++++++++---------=
-----
> > > --
> > > =C2=A01 file changed, 49 insertions(+), 49 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/industrialio-buffer.c
> > > b/drivers/iio/industrialio-buffer.c
> > > index 7e7ee307a3f7..e02a4cb3d491 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > >    =20
> >=20
> > Hi Jonathan,
> >=20
> > I noticed this one was left behind but I just waited another week to
> > see what happened... Is there any special reason for not taking this
> > one? =20
> Yup. It's not a fix, so needs to wait for the others to be upstream.
>=20
Applied!

Thanks,

Jonathan

>=20
> >=20
> > - Nuno S=C3=A1
> >  =20
>=20

