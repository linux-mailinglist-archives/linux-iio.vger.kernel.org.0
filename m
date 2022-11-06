Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0661E1EB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 12:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKFLtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiKFLtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 06:49:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D9B7C9
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 03:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEB28B80925
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 11:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B92AC433C1;
        Sun,  6 Nov 2022 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667735343;
        bh=qsE+BSLYkLmE9QP91m0NdVkRvcbJAZMS7+PbKOI6R4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nr9/HPWjLNBsdt+VV4OQGwT7HWOETTakBHTj/2uxNlgWLwpA1QPaaDdV39pkjE7OT
         CNVKoY/FiHALJ4CZT9b5mM3wN31Jy+SLdpH4Uu8+NyiuZpMN10IpUfZUUkhpZQG0Nf
         tI5xtMX+EW8AtTuS6nQuG5p/tL4hRrY6I6v0/o+p43h+Rbk9jfpBLhfCce/YF7QcP8
         QE8R/AaW0P8dshyFR7+3vreKCsrdbBvMkh8OrIHRgDCLpNWXF2cRNa4rG80b+ldk68
         2j/pZxiZO+YSFlBQ3gT3xjIZ+7kdfKq1XOpfPp71Hhhwq7Hgkqt1SRqtDdE7gOP01t
         EgTfhYmRKHdCw==
Date:   Sun, 6 Nov 2022 11:48:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phani Movva <Phani.Movva@imgtec.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH 0/5] iio: adc: cc10001: Devm conversion
Message-ID: <20221106114853.08a2ceac@jic23-huawei>
In-Reply-To: <SJ0PR03MB67785AB3EBAF51E84687F31499379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016170950.387751-1-jic23@kernel.org>
        <20221029134331.52adcda1@jic23-huawei>
        <SJ0PR03MB67785AB3EBAF51E84687F31499379@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 31 Oct 2022 11:19:19 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, October 29, 2022 2:44 PM
> > To: linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Phani Movva
> > <Phani.Movva@imgtec.com>; Naidu Tellapati <naidu.tellapati@imgtec.com>
> > Subject: Re: [PATCH 0/5] iio: adc: cc10001: Devm conversion
> >=20
> > [External]
> >=20
> > On Sun, 16 Oct 2022 18:09:45 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > A very simple example of how using devm_ managed calls for everything
> > > can reduce complexity error handling and removal ordering in a driver.
> > >
> > > Note I don't have one of these to test so if anyone has a chance to do
> > > so or give these a quick look at that would be much appreciated.
> > > Note this is a fairly old driver, so relative unlikely original autho=
rs
> > > still have access.
> > >
> > > Cc: Phani Movva <Phani.Movva@imgtec.com>
> > > Cc: Naidu Tellapati <naidu.tellapati@imgtec.com> =20
> >=20
> > If anyone has time for a quick glance at this it would be much apprecia=
ted!
> >=20
> > Old maintainer issue of who is the fall back reviewer for the maintaine=
rs
> > own patches to old drivers, where the authors etc have probably long si=
nce
> > moved on.
> >=20
> > Jonathan =20
> > >
> > > Jonathan Cameron (5):
> > >   iio: adc: cc10001: Add local struct device *dev variable to avoid
> > >     repitition
> > >   iio: adc: cc10001: Add devm_add_action_or_reset() to disable
> > >     regulator.
> > >   iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
> > >   iio: adc: cc10001: Use devm_ to call device power down.
> > >   iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ for=
ms.
> > >
> > >  drivers/iio/adc/cc10001_adc.c | 89 +++++++++++++--------------------=
--
> > >  1 file changed, 34 insertions(+), 55 deletions(-)
> > > =20
>=20
> Only minor comments, so feel free to add:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Tweaked as suggested whilst applying.  Thanks!

Applied to the togreg branch of iio.git and pushed out as testing for all t=
he
normal reasons.

Thanks,

Jonathan
