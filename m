Return-Path: <linux-iio+bounces-19444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E906AB29D9
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 19:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2971896F76
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E860258CE7;
	Sun, 11 May 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyLVrJc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716011B393C
	for <linux-iio@vger.kernel.org>; Sun, 11 May 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746983743; cv=none; b=k/y+4t2asOb1n2lVUJ+0/IOVBs2ZJdG10VOyIc8w5VBxdmZoZWw1NcjDGQRv9BKaXLQLEzARd9GdPGFZlpSbq+xo2V4GNSFs2nst/3oeI5c66Hun5G/VLbp3+NWkEIeZof+U6Z4/Or1Q+tPeAuOkZDZsk/haBzZbBWSpRPaqS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746983743; c=relaxed/simple;
	bh=phm6W/Si9JOZx/kEwJWD40GuNqmKqF1yKuBb75mEWoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdnxoQKVkykPnAu+M/SUkzdjhQDk1RzPlQmU1yS0pGVLyPDzN91gIrogxCDFoafCytIXqI4XWmKEzW0Xvx/6m0PANwGPBSUp29phvDW+bzmNGwSto3MgFijQvZTFbpKrjgABtYWqyy3FO+m7/O8hgAZtMp/jluJ3W6Bp3Urx24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyLVrJc3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-528ce9730cfso1034506e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 11 May 2025 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746983739; x=1747588539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9IgwtCNEEgmsnZ0T3AsXBTPXV9DZDS8J9wuT2BFZ3A=;
        b=EyLVrJc3lR7XdU1SBneBewe8DcZ/nPOtLGy3o881ekZ2qu9lC6WPiYKclsVPDTscfB
         +BuR0J8fJTD+NjUFss05u1Ekokl7dbDCidqLQVP+9fTxJlfto4wRRWG+mY+qjA+ky/dt
         BrZFfBfkfps8idOxQmiBvdsq6peVmWpO2Kj4h8on6jbRC7unexgcOidLh2gRMIvthAG1
         1IF2KEm31bMKfAUZcpBa8sKH6fKqWF8oRO0Ck4fF+23bThP5UzOzWy/kfd5H4YG93qo2
         pAuJVfIFvlq6ZMr5kfwMS0pn8uPP4FYP3HrvW//S5BGZOaIwxiZVdlkynNlBP+nD8xWj
         CShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746983739; x=1747588539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9IgwtCNEEgmsnZ0T3AsXBTPXV9DZDS8J9wuT2BFZ3A=;
        b=TQWsbMdbcmA46+lcpt2tl8tP+5hyZh23jEHwwC3GbGo8PGqsgQDO45ue254O2T7/fy
         SIHaqPKsyhwTroEemiCEE6xyrysIbJcmbV2unI+4L27f9imlLwjPS3eWRTTF3ieNmqRR
         BnDO94IxVNDBV8D7l/oo+jrmPxN7Px+KQjkZ+JjjMMAG/1YYXqbBD423XNqNv3nPU5U7
         5kK/e5JUaEQVLfT3jDrrv1iEy70Jo/BnstH5r0Fvmrwnw0QqmGiNJcdB+Z8MzJ5MoBYz
         Zfa/6lKtNj1GIZAiamig8a+u3wJmVHok39HIPYPZzprV9RBZD7ArUpggT7HRCdjaCAlR
         Rjgw==
X-Forwarded-Encrypted: i=1; AJvYcCW1oVtioGJTAc4fKk+HMRqxoHE3i1KitmnPIBaCRdgDymiUDQWenvEnZ6zw3PojpSA3+AgDTDIyN7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYCq1jSh1DKDLZVN3Rev2lf3Ib6RZrQBk2dho7ij7vw6dHKF/
	klXlaAc5bpgrrgxeik9f++ZuvXd3SzHz8jcG0Jr/JzQdYktBHN2CO6ExqNFXcXddjIDAkXrRLv/
	wu++/wt+Nlf2lQooAhdDpbIOMgCk=
X-Gm-Gg: ASbGnct4R6p7WtkeXDBzPsZDtMEVinUuYbKQH2m6KFJS3JxvGP7CREfmo1lr5lGjDDn
	NddA4/LT83ngjki3zghZ244bNQCdxO7lxWdqMZMHGZLear55OFQfPFUCFkYNVNAPQmEW9widjtQ
	6b31rg0OUz4Fphzpl24RTGykxoUFbUUefll7JsajKSfjCB0vQ=
X-Google-Smtp-Source: AGHT+IHShrM+f/AwMc91HIQCMdMfFLONlyA4Vnp9HpBgl8yDN8FGgfAs16prccVj78Z0pyCT+M9vo7eMywa61OWqbuo=
X-Received: by 2002:a05:6122:549:b0:529:995:5aec with SMTP id
 71dfb90a1353d-52c53bc1cbamr8126745e0c.4.1746983739196; Sun, 11 May 2025
 10:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
 <CANZih_SYwX2vLO79iiLbH7QXNkMgsc6+4byPC4bV849=whkYMw@mail.gmail.com> <CAHp75VcVM0fJ0XO2G71czFK_R3G0Vz+vm9pHxrftQ0tTPtHgvQ@mail.gmail.com>
In-Reply-To: <CAHp75VcVM0fJ0XO2G71czFK_R3G0Vz+vm9pHxrftQ0tTPtHgvQ@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sun, 11 May 2025 14:15:28 -0300
X-Gm-Features: AX0GCFsa5ByzUYUxAuJJsetqWRvXKhUsvpwViPKhpQHAm352ZXQixMPxUyVaPUQ
Message-ID: <CANZih_SZt8qOKbBfxZFcrQasgZ9tFcEa3fRVrGr3Y9LFQDTzOg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, gustavobastos@usp.br, 
	linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 6:38=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> +Cc: mailing list and other stakeholders back. You mistakenly sent
> this privately.
>

Thank you! I didn't notice that. I'll be more alert when replying from now =
on.

> > On Fri, May 9, 2025 at 6:06=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
>
> Also, this has some questions, so the new version of the patch will be
> ignored as we haven't settled this review down. Also it appears that
> some of my comments were ignored. Please, go via my initial reply and
> check all comments.
>

I'm really sorry for this confusion. Although I didn't answer them directly=
,
I went through all of them and included them in the version 4 of the patch.
I was afraid that replying to every comment would feel too repetitive and
you'd prefer a new version with these corrections already.

For now on, I'll make sure all the comments are addressed and I'll wait
until all reviews and discussions are settled before submitting a next vers=
ion.

Thank you for the feedback.

>
> > > > -                       *val =3D sign_extend32(be16_to_cpup((__be16=
 *)st->rx) >>
> > > > +                       *val =3D sign_extend32(be16_to_cpu((__be16)=
 ret) >>
> > >
> > > This doesn't look good, can you define a proper __be16 variable on
> > > stack and use it instead of ret?
> >
> > Yes! Also, sparse showed a warning about this casting between restricte=
d types.
> > Do you have a suggestion for how to handle this? Or is it safe to ignor=
e it?
>
> As I said above, define a properly typed local variable for this and
> do endianess conversions using it.
>

Ok! I'll do that then.

--
Thanks,
Andrew

