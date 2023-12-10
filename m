Return-Path: <linux-iio+bounces-784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363E80BA43
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329FD1F20FEB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD716849C;
	Sun, 10 Dec 2023 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGvy92dm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE03847B;
	Sun, 10 Dec 2023 11:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2018AC433C7;
	Sun, 10 Dec 2023 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702206462;
	bh=PeJBnbIr24URC9PS3TjlV1fHTQHII9IDKtiWrdqGxwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGvy92dmG5LQzR0PADNW4wr8XNuwwNpRWfBt20lvm54yRjTVnIYpIUG8EoRtul/sN
	 IuQK90QQr9Rc8o4dBU9RTvG/3/kVJMs6jeESXvaIGG386BWNTDXiMWlP/qC9kVSA/n
	 NPmAkU5WTDVAOsYrph0yXVP7BwHk+E2f5f8C/3oz5brrnx3XHyVhomwxQFIButCfXY
	 2oNSaG+PuOGVVG69zs49kHiZKZ7CGNPZbpkct6SGqJeyitC3OJR+JF317mfk3aoIzd
	 IT/N9GgdiVisxZAE4lDmnURvmL6dJwv7wNcp02RmVfGk/VQWBRIe53dLsz9UQcdrjA
	 8uugbcg9Vxt0Q==
Date: Sun, 10 Dec 2023 11:07:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org,
 benjamin.tissoires@redhat.com, lars@metafoo.de,
 srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
Message-ID: <20231210110735.52f8dc53@jic23-huawei>
In-Reply-To: <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
	<4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Dec 2023 00:39:28 +0100
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> Hi everybody,
>=20
> On 2023-09-19 13:40:45+0530, Basavaraj Natikar wrote:
> > This series adds support for light color temperature and chromaticity.
> >=20
> > v1->v2:
> > *Rename the series.
> > *Rename als_illum to als channel as it supports other channels.
> > *Update patch description to include same reading for the two existing
> >  channels to use channel index to support more hub attributes.
> > *Keep line length under 80chars in hid-sensor-als.
> > *Add new channel type IIO_COLORTEMP.
> > *Update patch description and its subject to add channel type for=20
> >  chromaticity.=20
> >=20
> > Basavaraj Natikar (9):
> >   iio: hid-sensor-als: Use channel index to support more hub attributes
> >   iio: Add channel type light color temperature
> >   iio: hid-sensor-als: Add light color temperature support
> >   HID: amd_sfh: Add support for light color temperature
> >   HID: amd_sfh: Add support for SFH1.1 light color temperature
> >   iio: Add channel type for chromaticity
> >   iio: hid-sensor-als: Add light chromaticity support
> >   HID: amd_sfh: Add light chromaticity support
> >   HID: amd_sfh: Add light chromaticity for SFH1.1 =20
>=20
> This series is breaking probing of hid-sensor-als on Framework 13 AMD
> laptops [0].
> The problem is that the patches require hid-sensors-als sensors to also
> report chromaticity and color temparature which they don't.
Gah.  Missed that in review.  Sorry about that and thanks for digging into
this.
>=20
> When I remove the 'if (ret < 0) return ret;' checks in
> als_parse_report() probing works and the illuminance/intensity channels
> that show up behave as expected.
> Unfortunately this still leaves behind a bunch of unusable channels.
> A nice fix would be to have something like sysfs/hwmon .is_visible()
> callback but that's not supported by IIO.

It's tricky to do because there is no simple association between
what is registered as channels and the resulting attribute.  We could proba=
bly
make it work, but not a simple thing to do.

>=20
> One aproach would be to detect the usable channels in als_parse_report()
> and then adapt the indio_dev->channels based on that information.
>=20
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D218223

Agreed that adapting the channels is the way to go.
Easiest option probably to set the relevant masks to 0 if the chromacity and
temp channels aren't there + set their scan index values to -1.
That 'should' suppress any attributes being created.
Having a gap in scan indexes is common anyway so any userspace should cope
with the timestamp being after a gap.

Alternatives would be to rebuild the chan_spec array to not have the entrie=
s,
or pass in and fill in two copies of the array, picking the relevant one on=
ly
on discovering if the temp and chromacity channels are present.

Jonathan

>=20
> #regzbot introduced: 5f05285df691b1e82108eead7165feae238c95ef
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=3D218223
>=20


