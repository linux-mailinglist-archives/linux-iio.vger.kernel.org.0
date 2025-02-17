Return-Path: <linux-iio+bounces-15716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D07A38D42
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 21:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4637116D7F3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7623872E;
	Mon, 17 Feb 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBcWvdg4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5C236A6A;
	Mon, 17 Feb 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823811; cv=none; b=DUeifcGkIgmA+inEcPdyl/XOrEDXF5A6bWhSI/q6iV5yXS2NeLeBpOwPDNqOljzX8VPILhcVuXNqIecHuNbDqbTJUuoFTiwX408qnvoyIJ5CF2+jgzn6RcvA2hHUXMmRjlIzj2pkuH3/BQh4qG9uK8CtQI/Mhcmir5eUi4GdAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823811; c=relaxed/simple;
	bh=1h9MwvGIS8D5jPJQSFET2oluXayiIP8DbSxALxBuL8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTA/5InpS6dVIZAJlKjyxZPWI2VjmHrAxEUy5vF03DqmDHSr/o417Wq5C3bs9/Mus066VQm9UDkuoYKJOe+nVuKYqAcqZoblQ8AeWoD9yhGAb4NCExT+Uat3rvYvbbYnHZUJG9QGjj2SaqqIBDNwqKCfjP8Ulxq6EhAGhFwX+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBcWvdg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088A5C4CEE2;
	Mon, 17 Feb 2025 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739823811;
	bh=1h9MwvGIS8D5jPJQSFET2oluXayiIP8DbSxALxBuL8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kBcWvdg4s2XQVXU6tMvldOT8u0YGKV63N6m8lJhV3QDqOEWSeg6D4vtaAN26pNwt6
	 NytnIxoR0ic8cWTdqsIVUKDrUpCv4zJkoPimIximoeNAiNHnMZDKAyMxqXkczjptjE
	 jrkWvkspWfdKL+QB/7fq1c1pHkRW5g7g1dFRSy8OlriZQgN7piNjhYXsebazYVF0Dr
	 rp6zv95H3w0+q7GzYTFmvD02jmOWUC/LMDeh1659dg37mqAx7drvgs0btdoVzoyQru
	 OtkJ80OyUYwvrmolmhal8/aiODJsjcMYupW75NiS+ST2Yrg5UZXEiTDMeM4dR+xKA7
	 A82aVLtisto7g==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-724d1724657so3254168a34.0;
        Mon, 17 Feb 2025 12:23:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHDG1M/WdsHdf5pekjgMbqNQzf7N1rUP64URyYM1ZuBhzuV4XrAcNDTY35wuy8hK7BWvTbbxgfBPE=@vger.kernel.org, AJvYcCXLm9Tgz/0xgt9pUHiy6UGnqDEpIwGrCwGnBy5HQNyQ51eNQt2UUG8T76FWJ0Yjy2tqEjzhNAmtM7Mo/Nak@vger.kernel.org, AJvYcCXlazXg4oYl0sWm5dGfPusLsaAB5IpZUYJZC2Chgjmy6oom6yYBrpA2bmdQY+Uwnsb+iF+YMWoT6Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6Ht00FOWNj7/Ko6VnettD5t4d7WEQJZ6LlAnZyqOGK6B453v
	3bb3Y8hKFv1/UNuvLfC8BLnIOg/F2le+2UH2e+JrgJ2MQYPXNhbniO8sBb8cXZJLrvrx49j/xyw
	IzlBZofcAjhak+wqSamLo1kmKp9w=
X-Google-Smtp-Source: AGHT+IGPh9FNrtXp3FggoEQw9aKUrDogGptSwF6VujHcw64guqZFeUK2vTL7g5FzrFK09nm4jP3iMmPGT9ohbNt/nqw=
X-Received: by 2002:a05:6808:2dcf:b0:3f3:fc36:25b7 with SMTP id
 5614622812f47-3f3fc362819mr4062729b6e.19.1739823810284; Mon, 17 Feb 2025
 12:23:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com> <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com> <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com> <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com> <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com> <Z7Kx2RN35QVyg8nP@google.com>
In-Reply-To: <Z7Kx2RN35QVyg8nP@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Feb 2025 21:23:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>
X-Gm-Features: AWEUYZlAjLzs6ezGg8wnligAVPSRXEI9eSmLi9kBikLyhpmKJuoOqGOdrVjLyt4
Message-ID: <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>
Subject: Re: PM runtime_error handling missing in many drivers?
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Brian Norris <briannorris@google.com>, 
	Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Joy Chakraborty <joychakr@google.com>, Vamshi Gajjela <vamshigajjela@google.com>, 
	Manu Gautam <manugautam@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 4:49=E2=80=AFAM Ajay Agarwal <ajayagarwal@google.co=
