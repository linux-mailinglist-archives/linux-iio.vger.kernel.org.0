Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2177CA0F0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Oct 2023 09:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjJPHno (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Oct 2023 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJPHnn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Oct 2023 03:43:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334EA95
        for <linux-iio@vger.kernel.org>; Mon, 16 Oct 2023 00:43:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CEEC433C8;
        Mon, 16 Oct 2023 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697442221;
        bh=AxGiQpsgiVK4n0R3cbO5cXmvI+G4x8Yk00FfT4N5Odg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a7xmbPokbfRIgluL0vQFmUZZhG8aTnYGDUKb0azlD8FtDLFWX35dwm1Da29EYp6o3
         FHlAjFrO7D6RQlrKZn0PcMJwY4qSc4PCssNVqNjTzhRGxCc3eKdjsmQd30KyDXruBa
         KcGGiCHPvoef7paK73KO1q0h9XwrhOmLUIwQrcSoOQB5j/zEJouI/tNhVK1NYuwSSr
         O3bj6YC+Lqai6G+f1dj9w7wHCo5VgV/vgdn4kCB1yZGqTWAztBAyLL1B/lYQDvqADD
         5MwDRm2q5EX9LTIFtBxUCl+1Wx0mpVjrmgFbNk6RBHUAcL/lbjKYhkS+Tgi6ZK3IVU
         P12nYj79ft30Q==
Date:   Mon, 16 Oct 2023 08:44:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20231016084400.79932e58@jic23-huawei>
In-Reply-To: <20231015120448.6279430d@jic23-huawei>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
        <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
        <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
        <20231014175206.6b2ff811@jic23-huawei>
        <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
        <20231015120448.6279430d@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Oct 2023 12:04:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 14 Oct 2023 19:56:26 -0700
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote: =20
> > > On Tue, 8 Aug 2023 14:22:10 +0200
> > > Philipp Jungkamp <p.jungkamp@gmx.net> wrote:
> > >    =20
> > > > > > The hid-sensor-prox returned an empty string on sysfs
> > > > > > in_proximity_scale
> > > > > > read. This is due to the the driver's scale never being
> > > > > > initialized.=C2=A0    =20
> > > > >=20
> > > > > What is scale value reporting here? Is it 1.
> > > > >=20
> > > > > Thanks,
> > > > > Srinivas=C2=A0    =20
> > > >=20
> > > > Calling `read` on the sysfs file `in_proximity_scale` returns 0,
> > > > thus an empty string.
> > > > Adding the hid_format_scale call makes that a '1.000000'.
> > > >=20
> > > > Regards,
> > > > Philipp   =20
> > >=20
> > > Srinivas - I was kind of waiting for a reply to say if you are happy
> > > with the explanation.
> > > All good?   =20
> > All good.
> >=20
> > Acked-by: Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>
> >  =20
> Given we are late in the cycle and my next fixes pull will probably end up
> going in during the merge window anyway, I've applied this to the togreg
> branch of iio.git (so the slow path).
>=20
> Phillipp, if a backport makes sense you can request that after this
> goes upstream.
Whilst typing up a pull request I saw this again and thought a bit more on =
it.

This fix is probably wrong approach.  Proximity sensors are often scale free
because they depend on reflectance off something or a capacitance changing =
etc
so we don't know the scaling.  So the right response then is not to return =
a scale
value of 1.0 but to not provide the attribute at all.  Is that something th=
at
could be easily done here?

For now I'm dropping the patch. Sorry I wasn't paying enough attention to n=
otice
this was a proximity sensor.

Jonathan

>=20
> Thanks,
>=20
> Jonathan
>=20
> > >=20
> > > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan   =20
> >  =20
>=20

