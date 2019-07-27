Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1377C46
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfG0WKl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 18:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfG0WKl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 18:10:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3CB206DD;
        Sat, 27 Jul 2019 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564265440;
        bh=00yF2jx/qVIhC8Cz9VBWgx9ALb8Uuea2njN1/i9ZEg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LzP3bs3iCOUvZfcVj4dlxGSfDuTHr68blANVBN/0OCdw0Xic3LxEN6ZxJLVPx8Ww2
         t0HVkYYJd8sXkQqvGwlNMeMApEhZHR9qUrHqJXR8fdvYSA1t65TAroAR9dB2XwBaMe
         QXnXZhFpkHs3tWU84cAwED3DA+e6WDNpCIX8m3Es=
Date:   Sat, 27 Jul 2019 23:10:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: cros_ec: Add sign vector in core for
 backward compatibility
Message-ID: <20190727231035.1e3fb6bc@archlinux>
In-Reply-To: <3729385a-6628-22e1-da50-e22233737a4b@collabora.com>
References: <20190628191711.23584-1-gwendal@chromium.org>
        <20190628191711.23584-2-gwendal@chromium.org>
        <20190714173203.0b50d5c7@archlinux>
        <3729385a-6628-22e1-da50-e22233737a4b@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jul 2019 16:53:41 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan,
>=20
> On 14/7/19 18:32, Jonathan Cameron wrote:
> > On Fri, 28 Jun 2019 12:17:08 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >  =20
> >> To allow cros_ec iio core library to be used with legacy device, add a
> >> vector to rotate sensor data if necessary: legacy devices are not
> >> reporting data in HTML5/Android sensor referential.
> >>
> >> Check the data is not rotated on recent chromebooks that use the HTML5
> >> standard to present sensor data.
> >>
> >> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >> Reviewed-by: Douglas Anderson <dianders@chromium.org> =20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > As I mentioned in one of the other series.  I've lost track of whether
> > anyone wants me to apply any of these through IIO, so will just ack
> > them as appropriate and assume someone will shout if they do want
> > me to pick them up ;)
> >  =20
>=20
> To try to give you a bit of light on this, all the required changes in
> chrome-platform are now in upstream so all the patches can go safely thro=
ugh
> your tree. The order to pick the patches is as follow:
>=20
>=20
> 1096491 [v4,1/1] iio: common: cros_ec_sensors: determine protocol version
>=20
> 1100922 [v6,1/4] iio: cros_ec: Add sign vector in core for backward
>                  compatibility
> 1100924 [v6,3/4] iio: cros_ec_accel_legacy: Use cros_ec_sensors_core
> 1100923 [v6,4/4] iio: cros_ec_accel_legacy: Add support for veyron-minnie
>=20
> 1100982 [v5,1/1] iio: common: cros_ec_sensors: Expose cros_ec_sensors fre=
quency
>                  range via iio sysfs
>=20
> But if you try to apply latest versions from patchwork you'll get some tr=
ivial
> conflicts. So, I fixed the problems, rebased on top of your testing branc=
h,
> added my Rb tag to all the patches and put together in this branch [1]
>=20
> All the patches have your Ack, so should be fine if you apply all of them=
 just
> replacing your Ack for your Signed-off
Thanks!  This is very helpful indeed.

I've done exactly - well sort of :)

Note I did get:

drivers/iio/light/cros_ec_light_prox.c:120:9: warning: =E2=80=98ret=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
  120 |  return ret;
      |         ^~~

Which looks like a bug, as there is one path under=20

	case IIO_CHAN_INFO_CALIBBIAS:
that got caught by gcc.

Ah, it's my merge mess up on an earlier patch. I'll fix it and post
in reply to that patch.

Also I swapped in the v6 of the veyron_minnie patches and  v5 of the sysfs =
one
as your branch predates those I think.

Thanks,

Jonathan

>=20
> I can also send a new patch series with those if you prefer this option.
>=20
> Hopefully is more clear now and sorry for that mess.
> ~ Enric
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
/log/?h=3Dfor-iio-next
>=20
>=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> >> ---
> >>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
> >>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c=
 b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> index 719a0df5aeeb..e8a4d78659c8 100644
> >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> @@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device=
 *pdev,
> >>  		}
> >>  		state->type =3D state->resp->info.type;
> >>  		state->loc =3D state->resp->info.location;
> >> +
> >> +		/* Set sign vector, only used for backward compatibility. */
> >> +		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> >>  	}
> >> =20
> >>  	return 0;
> >> @@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct=
 iio_dev *indio_dev,
> >>  		if (ret < 0)
> >>  			return ret;
> >> =20
> >> +		*data *=3D st->sign[i];
> >>  		data++;
> >>  	}
> >> =20
> >> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include=
/linux/iio/common/cros_ec_sensors_core.h
> >> index ce16445411ac..a1c85ad4df91 100644
> >> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> >> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> >> @@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
> >>  	enum motionsensor_location loc;
> >> =20
> >>  	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> >> +	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
> >> =20
> >>  	u8 samples[CROS_EC_SAMPLE_SIZE];
> >>   =20
> >  =20

