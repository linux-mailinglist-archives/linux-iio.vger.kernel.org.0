Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E97C98BF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Oct 2023 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJOLEe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Oct 2023 07:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJOLEd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Oct 2023 07:04:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A4D6
        for <linux-iio@vger.kernel.org>; Sun, 15 Oct 2023 04:04:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CDFC433C7;
        Sun, 15 Oct 2023 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697367871;
        bh=pWlH6N8yPU2n1xFKMAJOVtI96/hhz5jj9BQ/X6AXOkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bJ1+6JpDTs6xoPqgAvTzJRVcwGGNPbNs0xmSBlDu5g1Hk0LYMdMZtZEAOkwsPEgOg
         5JogFX4Ot1qdjPky/QcYz1IiRqZqZ/blhK9EgdqEIl2J1Y94f8VB2f0BLDi1kny70n
         gwcQAQA64g3viFSm8x4sDOhbGzFtwbVCsVAnc7bWp4ih9K3u02/XO6NhmS24gQsuc8
         jezoUvpg0z/QP7D9s0Zp2rUMsbMM2VDfGbJHwPZfJHfJJq9unQTV2AaQl1H2y4qkvI
         l2tm+jjJgwlRQPZRhzdcGd5ZQWI97zpM0LagTkucj7BkXiZrMoKatejrHBxotLXKGU
         /K+YPbGkRFolw==
Date:   Sun, 15 Oct 2023 12:04:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20231015120448.6279430d@jic23-huawei>
In-Reply-To: <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
        <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
        <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
        <20231014175206.6b2ff811@jic23-huawei>
        <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Sat, 14 Oct 2023 19:56:26 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:
> > On Tue, 8 Aug 2023 14:22:10 +0200
> > Philipp Jungkamp <p.jungkamp@gmx.net> wrote:
> >  =20
> > > > > The hid-sensor-prox returned an empty string on sysfs
> > > > > in_proximity_scale
> > > > > read. This is due to the the driver's scale never being
> > > > > initialized.=C2=A0  =20
> > > >=20
> > > > What is scale value reporting here? Is it 1.
> > > >=20
> > > > Thanks,
> > > > Srinivas=C2=A0  =20
> > >=20
> > > Calling `read` on the sysfs file `in_proximity_scale` returns 0,
> > > thus an empty string.
> > > Adding the hid_format_scale call makes that a '1.000000'.
> > >=20
> > > Regards,
> > > Philipp =20
> >=20
> > Srinivas - I was kind of waiting for a reply to say if you are happy
> > with the explanation.
> > All good? =20
> All good.
>=20
> Acked-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>
>=20
Given we are late in the cycle and my next fixes pull will probably end up
going in during the merge window anyway, I've applied this to the togreg
branch of iio.git (so the slow path).

Phillipp, if a backport makes sense you can request that after this
goes upstream.

Thanks,

Jonathan

> >=20
> > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> >=20
> > Thanks,
> >=20
> > Jonathan =20
>=20

