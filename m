Return-Path: <linux-iio+bounces-15731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C4A3A0A1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870483A06BC
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9F26A1A6;
	Tue, 18 Feb 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6iQfzLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9133286A1;
	Tue, 18 Feb 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890636; cv=none; b=jqsFqXksUAtBP03CywRmC3LnNJou16w2SIrUkYQWMWl4jaF1JrUZL/po9r/kj1Pe4lvkWQFYS7WTYQXmwVdLOE4TnOzltca95ykOTAihVwnrms0iVxxaoR9IDjD4GR3BPe/Pj8JIX/qTFOqnq7u7lJCxb1bpGLs49MFnPRHK7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890636; c=relaxed/simple;
	bh=y6PQRfjBS+mS7HSba5c7UKJ5vARgt/PWT3P3iOWvpPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+TgGQTVIi38zu6en3sqOjccm0NBKe24nJCyjFAW1Fhmz4/FlVZGSGfUL/wbh+G0AcIpxBXgX17g3xXnTMou36tB8G7BdAsVrw8vl+dS8utQ3fyttW5uwfoJkqXlx1FGs0SrbJTA+iXRCwgnrmdb2rB2+pXIk7VlcaDxqsevxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6iQfzLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632E0C4CEE8;
	Tue, 18 Feb 2025 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739890635;
	bh=y6PQRfjBS+mS7HSba5c7UKJ5vARgt/PWT3P3iOWvpPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l6iQfzLiHSkr7jjPEFhE5PcC9VYk+79ojLIPRGxKSrHERDemSiG8mPFPu/dEl/yZl
	 luvSCceoIWoD0Na8RgQVr5Mwy3ooOTXrVopzlwOixi6W1NCgZWV3RNh7wyPQpKE+zU
	 cQqYp/PYMmi7oMhlISDxPkEZtRVLFGbZc2+QHnaLMIxKz8lPQRSCi5MElPsCq/ymNt
	 C0sRVZytFbyLgUiKgVDfri2aZrPvvdKkI8Cv+/cdUOpJkRAsddYtxRBXr9tnZvfgrQ
	 W01Qk6r8l7RHaZw78li3dB9QA0yQ2+StCY/TvDOn0s7izB+qgX5Z4IG461AorXrO4j
	 TnJFKuS59yxxg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f3f716cc9eso1026031b6e.3;
        Tue, 18 Feb 2025 06:57:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0tRlc8nv962+tvgBBpKVgNneKrOfkFAgFcnHDegnDJwRUxc0AGHzi3+JIEpVzIfUWKbqHtTXJ1VUsOnYU@vger.kernel.org, AJvYcCVXeiuL2gizZRhRdGgUvMQ9I7KwSkwOjye/ErfWACH/y55gCGz3fyAF9tm4mNmGGZqX89xTpP2WXMY=@vger.kernel.org, AJvYcCXEdYSagSJe8xRP8d7LLUI3eaCdMrGs04tlMFyd261SbC40+BaaV0yLI9Scf+BuPyckTjTNVrY7tzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWqqozmastQHzE6tsNOO5G0+VZCLCxaW6/SGwcqyeX+abb0ms
	ThV9mX+oGYylfVlPYLq/Ek9PzVXgowLRGWslGWWLZSxugiKZmjC5fkNuUCTcoAsbQJ1rU+//udU
	g/MbLF99b26OcZSKetxcutOzHqTw=
X-Google-Smtp-Source: AGHT+IE8fgoiRfJ787MXWdmjiMpFKNo8wJySKZCDPYdwOTP8ZsLMPziuCl4HxL+uaG5emVQzOTrtwk6YOyCI90nDR5Y=
X-Received: by 2002:a05:6808:200c:b0:3f4:85c:2b60 with SMTP id
 5614622812f47-3f4085c2e00mr2043387b6e.26.1739890634689; Tue, 18 Feb 2025
 06:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com> <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com> <Z6vNV8dDDPdWUKLS@google.com>
 <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
 <Z7Kx2RN35QVyg8nP@google.com> <CAJZ5v0hom5Ex9xCfd_qD7XyFxie1iy2L_T8vDNWF-xBMmq=9aQ@mail.gmail.com>
 <Z7QcjvKRGKgrI8EC@google.com> <Z7QehEhw3uM176tW@google.com>
