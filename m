Return-Path: <linux-iio+bounces-21966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E823AB10A6A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416DE5464B9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242A2D3747;
	Thu, 24 Jul 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZCRtDh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0862D373F;
	Thu, 24 Jul 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360781; cv=none; b=LsCi7aj3JYjVBgUgsn1aR1mWtjlZLCsFVgBhwCXKromKdzED05kkM+R4x0eUIQsoev0/EYAmJrIpHHUeucyzotL5iDkfjFKxMOPabGo8+YZRtPWrKdak3hlI5gppvwfwn41tajQuZYHxgDrFYiUHLD2H1fayf6TnYXDcu7znr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360781; c=relaxed/simple;
	bh=Js6r1tJ+kSkB+fzMuC4uUHSR+dKl+NwgaFkENzJxIh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkPSaWkeWY9BhOkW+rx0ZBE8yR+iWlo57OOtrQ56+X8Ye6fOzLlO3SHD/lqd+ds55f/SZCJiZdMEwZ469aVtHXcFQIYo1FseSdJeDiwIE1NS+3mol3uyvDw+9H221ELE5IDmgxD3WPSQqTWN5MvYUAKqnPT2SVx0EHRVazYywDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZCRtDh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71150C4CEEF;
	Thu, 24 Jul 2025 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360781;
	bh=Js6r1tJ+kSkB+fzMuC4uUHSR+dKl+NwgaFkENzJxIh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZCRtDh1tMCqgSt9Va6aivHfiHJTAxvNmvsp6xy489RYbbZonSiImkurcp8g0HIme
	 03hWz+FY88v3Yj9cqlmxbRLqKg18Dm3c/F1kCfTWn2g8vhzbBC7fNACKOcEoLiDzT4
	 GFjoYez2uVVRp6yqng/BvALSQyVSjMCii6iV9VnWU0y3HcBJyrx4K7LlpO2W0U5JRY
	 QlgYauzf6zd3M1mOfmAcrHimGHW8qAGVPEviofvCY0JkL85l1HTiRzGqApbNtRLnvv
	 rKRoaten4Hq4d1rh8jvcLeqARpHGSMg5QpuuE8NQyFBSYXgSSI7NUYOrWF7YnfiPwo
	 CrFcGlXGE7Tdg==
Date: Thu, 24 Jul 2025 13:39:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
Message-ID: <20250724133933.220d00e4@jic23-huawei>
In-Reply-To: <8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com>
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
	<a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
	<CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
	<8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 16:15:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/21/25 10:55 PM, Akshay Jindal wrote:
> > Thanks David for the swift and valuable feedback. Please find replies i=
nline.
> >=20
> > On Tue, Jul 22, 2025 at 1:55=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote: =20
> >>
> >> For debugging, using debugfs would make more sense. =20
> > Will it make sense if I simply give register access via debugfs?
> > Something like this:
> > static const struct iio_info ad7606_info_sw_mode =3D {
> >     .read_raw =3D &ad7606_read_raw,
> >     .write_raw =3D &ad7606_write_raw,
> >     .debugfs_reg_access =3D &ad7606_reg_access,<---------
> >     .validate_trigger =3D &ad7606_validate_trigger,
> >     .update_scan_mode =3D &ad7606_update_scan_mode,
> > };
> > This way the information about data status will be available on demand,
> > without exposing any special sysfs attribute. =20
>=20
> Yes, this would be fine.
>=20
> >>
> >> For application level filtering, why does it matter if we have
> >> read the same value before or not? The sampling_frequency is
> >> available, so the application should be able to deduce when
> >> fresh data should be available based on time. =20
> > Agreed. =20
> >>
> >> I could see maybe polling this in the kernel in order to implement
> >> a buffered capture mode, but not sure passing this on to userspace
> >> is the best way to go about it. =20
> > I had sent 2 patches. This was my PATCH 1 of 2. In patch 2 of 2,
> > I have done something similar to what you mentioned, not exactly pollin=
g, =20
>=20
> Here is what the IIO docs have to say about it (reading the in_light_raw
> attribute is considered INDIO_DIRECT_MODE):
>=20
>  * @INDIO_DIRECT_MODE: There is an access to either:
>  * a) The last single value available for devices that do not provide
>  *    on-demand reads.
>  * b) A new value after performing an on-demand read otherwise.
>  * On most devices, this is a single-shot read. On some devices with data
>  * streams without an 'on-demand' function, this might also be the 'last =
value'
>  * feature. Above all, this mode internally means that we are not in any =
of the
>  * other modes, and sysfs reads should work.
>  * Device drivers should inform the core if they support this mode.
>=20
> So I don't think the current implementation is really in violation
> of this.
>=20
> Additionally, changes you proposed in patch 2/2 would break existing
> users by returning an error when it didn't used to, so we couldn't
> accept that.
>=20
> If this was a new driver, we might consider having the raw read
> poll for fresh data so that each read was guaranteed to be new
> data, but even that change in timing could break existing users,
> so probably not something we would want to do now.
>=20
>=20
> I still think there is a reasonable workaround of just having userspace
> wait for the sample period between reads to guarantee fresh data
> without changing the driver at all.
>=20

Agreed.  Is the interrupt wired on this board?  If it is and you
want to do filtering with the knowledge that the data is fresh then
add a data ready trigger and buffered capture support.
It's a much bigger job, but it is standard ABI and as such of more
general use.

Jonathan


>=20
> > but reading the data status bit before reading actual data.
> > Both patches are independent. Please have a look at that as well.
> >=20
> > Thanks,
> > Akshay =20
>=20
>=20


