Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E38E440802
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJ3IiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3IiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 04:38:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC2C061570;
        Sat, 30 Oct 2021 01:35:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g11so77427pfv.7;
        Sat, 30 Oct 2021 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9PSPHm2k4QOp5zNTuQ+K1Jl7bhvH3VWIPoK4iT8c/0=;
        b=ZrsSBl+/MDEpv7Y65Ax1HA1cN9nGpuWzehtcWTU7P05oXwi3we6fd7Qn6om8SwG0OL
         /+G5lVnsIDQSODKPvQC4yR+tJb/7uJUJ0bZg1oqUxOnnzmvyKrThnEoNsw2UCKnGkz9l
         pOK1HJyndXleoD6f2db7vXI2dnNFUgH1I5f1PXLFnTsE2EjGO9/+ROWU3oC5t4OSBhe2
         /tii+NC/qjJylkQLCqVNL/aXD8DaYdelGMQNN85Z1rDHsAysclUD9xaB7KzGvnhzMeiq
         8jUuMoW37xTojADEoJzuSmgU3CeAvb7wD8ljRVUk4bFiP4Znv0ZNrSjynbXN/jh3oOB6
         Y7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9PSPHm2k4QOp5zNTuQ+K1Jl7bhvH3VWIPoK4iT8c/0=;
        b=PfYk7dzoXNQnqsYIyQvf+Zf1XIglAWBS8e0p/Ot4lbQKpRqDlRjO/3r3TsM/hmThnk
         ZoOEZTQDFcBOEf7i9U0aYbFd3txquWdz/UTzj4cb4RaphNT2gdzXqE+H9kYdo5a2veu3
         X0MZbrxjKd4qd6wI/fV3ilS94Eu2AqmloQqfPVHYgz0cgqAtWZUsZ4q3tUFbQ35WnHJM
         J9RFlCYBMIB32X0drm7/+pNfCIdP5n0rG2aOPL+48Lp7WMPJ7wyoXzB4yh0EfJqIEOWC
         w569Sj+Hf+CP8nYqcft+3V99orIr6EyO8SQTcZjsZLRW5Wf0XK/p42Hamteh/yoa87pO
         vKJQ==
X-Gm-Message-State: AOAM531MyPIzoZxitLfY3MyvjoOE3e8li4m8jmHjVP8HnhfjwWFF8Srk
        VBAJf1XRwEkDRn+LvzHVEEg=
X-Google-Smtp-Source: ABdhPJzrRu1u1SWnSFTl7kg5HRhZwrpVnW5XQ3BDk7FzFnB0XYe84W/kSWWGKMXCNHSzL5KbXayqjA==
X-Received: by 2002:a05:6a00:1794:b0:47b:e4c8:e4f8 with SMTP id s20-20020a056a00179400b0047be4c8e4f8mr16225049pfg.6.1635582952848;
        Sat, 30 Oct 2021 01:35:52 -0700 (PDT)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id mw9sm1274938pjb.49.2021.10.30.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 01:35:52 -0700 (PDT)
Date:   Sat, 30 Oct 2021 17:35:46 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
Message-ID: <YX0D4j5B++G3QTj1@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-4-david@lechnology.com>
 <YXZvQSU6bRRaWD89@shinobu>
 <253916e2-a808-8786-ac72-60a1a62b1531@lechnology.com>
 <YXpVyjnrrmRbpHJU@shinobu>
 <f5e40a22-3c7f-4d4d-d160-fe5b5a7dd72e@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAECRAllJz4Bp4cu"
