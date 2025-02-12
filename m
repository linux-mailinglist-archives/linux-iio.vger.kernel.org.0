Return-Path: <linux-iio+bounces-15476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB0A32FAD
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0233A50A4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4147262814;
	Wed, 12 Feb 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNGelLin"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3491DEFDD;
	Wed, 12 Feb 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388586; cv=none; b=jqFnJzhTJ8P6wwWzyZJrRbGN/jQxY3BpHsYIMOW5IfMA+uILjoP48cio6O2AdeybdSkfcPRQMVCzBaVENDnfrYNNsm0firORiRzog6YRhPZBtxUQnpkr63VfbNp3JuIZIpnpe2ubSaML+CB3gVeWvxajuHMwkPetJm3XGcD9GWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388586; c=relaxed/simple;
	bh=Sq2mdjjVXHCvdecbhWDPkmqbNJgIoFdbEeglMcDtF4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1r3Su/Mv+q8FYY6H+1QPpvBoVI7B97ODLbByKO/lW6VQDfbTmIjWH8xOqgM2lj30xqNR6wFZZwp+QuS0ntn6gd4m1Q6cCV9AkbznQQdibFkuJmsSvlV9zTuy2Qd/0Xn+O7pF+uTDsUNJzABx6Yj3KsvOXkEXPv+zZhcr8/iulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNGelLin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2780EC4CEDF;
	Wed, 12 Feb 2025 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739388586;
	bh=Sq2mdjjVXHCvdecbhWDPkmqbNJgIoFdbEeglMcDtF4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNGelLinKWa3yJy/UL3Ohy2rSRXh4sIgw/80eeeCmQm45xAOu2hrWZ3A0efiSxwwI
	 hfeJF3pen8MXcQHO8bjcHb6BWlWPqthbSWIN1j1hUTCse/g5PFwhsqqQyqCu77SrgG
	 CwLVJaI4KhEk1uECiX/Z75naPpWTzaS06IQGqMntKprtedTtyD8qqMQtxYtKq7Zj1U
	 Ps5YRxj1bsU8PGHfhv6Sb5iIMrU/I/RIvzt6uiMvTgt3VceqBZHX14EIuqZ8SKNM/R
	 pPasJ7vAvsyTUkGsvHqsT/StGCLpXTxpMzGC5Rtyosvul8GNCgTKAKBdyakSqy2Qbb
	 9dHmUj0bfjEVg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fcad6dbc73so60920eaf.3;
        Wed, 12 Feb 2025 11:29:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdKFaKV74MW14g3BPq7fEctHPEmNr0Alr5XtW5je1aKUdtp+gcOe5idDm7X62+q5g0cxkLT4v5F4Z9BlXy@vger.kernel.org, AJvYcCVOfPniTOiWc+d1e6XPQrsWR9q2CiYVdoPUd7s7h3oWCF/7/D6HfRemeIYPAb8/In4MxRSagUEgbV8=@vger.kernel.org, AJvYcCXpj/sGLqI1qlDo3aB+cgDaBq4p/GgSn390LfkjPCWO3y85V353N6C7/JFr4lP3ZDnFkH/50BJTQJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYZ7qKrsarUCmme6bAYZ35/hinYD4K/7Dd4oOqq8zAJOnUe58
	HuQlteZnUqzOa/ZQPNlPlw8cTcw7MVhweD1oGyjcMoMSv0PgXY+08ZF4T7ftFxVid5krEKNnwKu
	qplHdB3BcJeCaO9r+aauNXthfNNU=
X-Google-Smtp-Source: AGHT+IFH0LFzIaVbHxzQmkxG28Ku3hRsFYi5/u37pvluWcr1gxWGDY+jNPKRzZuWpBlZEk08St3O8rnU0ZCabSz2gAE=
X-Received: by 2002:a05:6870:fb87:b0:2b8:3d8c:15ad with SMTP id
 586e51a60fabf-2b8dac927acmr2322300fac.1.1739388585467; Wed, 12 Feb 2025
 11:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220620144231.GA23345@axis.com> <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com> <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com> <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
 <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com> <CAJZ5v0ijy4FG84xk_n8gxR_jS0xao246eVbnFj-dXzwz=8S9NQ@mail.gmail.com>
 <Z6lzWfGbpa7jN1QD@google.com> <Z6vNV8dDDPdWUKLS@google.com>
