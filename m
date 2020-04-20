Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A261B1561
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTTIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 15:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 15:08:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF85C061A0C;
        Mon, 20 Apr 2020 12:08:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j4so11899017qkc.11;
        Mon, 20 Apr 2020 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H3Jg3tG9mOP7tMGOLglwmln0MBz8ObmXMf+JASaNH08=;
        b=sJ0PqwkjLvBvuf2g+GVKZUikKq4EiCL6XVrnPp6yMjFoiogoqIwOMSj4ydUKKkfoQc
         QA0Muf96g9gTXkat2x24I/kORZ2Aw3euk0noHRJrbZ0RzYZOGPqD4X6tc4bhw1IUX37w
         jOiGfRgX6I88dne3WkL9vNRudoxD9dWfpFYcZwkysTKplFm67VJThkLQdSdWU0lPlbHu
         uh7R7T1cLmH6c1MFrE5Z+sxUqTjPjaH8DV7Ucv6y3gTdeTzjGkCr+Bvzr9ceWvxnOrqr
         VPB+PKOmQdrZtj8/3GRH0Ih38xgeSl/VgV658w6lcu8w4XC9AQjCueUAUJbzOmcH5gkw
         TvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H3Jg3tG9mOP7tMGOLglwmln0MBz8ObmXMf+JASaNH08=;
        b=Ehe46LLG+tcaH55Z6cf1si5hirD6hNSZDhrE/Mfpm6bvII19okii+ncdc1GYRcI4EP
         eOhfOmhZHSGhCbHYmn+RfFjzKegem2ht0d/x5J2LJKCKXNxcMgRdac6xLJ7Wg14p+uTg
         +0sC2Sf6iX45m+/bST9fccglGyXnHqvztcFP4ZR4phZx6BSLq/L6imOk5FiLcJFqP2Y9
         UavqkQlOqhg5SmFcSyKDmcunf4zBsu/w8uN9nItkinVb5mzJJoSWR8EZCYATFBpBwZlK
         52JaV0oq7StwOTmY0xmlJ5QQBh0KrouddmTKeorlSeQmHCzWietKVABhO3KqTWAGWFXs
         fkqg==
X-Gm-Message-State: AGi0PubwOwSrAWa19Lyt5AZVzo7DCT4K//ND/VUSjsAe7SggvGZrYCNO
        XnN6Zm+KYhdez16MXs6mbbU=
X-Google-Smtp-Source: APiQypIs6F/4crhBr5ngpinP4J4A/ZzbDaWJ7ym5ePzRZC6vwn/0AZ0a1hX4yuysaEjJ1XMJjgJzSg==
X-Received: by 2002:a37:e112:: with SMTP id c18mr17010881qkm.467.1587409730812;
        Mon, 20 Apr 2020 12:08:50 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u190sm274784qkb.102.2020.04.20.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:08:49 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:08:10 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: counter: Add Cros EC Sync counter
Message-ID: <20200420190810.GA16124@icarus>
References: <20200413195514.192868-1-gwendal@chromium.org>
 <20200414204814.GH7347@icarus>
 <CAPUE2utas86PQdQem7bPsNL+xnHreepG8wbvbt2Vk5rtjoyn-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <CAPUE2utas86PQdQem7bPsNL+xnHreepG8wbvbt2Vk5rtjoyn-A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 11:54:16AM -0700, Gwendal Grignou wrote:
> On Tue, Apr 14, 2020 at 1:48 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 12:55:14PM -0700, Gwendal Grignou wrote:
> > > When the camera vsync pin is connected to the embedded controller (EC=
) of
> > > a chromebook, the EC reports a sensor with a counter that increases
> > > at each GPIO rising edge.
> > >
> > > The sensor is presented using the counter subsystem.
> > > In addition, it is also presented via the IIO subsystem with a timest=
amp,
> > > allowing synchronisation with sensors connected to the same EC, for
> > > image stabilisation or augmented reality applications.
> >
> > Hi Gwendal,
> >
> > Sorry for the delay. I have some changes requested below.
> >
> > > To enable the counter:
> > > via counter ABI:
> > > echo "rising edge" > counterX/count0/signal_action
> > > via iio ABI
> > > echo 1 > iio:deviceY/en
> > >
> > > To disable the counter:
> > > via counter ABI:
> > > echo "none" > counterX/count0/signal_action
> > > via iio ABI
> > > echo 0 > iio:deviceY/en
> >
> > Although in theory a user could manually disable the actions for a
> > Signal, this is a very roundabout way of actually disabling the Count.
> > It's better to expose an "enable" attribute to allow the users to
> > perform this functionality; for example:
> >
> > echo 0 > counterX/count0/enable
> > echo 1 > counterX/count0/enable
> >
> > >
> > > To read the current counter value:
> > > via counter ABI:
> > > cat counterX/count0/count
> > > via iio ABI
> > > cat iio:deviceY/in_count_raw
> >
> > I know we discussed this in the last review but it's still the same as
> > before: IIO_COUNT interface is deprecated so new drivers won't be
> > allowed to use it. You'll have to remove the IIO_COUNT code in this
> > driver and replace it with Counter subsystem equivalents.
> I understand the need of a clean separation between counter and IIO subsy=
stems.
> I will wait for counter to offer a way to gather timestamp'ed counts.
> Do you have a plan/proposed ABI you can share?
>=20
> Thanks,
>=20
> Gwendal.

Hi Gwendal,

I'm working on a reimplementation of the internals of the Counter
subsystem: https://gitlab.com/vilhelmgray/iio/-/tree/counter_chardev

I'm hoping to submit it to the mailing list later this week if I don't
hit any delays; it'll include support as well for a character device
interface for userspace application.

Once those changes are merged into IIO, I'll submit a patch to add
timestamp support -- hopefully within a week or two after. Right now I
haven't yet chosen any specific format for timestamps, but I will likely
match the format IIO subsystem currently has for its timestamp support
so that migration is easier for these drivers.

William Breathitt Gray

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6d8xoACgkQhvpINdm7
VJLvUBAAvbUJPNJWuqxWg5+I1tHr2pK+fwO7yuy65gwXG7V8n0kaZ5XqnZfwoO5+
1sdDtGnCs1qmhaY/ge2epuE9ylRW5RBkKbwAL8vB42Q2bbs7BgIaVg7LOvhcGNPV
7T0erY7XPf2/cxcuipQYhztISb9wMTYaLOCFdSNo+tUCJeRy0MPynOrdvI3Fsvzu
/SnvLFfhMeU3w9u2XXG/P7LY0bGIrrEfOu8b/MObIMYnRXi/squkNJAqojCXGFHZ
1c9rRtc9kWWxwM7cSzxSZKMJIiIpqdZFutDQW64uIIHmlnYzaRhz0Ti4OkedrzHY
AHWhQBbkA+1vLjX4Nt8Q521m1JlYg9T9oS3MPGhFdz7HO1XUZPJh0Fg18LCBEk4O
R0MpB/x6HGW3Ky+gIaXY5y9nY8BWozgBfEdPL5WYAqqiVs/yaV2KCcV14o+cHHSv
xZGfLObMPGmawTfFk2EsCyWca3G2ioPyG3ZkOcFXNOpuZUaqec5AfQhYkms1CE4I
Oj38LE3MShV5qYjBUE1zNd6MGI6+nFnIytm1gMq0nC5wP6HKsVm6BuTrmkfH5V1M
n2QaI96FUF+NZRpFp3BXktMi2S5BePtTogr5IkLZ5nuLmGPCfrKGyd8dxiv4/qmM
luSTSLtF/PN/bmVTs9VkMUTSuHyRqidCVvAMjwxM0zW5TvjPaSQ=
=Ale4
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
