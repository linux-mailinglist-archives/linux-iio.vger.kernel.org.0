Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02960B4D72
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2019 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfIQMHv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Sep 2019 08:07:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:56570 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfIQMHv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Sep 2019 08:07:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 05:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; 
   d="asc'?scan'208";a="387539464"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2019 05:07:48 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] counter: introduce support for Intel QEP Encoder
In-Reply-To: <20190917114403.GA8368@icarus>
References: <20190916093431.264504-1-felipe.balbi@linux.intel.com> <20190917114403.GA8368@icarus>
Date:   Tue, 17 Sep 2019 15:07:40 +0300
Message-ID: <87a7b3ceib.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi William,

William Breathitt Gray <vilhelm.gray@gmail.com> writes:

> On Mon, Sep 16, 2019 at 12:34:31PM +0300, Felipe Balbi wrote:
>> Add support for Intel PSE Quadrature Encoder
>>=20
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> ---
>>=20
>> Hi William,
>>=20
>> Here's a first cut of the ported driver. Note that this is really an RFC=
 as
>> there's still quite a bit I don't fully understand. I've left some of my=
 old
>> sysfs files in there just to keep track of which features I'm still miss=
ing.
>
> Hi Felipe,

before anything, thanks for the extensive background on the ideas of the
framework :-) Much appreciated

> That is understandable since this is an RFC; I expect in your final
> version those sysfs files will be Counter subsystem extension
> attributes.
>
> For reference, the existing Counter subsystem attributes are documented
> in the Documentation/ABI/testing/sysfs-bus-counter file. If you have any
> new attributes specific to the Intel QEP driver, add them as a new
> Documentation/ABI/testing/sysfs-bus-counter-intel-qep file.

Will do, thanks

>> If understood this correctly, I should add noise filtering as a signal
>> extension, right? Same for Input Swap.
>
> Determining the type of extension to create is a matter of scope.
>
> * Signal extensions are attributes which expose information/control
>   specific to a Signal. These types of attributes will exist under a
>   Signal's directory in sysfs.
>
>   For example, if have an invert feature for a Signal, you can have a
>   Signal extension called "invert" that toggles that feature:
>   /sys/bus/counter/devices/counterX/signalY/invert
>
> * Count extensions are attributes which expose information/control
>   specific to a Count. These type of attributes will exist under a
>   Count's directory in sysfs.
>
>   For example, if you want to pause/unpause a Count from updating, you
>   could have a Count extension called "enable" that toggles such:
>   /sys/bus/counter/devices/counterX/countY/enable
>
> * Device extensions are attributes which expose information/control
>   non-specific to a particular Count or Signal. This is where you would
>   put your global features or other miscellanous functionality.
>
>   For example, if your device has an overtemp sensor, you could report
>   the chip overheated via a device extension called "error_overtemp":
>   /sys/bus/counter/devices/counterX/error_overtemp

This clarifies a lot of my doubts.

> I'm not very familiar with the Intel QEP features, so I'll need your
> help clarifying some of it for me. I'm assuming "noise filtering" is
> a feature you can enable per individual Signal (is this correct?). If
> so, then it would be implemented as a Signal extension, maybe as a
> /sys/bus/counter/devices/counterX/signalY/noise_filter_enable file.
> Otherwise, it would be a device attribute if it enables noise filtering
> over all Signals.

The device, at least as is right now, has a single counter. It's a bit
difficult to decide whether the noise filter is global or per count :-)
I'll assume it to be per count as that would allow extension in case a
future version comes out with more than one counter. What do you think?

> Is "Input Swap" swapping the Phase A and Phase B signal lines for each
> Count? If so, this would be a Count extension if you can configure it
> per Count; otherwise a device extension if it's globally enabled for all
> Counts.

Yeah, it swaps A and B signals. Again, with a single count, difficult to
decide on global vs per-count.