In-Reply-To: <Z7QehEhw3uM176tW@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 15:57:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hTVtu0qL6o=v_fkzPFSixak-L=-T663W6fm2E_H6xG8Q@mail.gmail.com>
X-Gm-Features: AWEUYZmPsk8GDftnk7dvIftq7AaGckjVxEF_Tf5hGqe-wU9-8bX8XM33El6WPeY
Message-ID: <CAJZ5v0hTVtu0qL6o=v_fkzPFSixak-L=-T663W6fm2E_H6xG8Q@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 6:45=E2=80=AFAM Ajay Agarwal <ajayagarwal@google.co=
m> wrote:
>
> On Tue, Feb 18, 2025 at 11:07:19AM +0530, Ajay Agarwal wrote:
> > On Mon, Feb 17, 2025 at 09:23:18PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Feb 17, 2025 at 4:49=E2=80=AFAM Ajay Agarwal <ajayagarwal@goo=
gle.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 08:29:34PM +0100, Rafael J. Wysocki wrote:
> > > > > On Tue, Feb 11, 2025 at 11:21=E2=80=AFPM Brian Norris <briannorri=
s@google.com> wrote:
> > > > > >
> > > > > > Hi Ajay,
> > > > > >
> > > > > > On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > > > > > > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki w=
rote:
> > > > > > > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@sus=
e.com> wrote:
> > > > > > > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > > > > > > Well, in general suspending or resuming a device is a c=
ollaborative
> > > > > > > > > > effort and if one of the pieces falls over, making it w=
ork again
> > > > > > > > > > involves fixing up the failing piece and notifying the =
others that it
> > > > > > > > > > is ready again.  However, that part isn't covered and I=
'm not sure if
> > > > > > > > > > it can be covered in a sufficiently generic way.
> > > > > > > > >
> > > > > > > > > True. But that still cannot solve the question what is to=
 be done
> > > > > > > > > if error handling fails. Hence my proposal:
> > > > > > > > > - record all failures
> > > > > > > > > - heed the record only when suspending
> > > > > > > >
> > > > > > > > I guess that would boil down to moving the power.runtime_er=
ror update
> > > > > > > > from rpm_callback() to rpm_suspend()?
> > > > > > > Resuming this discussion. One of the ways the device drivers =
are
> > > > > > > clearing the runtime_error flag is by calling pm_runtime_set_=
suspended
> > > > > > > [1].
> > > > >
> > > > > I personally think that jumping on a 2.5 years old thread is not =
a
> > > > > good idea.  It would be better to restate the problem statement a=
nd
> > > > > provide the link to the previous discussion.
> > > > >
> > > > > > > To me, it feels weird that a device driver calls pm_runtime_s=
et_suspended
> > > > > > > if the runtime_resume() has failed. It should be implied that=
 the device
> > > > > > > is in suspended state if the resume failed.
> > > > > > >
> > > > > > > So how really should the runtime_error flag be cleared? Shoul=
d there be
> > > > > > > a new API exposed to device drivers for this? Or should we pl=
an for it
> > > > > > > in the framework itself?
> > > > > >
> > > > > > While the API naming is unclear, that's exactly what
> > > > > > pm_runtime_set_suspended() is about. Personally, I find it nice=
 when a
> > > > > > driver adds the comment "clear runtime_error flag", because oth=
erwise
> > > > > > it's not really obvious why a driver has to take care of "suspe=
nding"
> > > > > > after a failed resume. But that's not the biggest question here=
, IMO.
> > > > > >
> > > > > > The real reson I pointed you at this thread was because I think=
 it's
