Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE04ABC525
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395278AbfIXJqq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 05:46:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:63010 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392592AbfIXJqp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Sep 2019 05:46:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 02:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="asc'?scan'208";a="190972164"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2019 02:46:43 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP Encoder
In-Reply-To: <20190922233538.GA3119@icarus>
References: <20190917114403.GA8368@icarus> <20190919080305.960198-1-felipe.balbi@linux.intel.com> <20190919080305.960198-2-felipe.balbi@linux.intel.com> <20190922233538.GA3119@icarus>
Date:   Tue, 24 Sep 2019 12:46:39 +0300
Message-ID: <87tv92xc00.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
>> Add support for Intel PSE Quadrature Encoder
>>=20
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> ---
>>=20
>> Changes since v1:
>> 	- Many more private sysfs files converted over to counter interface
>>=20
>>=20
>> How do you want me to model this device's Capture Compare Mode (see
>> below)?
>
> Hi Felipe,
>
> I'm CCing Fabien and David as they may be interested in the timestamps
> discussion. See below for some ideas I have on implementing this.
>
>> For the few features which I couldn't find a matching property in
>> counter framework, I still leave them as private sysfs files so we can
>> discuss how to model them in the framework.
>>=20
>> Do you want Capture Compare to be a new function mode?
>>=20
>> BTW, I know I'm missing a Documentation file documenting sysfs files
>> introduced by this driver, I'll do that once we agree how to move all
>> other sysfs files to the framework. No worries.
>>=20
>>=20
>> Details about the controller (do you want this in commit log?):
>>=20
>>=20
>> Controller has 2 modes of operation: QEP and Capture. Both modes are
>> mutually exclusive. We also have a set of maskable interrupts. Further
>> details about each mode below.
>
> I noticed your interrupt handler takes care of a number of different
> scenarios. Would you be able to summarize a bit further here the
> conditions for this device that cause an interrupt to be fired (watchdog
> timeout, FIFO updates, etc.)?
>
>> Quadrature Encoder Mode
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Used to measure rotational speed, direction and angle of rotation of a
>> motor shaft. Feature list:
>>=20
>> 	- Quadrature decoder providing counter pulses with x4 count
>> 	  resolution and count direction
>>=20
>> 	- 32-bit up/down Position Counter for position measurement
>>=20
>> 	- Two modes of position counter reset:
>> 		> Maximum Count (ceiling) to reset the position counter
>> 		> Index pulse to reset the position counter
>>=20
>> 	- Watchdog timer functionality for detecting =E2=80=98stall=E2=80=99 ev=
ents
>>=20
>> Capture Compare Mode
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Used to measure phase input signal Period or Duty Cycle. Feature List:
>>=20
>> 	- Capture function operates either on phase A or phase B input
>> 	  and can be configured to operate on lo/hi or hi/lo or both hi
>> 	  and lo transitions.
>>=20
>> 	- Free-running 32-bit counter to be configured to run at greater
>>           than or equal to 4x input signal frequency
>
> So in "Capture Compare" mode, the counter value is just increasing when
> a state condition transition occurs. In that case we won't need a new
> function mode to represent this behavior since one already exists:
> "increase".
>
> You can add it to your intel_qep_count_functions array like so:
>
>         [INTEL_QEP_ENCODER_MODE_CAPTURE] =3D
>         COUNTER_COUNT_FUNCTION_INCREASE,
>
> The various configurations for this mode are just Synapse action modes.
> If you want only Phase A, you would set the action mode for Phase A
> ("rising edge", "falling edge", or "both edges") and change the action
> mode for Phase B to "none"; vice-versa configuration for Phase B instead
> of Phase A.
>
> One thing to keep in mind is that action_set will need to maintain valid
> configurations -- so if the user tries to set the action mode for Phase
> A to something other than "none", you need to automatically set Phase
> B's action mode to "none" (and vice-versa).

interesting, thanks

>> 	- Clock post-scaler to derive the counter clock source from the
>> 	  peripheral clock
>
> I see you already have a "prescaler" extension in your code. Is this
> different from the "post-scaler" you mentioned here?

This was probably a brain-fart on my side. It should be post-scaler, but
that's only valid for capture compare mode.

>> 	- 32B wide FIFO to capture 32-bit timestamps of up to 8
>> 	  transition events
>
> You can implement this as a Count extension called "timestamps" or
> similar. What we can do is have a read on this attribute return the
> entire FIFO data buffer as unsigned integers, where each timestamp is
> deliminated by a space.
>
> In addition, it may be useful to have another extension called
> "timestamps_layout", or something along those lines, that will report
> the ordering of the buffer (i.e. whether it's "fifo", "lifo", etc.).
>
> Would this design work for your needs?

Perhaps it would be best to have a pollable binary sysfs file (meaning,
we need to be able to call sysfs_notify() at will) and userspace just
receives POLLIN whenever there's data read. Then a read returns an array
of e.g. struct counter_event where struct counter_event could be defined
as:

	struct counter_event {
        	uint32_t	event_type;
		struct timespec64 timestamp;
                uint8_t		reserved[32];
        };

Userspace would do something along the lines of:

	fd =3D open("/sys/bus/counter/foo/capture/timestamps",...);
	pollfd[0].fd =3D fd;
        pollfd[0].events =3D POLLIN;
        poll(pollfd, 1, -1);

	if (pollfd[0].revents & POLLIN) {
        	ret =3D read(fd, events, sizeof(struct counter_event) * 8);

		for (i =3D 0; i < ret / sizeof(struct counter_event); i++)
			process_event(events[i]);
        }
=20=20=20=20=20=20=20=20
Or something like that.

I could, also, remove this part from the driver for now, so we can
discuss how the capture-compare buffer read would look like. At least we
could get QDP feature merged while we come to a consensus about capture
compare.

What do you think?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2J5f8ACgkQzL64meEa
mQa/QBAAiQFvXgs+yhs7fMe7bL39eb6k+Kh8WggCK+fiPOzqcQaZ0B6h32aBNj6H
YHMbzR28C0PzSTvAbrH8fyGtPx/Hvw17n645LABc9dNv4J6mIXohqILJWyHyl4iH
k6i1UGOdqQnjqKi5oKwq7XsD+jqco9SZ+rnTJxIl1jE6CTClLeWYSzRr+1hL0QLt
Fj+udj2/vXXiAVXcyTArGuR9TTftTP6m2hwPzahgUU/KffR+tQsPdUmSTedaK3FN
YjVUJ1EOPzwtfpNhpqvumhCBenHiF5XjLM+2mp/8bHhy4Gf3+KF5ccsCBQ47NFDO
S1Z/8ENCQRo/PLzhLPSstf0X5jOgZz+pU7+98y7cu7XbF90w+UNhsEcJYc1Hig4D
GcklIWbrGdnMUTKGNBe62PiuNXJBcuERf3Jf/HFAHG5xiKuU2nWWA8SjnxZFDV+t
GjminllgtLgGqiG/qfAdPu5Id299Hp1BVwUPx4+wLoPniGdoWsY/9ePCLf7Hw25z
O5EvWbzbPyfeBGq/fGjoIfQBwVpcJHoNinEzOPZ63C5xX5hoF88+PI/efoA2QErS
8ZnVEBIODxTiB/Es6bnX2GvvYZTmIN9eBWZQPxNN2BT5IkcMcQZxUEJJvWgN5ycV
6Xy2Dss0ZMLR130G5jNmBzYndg8T6dOb4cVfnl/hEailqfWMDEE=
=7PGz
-----END PGP SIGNATURE-----
--=-=-=--
