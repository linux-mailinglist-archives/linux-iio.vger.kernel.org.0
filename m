Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDF7CCBDA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJQTLA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjJQTK7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 15:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF459E8
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 12:10:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B46BC433CA;
        Tue, 17 Oct 2023 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697569857;
        bh=tqqN5AoAoGQlXS8xbVJVa2lk0t6nt7WWdIVQQELEjlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGTuLnEsk2KfqFzJGoGfpJxyDvXiUwgEgu9oi7JiHJf789PacTTwBa2XNBOriPsx6
         t2jKf+vvN8H01tjWdcOGJlVgtXLxfx24/rOySAaFmFoi/SMwHjWrkfzP6YBfZ04ptU
         MGzv2im5RmEElmnOm+L8m+1009LrHTXOjyTe2VeyVe5TuuZ+b1v8ydU/RH+KDAZv20
         b7JReNH3pG4RJo6QQso7Jmp0VPSRIAzaOFIHxpOMr6jE1rwIjhXT7ELXLgYtV6tllO
         zAeqo3vDBy+Uo1FPsJsOsHLz3m6+UgmkcQ2TjygaLQ+ISc39N2k3q+lsHJGSLKp6Gb
         CBotrNFB6ekOw==
Date:   Tue, 17 Oct 2023 20:11:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20231017201116.63d54c60@jic23-huawei>
In-Reply-To: <7c09e707455e43d87a0e2368842c9b5b1afcf80f.camel@linux.intel.com>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
        <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
        <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
        <20231014175206.6b2ff811@jic23-huawei>
        <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
        <20231015120448.6279430d@jic23-huawei>
        <20231016084400.79932e58@jic23-huawei>
        <7c09e707455e43d87a0e2368842c9b5b1afcf80f.camel@linux.intel.com>
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

On Mon, 16 Oct 2023 07:28:36 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2023-10-16 at 08:44 +0100, Jonathan Cameron wrote:
> > On Sun, 15 Oct 2023 12:04:48 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Sat, 14 Oct 2023 19:56:26 -0700
> > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > >  =20
> > > > On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:=C2=A0=20
> > > >  =20
> > >  =20
>=20
> [...]
>=20
> > > Phillipp, if a backport makes sense you can request that after this
> > > goes upstream. =20
> > Whilst typing up a pull request I saw this again and thought a bit
> > more on it.
> >=20
> > This fix is probably wrong approach.=C2=A0 Proximity sensors are often
> > scale free
> > because they depend on reflectance off something or a capacitance
> > changing etc
> > so we don't know the scaling.=C2=A0 So the right response then is not to
> > return a scale
> > value of 1.0 but to not provide the attribute at all.=C2=A0 Is that
> > something that
> > could be easily done here? =20
>=20
> I think so. But hope that iio-sensor-proxy can handle absence of scale
> attribute.
>=20
> git diff drivers/iio/light/hid-sensor-prox.c
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index a47591e1bad9..e4b81fa948f5 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -36,7 +36,6 @@ static const struct iio_chan_spec prox_channels[] =3D {
>                 .type =3D IIO_PROXIMITY,
>                 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>                 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
> -               BIT(IIO_CHAN_INFO_SCALE) |
>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>                 BIT(IIO_CHAN_INFO_HYSTERESIS),
>                 .scan_index =3D CHANNEL_SCAN_INDEX_PRESENCE,
>=20
> Thanks,
> Srinivas

Just to check. Are we guaranteed that there is never a scale parameter?
Some proximity sensors do have absolute units (time of flight sensors
for example).

Jonathan

>=20
> >=20
> > For now I'm dropping the patch. Sorry I wasn't paying enough
> > attention to notice
> > this was a proximity sensor.
> >=20
> > Jonathan
> >  =20
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> > > > >=20
> > > > > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > Jonathan=C2=A0=C2=A0=C2=A0  =20
> > > > =C2=A0  =20
> > >  =20
> >  =20
>=20

