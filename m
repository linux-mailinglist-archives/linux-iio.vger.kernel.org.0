Return-Path: <linux-iio+bounces-22289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64640B1A6FA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789A77A4853
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60821A94F;
	Mon,  4 Aug 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuSursmi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E354673
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323383; cv=none; b=XMPzkJNCH/C4PzGjL86EPCRN5m8h7L+SEEKvdOuqSPBOeuWTsYND5rKHUoyWJPEyDxx9YcAuKxgB2JVqjrLURf+POG6mRcjO92vpmnBN37FvNRTDtPFR6kntULzmVmV97IWNG5UiguI7zoxri7h8IsitrNICBr49K5krV4xuXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323383; c=relaxed/simple;
	bh=Yc7fM3xBdY5Reb11ZNNHbPQ4ZZ0vb//SFrC/MoB5Ask=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI/4m3t6pakpJgncqYTJvswDOFfYEZj2Dz9RZAx/xAQl3wmnDvHzISonYtd+tFvtYvczkCjwYhHyCAlcBAlK3GhzBR7QlTp36c4dop0pZXOgef8Mbu8Z+LWU47CG9IHnHukJZMBMDissMcUW9vBvVgDWI4IGrSr6Tfyvker1qic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuSursmi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af90fd52147so646761066b.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754323380; x=1754928180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMyaM0y93J2fyU+H5T2OmpvFQxRRg6viemu1CIUQnz4=;
        b=WuSursmiWcOtkZq1a04jraQj43Az6RsyRK8cZ3A2A8qGISiswvDeiMmqIjalgHGCZ2
         +Sh2hm1Pfyz40wJIuZwHMhEWOBhKiabMXpleu3g5Cy/TJHVj3EIzSzFoACQqGDR0SHdJ
         4oUC911lsqVRPbw55F9hSoSX8XN34sfUTJQZMDxa/TX8NkO+ZN35K6EnbIzjJnVPiS8W
         3+rxgycXWRtP+g/8DQZlaK+g05UM/XogsKJMjVIK5HzYbv+g6QVCp1gM062s8rBryew2
         MNpbAMrE4aj2aQC5EwFdV/vasj6aMZ4SnToKS8lj70SJnndtN8MzrH8xJwdqVA8Ioica
         cRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323380; x=1754928180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMyaM0y93J2fyU+H5T2OmpvFQxRRg6viemu1CIUQnz4=;
        b=I4r7O/QAh1wtNKUntTziYKv7xieZYbnrb0qBEGiLqRJ8dAZvH/fNhiv4yc0cReUaar
         IwRfdYw+tazrx0NdXOVrD1lXcQcXIsewvSJpJ68nQjFiHBnuWQQDZQoWHU/Jt2KOqr77
         QRahw0yD7KO7fsk+hDh9fFab5VOrwLCQqv2LXjSs43imcBbLI4W1kOCx/KEZgCzE16Bm
         bx3+CmBB5VByMJp9vmM+Ul3pncVfF07OZ8H9ELClaYg2qN5iIMqVj+U6APDEN5i31Z06
         mz3rZ6E+Ynuz3wVl85PwaLNOc+4kgDy2udtEjVVoVddsr4JIENIOetS1C00w+G7pTNIo
         D17Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+POdEnkWKG+t4sbCv2mHi0ilC2zd6ovVQSeEPPIki6B90o3AUu8ZJI7c7Ku/C2+lHA4pD0w+QLqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hxnid0bdSXO7fdSmYI+vmOtuRFwb2CqKk9gip0HVAJ4AFcpx
	xTxajHC8ubfuLQYJuHDRpjXesplyRmGsu8WhASzQtYBGLqhfyPGaUn6pk6UpTBiRnbCC9yc363M
	Zpm+zy1UWfyPI5kuPwE0fC+XDWYccaCg=
X-Gm-Gg: ASbGncvOPWwlpfcIgnTXwAiBwFO7d1GJvYm22rqf/ajjPNU05/x+tIWFK68K69rBiv8
	lzWWHeotflWmrmxFIvNZ58mFXqOgrfi9YYqYogVRmVudHzesH5APKvbrGZt0arkwQbjxtfyzCEZ
	LFH5ePbJF8VdobhJeLPw6WgtA+K1eQ5lgErZeAZAfCyEhzTJ03CKWwq1G3Pu5A/iyih3i+h1Gvc
	tn/vHYTzw==
X-Google-Smtp-Source: AGHT+IHqXI1bZzrCeWM4/mDKzeq2PUvY8aDXWA2Hop45zC6sV753ViIvRQeDgv2asy/v5/jemR8YnbC5U+6rEopqm9M=
X-Received: by 2002:a17:907:1c0a:b0:af8:ed6a:a9c6 with SMTP id
 a640c23a62f3a-af94001798cmr989211366b.20.1754323379405; Mon, 04 Aug 2025
 09:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802171539.518747-1-jic23@kernel.org> <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
In-Reply-To: <73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 18:02:22 +0200
X-Gm-Features: Ac12FXzxM7sPS9eNW1r2lgtIHh7hxxU4hmzqQ6SbvSxeOl7vsiBVuq1kGjfSRPE
Message-ID: <CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 5:37=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote:

...

> > +     /* Walk remaining bits of active_scan_mask */
> > +     in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklength,
> > +                            in_ind + 1);
>
> I wonder if it matters to check that in_ind + 1 is in fact lower than
> masklength? Not that it will be an issue for find_next_bit() but we will
> fail the expectation:
>
> if (unlikely(__start >=3D sz)) [1]
>
> And being this a sensible path, I thought it's worth (at least) questioni=
ng...

It doesn't matter. The find_*_bit() are all aligned to return sz for
anything "not found anymore" cases, so it will be okay.

> Other than that kind of nit comment, patch looks good.
>
> [1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L50

> > +     while (in_ind !=3D masklength) {
> > +             ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > +             if (ret < 0)
> > +                     goto error_clear_mux_table;
> > +
> > +             length =3D ret;
> > +             /* Make sure we are aligned */
> > +             in_loc =3D roundup(in_loc, length) + length;
> > +             in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> > +                                    masklength, in_ind + 1);
> > +     }

--=20
With Best Regards,
Andy Shevchenko

