Return-Path: <linux-iio+bounces-22579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DBB20CB7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213183B281D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46012BEC55;
	Mon, 11 Aug 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ7GYP2p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC94414
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924073; cv=none; b=sNUAlv77j2ayaw4stgSHbARiyiis5W9Z+y7MUTPg61/Q9g5d+S9p5CF44VwT2OJWI5ZEPSvNeA6hn/+FslLeAg7i3ORz6k3hg3BbwZvJFuMEDrw0b1sTNVWp4V9JCRU2LMl9S6ahUtquSbYZw3SRCx3h6d63Qq/NCF7Q5Z4+rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924073; c=relaxed/simple;
	bh=QJGlSk8bm2SH5JiV1IDA1+GL42DRa8gA+PIXu9KiGeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvq3woGJcabyxPOo6nGIOmpw+ARfPl8a/Pw6+pO2THjLQt4Sr4jjh87BVvknjUTGDA4W5POhsOBxq2rKFVZMaTmcKuEhAg6dYhtPJKMCkemnqGjqB2fKzr1XI9XyOj7tOHQzUpGe8d0iIoTQVuOQOkSvsUyINO5nsgBVeN4LsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ7GYP2p; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af95525bac4so800295066b.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754924070; x=1755528870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJvWQULHgZu+kOa6maAPJUFUGLqb/VF2NnkN+ZMz9n4=;
        b=RZ7GYP2p5mBdWXZxTnB9HoSBwwWDgDHvlLFAzdSCGCTq4AAbwodc7hfzht5hWbxtOs
         ahlM4UbCNNHjO8M9d7clX6i4ihlkHE4VPvKYFWEH/OzuhEZds2t5Jn9sJ3fYY7zh5VYL
         BPal6jR/I84hq3JPkVf6/+h98cm5dfG6cMgpL0ymPmnE3Jz75A3iqYBWReci7Y8XnuFO
         WBZpjoGOP0ZsBlE3mDHJpSx4Tk0inEzwwG0oaD2S2En82pJwfMcCnKbrJk8RDljx7p8M
         gUl/TLf5agYlqv+CrIRcyjvfxdj24YRWhc9IQFE+xej1MzHKsPM/QsoqQwdPb6l7U34s
         6Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924070; x=1755528870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJvWQULHgZu+kOa6maAPJUFUGLqb/VF2NnkN+ZMz9n4=;
        b=SOWcmxcLsKpOur79/OEgaDokb0bi4iP6tsYAfy2PA8Fsv5N7DrLQUdxkkjbZB2Ek1x
         VrDI4AI/pplp2RjxFsmf1+UOAnYjyVb8m2f7dubRLI3MQAsHy5c9OT68P+SSfPo3XlcV
         MPEBItOV2cHBYbyTGA4E5P4eeYNtSDDOda9c+hb1b+PhhTei01iI8acMbHm1nlpRbsIz
         CN4QLTRWsB2f7OEXXm7CwWo2lcLR+hubnOOkwChjJ4IdpTg9ZUlc09fnW0xq1k4JuWa8
         Kdl3v1ZooJ0Vm/VYP517M3D/qYjVPYmz8l39e83YUROrbt/EsIxdZvjgJGjvxgVOVhXO
         OKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuFerk24S1N0Ll4PvB2FRRV4PLeVPTGcJRihHx64Out6OBQmjpTKcUWCfONnXti6Uaj7/7IGP7Zs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzchM466Y4oNbAI2rdj+Ck1CkxO4f4JeQryUbmZuijSgVxjSaIe
	sQ1+MSarkqSaLczZw7QZucHbHKd1TvFNHvYN/+1Z+8xMpQnAgvtXbG9TY8f+5rJpKWUzGBU7kJH
	hkI/djCa4q/YZm1PgtE4hDOb18iKZBLs=
X-Gm-Gg: ASbGncsmmMTF2CPWFA2qJCGAhW4doBSr/lR6nOGPcy7T/59nntm4mPYpbf9qFFt818s
	0QlUz6BrbRoUYVjnxdHJoygcDqJ85CFBFZJeHDAoiO8fIesNH8qKVl2eWgokwe/HQpcqc2HiQz6
	BNLg5s4707/xZ8N5Mf80SSCWtEtj8MNx8jTI7QlTNqcHYyGRgBtYB0dKGA4QL0oJa95K0QZjxd/
	XYqBoS4V8uqLeQQWL9J