m> wrote:
>
> On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 11, 2025 at 11:21=E2=80=AFPM Brian Norris <briannorris@goog=
le.com> wrote:
> > >
> > > Hi Ajay,
> > >
> > > On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > > > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com>=
 wrote:
> > > > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > > > Well, in general suspending or resuming a device is a collabo=
rative
> > > > > > > effort and if one of the pieces falls over, making it work ag=
ain
> > > > > > > involves fixing up the failing piece and notifying the others=
 that it
> > > > > > > is ready again.  However, that part isn't covered and I'm not=
 sure if
> > > > > > > it can be covered in a sufficiently generic way.
> > > > > >
> > > > > > True. But that still cannot solve the question what is to be do=
ne
> > > > > > if error handling fails. Hence my proposal:
> > > > > > - record all failures
> > > > > > - heed the record only when suspending
> > > > >
> > > > > I guess that would boil down to moving the power.runtime_error up=
date
> > > > > from rpm_callback() to rpm_suspend()?
> > > > Resuming this discussion. One of the ways the device drivers are
> > > > clearing the runtime_error flag is by calling pm_runtime_set_suspen=
ded
> > > > [1].
> >
> > I personally think that jumping on a 2.5 years old thread is not a
> > good idea.  It would be better to restate the problem statement and
> > provide the link to the previous discussion.
> >
> > > > To me, it feels weird that a device driver calls pm_runtime_set_sus=
pended
> > > > if the runtime_resume() has failed. It should be implied that the d=
evice
> > > > is in suspended state if the resume failed.
> > > >
> > > > So how really should the runtime_error flag be cleared? Should ther=
e be
> > > > a new API exposed to device drivers for this? Or should we plan for=
 it
> > > > in the framework itself?
> > >
> > > While the API naming is unclear, that's exactly what
> > > pm_runtime_set_suspended() is about. Personally, I find it nice when =
a
> > > driver adds the comment "clear runtime_error flag", because otherwise
> > > it's not really obvious why a driver has to take care of "suspending"
> > > after a failed resume. But that's not the biggest question here, IMO.
> > >
> > > The real reson I pointed you at this thread was because I think it's
> > > useful to pursue the proposal above: to avoid setting a persistent
> > > "runtime_error" for resume failures. This seems to just create a pitf=
all
> > > for clients, as asked by Vincent and Oliver upthread.
> > >
> > > And along this line, there are relatively few drivers that actually
> > > bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> > > ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
> > > fails")).
> > >
> > > So to me, we should simply answer Rafael's question:
> > >
> > > (repeated:)
> > > > > I guess that would boil down to moving the power.runtime_error up=
date
> > > > > from rpm_callback() to rpm_suspend()?
> > >
> > > Yes, I think so. (Although I'm not sure if this leaves undesirable sp=
am
> > > where persistent .runtime_resume() failures occur.)
> > >
> > > ...and then write/test/submit such a patch, provided it achieves the
> > > desired results.
> > >
> > > Unless of course one of the thread participants here has some other
> > > update in the intervening 2.5 years, or if Rafael was simply asking t=
he
> > > above rhetorically, and wasn't actually interested in fielding such a
> > > change.
> >
> > The reason why runtime_error is there is to prevent runtime PM
> > callbacks from being run until something is done about the error,
> > under the assumption that running them in that case may make the
> > problem worse.
> >
> > I'm not sure if I see a substantial difference between suspend and
> > resume in that respect: If any of them fails, the state of the device
> > is kind of unstable.  In particular, if resume fails and the device
> > doesn't actually resume, something needs to be done about it or it
> > just becomes unusable.
> >
> > Now, the way of clearing the error may not be super-convenient, which
> > was a bit hard to figure out upfront, so I'm not against making any
> > changes as long as there are sufficient reasons for making them.
>
> I am thinking if we can start with a change to not check runtime_error
> in rpm_resume, and let it go through even if the previous rpm_resume
> attempt failed. Something like this:
>
> ```
> static int rpm_resume(struct device *dev, int rpmflags)
>         trace_rpm_resume(dev, rpmflags);
>
>   repeat:
> -       if (dev->power.runtime_error) {
> -               retval =3D -EINVAL;
> -       } else if (dev->power.disable_depth > 0) {
> +       if (dev->power.disable_depth > 0) {
>                 if (dev->power.runtime_status =3D=3D RPM_ACTIVE &&
>                     dev->power.last_status =3D=3D RPM_ACTIVE)
>                         retval =3D 1;
> ```
>
> I think setting the runtime_error in rpm_callback, i.e. for both resume
> and suspend is still a good idea for book-keeping purposes, e.g. the
> user reading the runtime_status of the device from sysfs.

What would be the benefit of this change?

