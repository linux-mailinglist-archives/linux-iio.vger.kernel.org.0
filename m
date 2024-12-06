Return-Path: <linux-iio+bounces-13179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2DE9E7771
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90D8188892F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F02206BD;
	Fri,  6 Dec 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLUmnG9s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817C2206B4;
	Fri,  6 Dec 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506227; cv=none; b=mp+Plh4kTvam3Q9RcBr+lAGspb2yOfh0f0wUubj4t5J4y0v7beCnIqWeupoQYEW6+cldnPUfxO4FFkI7VLKRmPgUoRTsTzOqYES+cjzJigND1t6sSGeOArRrPlyCqnzThpYSueBxM/XdCNPh3btdn0UdktxQHu3WfDOqmLumyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506227; c=relaxed/simple;
	bh=ow5rBDgJkta/XA4DgUkjimBjGufCKoc4OVk+hj1J9CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeHpzib9lwlHgx3Xn2aWXwJISvqHIP953yTHZthzHwLefcXqR4N09o2HrVXs+O50m5eBIYWPsk5PaRRCZNx3DS8t1fgp9IdEPHsFqRc9KkSwiLZFHthnyFydeWimib59nSaAccyFK9axhFCrwF/YPHsRbGUWBqdvSipYgG0pr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLUmnG9s; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef75fac658so609407b3.3;
        Fri, 06 Dec 2024 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733506225; x=1734111025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ6wO3L45AaYxQvu01dcB+Xeq6Tm84PAttAFYpDqMZk=;
        b=QLUmnG9sNFopclzt8QqLXTQ0NdaODz9JfbH2Pw+wBemAFmkcHly7e519Kn6abfbvoG
         Jq9zSr4AUOgKlsgaE8ZeecGKNCqw3M0305SkPV2Cp+I/1Qo5Er0vXqK+gPgHoXuoO89P
         8qHWD1olBSDGQmHRxjiHLiDPxPdADPv/xy706k7/z15ZmD+372Ef8kGqVoLLY7T59yTP
         KneuFGQv2JfO3ceXy3Gxxwsu3hUv+JoeLOf+Zq1HJREDa4rWYZDHr+mfp9L/t/ys0/GP
         kC+CG+qwRLhwki/xJB6lz/PQ6Wi4lhmqVsJWD0LlOg2t0otiLDdIvYJKpWQT9h2OaDFu
         dSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506225; x=1734111025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJ6wO3L45AaYxQvu01dcB+Xeq6Tm84PAttAFYpDqMZk=;
        b=Ajt1lq+CZW+G8o1kswyeFyrQSPspU3mXriEpWMK8SeATngAmB5mEFqYYzfxdwDACx/
         CGfZmkKqUqnynzFAWnPeTHecH/kXJS+NLQFrRo3aqpj0xgt4hhoYEfi/9wz5IY70BaJG
         cUZm7CmN+9GFGEWR7Myt7vJeVzV9m1SXpoKi0RBFYluX5Ab7dWlCwkOeR6HOurgRcXmO
         e9XSf3zVSJnsYM61Ob1JPWkr2KCbKIjMMe3dww0c0hA65XZLdP483FT+ulRshw4jaNg0
         tZdwv9a+fjDlLDW4b6wPvYrTbQ0JK2vTusDWNLMydlUt4oyXswvDvq+xwC1dCxLDGoLO
         NtCw==
X-Forwarded-Encrypted: i=1; AJvYcCVrkEea5oQo4DbWCbF3jhiUKMzy6+BWISDTbVjzn3vvr21LC6gxOdofN2Nb3HC+M3WI+VeOsFJcVxJCOEDs@vger.kernel.org, AJvYcCWEENP3zgYSvHQl87lIKgEZX1lZAeU/Kd6Js/g2Kw9DDKfnLoFrDYXU4CuqY7uRgWjlmqcFSoqbjGqa@vger.kernel.org, AJvYcCWKStO4MPgRx4esG+mJSM+XMrLy+beFeTkmnzg9DcTJ+U1g9Yyd9MGLRKvVlrno22O8tQKvpT3W9xmX@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZG5IRTyVOOl/rO3nLTO5HSv9p3sH9+2kekyFrVRjgGPTEQHH
	96jCB3x93QnjIPS5tySOruibGlGw6AnEbruDFa3VRWsTr7ek9wXf5tEIGpNUZFWX3R74prmrfmJ
	8VSuurHHx0CJTewTyZKwNOafQACGGPWbm
