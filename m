Return-Path: <linux-iio+bounces-22569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81181B20993
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 15:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDD7A5480
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBB2D7819;
	Mon, 11 Aug 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H26eF4zV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BF3B29E
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917451; cv=none; b=at/pqt00d1F6rX7u9ntedkJsYupufP9lETvyB7ga6hbaDfxS0wz3gWUZBJaXM7zWzrpJvDz+wYh4LQ/EwEIY44xx0V0wO8OJ3NtlXrhzOdrfnE7K7EvORA7X1+sScg7lQRQMoi9v1UvlYIhDuoyH5GD/fgmWdR/aKJXcDV8qYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917451; c=relaxed/simple;
	bh=kA4iN6kFCmAFDmMNaA9yHIcAe4VTB5zK9azrKiAAGAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqSS2STISSu0o1Sz4G6A7/tbeZQVYTM7RfGUhKpe88XY0BeJWDtS4N2WlsXkdgf0tacK5uNovR5Kqu8DWqS4PfohVfuerV6ZXx7PmOXLMThoHcXtwBN9rcIQ6lTPlIKGAMGNOa/OIe6sZGJwxEc4t8hGJPCdO0kGodXHoyy9xaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H26eF4zV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af96d097df5so787898666b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917448; x=1755522248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIZ+dOfFnG1IxDS5aQIpDXTEJTUl9Zq0jm+qMgh9mV0=;
        b=H26eF4zVAbITQ0znyeDo+1io90lAUoA3hxs/Lu2yd5U2j2QBCk6ITA4KRrSzr5Uixl
         Z6v3JM/wkqRJqOIWZrRIIyOPTY80sGZalErCr0Vdg0uSZqRIXco/k2mOWEQ5A/N32KpY
         lv1kOC6JRMFpJ8Z/vTy+oAU7ZA1NW9PWz19LNzSeOTTx8pWD6lFHUF3oqm4a3PAw7eRu
         yAVF8QM5GdTwTdhrxwzxmLkjFIpKbFnKH7eOdld+jfwfVmXEYs7XerbLMs79WJxL6g0D
         JVO/c5NsAvJOWSlF/ja7Q1etPZq+J8+xzW2fsYyl/CaagoQQ2wtWbOvIEb3+mInNf9dN
         Qcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917448; x=1755522248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIZ+dOfFnG1IxDS5aQIpDXTEJTUl9Zq0jm+qMgh9mV0=;
        b=gf6raigdNdwXBNS+ia9NrQeTSNfK2Y58ECWtp4yQy88huKC3bwY8bgq/aOqfns4JV8
         CrORVzV4yna7O/UMaImqbWP8Q6TDUGkdwJu1uzJV43gGNWun7rjhyBok1M6ebf8YpbNZ
         yXgsAsOsnFIi/vcpSJOPOO2a6dN89gKMpwx7kj9Zs6TTrot/lQOZXTZWCHNR4lXx2Jh2
         hkm2c1AEAMRm60ygxJWo8LtuKN3h5kikLl9CBIAGIwpnl4ubjuZPn+NrVec/FO3X/tzV
         Gh5DHfiQj12aqHVjEl3VkewYolhYTJmBMK+zHhQvCpSGHohFY+1Sl63kWdnLgl2YCC7J
         R/uA==
X-Forwarded-Encrypted: i=1; AJvYcCV2PBfwa7BDnUbAF3rzAUbrQfrUbCS5GBFq4DUR9fPsUqjcDdB2Jr5AwvXwwen0se3qYkhI++K/qo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX42zLmX39xnbu7j6i0zgq5QfgtrG0tG7D0XPiB1nEKmljmBfA
	CX9uUkyscnyhHVHVBSWaM5broqYgOxvTIo7BzxzDxe10U5eV3YAGVp71BtYL0+j/8A8nF2ihs+r
	RX3qoi+307MS11r6jh5l3i3cX9ChnB6tq1EBNorLyaw==
X-Gm-Gg: ASbGncvtBIfE7D2QVbfIRtLPFfX7gh0HK1/PVYVCzTiKULKnGicbHoCAQYJ9o+TL2xN
	KHG6mKDKoXqGSCC9DUbYYfutcKz49s/ZkH24RMD6gbwMvqOtgL0kpRjz+X4JzqrdknIy++0zxuZ
	fxisgLXfEagULHSOX6DXy2QzCiDLyFJirNSaqTqUIaKd2qLjjYKZOrCVxferTDXY5z1KZuZMbGu
	WlP/0nvRA==
