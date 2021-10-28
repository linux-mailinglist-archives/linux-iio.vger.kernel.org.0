Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32543DC59
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 09:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ1HvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 03:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhJ1Hu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 03:50:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4659C061570;
        Thu, 28 Oct 2021 00:48:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r28so5663842pga.0;
        Thu, 28 Oct 2021 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zfml4e/5zjeeksUFAYJ3rGZIA4StdAA4EuaHjMcQT38=;
        b=huhpet0MqDupEUIfOECUKPrG53w0qEtMllFJZbxy4Me0FyWstqsZ7UneriQNH7rGuC
         3LgBE/hmavntJtz7TkVXqvfm37Bg8GiktDQOMOOEW9FOgiBOC06JWXwBlNwnBroXa0BR
         Voi+RaSCWJnELgSdWiUvOtw+D9w8vLnQsVIPLscCG7DUaxWR4AZLsDgwygX0i3GwMUho
         my/uxovtguIuI+HPJz+29klY4pI9fADhnYLFraQgF1+c0fnq2+VG/qTvQLePegSwKFCg
         bsZumqvtECcx5VQb6lNno6nAUKS+fIsvH/VSJ1Juo6nbQ3jNQyWF1OtacPOuipV1kYaW
         q5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zfml4e/5zjeeksUFAYJ3rGZIA4StdAA4EuaHjMcQT38=;
        b=RfQnrQzB0l8Om9MFcFJ9gJWVt2Nlmi/xRTbHXQBl6WqhfEXlh1lrbU5kpnu2THcRCc
         mhTey7P8e//BNIXioHysy3960oQit+V61T7EQDLuV6dv6Rtqv8gLo4p8Lx8+pXrPRV0w
         9rXF1nWlrfgBw+hxDB6lH3rzHH3Bs3xglLZTFEJuVoBveptUfl5p+lyqx7kU42v50yVK
         AUAV7lE3yh0mUHaGdEN6VDue54Ncv4zU7wH78YT/JSzIzQ1RZ/XuW/Qk6/EPGekTzEXG
         pk+x1GEdiRtHD0fWZBIPmrK4057FB93AMNyICj3/b7CvNjbUW10zOviJ7lj+VO7iW16f
         4EWA==
X-Gm-Message-State: AOAM532pu+atIOtldm5qR6y5JzZtQGwr1lOXlghY0Iqwxm5kPd4Rd21v
        eMwFsPR9NxCB8GHAigQHQiWlmD2ao38=
X-Google-Smtp-Source: ABdhPJxhSQ80/zsI1j1kX4zZKzW2XoeRvm6mtyOtSwlgdy3+1ugCeIH2wETwQ0645Pb5LNOQP4zbKA==
X-Received: by 2002:a63:b957:: with SMTP id v23mr2013793pgo.74.1635407312096;
        Thu, 28 Oct 2021 00:48:32 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i2sm2274853pfa.34.2021.10.28.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:48:31 -0700 (PDT)
Date:   Thu, 28 Oct 2021 16:48:26 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
Message-ID: <YXpVyjnrrmRbpHJU@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-4-david@lechnology.com>
 <YXZvQSU6bRRaWD89@shinobu>
 <253916e2-a808-8786-ac72-60a1a62b1531@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hJL1FEZlpoaElEeg"