> If you're still having trouble figuring out which type of extension to
> use, give me a simple breakdown of the features you are trying to
> support with these attributes and I should be able to specify which type
> works best for each.
>=20=20
>> How should we handle the reset mode of the device? And mode of operation?
>
> Is "reset mode" specifying the condition that causes a Count's count to
> be reset back to a value of 0? If so, I assume "index" means an active
> level on the index line will reset the count; does "maximum" mean the
> index line is ignored and the reset operation is simply activated once
> the ceiling is reached? As well, I'm assuming this is a global
> configuration for all counts.

This seems more logical to be global, yes. The other thing this QEP
controller has is that we can configure the maximum count value. By
default it's UINT_MAX (0xffffffff) but it could be less and that's
configurable. So I'm assuming I would have a "maximum_count" device
extension in this case.

> If my assumptions are correct here, then this behavior can be exposed
> by creating two device extensions: "preset" and "preset_enable"; these
> should be based on the existing two same-named Count attributes (see the
> Documentation/ABI/testing/sysfs-bus-counter file).
>
> * /sys/bus/counter/devices/counterX/preset
>   For the Intel QEP, this will be a read-only that always report "0".
>
> * /sys/bus/counter/devices/counterX/preset_enable
>   Assuming "maximum" is just equivalent to ignoring index, preset_enable
>   can toggle between the two modes as a simple boolean: "1" =3D "index"
>   and "0" =3D "maximum".

Understood. This will be nice from userspace point of view.

>   If I assumed incorrectly, please let me know and we can discuss the
>   possibility of a new attribute (perhaps "preset_mode").
>
> Take a look inside 104-quad-8.c to see how it handles index lines and
> reseting the counts; "preset" and "preset_enable" extensions are
> specified in the quad8_count_ext array.
>
>> If you have any ideas, let me know.
>>=20
>> cheers
>
> Since I expect a good amount of this code to change once the extensions
> are added, I'll hold off on a more in-depth code review until we get it
> closer to what it'll actually look like. From skimming the code in this
> RFC, it seems like you have the core Counter subsystem functions and
> structures use correct, so I think it'll be the implementations of the
> extensions that we'll be focusing on.

Cool, thanks a lot. I'll start moving some more of those private sysfs
files to extensions.

Again, thanks for the background information. Helps a lot.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2AzIwACgkQzL64meEa
mQYmARAAtsFAMBm29bZLyzDLXxhGfuj09owhNvDKBwpoouX3Icv78LSdkARVDaYt
AzDAPnQ8lPL3zyYkUoHJz3Gy7NCnVUYvNr2L+8xx4ILXbwRSqeK/Z6L0yt48pPXI
FXgRFr1aJDzegBDmrCLtg4pcnafGz3JEpO0Ud9/rOFE/lc46086EezOaQKx/6ROL
/cic/hbKDS33+IhcDefA6yHlaZnPKxMc6d/hdqSNRywHToO64HS4mLyKLcW7f0VK
LI70aZdIrIFXmbiyyWo0oLPeA+MwmfOJPG4mKzy+ur2mnD4VwIwp+lhRMlsxW7gF
eXydVmxjJeOUAJL3YDYvaTT7n8o9WDlZo1UeAFdEI2Ps6zVuppgp8FmuR98OWSBp
hIWPdcfTxZ5YQ4tiPOu8HA3Mi1Eub7KKmLH38AVY5yseb/H4mfwOnqyRDePkMvYz
Z+8rqDlcDuWEsG5a9wwgc/n9wCm2ZrCyAHhj5w9bLlHwPGBaGd2xkm8otGv842s8
JFqVah70jZnJpjEmgMZVx77YD9xZY2nuxnuLQU7dg5GQbdJb3qj0Fam039EdPZ7Y
CZ3K7NTVcY1kQPHF1uWCn+3ov0SP8XgBMC4AOoZDiGtEGj897qW/emltMUot6JNg
PH7+KWmQxhSQjS5Y65PCAUhW3y00uZerVEIB/HhZLUGxU7DGzDQ=
=w6Wt
-----END PGP SIGNATURE-----
--=-=-=--
