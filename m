Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6083DBC6F3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440847AbfIXLfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 07:35:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:11339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440846AbfIXLfr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Sep 2019 07:35:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 04:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="asc'?scan'208";a="203362448"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2019 04:35:45 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP Encoder
In-Reply-To: <20190924113128.GA2727@icarus>
References: <20190917114403.GA8368@icarus> <20190919080305.960198-1-felipe.balbi@linux.intel.com> <20190919080305.960198-2-felipe.balbi@linux.intel.com> <20190922233538.GA3119@icarus> <87tv92xc00.fsf@gmail.com> <20190924113128.GA2727@icarus>
Date:   Tue, 24 Sep 2019 14:35:41 +0300
Message-ID: <87o8zax6ya.fsf@gmail.com>
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
>> William Breathitt Gray <vilhelm.gray@gmail.com> writes:
>> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
>> >> Add support for Intel PSE Quadrature Encoder
>> >>=20
>> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> >> ---
>> >>=20
>> >> Changes since v1:
>> >> 	- Many more private sysfs files converted over to counter interface
>> >>=20
>> >>=20
>> >> How do you want me to model this device's Capture Compare Mode (see
>> >> below)?
>> >
>> > Hi Felipe,
>> >
>> > I'm CCing Fabien and David as they may be interested in the timestamps
>> > discussion. See below for some ideas I have on implementing this.
>> >
>> >> For the few features which I couldn't find a matching property in
>> >> counter framework, I still leave them as private sysfs files so we can
>> >> discuss how to model them in the framework.
>> >>=20
>> >> Do you want Capture Compare to be a new function mode?
>> >>=20
>> >> BTW, I know I'm missing a Documentation file documenting sysfs files
>> >> introduced by this driver, I'll do that once we agree how to move all
>> >> other sysfs files to the framework. No worries.
>> >>=20
>> >>=20
>> >> Details about the controller (do you want this in commit log?):
>> >>=20
>> >>=20
>> >> Controller has 2 modes of operation: QEP and Capture. Both modes are
>> >> mutually exclusive. We also have a set of maskable interrupts. Further
>> >> details about each mode below.
>> >
>> > I noticed your interrupt handler takes care of a number of different
>> > scenarios. Would you be able to summarize a bit further here the
>> > conditions for this device that cause an interrupt to be fired (watchd=
og
>> > timeout, FIFO updates, etc.)?
>> >
>> >> Quadrature Encoder Mode
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>=20
>> >> Used to measure rotational speed, direction and angle of rotation of a
>> >> motor shaft. Feature list:
>> >>=20
>> >> 	- Quadrature decoder providing counter pulses with x4 count
>> >> 	  resolution and count direction
>> >>=20
>> >> 	- 32-bit up/down Position Counter for position measurement
>> >>=20
>> >> 	- Two modes of position counter reset:
>> >> 		> Maximum Count (ceiling) to reset the position counter
>> >> 		> Index pulse to reset the position counter
>> >>=20
>> >> 	- Watchdog timer functionality for detecting =E2=80=98stall=E2=80=99=
 events