Content-Disposition: inline
In-Reply-To: <f5e40a22-3c7f-4d4d-d160-fe5b5a7dd72e@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--iAECRAllJz4Bp4cu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 28, 2021 at 08:42:49AM -0500, David Lechner wrote:
> On 10/28/21 2:48 AM, William Breathitt Gray wrote:
> > On Wed, Oct 27, 2021 at 10:28:59AM -0500, David Lechner wrote:
> >> On 10/25/21 3:48 AM, William Breathitt Gray wrote:
> >>> On Sat, Oct 16, 2021 at 08:33:38PM -0500, David Lechner wrote:
> >>>> This adds support to the TI eQEP counter driver for the Unit Timer.
> >>>> The Unit Timer is a device-level extension that provides a timer to =
be
> >>>> used for speed calculations. The sysfs interface for the Unit Timer =
is
> >>>> new and will be documented in a later commit. It contains a R/W time
> >>>> attribute for the current time, a R/W period attribute for the timeo=
ut
> >>>> period and a R/W enable attribute to start/stop the timer. It also
> >>>> implements a timeout event on the chrdev interface that is triggered
> >>>> each time the period timeout is reached.
> >>>>
> >>>> Signed-off-by: David Lechner <david@lechnology.com>
> >>>
> >>> I'll comment on the sysfs interface in the respective docs patch. Some
> >>> comments regarding this patch below.
> >>>
> >>
> >> ...
> >>
> >>>> +static int ti_eqep_unit_timer_period_write(struct counter_device *c=
ounter,
> >>>> +					   u64 value)
> >>>> +{
> >>>> +	struct ti_eqep_cnt *priv =3D counter->priv;
> >>>> +	u32 quprd;
> >>>> +
> >>>> +	/* convert nanoseconds to timer ticks */
> >>>> +	quprd =3D value =3D mul_u64_u32_div(value, priv->sysclkout_rate, N=
SEC_PER_SEC);
> >>>> +	if (quprd !=3D value)
> >>>> +		return -ERANGE;
> >>>> +
> >>>> +	/* protect against infinite unit timeout interrupts */
> >>>> +	if (quprd =3D=3D 0)
> >>>> +		return -EINVAL;
> >>>
> >>> I doubt there's any practical reason for a user to set the timer peri=
od
> >>> to 0, but perhaps we should not try to protect users from themselves
> >>> here. It's very obvious and expected that setting the timer period to=
 0
> >>> results in timeouts as quickly as possible, so really the user should=
 be
> >>> left to reap the fruits of their decision regardless of how asinine t=
hat
> >>> decision is.
> >>
> >> Even if the operating system ceases operation because the interrupt
> >> handler keeps running because clearing the interrupt has no effect
> >> in this condition?
> >=20
> > I don't disagree with you that configuring the device to repeatedly
> > timeout without pause would be a waste of system resources. However, it
> > is more appropriate for this protection to be located in a userspace
> > application rather than the driver code here.
> >=20
> > The purpose of a driver is to expose the functionality of a device in an
> > understandable and consistent manner. Drivers should not dictate what a
> > user does with their device, but rather should help facilitate the
> > user's control so that the device behaves as would be expected given
> > such an interface.
> >=20
> > For this particular case, the device is capable of sending an interrupt
> > when a timeout events occurs, and the timeout period can be adjusted;
> > setting the timeout period lower and lower results in less and less time
> > between timeout events. The behavior and result of setting the timeout
> > period lower is well-defined and predictable; it is intuitive that
> > configuring the timeout period to 0, the lowest value possible, results
> > in the shortest time possible between timeouts: no pause at all.
> >=20
> > As long as the functionality of this device is exposed in such an
> > understandable and consistent manner, the driver succeeds in serving its
> > purpose. So I believe a timeout period of 0 is a valid configuration
> > for this driver to allow, albeit a seemingly pointless one for users to
> > actually choose. To that end, simply set the default value of QUPRD to
> > non-zero on probe() as you do already in this patch and let the user be
> > free to adjust if they so decide.
> >=20
> > William Breathitt Gray
> >=20
>=20
> I disagree. I consider this a crash. The system becomes completely
> unusable and you have to pull power to turn it off, potentially
> leading to data loss and disk corruption.

I hope I'm not being excessively pedantic here -- I'll concede to a
third opion on this if someone else wants to chime in -- but I want to
ensure that we are not going outside the scope of what a driver should
do. Note that any device is capable of flooding the system with
interrupts (e.g. a counter operating on a high enough frequency
overflowing a low ceiling), so I don't think that reason alone will pass
muster. Nevertheless, it is important to define when a driver should
return an error or not.

Take for example, the period range check right above. If a user requests
the device do something it cannot, such as counting down from a period
value that is too high for it to represent internally, then it is
appropriate to return an error: the device cannot perform the request
and as such the request is not valid input for the driver.

However, when we apply the same method to the zero value case -- a user
requests a timeout period of 0 -- the device is capable of performing
that request: the device is capable of waiting 0 nanoseconds and as such
the request is a valid input for the driver because it can be performed
by the device exactly as expected by the user. As long as the behavior
of a request is well-defined, we must assume the user knows what they
are doing, and thus should be permitted to request their device perform
that behavior.

A driver should not speculate on the intent of a user's actions.
Restricting what a user can do with their device is a matter of
configuration policy, and configuration policy belongs appropriately in
userspace. Rather, the scope of a driver should be limited narrowly to
exposure of a device functionality in a standard and predictable way.

William Breathitt Gray

--iAECRAllJz4Bp4cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF9A9QACgkQhvpINdm7
VJIPyw/+KKWpbFVnxxqNc75d7n80BlKyJDwICE1wa0pCJKB3FiD3L7yFTrX+pjtl
gwHNdRZ5v1FwUoPxTAiqVzDuPDHZQq44wzCspznvL+jcsOFZPqqos8+qQ5xugEIp
pbf70AGh0QIru6IAq1RH9NxkR8b0pryiJPTNdIPz/4YTLI7c7q8IV6GqN9GjaVtg
fJvKemuP8nS5adaTCMzxE60Uu9CHMFjhKQDfs0WMua7XCvZBhH/uus8ghwtmnlHF
ISFujrnMn6dFInDfL4ZMv0L82l6P6tBh3tUpB14u6Tc3e3b3u/FjVx7VU7pmja5J
KczI/5Lo0gboX+VfJYkEMmPI3rhZwelNwCprdcFgvz3viHQT9KZgf/jEZdU0PmUg
uatEmBzV7GWBnXfSdZNRDQcV5ifPBGNLOW7KspIW8vCeIPktFCd/927qYQkkE6Lo
xojpvS1MVu69qNg57zSwVSxtkwYnrH/3XcjN9qHz26ZqgZSmlntxTnhFmyR0rFhg
GNj8u6iBlDxbHffbsGnOJBWKLMSRwY53dY079KXCITrGm3MakSOoJO9oJycVihvC
ZrV2dqnOc8jd86XmbcwRsSQSfwTxmTm6gY6XqF77tfoR0DFT6qAA/s+mlFALTwHU
sQPwZRHC+FpZfb+pT46Ov+pEkY6AzBaXoMXxrqtL3HbNACOrpfg=
=KZ1I
-----END PGP SIGNATURE-----

--iAECRAllJz4Bp4cu--
