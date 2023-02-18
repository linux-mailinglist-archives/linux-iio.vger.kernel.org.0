Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3069BB12
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 17:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBRQwx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 11:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBRQww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 11:52:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC9D46B0
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 08:52:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96DEDB80502
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 16:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65714C4339B;
        Sat, 18 Feb 2023 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676739168;
        bh=Oryyd5I5C6KWG3nkXYOikKirvkCpR9LqAxlupnRfqfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d2eQMp9U09QZ6hyKlbxuDNj0G24UODKJwewnwky2pzzT+HP6fz98JkQ/eEsb6DHoK
         PJNGEBKp72+Jc7dqp4uhZSafzxE4PrJrreQO2WQY6h2TOSBc3/huNWCv+JBTIzZNKL
         S9AjdZ7yMGloRk4AkxQgYZ1jj99eeCB+ONhl3tPeiJQG91mEvPe44CZ7Kro4XFl1gd
         4rdHmHIv4Wsuvl/SFjQsnyWRFoSd+EoygoAX1QmAPrxk4wvIY4BupBzqcn3rDXFS5h
         twS2YXPr4mdk6LDVXkr1bn1f51328/+DA1hzY6FHuSR40gRBzpDMcm8L3TlyPD1D2P
         8tfAnOglvMR+w==
Date:   Sat, 18 Feb 2023 17:07:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: ad7791: fix IRQ flags
Message-ID: <20230218170707.5c31252d@jic23-huawei>
In-Reply-To: <e619b7ba249457a542f04a198133e4ba9255d16c.camel@gmail.com>
References: <20230120124645.819910-1-nuno.sa@analog.com>
        <20230121165852.5a302778@jic23-huawei>
        <e60e97d614a03c5a6e1e86b330a3d3ae47d3d220.camel@gmail.com>
        <e619b7ba249457a542f04a198133e4ba9255d16c.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 06 Feb 2023 12:13:50 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-01-30 at 10:01 +0100, Nuno S=C3=A1 wrote:
> > On Sat, 2023-01-21 at 16:58 +0000, Jonathan Cameron wrote: =20
> > > On Fri, 20 Jan 2023 13:46:45 +0100
> > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > >  =20
> > > > The interrupt is triggered on the falling edge rather than being
> > > > a
> > > > level
> > > > low interrupt.
> > > >=20
> > > > Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ
> > > > flags")
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > >=20
> > > What are the symptoms of this?=C2=A0 Given the ad_sigma_delta.c irq
> > > handler
> > > disables the interrupt until after the data read is done (at which
> > > point the
> > > level is presumably high again), I don't immediately see why the
> > > change
> > > here has any impact - either we trigger on the fall, or on the fact
> > > it
> > > has become low..
> > >=20
> > >  =20
> >=20
> > Honestly I did not checked this in any HW. This was just by
> > inspecting
> > the datasheet and confirming that the LOW IRQ is not coherent with
> > what
> > we have in other sigma delta ADCs.
> >=20
> > However, after some git blaming, I found this [1] which shows that
> > this
> > might be an issue...
> >=20
> > Hmm, maybe makes sense to add a link to the bellow patch in the
> > commit
> > description...
> > =C2=A0
> > [1]:
> > https://lore.kernel.org/linux-iio/20200113102653.20900-3-alexandru.tach=
ici@analog.com
> > /
> >=20
> > - Nuno S=C3=A1 =20
>=20
> Hi Jonathan,
>=20
> Anything that I should do in this one? As I did not tested it, it might
> not be a real issue but I still think the patch is good even though it
> might not deserve a Fixes tag...
>=20
> - Nuno S=C3=A1

Applied to the fixes-togreg rbanch of iio.git.  I left the fixes tag
but just to be awkward didn't mark it for stable (it'll get picked up anyway
probably but I didn't want to imply there was any rush in doing so ;)

Thanks,

Jonathan