X-Google-Smtp-Source: AGHT+IGjs+hxP54DGmdOga2sME1JEXHENZ3oDEuNc7ixjz7K6VU+5AiAKepXGI1vhcjfWtJjTUar5+y5yO38vfREnfE=
X-Received: by 2002:a17:907:3f1b:b0:ae0:a597:2959 with SMTP id
 a640c23a62f3a-af9c6516d10mr1121138166b.32.1754924069928; Mon, 11 Aug 2025
 07:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
 <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
 <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com>
 <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
 <CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com> <ttos64aijdgv6tidi2iiweee2pf3fvu5u2a5hpijleeo533or3@nuaxva2ktrwc>
In-Reply-To: <ttos64aijdgv6tidi2iiweee2pf3fvu5u2a5hpijleeo533or3@nuaxva2ktrwc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 16:53:52 +0200
X-Gm-Features: Ac12FXzpsd5i31dqv4b8rADaNgPPX1_6TR-z6bMPPLIs_m4sE7f2dgC21T3rpvE
Message-ID: <CAHp75Vdfqu6NEHuZXyTEo7aEhPEDjWbwBbk869TDH76SNruVig@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:37=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Mon, Aug 11, 2025 at 03:03:30PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 2:48=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> > > On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Aug 11, 2025 at 11:42=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@=
gmail.com> wrote:
> > > > > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Aug 8, 2025 at 6:09=E2=80=AFPM Nuno S=C3=A1 via B4 Rela=
y
> > > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > > > > > +       st->r4_rf_div_sel =3D 0;
> > > > > > > +
> > > > > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > > > > +               freq <<=3D 1;
> > > > > > > +               st->r4_rf_div_sel++;
> > > > > > > +       }
> > > > > >
> > > > > > This is a reimplementation of ffs()/fls() or similar calls. Do =
you
> > > > > > have a plan to clean up?
> > > > >
> > > > > Oh so? Not seeing any direct way of using ffs()/fls() for achievi=
ng the
> > > > > same as the above.
> > > >
> > > > Bit operations are hard, I know :-)
> > >
> > > Even more in the morning :)
> > >
> > > > r4_rf_div_sel is a power-of-two shift to make sure the freq is just
> > > > above the MIN_VCO_FREQ. Of course it's just a subtraction between
> > > > fls() of the MIN_VCO_FREQ (which is compile-time constant, I believ=
e),
> > > > and fls(freq). No need to loop, really.
> > >
> > > Yes, I agree the loop is not needed and if I got you right, you mean =
something like:
> > >
> > > if (freq < ADF4350_MIN_VCO_FREQ) {
> > >         st->r4_rf_div_sel =3D fls(MIN_VCO_FREQ) - fls(freq);
> > >         /* But then, you would need to re-check the if condition.
> > >          * AFAICT, it is not guaranteed that we will always get
> > >          * the condition right just by subtracting (or shifting freq =
til
> > >          * the same MSbit)
> > >          */
> > >         if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
> > >                 st->r4_rf_div_sel++;
> > > }
> > >
> > > So yes, we can skip the loop but in terms of code it's not really con=
vincing me
> > > to bother in changing it. I also don't have HW with me to test it (bu=
t
> > > it does look like a safe change though). I guess we could also use
> > > ilog2() but I think we always need to recheck to see if we need and
> > > extra shift.
> >
> > Yes, ilog2() to make compile-time constant for minimum.
> > But also one may think more about this and come with the idea of only
> > one check. I don't see why the second check is needed.
>
> Because if you just fls(MIN_VCO_FREQ) - fls(freq), you might (or might
> not) get freq * 2^st->r4_rf_div_sel  >=3D ADF4350_MIN_VCO_FREQ (which is
> what we want).

Yes, that's why I pointed out...

> > The question the code tries to answer is "how is the freq lesser than
> > the minimum in terms of power-of-two multiplier?". I have that already
> > done in some drivers. And that becomes fls_long(). See implementations
> > of roundup_pow_of_two() and rounddown_pow_of_two().

...these implementations. They accurately assume off-by-one cases.

> I think the code wants to get the minimum value needed in order to get
> the above condition (r4_rf_div_sel ends up being programmed in the chip).
> Maybe I'm missing something but at this point (and replying to your
> original question) I'm not feeling too convinced in changing this code
> (more so given that I do not have HW to test).

Okay, fair enough. But maybe TODO in the code to make sure somebody
looks at it again (e.g., me, if I ever have time for that)?

> > https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/8250/8=
250_mid.c#L220
> > https://elixir.bootlin.com/linux/v6.16/source/drivers/spi/spi-pxa2xx.c#=
L820

> > > That said, I would ack a change like (or better) the above.

--=20
With Best Regards,
Andy Shevchenko

