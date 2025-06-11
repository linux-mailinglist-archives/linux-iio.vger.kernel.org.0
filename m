Return-Path: <linux-iio+bounces-20474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55FAD5CE1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFF5173C41
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E320CCD3;
	Wed, 11 Jun 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWEEMwVy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2540157A67;
	Wed, 11 Jun 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661967; cv=none; b=nWNE9yIlPMZCcFybnoYJQNHyv0IOquMmt8bpvrwsYdQI9KtR8HNbL9NeZTQy8/eMwXB0TJF+aR8wJcO1SSTCHBX2w5JHhGCwNfG+Fc8pyHdee/CA039Uc9Jc2MzeBUI9BSNScjhy6il/u+uCBqX1gxPck019VTUiCSsJcPUlGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661967; c=relaxed/simple;
	bh=fo7JC4KScGUQTIQ/w+iOjsTGi3bBJrY6VglgxIlGW/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlGyQsJoSdHEhY8LZNiAjKrTzArdPO9q8JMswAyV7TDb07c0J15uktE7NxovpsZiWQ5wZY55MNcQALhEAZz8/gTpI7mxGd0IVyHykCX4V7eLMr66K5UV+qyZ7c5jySEYSFudVXjQsIeKaRlFA/jbop5o+1UytcH+OKnqKA9rcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWEEMwVy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71101232af5so21127b3.0;
        Wed, 11 Jun 2025 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749661964; x=1750266764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ5j+E9v3b7sSvEXVxCoNNdW6tgOp2f2eMuGP+gBZoA=;
        b=nWEEMwVymJIdNuQmUO28Yw+UQx2xZUHmYTTyVlS5Y0kPiJakoW5BC+gFCJ7POAHiXN
         AboQDJrwphZjgI0PkgpJ2c9LeHxQpFCIKGGdYwc2nO58soYZ6atF64nUXrQdB/wWcGvz
         vtUNn7puXHHYd2pY/uFgDry3TxOg7Xk+/85unapoPB0UYSM+2xGt1TWI4BozRCsqgKVm
         bQKctf53BN8Cfx2yjGZxUijWMW9fG+pwIaHGhkRf4tux3bjwmK9Jwh3UcYhfmJbNNuCZ
         h50xYw3xIhiM2Ssjpc7H90ZFhNW/WYna7jGck9EZChnEm3n5xz/h5lsDbaAinzvcO8ES
         xuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749661964; x=1750266764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ5j+E9v3b7sSvEXVxCoNNdW6tgOp2f2eMuGP+gBZoA=;
        b=Z8akOLb5CQrEA8gZt4t7HokbKBjT33DdnbZJlyebjhBSa9ljkmsfaqZ1ERGi1Zeh6A
         MKKWzCUvD6thHb/Tdo0ceZ3BrQlu0/ZaWf+lOZvCO/pzKbqDsSgex+KwGW3oibeqXNze
         yTPJn3gepd6wkbJ3bH6my0ivcQOZ7LBwJmMYDWKLfItL3AWOIDkcARWwZWaNI5Qt7WMJ
         nTbnLwlZH1Pn1tb3rc5grTm3AMFV6lh1CDzGlZkoeox3BdlMa/FgM7Py3GlwPFeFY3Kk
         5PKbw1xc+pcAdSO27it9uSg0jYUslozMca7EScqNKeo0VN3WqUKUO4Hu2dCMH6jWrK/m
         gwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKVuxiNdFtTCZaFdot/IkzajV4SGWhmZX45H8o74IipLL1/FGHG2VC2b/P7oQWg4pqpsPsl0HVK7s=@vger.kernel.org, AJvYcCWQV5BXco38yAesucNo0A/vxCUhVMwvjKE8Ug2U65J0mqyGCCKsbEpzKaxQpypNhWXFCqrzd2ZBIEm/4F8e@vger.kernel.org, AJvYcCWqAIfILHnAO6Gzb8RB5sSdUrDHtIpn35g6pBHyZABV1PrNmwXE3Yu4sjm7YpzoOOnmzvDWBm/CVewu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxquasnli7tzlvlfQiElA8jboG93NawiFGzFB7lF71TVo7FK4Pe
	af7kMqoxmlIRq11N0Z4FG1MSdKfvXKucHBXFmTDVfPhFv02h69THDX6pVzSNpk3Q3NYKxn4NLVM
	Bhmm+HzeXKjQ1OsWcwymx7vCHRnO26YCZIQ==
X-Gm-Gg: ASbGncvipmx17qAxhnl/xFCXuEl5uBRNyxBz9tJVaQbb3KnyDaABW5OjkoQGsS2DZeK
	7EYEW0stFOcrDto6DGf16fjKD8TcuUv+E3t15u8LltuOrLmp7nZBLddB6pqXM7JJbyWsUAsS+rG
	LVii2KuE++usUPFZIcdaZe5EcwMXlt/i9VQ4ZLMrzXKSQ=
