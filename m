Return-Path: <linux-iio+bounces-2566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B568551FD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3128919F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D172127B5D;
	Wed, 14 Feb 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbMliydD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44784FC8
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934914; cv=none; b=VrD0eqbKE365x4BM8RXawcQnqvRAOahzQRmDkxfyX4uRpYMB8Ox41y+ynFlfknlHeFBWRnRIbL2QjW1n3eppedgvGac9PKuN97g1aqlIiyy0eHbfZs4iTu7842kbZtWgStN3ve/L0IGNvYHHZqW7lbKOEcbygASRm6g65AadyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934914; c=relaxed/simple;
	bh=RAKcIWWw+hHmG443juEVwmPhyLhA1QzUolgjmmY3tDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDScJGyjDntLkHtTjzw6cPU0r1xAaEQAuk4+iHXNN27Zq9rWCPpwNOvdCl68UeJGANokYuQ9XK58oJhRbkgUw84Bv82to7eLvNAtdHVQym+w/Rn5+NgZTsCciM07KiyXRQyoUUX8upQ92ewrUvrYwJhILGNDpL2PfYu9w9v0zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbMliydD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d54555692so96227866b.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934911; x=1708539711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAKcIWWw+hHmG443juEVwmPhyLhA1QzUolgjmmY3tDw=;
        b=dbMliydDJ1fNR3bPULRERocP1t2GxcZw3wecA7QwVI+lb+OdARkNI3PJsn0LSouVmh
         nbItHBXN5aOhEe7UTyLIn+t2+LmVGX1nDCCTPBUG2Oz7XmLnumULJ61FdIy5Ua82ikBa
         wv3YVL4GvNNv8f9qYHfFIc116xKUJ9TliumwYsxJfyCFZ+m5NfA8qiG9UR/7WUKUAQS0
         jz+ravDkLGeGPZEhquZVrhOsuq9qZFlky91dYHLcLycUNxyURyvuZIOP2rKZIZ+PEUPL
         0k43oVWe+VBqF8rNzq3+2JSVHyahsWWIwELQtlPkV2inJdCkgNMgQmx2U6/t8r7+9E14
         9jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934911; x=1708539711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAKcIWWw+hHmG443juEVwmPhyLhA1QzUolgjmmY3tDw=;
        b=DtN+VZ4ivv9mXXQ0RcbjztmkrA2WqYh+U1meoKrsrIZuTmGNVmu2sXzWMtj0vl+ljs
         IuKxeIgK/E9Ulx4DUgXMD5rDlGCsBRINr9OVnhLRsdO2seSFpgWadNdo6DbF0Blowlyb
         J37/CKDOgFntIVhsUgdcVYfkLbQCxPwa8PozdzbKFd/pgT6/V6A/UY+xz1MX9RlVc1nw
         ahRZo2Oq6/RuJuNtYzHuh5O10llzrQ4xGC03gOb3CdPgUug70/gZ8CaHGSBGkxr7hBBw
         RUfYocJGd5xwrCtySBlNqwcAkNdRn2ZJ04+voS47cz65tcCtzLDQ1REts74x91vz34jd
         wjcA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgUVxikk54+E4P2O4ctFzlMl5MrjJLWGLKfoBgnDLYrUjh3Ups1MwMDWROwPTuBD1EqITE4noglMTwkiEXnTxF/3zinXlaRPu
X-Gm-Message-State: AOJu0YxRw/W09Skd+ZQHAg+9czhSTcQ/derEVA/kXEt5ORw70KcSseDf
	YvMMkYkNnA4o7S83g7psGFGaAPs3tvoGhmHNaS02Jkf20iu0m4NpZBOIagBW77tDXMlijEhzHp6
	Rbpx7lzJie2Qi+UL91xN+5lmFoQM=
X-Google-Smtp-Source: AGHT+IEY63ridnodaCKG+Ir9GUF5fCT1S8mMYblsAIeMz1FrDnh7A05Ew44bDZjBUmkwcH1KNyf6bjmbeHJiY2/Y3xQ=
X-Received: by 2002:a17:906:413:b0:a3b:f3e4:e91b with SMTP id
 d19-20020a170906041300b00a3bf3e4e91bmr2447884eja.42.1707934910483; Wed, 14
 Feb 2024 10:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <2192956.irdbgypaU6@nobara-ally-pc> <CAHp75Vc+pb6YUhx7QOzWGQwmSgGmq2-7NjJHgOBSekKyqdVg5A@mail.gmail.com>
 <12396329.O9o76ZdvQC@nobara-ally-pc>
In-Reply-To: <12396329.O9o76ZdvQC@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 20:21:13 +0200
Message-ID: <CAHp75VdKohmw=fP7EN5w_0A30puAz48+mxLXdzq2aXmT6_s1Hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:35=E2=80=AFPM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
>
> On Wednesday, February 14, 2024 7:31:14 AM PST Andy Shevchenko wrote:
> > But are those IDs different?
>
> During the chip id check during init (after ACPI match), yes those IDs ar=
e
> different between devices with bmi323 and bmc150.

Thanks for confirming!
Perhaps you may improve the wording based on this information.

> > I also recommend looking at my "smart" script [1] that helps sending
> > kernel related patches. Improvements are welcome as GH pull-requests!
> >
> > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintai=
ner.sh
>
> Thanks for this useful script, and thanks for your patience and guidance.
> If I make a future submission after this patch series, the whole process
> should go much smoother as I have learned a lot in this thread.

You're welcome!

--=20
With Best Regards,
Andy Shevchenko