In-Reply-To: <Z6vNV8dDDPdWUKLS@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 20:29:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
X-Gm-Features: AWEUYZmhW5ok-2DBVnS1_g02ioOjQJzY8xCt2BGdeeXG0jyqtGs2qrNxSO61FRI
Message-ID: <CAJZ5v0i83eJWV_kvWxZvja+Js3tKbrwZ8rVVGn7vR=0qLf1mtw@mail.gmail.com>
Subject: Re: PM runtime_error handling missing in many drivers?
To: Brian Norris <briannorris@google.com>
Cc: Ajay Agarwal <ajayagarwal@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 11:21=E2=80=AFPM Brian Norris <briannorris@google.c=
om> wrote:
>
> Hi Ajay,
>
> On Mon, Feb 10, 2025 at 09:02:41AM +0530, Ajay Agarwal wrote:
> > On Wed, Jul 27, 2022 at 06:31:48PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 27, 2022 at 10:08 AM Oliver Neukum <oneukum@suse.com> wro=
te:
> > > > On 26.07.22 17:41, Rafael J. Wysocki wrote:
> > > > > Well, in general suspending or resuming a device is a collaborati=
ve
> > > > > effort and if one of the pieces falls over, making it work again
> > > > > involves fixing up the failing piece and notifying the others tha=
t it
> > > > > is ready again.  However, that part isn't covered and I'm not sur=
e if
> > > > > it can be covered in a sufficiently generic way.
> > > >
> > > > True. But that still cannot solve the question what is to be done
> > > > if error handling fails. Hence my proposal:
> > > > - record all failures
> > > > - heed the record only when suspending
> > >
> > > I guess that would boil down to moving the power.runtime_error update
> > > from rpm_callback() to rpm_suspend()?
> > Resuming this discussion. One of the ways the device drivers are
> > clearing the runtime_error flag is by calling pm_runtime_set_suspended
> > [1].

I personally think that jumping on a 2.5 years old thread is not a
good idea.  It would be better to restate the problem statement and
provide the link to the previous discussion.

> > To me, it feels weird that a device driver calls pm_runtime_set_suspend=
ed
> > if the runtime_resume() has failed. It should be implied that the devic=
e
> > is in suspended state if the resume failed.
> >
> > So how really should the runtime_error flag be cleared? Should there be
> > a new API exposed to device drivers for this? Or should we plan for it
> > in the framework itself?
>
> While the API naming is unclear, that's exactly what
> pm_runtime_set_suspended() is about. Personally, I find it nice when a
> driver adds the comment "clear runtime_error flag", because otherwise
> it's not really obvious why a driver has to take care of "suspending"
> after a failed resume. But that's not the biggest question here, IMO.
>
> The real reson I pointed you at this thread was because I think it's
> useful to pursue the proposal above: to avoid setting a persistent
> "runtime_error" for resume failures. This seems to just create a pitfall
> for clients, as asked by Vincent and Oliver upthread.
>
> And along this line, there are relatively few drivers that actually
> bother to reset this error flag ever (e.g., commit f2bc2afe34c1
> ("accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get()
> fails")).
>
> So to me, we should simply answer Rafael's question:
>
> (repeated:)
> > > I guess that would boil down to moving the power.runtime_error update
> > > from rpm_callback() to rpm_suspend()?
>
> Yes, I think so. (Although I'm not sure if this leaves undesirable spam
> where persistent .runtime_resume() failures occur.)
>
> ...and then write/test/submit such a patch, provided it achieves the
> desired results.
>
> Unless of course one of the thread participants here has some other
> update in the intervening 2.5 years, or if Rafael was simply asking the
> above rhetorically, and wasn't actually interested in fielding such a
> change.

The reason why runtime_error is there is to prevent runtime PM
callbacks from being run until something is done about the error,
under the assumption that running them in that case may make the
problem worse.

I'm not sure if I see a substantial difference between suspend and
resume in that respect: If any of them fails, the state of the device
is kind of unstable.  In particular, if resume fails and the device
doesn't actually resume, something needs to be done about it or it
just becomes unusable.

Now, the way of clearing the error may not be super-convenient, which
was a bit hard to figure out upfront, so I'm not against making any
changes as long as there are sufficient reasons for making them.