X-Google-Smtp-Source: AGHT+IFpX6PQ4xIOqy1nFMqEk14gU8QPk0MvoGy3o/zXPCH1mXpAN7mMsJ6S2n6xnZOi7cliKdk60KneLJGTxCdWGnE=
X-Received: by 2002:a17:906:9fd0:b0:af9:495b:99e1 with SMTP id
 a640c23a62f3a-af9c65b086cmr1253282966b.43.1754917447567; Mon, 11 Aug 2025
 06:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-adf4350-fix-v1-1-58eed5c07359@analog.com>
 <CAHp75VeXCrqzRFzNsMYHafRQ3SKztd-UaFKvvt_msh=O+Czb8Q@mail.gmail.com>
 <g7qklr4fx7qria6yeztybimqa26nyysmalbr7vbotjsojw63cw@6n36krmjw77v>
 <CAHp75Vcz1Syosz_uSOka2RCWP7-xiRB5f4iqmWkEPz12iLmkcQ@mail.gmail.com> <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
In-Reply-To: <yvqbio6ip6zeycuccihiqnxpho4p7bpg6uk53zgdbwazlwpwkk@lozrfgb7ul7d>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 15:03:30 +0200
X-Gm-Features: Ac12FXyUcjS46EBoUgCdcY7HEYlh-tL8_Uv1EuPpVFqVCfcCJsrPbH8mjeqDANo
Message-ID: <CAHp75Ve-dYcD1j0n3PeRbUJO-8TR1ADyKp-u75sLysNp-uNxwg@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Fix prescaler usage.
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:48=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Mon, Aug 11, 2025 at 01:53:20PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 11:42=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > > On Fri, Aug 08, 2025 at 11:56:23PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Aug 8, 2025 at 6:09=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > > > +       st->r4_rf_div_sel =3D 0;
> > > > > +
> > > > > +       while (freq < ADF4350_MIN_VCO_FREQ) {
> > > > > +               freq <<=3D 1;
> > > > > +               st->r4_rf_div_sel++;
> > > > > +       }
> > > >
> > > > This is a reimplementation of ffs()/fls() or similar calls. Do you
> > > > have a plan to clean up?
> > >
> > > Oh so? Not seeing any direct way of using ffs()/fls() for achieving t=
he
> > > same as the above.
> >
> > Bit operations are hard, I know :-)
> >
>
> Even more in the morning :)
>
> > r4_rf_div_sel is a power-of-two shift to make sure the freq is just
> > above the MIN_VCO_FREQ. Of course it's just a subtraction between
> > fls() of the MIN_VCO_FREQ (which is compile-time constant, I believe),
> > and fls(freq). No need to loop, really.
>
> Yes, I agree the loop is not needed and if I got you right, you mean some=
thing like:
>
> if (freq < ADF4350_MIN_VCO_FREQ) {
>         st->r4_rf_div_sel =3D fls(MIN_VCO_FREQ) - fls(freq);
>         /* But then, you would need to re-check the if condition.
>          * AFAICT, it is not guaranteed that we will always get
>          * the condition right just by subtracting (or shifting freq til
>          * the same MSbit)
>          */
>         if (freq * 2^st->r4_rf_div_sel < ADF4350_MIN_VCO_FREQ)
>                 st->r4_rf_div_sel++;
> }
>
> So yes, we can skip the loop but in terms of code it's not really convinc=
ing me
> to bother in changing it. I also don't have HW with me to test it (but
> it does look like a safe change though). I guess we could also use
> ilog2() but I think we always need to recheck to see if we need and
> extra shift.

Yes, ilog2() to make compile-time constant for minimum.
But also one may think more about this and come with the idea of only
one check. I don't see why the second check is needed.

The question the code tries to answer is "how is the freq lesser than
the minimum in terms of power-of-two multiplier?". I have that already
done in some drivers. And that becomes fls_long(). See implementations
of roundup_pow_of_two() and rounddown_pow_of_two().

https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/8250/8250_=
mid.c#L220
https://elixir.bootlin.com/linux/v6.16/source/drivers/spi/spi-pxa2xx.c#L820
...

> That said, I would ack a change like (or better) the above.

--=20
With Best Regards,
Andy Shevchenko