X-Gm-Gg: ASbGnct2+Olj+/K941eOAFtKMAkk5oUSxl1Us1vKWnkdIO6Hgsm3wRybNVNjkOTvfeq
	Kziy1JX+5VfkTvia1yhDWlT86wYcSskI=
X-Google-Smtp-Source: AGHT+IE+oPKV6REojBEmRe9Fp9HxtdvKApFHbvQEeIKCoJd9jk/Lz0YUFgbbDvbS/Q0PT3OHurXM/ha0ZPAHGMnKjY8=
X-Received: by 2002:a05:690c:6503:b0:6ef:97d0:a989 with SMTP id
 00721157ae682-6efe3bff0efmr18947287b3.4.1733506224613; Fri, 06 Dec 2024
 09:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-7-l.rubusch@gmail.com>
 <20241205-fraying-overfull-4fe3eb6c5376@spud> <CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
 <20241206-settle-impulsive-280ce8dc312f@spud>
In-Reply-To: <20241206-settle-impulsive-280ce8dc312f@spud>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 6 Dec 2024 18:29:48 +0100
Message-ID: <CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
To: Conor Dooley <conor@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Dec 05, 2024 at 08:41:52PM +0100, Lothar Rubusch wrote:
> > On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote:
> > > > Add interrupt-names INT1 and INT2 for the two interrupt lines of th=
e
> > > > sensor. Only one line will be connected for incoming events. The dr=
iver
> > > > needs to be configured accordingly. If no interrupt line is set up,=
 the
> > > > sensor will still measure, but no events are possible.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +++=
++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl34=
5.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > index 280ed479ef5..67e2c029a6c 100644
> > > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > @@ -37,6 +37,11 @@ properties:
> > > >    interrupts:
> > > >      maxItems: 1
> > > >
> > > > +  interrupt-names:
> > > > +    description: Use either INT1 or INT2 for events, or ignore eve=
nts.
> > > > +    items:
> > > > +      - enum: [INT1, INT2]
> > >
> > > The description for this ", or ignore events" does not make sense. Ju=
st
> > > drop it, it's clear what happens if you don't provide interrupts.
> > >
> > > However, interrupts is a required property but interrupt-names is not=
.
> > > Seems rather pointless not making interrupt-names a required property
> > > (in the binding!) since if you only add interrupts and not
> > > interrupt-names you can't even use the interrupt as you do not know
> > > whether or not it is INT1 or INT2?
> >
> > What I meant is, yes, the sensor needs an interrupt line.
> > Interrupt-names is optional. The sensor always can measure. When
> > interrupt-names is specified, though, the sensor will setup a FIFO and
> > can use events, such as data ready, watermark, single tap, freefall,
> > etc. Without the interrupt-names, the sensor goes into a "FIFO bypass
> > mode" without its specific events.
>
> What I'm talking about here is how it is ultimately pointless for
> interrupts to be a required property if it can never be used without
> interrupt-names as you cannot know which interrupt is in use. I think
> both should be made mandatory or neither.
>

Ah, now I can see your point. I agree that it should be equally
mandatory as the interrupt. Legacy implementations used simply always
just INT1. I'd like to make it configurable in the IIO driver but
tried to avoid the DT topic for now (which was not a smart decision
either). Hence, I added the interrupt-names.
I'm unsure should I make "interrupt-names" a required property now?
What about the existing DTS files using this sensor? There are no
interrupt-names specified, so if made required, the missing
interrupt-names there would break binding check, or not?

> > Hence, I better drop the description entirely, since it rather seems
> > to be confusing.

