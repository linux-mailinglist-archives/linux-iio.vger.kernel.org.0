Return-Path: <linux-iio+bounces-1944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28DD83EDD3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231721C21235
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAA28DC6;
	Sat, 27 Jan 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKTPvrHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C2208B2;
	Sat, 27 Jan 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368527; cv=none; b=DuC9g7oYBYAaAD1ouwyVD7BEflawfkVnIa4D1vorCatrs09aSM7ActSkHqZJ+JYgim3JdtiYdcg4WeL3TRx3pTiaEeSBAcQXT+TmxDYr8dYD5iMZJgkuxAfbmCSPv+kTtctHOOXeNVeL8xxlBPFyLxFBs8MWaz71FkGRnV0dHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368527; c=relaxed/simple;
	bh=2nCW0EZczJhkVrTmPaxsjY9nXHnDMKt0t9dEyAfMlGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkIWu0olUgZOMWkNp/7PjTCuqxyZ5JLY3El7cgx1HO8dCJNr3BMQEKTMYcmgXvYXRtO8ugs/hJ+x5BdlobszrjLWPOoYPsgh3kaXQ/pnc8NjjjDPHqCY+j04RAOIHq8BVJ9G+o3o1Q4bX1oAm7rEDTVrTSuvlkyeANaRO8530mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKTPvrHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B654C433C7;
	Sat, 27 Jan 2024 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706368526;
	bh=2nCW0EZczJhkVrTmPaxsjY9nXHnDMKt0t9dEyAfMlGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kKTPvrHBHqHCOCYa/e53PZ4rzllmFAWS5PLkC1VLxRt76PbiFdamzXJd2ziC9aqHQ
	 I3LuIzu+BxHfkDVw8EHGB3YZbd2hA40veiQZ233jw3WqGKZvA4nsWo5AwHR/1ii7ug
	 BZ+IqzMIawHrLcJxAMavoZ2Fm2DI2axxdG47ugdAOa7ixDFMIGQYbcPKt6eCvqOsQ3
	 HqCfjAuFYZkPp8KEprt2JMCVM+SyfgSBsZUHfmfFU2h1qjOxMUefE4e3knhdzk2ROF
	 7mz7nWNeVWPcWOGAqB1mVO6T9Guc8uaNWGCIpmfvrWMCVcRd//SIJCbmc2A9TuREA4
	 syQGVwj71SHdw==
Date: Sat, 27 Jan 2024 15:15:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan
 <saravanak@google.com>, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v7 4/9] driver: core: allow modifying device_links flags
Message-ID: <20240127151511.4763cd61@jic23-huawei>
In-Reply-To: <f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	<20240123-iio-backend-v7-4-1bff236b8693@analog.com>
	<CAGETcx8_0ExTG4ASb9xK-uwmubMFDx44_wUf1h3VsO8w9jJApQ@mail.gmail.com>
	<8eae083af481441d83df02a1880e2aedf99efdfb.camel@gmail.com>
	<ef59aaa2a251e92d463d8983ab6eec459298c102.camel@gmail.com>
	<CAJZ5v0iHJpvzrNSB4XEYxbTN+kQ6G_NXYrK4Z17WiFOTYDbm9w@mail.gmail.com>
	<ff0b5a9362061fb6969099bc7ae6a0b43707968f.camel@gmail.com>
	<f6cfd587242001326ea6fdb9678359c1289202e5.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 15:26:08 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-01-26 at 09:04 +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-01-25 at 17:57 +0100, Rafael J. Wysocki wrote: =20
> > > On Thu, Jan 25, 2024 at 4:31=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote: =20
> > > >=20
> > > > On Thu, 2024-01-25 at 09:14 +0100, Nuno S=C3=A1 wrote: =20
> > > > >=20
> > > > > Hi Saravana,
> > > > >=20
> > > > > Thanks for your feedback,
> > > > >=20
> > > > > On Wed, 2024-01-24 at 19:21 -0800, Saravana Kannan wrote: =20
> > > > > > On Tue, Jan 23, 2024 at 7:14=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > > > > > >=20
> > > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > > >=20
> > > > > > > If a device_link is previously created (eg: via
> > > > > > > fw_devlink_create_devlink()) before the supplier + consumer a=
re both
> > > > > > > present and bound to their respective drivers, there's no way=
 to set
> > > > > > > DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks t=
o allow
> > > > > > > for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> > > > > > > DL_FLAG_AUTOREMOVE_SUPPLIER is done. =20
> > > > > >=20
> > > > > > Curious, why do you want to set DL_FLAG_AUTOREMOVE_CONSUMER?
> > > > > > Especially if fw_devlink already created the link? You are effe=
ctively
> > > > > > trying to delete the link fw_devlink created if any of your dev=
ices
> > > > > > unbind.
> > > > > >  =20
> > > > >=20
> > > > > Well, this is still useful in the modules case as the link will be
> > > > > relaxed
> > > > > after
> > > > > all devices are initialized and that will already clear
> > > > > AUTOPROBE_CONSUMER
> > > > > AFAIU. But, more importantly, if I'm not missing anything, in [1],
> > > > > fw_devlinks
> > > > > will be dropped after the consumer + supplier are bound which mea=
ns I
> > > > > definitely
> > > > > want to create a link between my consumer and supplier.
> > > > >  =20
> > > >=20
> > > > Ok, so to add a bit more on this, there are two cases:
> > > >=20
> > > > 1) Both sup and con are modules and after boot up, the link is rela=
xed and
> > > > thus
> > > > turned into a sync_state_only link. That means the link will be del=
eted
> > > > anyways
> > > > and AUTOPROBE_CONSUMER is already cleared by the time we try to cha=
nge the
> > > > link.
> > > >=20
> > > > 2) The built-in case where the link is kept as created by fw_devlin=
k and
> > > > this
> > > > patch effectively clears AUTOPROBE_CONSUMER.
> > > >=20
> > > > Given the above, not sure what's the best option. I can think of 4:
> > > >=20
> > > > 1) Drop this patch and leave things as they are.
> > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > is
> > > > pretty much ignored in my call but it will turn the link in a MANAG=
ED one
> > > > and
> > > > clear SYNC_STATE_ONLY. I could very well just pass 0 in the flags as
> > > > DL_FLAG_AUTOREMOVE_CONSUMER is always ignored;
> > > >=20
> > > > 2) Rework this patch so we can still change an existing link to acc=
ept
> > > > DL_FLAG_AUTOREMOVE_CONSUMER (in the modules case for example).
> > > >=20
> > > > However, instead of clearing AUTOPROBE_CONSUMER, I would add some c=
hecks
> > > > so
> > > > if
> > > > flags have one of DL_FLAG_AUTOREMOVE_SUPPLIER or
> > > > DL_FLAG_AUTOREMOVE_CONSUMER
> > > > and
> > > > AUTOPROBE_CONSUMER is already set, we ignore them. In fact, right n=
ow, I
> > > > think
> > > > one could pass DL_FLAG_AUTOREMOVE_SUPPLIER and link->flags ends ups=
 with
> > > > AUTOREMOVE_SUPPLIER | AUTOPROBE_CONSUMER which in theory is not all=
owed... =20
> > >=20
> > > No, because DL_FLAG_AUTOREMOVE_SUPPLIER is only added to the link
> > > flags if DL_FLAG_AUTOREMOVE_CONSUMER is already set in there and the
> > > former replaces the latter.
> > >  =20
> >=20
> > Oh yes, I missed that extra if() against the DL_FLAG_AUTOREMOVE_CONSUMER
> > flag...
> >  =20
> > > Now, DL_FLAG_AUTOREMOVE_CONSUMER cannot be set in the link flags if
> > > AUTOPROBE_CONSUMER is set in there.
> > >  =20
> > > > 3) Keep it as-is... This one is likely a NACK as I'm getting the fe=
eling
> > > > that
> > > > clearing stuff that might have been created by fw_devlinks is proba=
bly a
> > > > no-
> > > > go.
> > > >=20
> > > > Let me know your thoughts... =20
> > >=20
> > > If the original creator of the link didn't indicate either
> > > DL_FLAG_AUTOREMOVE_CONSUMER, or DL_FLAG_AUTOREMOVE_SUPPLIER, they are
> > > expected to need the link to stay around until it is explicitly
> > > deleted.
> > >=20
> > > Therefore adding any of these flags for an existing link where they
> > > both are unset would be a mistake, because it would effectively cause
> > > the link to live shorter than expected by the original creator and
> > > that might lead to correctness issues.
> > >=20
> > > Thanks! =20
> >=20
> > Thanks Rafael, your last two paragraphs make it really clear what's the
> > reasoning and why this patch is wrong.
> >=20
> > Jonathan, if nothing else comes that I need a re-spin, can you drop thi=
s patch
> > when applying?
> >=20
> > I think we can keep the DL_FLAG_AUTOREMOVE_CONSUMER in the device_link_=
add()
> > call as it will be ignored if fw_devlinks already created the link but =
might
> > be
> > important if the kernel command line fw_devlink is set to 'off'.
> >=20
> > Or maybe, as Saravan mentioned in his reply we can just pass DL_FLAG_MA=
NAGED
> > as =20
>=20
> Forget about this as I just realized DL_FLAG_MANAGED is not a proper flag=
 we can
> pass...
>=20
> - Nuno S=C3=A1
>=20

Discussion has gotten too complex - so even if no changes, send a v8 droppi=
ng
the patch (assuming that's the end conclusion!)

Jonathan



