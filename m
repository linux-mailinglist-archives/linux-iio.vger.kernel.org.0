Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BA51AFED
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiEDVC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiEDVCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 17:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61640E40
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 13:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4FCDB8298D
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 20:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68907C385A4;
        Wed,  4 May 2022 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651697925;
        bh=l1WJwsWLYz+ulbb8iY+KLKyiPv4eYktWOD8/eK71reE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cx+Ooitoubx7NC80Q6JDmQwhS769Eu2v5aytOKGszOljSNae07pri5h3r/7ihguyS
         YMGZe2d5dgxRE2+lrEPm/CxheBkOzNcIXTneKO84GN49dXdZDvqnHNZ8z7RyDHJZ5l
         w4KueZ+EY+/Kz35XIVNF1FkdTXd+ffdxaLrCryhtuPL3o33VGrvh1JEoN4Kl4Msa2C
         I0yMS71zMf0KEkLdnEJHsztDO7LzFZbx0FsX44KB6W0pu2aaeNe0is21UZjBhtJd/4
         TP3WmHZ0VXjOVZBhTP7Hg83f5ljS2wdk3j5v1lLBA519CUg+3w07gWxQ03lGrZzhWw
         XpDxxFzN9Iq3g==
Date:   Wed, 4 May 2022 22:06:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: Re: [PATCH 00/92] IIO: Fix alignment of buffers for DMA
Message-ID: <20220504220657.6f9f3f69@jic23-huawei>
In-Reply-To: <PH0PR03MB67861B4A26E0297578E90CFC99C39@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
        <PH0PR03MB67861B4A26E0297578E90CFC99C39@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 May 2022 13:00:58 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Jonathan,
>=20
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Tuesday, May 3, 2022 10:58 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Akinobu Mita <akinobu.mita@gmail.com>; Alexandru Lazar
> > <alazar@startmail.com>; Tachici, Alexandru
> > <Alexandru.Tachici@analog.com>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; Charles-Antoine Couret <charles- =20
> > antoine.couret@essensium.com>; Tanislav, Cosmin =20
> > <Cosmin.Tanislav@analog.com>; Cristian Pop
> > <cristian.pop@analog.com>; David Lechner <david@lechnology.com>;
> > Ivan Mikhaylov <i.mikhaylov@yadro.com>; Jacopo Mondi
> > <jacopo+renesas@jmondi.org>; Jean-Baptiste Maneyrol
> > <jmaneyrol@invensense.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Marcelo Schmitt <marcelo.schmitt1@gmail.com>;
> > M=C3=A5rten Lindahl <martenli@axis.com>; Matt Ranostay
> > <mranostay@gmail.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Michael Welling
> > <mwelling@ieee.org>; Mugilraj Dhavachelvan
> > <dmugil2000@gmail.com>; Navin Sankar Velliangiri
> > <navin@linumiz.com>; Sa, Nuno <Nuno.Sa@analog.com>; Paul
> > Cercueil <paul@crapouillou.net>; Phil Reid
> > <preid@electromag.com.au>; Puranjay Mohan
> > <puranjay12@gmail.com>; Ricardo Ribalda <ribalda@kernel.org>;
> > Robert Jones <rjones@gateworks.com>; Rui Miguel Silva
> > <rui.silva@linaro.org>; Sean Nyekjaer <sean.nyekjaer@prevas.dk>;
> > Tomas Melin <tomas.melin@vaisala.com>; Tomislav Denis
> > <tomislav.denis@avl.com>; Uwe Kleine-K=C3=B6nig <u.kleine- =20
> > koenig@pengutronix.de>; Jonathan Cameron =20
> > <Jonathan.Cameron@huawei.com>; catalin.marinas@arm.com
> > Subject: [PATCH 00/92] IIO: Fix alignment of buffers for DMA
> >=20
> > [External]
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Many years ago, IIO started using ____cacheline_aligned to ensure
> > that buffers that might be used for DMA were not sharing a cacheline
> > with other data that might lead to DMA safety issues.
> >=20
> > As it turns out, that was fine at the time, but not based on the
> > correct alignment requirement (though I believe it was a conservative
> > choice at the time).  Note that on many architectures this was
> > introducing
> > unecessary padding.  We should have been using
> > ARCH_KMALLOC_MINALIGN
> > as other subsystems such as crypto have done for a long time.
> >=20
> > Patch 1 discription contains more information but in short, there are
> > ARM64 SoCs out their that have a larger cachline size for caches
> > beyond
> > L1. In many cases they maintain coherency for all DMA devices
> > attached
> > and so this isn't a problem, but there are exceptions that do not.
> >=20
> > So, this is a rather large patch set and just covers those drivers
> > that are in the last kernel release and in drivers/iio.
> >=20
> > Many of these drivers are somewhat old so I haven't specifically
> > cc'd anyone so will be relying on those kind enough to sanity check
> > patches on drivers that are beyond their own.
> >=20
> > Given there is ongoing discussion around reducing the alignment
> > requirements where possible, I've adopted the existing IIO_ALIGN
> > define througout.  That way we have a single point to update if
> > that becomes relevant in future.
> >  =20
>=20
> Nice to see this in... Since we are here, I guess in a couple of patches =
where we have:
>=20
> struct {
> 	...
> 	u8 rx[] __aligned();
> 	u8 tx[] __aligned();
> };
>=20
> we could make it such that only the first member is aligned. But bah, I g=
et that this
> is already a huge patchset to diverge from it. Anyhow,

Yup. I thought about tidying those up but decided it would just make
things harder to explain so could be done as a follow up.
I should have said so in the cover letter though!

I particularly like the case where (a long time ago) I added
a question on whether there was a need for separate alignment
and left that question in the final code. Oops.
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Thanks for looking through all these.

We haven't yet concluded on the questions of naming and possible
additional define for __aligned(XXX) but if we do make such a change
it should be purely mechanical hence I'll keep all the tags people
have given and not bother them again :)

Thanks,

Jonathan



