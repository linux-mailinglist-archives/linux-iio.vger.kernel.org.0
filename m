Return-Path: <linux-iio+bounces-22308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBADB1B39A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 14:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B76A181467
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95156270569;
	Tue,  5 Aug 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ZALdpY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B661A0BFD
	for <linux-iio@vger.kernel.org>; Tue,  5 Aug 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397705; cv=none; b=UCE/2bFlzCVnTQln+3gVEvpmsPHds+ExabofbdLcMt+0QPQs8vmRHm0YIZP45FiIu2DRlOIvsqGWItnA8DhqBNW2GG3w4+BLBrrqS30cr+OwydaTfH2MMnk+2GzGn3tZREkgWF9drWZuEr2cfZkLABhPmPQJ/NOqUX5P/joB1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397705; c=relaxed/simple;
	bh=csoXacvin82Y2q1H2Sl/rc8mRogW7g/HQ5r3qzIBkmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VREAVbaXocabZopF9GgFnMFBYRIFe0GELPaKCorpjCtFxBGl6h8+pvjpzF7l0/8ZHVn1fqiw7nfCSL8FWbScIzoXVW54xtifi/1P/JkZFbhABzRm1qQBJEC6sU06kzY4a/bWq9oDCkMXX7e0bpQBubiq05tOQ6ZVEPCpbkou1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3ZALdpY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso8078832a12.3
        for <linux-iio@vger.kernel.org>; Tue, 05 Aug 2025 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397701; x=1755002501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJtOMjlld2BynwqxJvdPys6HUoBpeeeLGIpMOXj7T9Q=;
        b=Y3ZALdpYJgDfwJVL542CMVordvvYD0d15Zufw0BSgQAP0zhHF2/qM4CR/BKYUY8kUh
         M+xhlzlNLeQXWemgR1pIlWnaXbkQKQtiu1D8Z0xntL8l0n5NPz3qyuCV3hNGjzc+RT+r
         3zrzrEQThawxVskLse/XCWTuqAEaaPEXWhsL1w9FuVgq9HCNb4WemWYjCZfmn9aoq2N3
         chUxATd5gw/SXlWdL1WcgP+KO56RHP+DgMkGutEehqD9V5EVWuz6sk6UDaNu436IOvIF
         Y5i3YAk/gThmiGRgWvuhiQ6KVzEkyqyPflPC82mLZ76GQOnZm0gbmYgC9CRgZt5BtjSL
         x8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397701; x=1755002501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJtOMjlld2BynwqxJvdPys6HUoBpeeeLGIpMOXj7T9Q=;
        b=Ndm4i84OCRWIwT3wWpdPdmQ00OON+zXsqev4j0iTchFN+qr8QhrX2XwmvMVccTQ4ay
         26W8TUgBVOldgA8dnCMBpvuAR/ARur29K/Ve/Gl6NBcO2oovzRasA0nNcUXOUDw8/n/n
         ATaMkh29CWHMxG+kaCZUgfvr1+Xc/jB7H4+cMBaOWyiGFevFB7z316ABubPOamUnlWQ2
         UB7D646v0khFzsPwwm1aQyuEP849vOfjGyljVcb8yhUk7BH6fpsYMQGOR9MX5ggv9x//
         sP0wDuYAf2yLeq0fxG4wYbFxNXp2CVEMMIiQ1/yg/KmcqvvYvJ6HSHiPbPplERhCKa4C
         CIkw==
X-Forwarded-Encrypted: i=1; AJvYcCVyttA/W+rtBcWByIKxEhGwrfhWX8K/zAskTSpwjswELuP3/SQZirkt9FYXalpYtNSTkEIJoSFaE+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9jFlARESWHseibnP1X5vAgN8BI30AXMS1zbGwQbZRrjKVXEc
	0TT0J615pmBBwVj3c5IsU+8SZA8g4U/Zf267B02OvPk+IJl+0z4E1f+Rh02qMBbSPwuo1aBM2og
	cG5yvo6iakC50ELrM0Fq5wwiez7hVR+c=
X-Gm-Gg: ASbGncvZJ/fTpsvoOR2FU9LlKczK3vQZ5jzhqNevU+QSylWy0c+Q5WMLcMSzmoHL6g1
	uOhHmPKNw7VBqt3RTsnD67eGhM7wBSURYtqWIS7w/Jjph1fZ3uX/RIbYOvBIGVpa071qengVVdM
	YNsFBM0lLDdx2EzPKB2/scplnjEKh6s3p3BvVp5sEYHTSfAN2J/2Fdlg7+QSHmzW4KbWL4vO2R7
	EqQAIYasg==
X-Google-Smtp-Source: AGHT+IFxlLV3nZ2NT2UTnAXExeDbr/ohgWVTv6XR8CJHirQZwjQgOsU0V9vSvU8i00oWkH/6iuV2QwLphL+D9fKP138=
X-Received: by 2002:a17:907:d8d:b0:af9:2e26:4636 with SMTP id
 a640c23a62f3a-af940173110mr1299680966b.32.1754397700524; Tue, 05 Aug 2025
 05:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802171539.518747-1-jic23@kernel.org> <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
 <CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com> <zaymyis6xp4t6qz6se2xehj4gp4lzaybuu2vzabew3pxqoxtsf@36dykzwuloq6>
In-Reply-To: <zaymyis6xp4t6qz6se2xehj4gp4lzaybuu2vzabew3pxqoxtsf@36dykzwuloq6>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 14:41:03 +0200
X-Gm-Features: Ac12FXy05EBG5JQkP0szw-txWx-os4xJBhj2PdYro9e_qHs6YnJ_uXneZ6V5-F4
Message-ID: <CAHp75VcWepvA73Pv=JHZn3BAnnO=NcaEvU85p2yQrVJW_pXFmw@mail.gmail.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:16=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Mon, Aug 04, 2025 at 06:02:22PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 4, 2025 at 5:37=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> > > On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote:

...

> > > > +     /* Walk remaining bits of active_scan_mask */
> > > > +     in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklen=
gth,
> > > > +                            in_ind + 1);
> > >
> > > I wonder if it matters to check that in_ind + 1 is in fact lower than
> > > masklength? Not that it will be an issue for find_next_bit() but we w=
ill
> > > fail the expectation:
> > >
> > > if (unlikely(__start >=3D sz)) [1]
> > >
> > > And being this a sensible path, I thought it's worth (at least) quest=
ioning...
> >
> > It doesn't matter. The find_*_bit() are all aligned to return sz for
> > anything "not found anymore" cases, so it will be okay.
>
> I know :):
>
> "...Not that it will be an issue for find_next_bit()..."
>
> I was mostly worried by performance as we'll have a compiler hint that
> will pretty much fail (that =C2=B4if (unlikely(__start >=3D sz))' for eve=
ry sample we push and
> I guess the CPU will have to unroll that prediction. Maybe it will be sma=
rt enough to
> adapt.

Ah, I see now. Yeah, there might be a hint to skip the branch which is
unlikely() for.

> But as I said, it might be neglectable but still worth at least
> questioning...
>
> > > Other than that kind of nit comment, patch looks good.
> > >
> > > [1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L50
> >
> > > > +     while (in_ind !=3D masklength) {
> > > > +             ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > > > +             if (ret < 0)
> > > > +                     goto error_clear_mux_table;
> > > > +
> > > > +             length =3D ret;
> > > > +             /* Make sure we are aligned */
> > > > +             in_loc =3D roundup(in_loc, length) + length;
> > > > +             in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> > > > +                                    masklength, in_ind + 1);
> > > > +     }

--=20
With Best Regards,
Andy Shevchenko