> > > > > > useful to pursue the proposal above: to avoid setting a persist=
ent
> > > > > > "runtime_error" for resume failures. This seems to just create =
a pitfall
> > > > > > for clients, as asked by Vincent and Oliver upthread.
> > > > > >
> > > > > > And along this line, there are relatively few drivers that actu=
ally
> > > > > > bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> > > > > > ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_g=
et()
> > > > > > fails")).
> > > > > >
> > > > > > So to me, we should simply answer Rafael's question:
> > > > > >
> > > > > > (repeated:)
> > > > > > > > I guess that would boil down to moving the power.runtime_er=
ror update
> > > > > > > > from rpm_callback() to rpm_suspend()?
> > > > > >
> > > > > > Yes, I think so. (Although I'm not sure if this leaves undesira=
ble spam
> > > > > > where persistent .runtime_resume() failures occur.)
> > > > > >
> > > > > > ...and then write/test/submit such a patch, provided it achieve=
s the
> > > > > > desired results.
> > > > > >
> > > > > > Unless of course one of the thread participants here has some o=
ther
> > > > > > update in the intervening 2.5 years, or if Rafael was simply as=
king the
> > > > > > above rhetorically, and wasn't actually interested in fielding =
such a
> > > > > > change.
> > > > >
> > > > > The reason why runtime_error is there is to prevent runtime PM
> > > > > callbacks from being run until something is done about the error,
> > > > > under the assumption that running them in that case may make the
> > > > > problem worse.
> > > > >
> > > > > I'm not sure if I see a substantial difference between suspend an=
d
> > > > > resume in that respect: If any of them fails, the state of the de=
vice
> > > > > is kind of unstable.  In particular, if resume fails and the devi=
ce
> > > > > doesn't actually resume, something needs to be done about it or i=
t
> > > > > just becomes unusable.
> > > > >
> > > > > Now, the way of clearing the error may not be super-convenient, w=
hich
> > > > > was a bit hard to figure out upfront, so I'm not against making a=
ny
> > > > > changes as long as there are sufficient reasons for making them.
> > > >
> > > > I am thinking if we can start with a change to not check runtime_er=
ror
> > > > in rpm_resume, and let it go through even if the previous rpm_resum=
e
> > > > attempt failed. Something like this:
> > > >
> > > > ```
> > > > static int rpm_resume(struct device *dev, int rpmflags)
> > > >         trace_rpm_resume(dev, rpmflags);
> > > >
> > > >   repeat:
> > > > -       if (dev->power.runtime_error) {
> > > > -               retval =3D -EINVAL;
> > > > -       } else if (dev->power.disable_depth > 0) {
> > > > +       if (dev->power.disable_depth > 0) {
> > > >                 if (dev->power.runtime_status =3D=3D RPM_ACTIVE &&
> > > >                     dev->power.last_status =3D=3D RPM_ACTIVE)
> > > >                         retval =3D 1;
> > > > ```
> > > >
> > > > I think setting the runtime_error in rpm_callback, i.e. for both re=
sume
> > > > and suspend is still a good idea for book-keeping purposes, e.g. th=
e
> > > > user reading the runtime_status of the device from sysfs.
> > >
> > > What would be the benefit of this change?
> > The benefit would be that the runtime_resume would be re-attempted even=
 if
> > the previous attempt failed.
>
> Actually, I wanted to propose the removal of `runtime_error` flag
> completely from the code.

Why?

> But it sounded too disruptive to me. Hence, I
> proposed the milder patch of removal of `runtime_error` check from
> rpm_resume so that the drivers do not have to call
> `pm_runtime_set_suspended` explicitly.
>
> Basically, we still do not have a good solution for the situation where
> one of the ancestors fails to resume.

If an ancestor fails to resume, runtime_error is not set for the
device at hand.  rpm_resume() returns -EBUSY without setting
runtime_error in that case.

> We do not know how to make the
> ancestor working again.

That's true, but poking at it again and again may not work either.

> But I guess a re-attempt is better than not
> doing anything about it?

I would start with changing rpm_callback() to avoid setting
runtime_error if the retval is -EBUSY or -EAGAIN, to make rpm_resume()
work consistently with rpm_suspend() in that respect.  Then, no
corrective action would be needed after returning one of these from
the callback.  I'll send a patch for this shortly.

-EACCES is kind of a grey area.  It is converted to -EIO, but then it
indicates an error that can be corrected outside the driver and is not
related to the hardware, so it should be OK to avoid setting
runtime_error in that case either, but then it might be better to
convert it to -EAGAIN.

Returning any other error codes indicates a hardware issue, however,
and those should be corrected by the driver handling the given piece
of hardware.