Content-Disposition: inline
In-Reply-To: <253916e2-a808-8786-ac72-60a1a62b1531@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--hJL1FEZlpoaElEeg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 10:28:59AM -0500, David Lechner wrote:
> On 10/25/21 3:48 AM, William Breathitt Gray wrote:
> > On Sat, Oct 16, 2021 at 08:33:38PM -0500, David Lechner wrote:
> >> This adds support to the TI eQEP counter driver for the Unit Timer.
> >> The Unit Timer is a device-level extension that provides a timer to be
> >> used for speed calculations. The sysfs interface for the Unit Timer is
> >> new and will be documented in a later commit. It contains a R/W time
> >> attribute for the current time, a R/W period attribute for the timeout
> >> period and a R/W enable attribute to start/stop the timer. It also
> >> implements a timeout event on the chrdev interface that is triggered
> >> each time the period timeout is reached.
> >>
> >> Signed-off-by: David Lechner <david@lechnology.com>
> >=20
> > I'll comment on the sysfs interface in the respective docs patch. Some
> > comments regarding this patch below.
> >=20
>=20
> ...
>=20
> >> +static int ti_eqep_unit_timer_period_write(struct counter_device *cou=
nter,
> >> +					   u64 value)
> >> +{
> >> +	struct ti_eqep_cnt *priv =3D counter->priv;
> >> +	u32 quprd;
> >> +
> >> +	/* convert nanoseconds to timer ticks */
> >> +	quprd =3D value =3D mul_u64_u32_div(value, priv->sysclkout_rate, NSE=
C_PER_SEC);
> >> +	if (quprd !=3D value)
> >> +		return -ERANGE;
> >> +
> >> +	/* protect against infinite unit timeout interrupts */
> >> +	if (quprd =3D=3D 0)
> >> +		return -EINVAL;
> >=20
> > I doubt there's any practical reason for a user to set the timer period
> > to 0, but perhaps we should not try to protect users from themselves
> > here. It's very obvious and expected that setting the timer period to 0
> > results in timeouts as quickly as possible, so really the user should be
> > left to reap the fruits of their decision regardless of how asinine that
> > decision is.
>=20
> Even if the operating system ceases operation because the interrupt
> handler keeps running because clearing the interrupt has no effect
> in this condition?

I don't disagree with you that configuring the device to repeatedly
timeout without pause would be a waste of system resources. However, it
is more appropriate for this protection to be located in a userspace
application rather than the driver code here.

The purpose of a driver is to expose the functionality of a device in an
understandable and consistent manner. Drivers should not dictate what a
user does with their device, but rather should help facilitate the
user's control so that the device behaves as would be expected given
such an interface.

For this particular case, the device is capable of sending an interrupt
when a timeout events occurs, and the timeout period can be adjusted;
setting the timeout period lower and lower results in less and less time
between timeout events. The behavior and result of setting the timeout
period lower is well-defined and predictable; it is intuitive that
configuring the timeout period to 0, the lowest value possible, results
in the shortest time possible between timeouts: no pause at all.

As long as the functionality of this device is exposed in such an
understandable and consistent manner, the driver succeeds in serving its
purpose. So I believe a timeout period of 0 is a valid configuration
for this driver to allow, albeit a seemingly pointless one for users to
actually choose. To that end, simply set the default value of QUPRD to
non-zero on probe() as you do already in this patch and let the user be
free to adjust if they so decide.

William Breathitt Gray

--hJL1FEZlpoaElEeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF6Vb8ACgkQhvpINdm7
VJLXcw/8DBoqyQVMSMUjudHYbWVbHN31fXpYvv0vcUwGEfOBb4hNcyBGopF/NpA1
HfhcGN0gOrbX3wCRe7cMhVeJ9HMOUnZ2HGwm7ozyPhoirOZkDupZoD9dFnTXaSw2
3mETKBXFX5TSMs0q1TgvAVycBwJycPtAXrrWV3K411hDDXE1TRLReZSWIt15rgIn
vLQp+A0WlQP9/1mhv8ABkA2iXPkLTt2PiYyc8qqo5QfJXbH8EpP1bKMsse/8J59j
8sOV4PDUGfLf5VxmYWPjxgkEvmqXUp6RnYzlVQ6Dp4AF/wfjPTKAq0PG4B0ANeE6
2TZpvmJm+x33El8tR2sePynwLTDFTAkx4HnDaGOYAjsEG9Q006icB9iejNODRy/k
+I7RCCpuU7X1VTkqc9c/M9gYv2sLM1xIzyTY7/VpFqPu1DZmHRCGxMUyhWvKoVO6
LGQCdIxxPNlOD7TZwiyQYpNccqcJh9amVH68PKJtKAfVsCGdfs2+AGK7UieZaJuM
C2mh/HTTEa/wnvs1FRBYsCxyCVL0f2mkHwF/EqBhnTfEK48BWw3VaRiMXPzpkT+Q
kqWHYKUVIRQh1nouFyYBnmnJHjx7Qrydjf9mBnc0uGs/15r4C1V0qUs1aDAg6u2e
pvccldIKPpFLIFWcdPKjsVKkbpHnKC8dR9WcPzr2+spLja6VWrE=
=8g77
-----END PGP SIGNATURE-----

--hJL1FEZlpoaElEeg--
