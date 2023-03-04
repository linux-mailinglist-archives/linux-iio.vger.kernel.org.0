Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC406AA997
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 13:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCDMtR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 07:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCDMtR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 07:49:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9C149AC
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 04:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A83460B4E
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 12:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942F9C433D2;
        Sat,  4 Mar 2023 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677934155;
        bh=diXsTRlrJTmwhfpDh2UgbCaJ1GOb+UXKnsLiV2r5M/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kmaDkZ4O7P4AC8lQpRgNccpTlTtJGiqML/5QlV1uZBDAwUBgwn79CX0rITBq56/4T
         HWmIIYzRhmoTozF9pA4GKw8kTQFrMqRoIdWn8ho2XfPSG9BFAfiBw2vcZTkrq6mhvc
         t3jviE8aCGcguVxmNDhhoSa+qvTiRWMSaCCQ601vdTQxltr8WJNpdX9JTH8avNSsUp
         /Yim0g2HFRvLyf3X/fKO/8xbk5VvVyhnhG5ukwVzYCJMIUGAtGheSyVNT6f/+Erqfp
         SCSKwZGwU8NAnTEtZF+DopGvkgbpFB7JF/sbsV9EvssWKpS38AKYY3U/d6yfU0mN00
         2E1dVbCM1bvdg==
Date:   Sat, 4 Mar 2023 13:03:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] iio: buffer: fix coding style warnings
Message-ID: <20230304130351.7b6965c2@jic23-huawei>
In-Reply-To: <b0e25164a712c816f5dc227b5da21c653c57c4f1.camel@gmail.com>
References: <20230216101452.591805-1-nuno.sa@analog.com>
        <20230216101452.591805-4-nuno.sa@analog.com>
        <b0e25164a712c816f5dc227b5da21c653c57c4f1.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Feb 2023 08:39:37 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-02-16 at 11:14 +0100, Nuno S=C3=A1 wrote:
> > Just cosmetics. No functional change intended...
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-buffer.c | 98 +++++++++++++++-----------=
---
> > --
> > =C2=A01 file changed, 49 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index 7e7ee307a3f7..e02a4cb3d491 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> >  =20
>=20
> Hi Jonathan,
>=20
> I noticed this one was left behind but I just waited another week to
> see what happened... Is there any special reason for not taking this
> one?
Yup. It's not a fix, so needs to wait for the others to be upstream.


>=20
> - Nuno S=C3=A1
>=20