>> >>=20
>> >> Capture Compare Mode
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>=20
>> >> Used to measure phase input signal Period or Duty Cycle. Feature List:
>> >>=20
>> >> 	- Capture function operates either on phase A or phase B input
>> >> 	  and can be configured to operate on lo/hi or hi/lo or both hi
>> >> 	  and lo transitions.
>> >>=20
>> >> 	- Free-running 32-bit counter to be configured to run at greater
>> >>           than or equal to 4x input signal frequency
>> >
>> > So in "Capture Compare" mode, the counter value is just increasing when
>> > a state condition transition occurs. In that case we won't need a new
>> > function mode to represent this behavior since one already exists:
>> > "increase".
>> >
>> > You can add it to your intel_qep_count_functions array like so:
>> >
>> >         [INTEL_QEP_ENCODER_MODE_CAPTURE] =3D
>> >         COUNTER_COUNT_FUNCTION_INCREASE,
>> >
>> > The various configurations for this mode are just Synapse action modes.
>> > If you want only Phase A, you would set the action mode for Phase A
>> > ("rising edge", "falling edge", or "both edges") and change the action
>> > mode for Phase B to "none"; vice-versa configuration for Phase B inste=
ad
>> > of Phase A.
>> >
>> > One thing to keep in mind is that action_set will need to maintain val=
id
>> > configurations -- so if the user tries to set the action mode for Phase
>> > A to something other than "none", you need to automatically set Phase
>> > B's action mode to "none" (and vice-versa).
>>=20
>> interesting, thanks
>>=20
>> >> 	- Clock post-scaler to derive the counter clock source from the
>> >> 	  peripheral clock
>> >
>> > I see you already have a "prescaler" extension in your code. Is this
>> > different from the "post-scaler" you mentioned here?
>>=20
>> This was probably a brain-fart on my side. It should be post-scaler, but
>> that's only valid for capture compare mode.
>
> In that case you're implementation seems fine for this; perhaps a more
> generic name for that extension might be better such as "scale", but
> I'll decide later.
>=20=20
>> >> 	- 32B wide FIFO to capture 32-bit timestamps of up to 8
>> >> 	  transition events
>> >
>> > You can implement this as a Count extension called "timestamps" or
>> > similar. What we can do is have a read on this attribute return the
>> > entire FIFO data buffer as unsigned integers, where each timestamp is
>> > deliminated by a space.
>> >
>> > In addition, it may be useful to have another extension called
>> > "timestamps_layout", or something along those lines, that will report
>> > the ordering of the buffer (i.e. whether it's "fifo", "lifo", etc.).
>> >
>> > Would this design work for your needs?
>>=20
>> Perhaps it would be best to have a pollable binary sysfs file (meaning,
>> we need to be able to call sysfs_notify() at will) and userspace just
>> receives POLLIN whenever there's data read. Then a read returns an array
>> of e.g. struct counter_event where struct counter_event could be defined
>> as:
>>=20
>> 	struct counter_event {
>>         	uint32_t	event_type;
>> 		struct timespec64 timestamp;
>>                 uint8_t		reserved[32];
>>         };
>>=20
>> Userspace would do something along the lines of:
>>=20
>> 	fd =3D open("/sys/bus/counter/foo/capture/timestamps",...);
>> 	pollfd[0].fd =3D fd;
>>         pollfd[0].events =3D POLLIN;
>>         poll(pollfd, 1, -1);
>>=20
>> 	if (pollfd[0].revents & POLLIN) {
>>         	ret =3D read(fd, events, sizeof(struct counter_event) * 8);
>>=20
>> 		for (i =3D 0; i < ret / sizeof(struct counter_event); i++)
>> 			process_event(events[i]);
>>         }
>>=20=20=20=20=20=20=20=20=20
>> Or something like that.
>
> One concern is that returning binary data like that isn't friendly for
> human interaction. However, alternatively printing a human-readable
> array would add latency for userspace software that has to interpret it,
> so that would a problem as well. This is something we'll have to think
> more about then.
>
>> I could, also, remove this part from the driver for now, so we can
>> discuss how the capture-compare buffer read would look like. At least we
>> could get QDP feature merged while we come to a consensus about capture
>> compare.
>>=20
>> What do you think?
>>=20
>> --=20
>> balbi
>
> That sounds like a good idea. Most of this driver can be implemented
> using the existing Counter subsystem components, so we can do as you
> suggest and focus on just getting this driver merged in with the
> functionality it can for now.
>
> After it's accepted and merged, we can turn our attention to the new
> extension features such as the timestamps buffer return. This will make
> it easier for us to discuss ideas since we won't have to worry about
> merging in nonrelated functionality.

That's great. I'll prepare a version removing capture compare support
and all the extra sysfs files. That could potentially be merged for v5.5
merge window.

In parallel, we discuss capture compare buffer and how to expose it.

cheers

=2D-=20

balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2J/40ACgkQzL64meEa
mQZEog/+PIUolFw/uj7JfOJ7lwRGBK+l+/WS61Gejt9OGUaMTx2hYgFY+5fOIdqs
DjH3NI1UuNFHVCTU7YyVPvMCgJM5SfMnlenfAB/Qfbjx5gMg43cZeTjCikzvy3u2
OtAxGc4oB+qhw19hsd5UgjbSJOEHx5LUUH1jO2Xhv2hnjRMkAhc1VBz8sPaifMAI
PcpNyNtdWR5pK4cOcW8BD2KneRsAP8J+HuJf53U0BcPI04O41NDHOI62F64LGKxM
pUSA4NG+QlfbN/EDIawwBmFFTXy3Lws9DnRVmQ389vwQ7+Wt0RVpiWUW6Oyq81Vt
lW2GCjZiY/v32bttWhy+MhF2ec8ddat11tNl296gmDYdGpT/Yd84qy+Xi7G5adpk
DFVQAdE/0SJGvKPBmrDOamqHu4wLVr0zieA3t73fYmuUKRR3X3erK4GByGINZxNB
RLDpjaovLngtbZx4BZU3pBXhKZdXnSl7EbK/5JpS/YClkowiRXC6KsxFpY7CUqOB
Ph4kT12wknmf1uZ74hVqcrS1DgTe3ZTXZx8g9jJIs8sM5zIok4ei/6OHKIsCtvEe
Q/cQ6NuWvhGzbm7QvFLnyxOk7RXsbDSO/94eDKOHOGYxN9FsAVSmvA7lZkrdLTdU
kyECkBC4qVCAiJfXCQUq9WyQxMQUFYlqRf1L85tCLWIDlH77NxE=
=0Ltv
-----END PGP SIGNATURE-----
--=-=-=--