X-Google-Smtp-Source: AGHT+IFrKWrFFkvbxgx2J2LOU1dTY9SksrisaeaMBSed/RqZfvGOG6zzy1YT6frh6KIF+LA2Y6oLj8CrMbFcBLbezXE=
X-Received: by 2002:a05:690c:6311:b0:70e:7613:e365 with SMTP id
 00721157ae682-71140a0a4ccmr28108717b3.3.1749661963730; Wed, 11 Jun 2025
 10:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-11-l.rubusch@gmail.com>
 <CAHp75Ve+f4c-aVD3vMfi1NP7vohJWDFFO+F4ckYCKkw2iYDsFw@mail.gmail.com>
In-Reply-To: <CAHp75Ve+f4c-aVD3vMfi1NP7vohJWDFFO+F4ckYCKkw2iYDsFw@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 19:12:05 +0200
X-Gm-Features: AX0GCFuio6pOww4OvJeIBcJ4chzgH4vhtj2xAfqZoDBdeLhkTHCy-H6ewenMhoY
Message-ID: <CAFXKEHYB-JM11tbpdb+sRBZ7pF4oYD5BO5OVxxf1VPU09MXkNQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled
 activity/inactivity events
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Jun 1, 2025 at 9:54=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.co=
m> wrote:
> >
> > Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This ad=
ds
> > up an additional set of threshold and period handles, verifies matching
> > disabling functionality and extends setting the link bit to complementa=
ry
> > event configurations.
> >
> > This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The mos=
t
> > recent set will remain configured. Disabling ACTIVITY where ACTIVITY_AC=
 was
> > enabled is ignored, since it does not match (should be disabling
> > ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the lin=
k
> > bit will be set. Note, having the link bit and auto-sleep in place acti=
vity
> > and inactivity indicate the power save state change and thus will only =
be
> > triggered once a state transition occurs. Since there is a separate AC =
bit
> > for ACTIVITY and for INACTIVITY, events can be linked independently fro=
m
> > each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.
> >
> > When one of both is disabled, the link bit will be removed. Hence, the
> > remaining event will not indicate a plain state change anymore, but occ=
ur
> > as a periodically triggered inactivity event or for each activity event
> > above the threshold.
>
> ...
>
> > +/**
> > + * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.
>
> > + *
>
> Unneeded blank line.
>
> > + * @data: The device data.
> > + * @type: The activity or inactivity type.
> > + *
> > + * Provide a type of activity or inactivity, combined with either AC c=
oupling
> > + * set, or default to DC coupling. This function verifies, if the comb=
ination is
> > + * currently enabled or not.
> > + *
> > + * Return if the provided activity type has AC coupling enabled or a n=
egative
> > + * error value.
>
> Missing Return section. Always try kernel-doc validation when adding
> new kernel-doc descriptions.
>
> > + */
>
> ...
>
> >         unsigned int regval;
> > +       int coupling;
>
> Why? Doesn't 'ret' suffice?
>

the coupling variable here is rather meant to provide kind of a
semantic context. It shall be checked for being negative (error), or
used in binary decision logic. In fact, could be done with ret as
well, but then in case I'd need to comment that in this case the value
of 'ret' carries either error, or the bool if we have coupling or not.
I'd like to leave it like this, but let me know if better replace it
by ret here.

> >         int axis_en, int_en, ret;
>
> ...
>
> > -       int act_en, inact_en;
> > -       bool en;
> > +       int act_en, inact_en, act_ac_en, inact_ac_en;
> > +       bool en, act_inact_ac;
> >         int ret;
>
> For all your patches: try really hard to avoid the ping-pong coding,
> i.e. when you add something in one patch in the series and change in
> the other for no reason. I.o.w. when the initial code may be written
> already in a form that doesn't need further changes (e.g., switch-case
> vs. if).
>
> This patch is *very* noisy due to the above. So, just slow down, try a
> new approach that you have less '-' lines in the diff:s all over the
> code.

Agree. I tried to follow the review comments. Probably, IMHO it's
mostly about how to separate the patches. Your reviews seem to be
quite focussed on the particular patch w/o taking the context of
follow up patches so much into account. [At least by the way you gave
me feed back here. Actually, by your vast experience I'm pretty sure
you have the context of how such a driver shall look and have an
excellent overview well in mind.]

So, I guess you'd like to stress on certain points. I'm wondering if
it might probably be better to send you this all first in one big
patch, or say rather bigger patches, and then separate pieces out? Let
me know what you think. Thank you so much for the reviews, let's see
how this can be improved here in a v5.

Best,
L

>
> --
> With Best Regards,
> Andy Shevchenko

