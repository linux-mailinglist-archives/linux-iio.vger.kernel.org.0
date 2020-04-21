Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395601B31C7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgDUVSp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 17:18:45 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUVSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 17:18:44 -0400
Received: from envy ([82.207.214.61]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M6URd-1jK9bH0505-006sqo; Tue, 21
 Apr 2020 23:18:26 +0200
Message-ID: <c6831429000eeb2132c68c44d4d171063fa53d56.camel@richard-neumann.de>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Richard Neumann <mail@richard-neumann.de>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>, Shyam-sundar.S-k@amd.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Tue, 21 Apr 2020 23:18:23 +0200
In-Reply-To: <f4c08c96-bbaf-c42e-0dff-a02c5bbed6ed@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
         <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
         <4fe47b0323c1d65d429ee89b000e8bfcd984495f.camel@richard-neumann.de>
         <896f84bc-f0d6-59a5-c894-809695aa348f@amd.com>
         <CAHp75Vfr6q_H6z6tRFfaKedF7oR7nhmZvRWL4mxx3W7uypUFvA@mail.gmail.com>
         <9aea760f9abdd2f90f36642af77de7bfae719485.camel@richard-neumann.de>
         <3ffc343e-c44b-1b4e-993e-179a13dc928c@amd.com>
         <7683f875aa617b3003a1949131ce79bd0e3c4dcb.camel@richard-neumann.de>
         <f4c08c96-bbaf-c42e-0dff-a02c5bbed6ed@amd.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qKskeWVPLD7TB1ApjQF3"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:MEfE3I7hfcltTmoofx/Sk9X2L2Rsx4r1czXM8UQR5m3eXhcdtJE
 FQkLSJzTHehzjsLHwTtXts+T32txJuXhpMmGcp0oAB7D8zzCU6w6KE7VITqvy5uAyJ7RBcF
 I8CD8DrmJyQxU7zfTRQN2keVwtG1uOY9Y3PrHliveZ8yiexHNvHlHXlu5BlLkSU9M8FWiPb
 rp9aQukTYY3Sxz7blJ6VQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEb9qy7t5V8=:jZa391THHBj2FnwxkZJpt+
 Eh1rWsIsrjBlp2K2RnVU5PTyB8xaeW+MpbrFYwNHgm29ZutExAj3pitOspN6x3RxVsCKZo2ZJ
 rCN5vqLxcc2OAseuJ85d2Lj/rQH58p8PDVLYQxvsaH5mN4ROaiU+EZg7YZhI3K7vF/sUIqZ4W
 by++CIl7RS1/ITPPKeIm+GmNGgX1rsJ2OyOTbqBV1Dmu5xTevR9bc/j15dcTLXswsTXz8iHVI
 HvIg3onfmHPhdkmRe9JV+WC2nn+2ISattINvuL2AjG0QW/GOQr/zbw+hDGsFN/jutydY3EE81
 hF69M9POZYy1AkWWJ35ueM9CsIO2jM+JPR8b27ASPBxzFnTJo0J+MfyZ1OceUVURGgYN6St32
 kA25ELwczRU/Ty9B/9oeMzi9xyrwF65Rrwdh9y2fmzY9Dx1pQMrXN7Pv47P0kGBbjPo3CH7Er
 W5HfQHTOhIp/uf1DsQsvYkl5D6ZgGtVftrBYJTRCqU9RhsQKx9aUO0uznQ0D9Sb3NZ+q8sOTZ
 Vy5d2OXVh+FcCOL+EcOT7r2pARBQpA2lFkoxctSAvblFTsO3gW3ex45xRavmmYJt7wS2ypnd4
 XcNRJjUyYCB3Gepo9aXLDd7SeegARWKnrAt7lYKyKUHHLpp+COfwmP22fmQDVxIbg+/j1T1hU
 H9gi4MUtYL3mcbbQh6Md0idKc3gGnS1VLfUf6XBQU9YFuL8GtnIw33zJV1uTNajk5IEnLcaY3
 pZApomV6EPkXbrn58xhqilJAonmuHkYTEZCSruPL6tsIkSzLnp0wrDBYqhcGRy/9/wpT561BL
 KgvIxpOXCnQrBnqI6M9AMEiQIh46wqU15sbIC2aVb2gAj/EplZ1CBwsKZYCOFaBeP3khXqB
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--=-qKskeWVPLD7TB1ApjQF3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 22.04.2020, 00:01 +0530 schrieb Shah, Nehal-
bakulchandra:
> Hi Richard,
>=20
> Thanks for the refactoring  the patch. The .raw_request in
> hid_ll_driver is not correct, the output of sensor is not raw but it
> is processed one,
>=20
> so better to move it to .request function. Regarding your question
> for sensor position well it comes from firmware. So i am not sure
> about the firmware
>=20
> for sensor , what you have.Also, regarding the IOMMU, we figured out
> the issue, earlier patch series has bug that during DMA allocation
> pdev was passed
>=20
> from platform driver context, where in for IOMMU needs context PCI
> pdev. So that is taken care in your refactored patch hence issue is
> disappeared.
>=20
>=20
> Now regarding the patch (with your changes) i need to validate at our
> side. Due to lockdown i dont have access to the system, so may be we
> can wait on that.
>=20
>=20
> Thanks
>=20
> Nehal Shah

Hi Nehal

and thank you for the feedback.

Regarding the raw_request / request, I think the "raw" here is meant to
indicate, that the implementation is expected to write "raw bytes" [1]
into a buffer rather than handling a "struct hid_report", which is
exactly what the get_feature_report() and get_input_report() from the
original patch seem to be intended to do.
However it should be easy to migrate this to ".report", since it'd
probably look a lot like __hid_request() [2], which is currently doing
the magic automatically for me.
Furthermore a ll_driver needs a raw_request implementation anyways as
it's being tested for in hid_add_device() [3].

Regarding the validation on your side: Of course! I do in no way want
to undermine your work on this in any way. I'm just offering what I've
learned so far and what is working for me. If you find parts of it
worth taking into a refactored version for upstream, awesome. If you
don't agree with other parts, that's fine, too. I'm quite new to this
and eager to learn. Also I am in no rush. Good things take time.

In case you're missing my patch on gist.github.com, I decided to
further develop the driver in a forked linux source tree [4].

It's on the branch amd-sfh. You can just diff to the master branch to
get the entire patch. The changed files are still under
drivers/hid/amd-sfh-hid and Documentation/hid respectively.

You'll find that in the meantime I did some more work / learning and
implemented some rudimentary IRQ handling.

Kind regards,

Richard

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/hid.h#L107=
0
[2] https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-core.c#L=
1688
[3] https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-core.c#L=
2386
[3] https://github.com/conqp/linux/tree/amd-sfh

--=-qKskeWVPLD7TB1ApjQF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT62wKwhMqSt8WaustMqNUjvThq9wUCXp9jHwAKCRBMqNUjvThq
99I7AP9vmpENS45P92BDw1vV5wR4JcPiqpoc3lYzTupHbHyjXQD+OcnvH+UeIapi
7dK8yJqSiySCtpBMjt5Nh43DbwBAegs=
=CNx3
-----END PGP SIGNATURE-----

--=-qKskeWVPLD7TB1ApjQF3--

