Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923AE7DA814
	for <lists+linux-iio@lfdr.de>; Sat, 28 Oct 2023 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJ1QbZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Oct 2023 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJ1QbZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Oct 2023 12:31:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EF9F1
        for <linux-iio@vger.kernel.org>; Sat, 28 Oct 2023 09:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89617C433C8;
        Sat, 28 Oct 2023 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698510682;
        bh=pqzNBsro4f5+F2py+e/b1zfe605C47w0VXqZe66xJlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OQ5NsotavJ9Wwhy1eGtU76m7vNaCjDBVlkC/+7vyrWXMKgkuqD0t7AOxWwX30iXN5
         u2H9fJ2GwnKsC0v9LbhbQd+rVAQ+MYz45i8/oeo+7WLEMZEXHlIFNt5hJECIWsyRWo
         8JNbPojtKShlpwRV0CQFNUYb5NJ+0WBQx/Mw+qy+h0KLED5/4kbWWlspnASO9rNbUz
         65Hopa1b/aA9YcoRvYwGtccRrdb8C2xqgbC7guMd1ohcmWwwRpILuDwnQrrfn5BDNX
         K07ASbLV5T4sjgHgAKHPEDMg/nlFB87TW6wbl07q+KRFaXAwEAXBubU0St+b5gdmKA
         V/y7QBeZT6wRA==
Date:   Sat, 28 Oct 2023 17:30:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] IIO: hid-sensor-prox: add missing scale attribute
Message-ID: <20231028173050.4ceb7207@jic23-huawei>
In-Reply-To: <861ee3a58a52afb9e3f4001e4f25a2fd5c318618.camel@linux.intel.com>
References: <20230806130558.89812-2-p.jungkamp@gmx.net>
        <cd33e36768322d4e8f7919711d3474f57c4383ff.camel@linux.intel.com>
        <trinity-2e8c2d00-be4a-4590-ae0f-265289d9256b-1691497330952@3c-app-gmx-bs40>
        <20231014175206.6b2ff811@jic23-huawei>
        <32200d0651ba77d03bad5733d8690f9f1b7b8d1a.camel@linux.intel.com>
        <20231015120448.6279430d@jic23-huawei>
        <20231016084400.79932e58@jic23-huawei>
        <7c09e707455e43d87a0e2368842c9b5b1afcf80f.camel@linux.intel.com>
        <20231017201116.63d54c60@jic23-huawei>
        <861ee3a58a52afb9e3f4001e4f25a2fd5c318618.camel@linux.intel.com>
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

On Tue, 17 Oct 2023 18:56:38 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Tue, 2023-10-17 at 20:11 +0100, Jonathan Cameron wrote:
> > On Mon, 16 Oct 2023 07:28:36 -0700
> > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >  =20
> > > On Mon, 2023-10-16 at 08:44 +0100, Jonathan Cameron wrote: =20
> > > > On Sun, 15 Oct 2023 12:04:48 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > > =C2=A0  =20
> > > > > On Sat, 14 Oct 2023 19:56:26 -0700
> > > > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > wrote:
> > > > > =C2=A0  =20
> > > > > > On Sat, 2023-10-14 at 17:52 +0100, Jonathan Cameron wrote:=C2=
=A0=20
> > > > > > =C2=A0  =20
> > > > > =C2=A0  =20
> > >=20
> > > [...]
> > >  =20
> > > > > Phillipp, if a backport makes sense you can request that after
> > > > > this
> > > > > goes upstream.=C2=A0  =20
> > > > Whilst typing up a pull request I saw this again and thought a
> > > > bit
> > > > more on it.
> > > >=20
> > > > This fix is probably wrong approach.=C2=A0 Proximity sensors are of=
ten
> > > > scale free
> > > > because they depend on reflectance off something or a capacitance
> > > > changing etc
> > > > so we don't know the scaling.=C2=A0 So the right response then is n=
ot
> > > > to
> > > > return a scale
> > > > value of 1.0 but to not provide the attribute at all.=C2=A0 Is that
> > > > something that
> > > > could be easily done here?=C2=A0  =20
> > >=20
> > > I think so. But hope that iio-sensor-proxy can handle absence of
> > > scale
> > > attribute.
> > >=20
> > > git diff drivers/iio/light/hid-sensor-prox.c
> > > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > > b/drivers/iio/light/hid-sensor-prox.c
> > > index a47591e1bad9..e4b81fa948f5 100644
> > > --- a/drivers/iio/light/hid-sensor-prox.c
> > > +++ b/drivers/iio/light/hid-sensor-prox.c
> > > @@ -36,7 +36,6 @@ static const struct iio_chan_spec prox_channels[]
> > > =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_PROXIMITY,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .info_mask_shared_by_type =3D
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .scan_index =3D CHANNEL_SCAN_INDEX_PRESENCE,
> > >=20
> > > Thanks,
> > > Srinivas =20
> >=20
> > Just to check. Are we guaranteed that there is never a scale
> > parameter?
> > Some proximity sensors do have absolute units (time of flight sensors
> > for example).
> >  =20
> This driver is implementing:
> Biometric: Human Presence (Usage ID 0x11) from HID sensor hub
> specification.
>=20
> "Biometric: Human
> PresenceCA,CP =E2=80=93 An application-level or physical collection that
> identifies
> a device that detects human presence (Boolean yes or no)."
>=20
>=20
> It is not implementing Biometric: Human Proximity (Usage ID 0x12).
> This has range of values, then unit will be applicable.

Makes sense. In that case, formal version of the patch above?

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas
>=20
> > Jonathan
> >  =20
> > >  =20
> > > >=20
> > > > For now I'm dropping the patch. Sorry I wasn't paying enough
> > > > attention to notice
> > > > this was a proximity sensor.
> > > >=20
> > > > Jonathan
> > > > =C2=A0  =20
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > Jonathan
> > > > > =C2=A0  =20
> > > > > > >=20
> > > > > > > Phillipp - this sounds like a fix to me.=C2=A0 Fixes tag?
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > >=20
> > > > > > > Jonathan=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0  =20
> > > > > > =C2=A0=C2=A0=C2=A0  =20
> > > > > =C2=A0  =20
> > > > =C2=A0  =20
> > >  =20
> >  =20
>=20

