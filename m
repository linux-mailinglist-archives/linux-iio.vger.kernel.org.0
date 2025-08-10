Return-Path: <linux-iio+bounces-22537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCD5B1FBF3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 21:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65C57A98F7
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2041F4281;
	Sun, 10 Aug 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srle1TXh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03444A21
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754855429; cv=none; b=lI/2OCBgQkTw2x94kqYxDUAtYJUC8CkoNl+O/otuHumieNnhZQ+31gkQgcZFeNOCklNvdb6WJAtIV0VOh5cBZ392FrQh4Fk7AOl3MgWIF4sp2Ndnd2H6+HLuVEdRAttTGC7KMZmXQM5PDdE1KmHxs8Yl12GQsPsOMhDRa99BnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754855429; c=relaxed/simple;
	bh=h9EPvICVeo9hII6BhDSrx3o/JqTpv5xpEFpXZhkDtGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gto15fuiYOD0LCF1VCdVHLY6gABOL8UtJhaidUX5ppsKZH841d+bMMD8GTDWFMbITDlvCKis5tiWxPgWkgHPxFBeyGfUhZUDCpnVHm6yFQVwoWGwuKGM9OgYzWqivFW/0c9Dig7s68P7hpiAtxiiVvf1ditB7nWTvAUkN2o+6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Srle1TXh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af9842df867so658911466b.1
        for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754855426; x=1755460226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HSzz7dI6Re2XRNp2end6psbX1gsJ/63ui/QVbdbRks=;
        b=Srle1TXhTfIE2omwmzcOjdNurJa/mqYaAKk956bBLT6qnQOrluQwA9ycFkKp4Vg7qQ
         EGxyCEQHU+QOJr+mmJclVsq30VY6iO5sU0COr1ZPODyJGKDsfRnoNz0BeKSUo2q5WFdv
         K9hK7uoIyxcYBsYoTo9EfDqDkAd75E6bc1GLNPQ9dOLsd7SKIFsYVv85rcvaSAsRVSzH
         cpz2iufw13+Pe040yXXoikgh65aku3NfCjH2kN3T24fZmoXwCp9SVbCjgNfSStrOpZAi
         Je1p/4OnHrVbCKpcmGa7Zu2ifkRvEo094BiG2QppxUr6p3N+J7Ps7K1QGDAV6X0RrjCz
         Wskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754855426; x=1755460226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HSzz7dI6Re2XRNp2end6psbX1gsJ/63ui/QVbdbRks=;
        b=ONG65h6pyaF0XM50SgVLz6WusTs1h09w8ClZXMVyAHFXyA1CadpaXk+dSJr/d2tfhN
         Ca7GrGyoqy7PFUh/eHjpFD8d0NBvNpdzhVZn3M/z2uwX7d/w2yIxEOemu+Ax4WFuHzKm
         qECt4jld7Ud6slY4SUECINIr9vSU1FgGD3mcxM1QemZG1ry3V5QIpfcnejGlLF8Y5cvP
         usENGNeyX02TRoEdyre1rmZJFKDkTyynXsORYY/8wE9F3YSgdE2CNebf0KT1Vp7h3inU
         NZf0q354btLtn3ezCkR2CmWfMyKjV0vNw34XBwy2LroIWKastHUxtfLli0JcelfSRroP
         46WA==
X-Gm-Message-State: AOJu0Yylb7w/9LiHUAsfrRceZREPFk1UqHGHAuuvsHb/+tlGKdBX7IeB
	6snEZjrgngLRuqCI1TPhMIbi8YFVgaB0DO1MhkGkSoY8ZAblS+MyrSWyYlg8IzhXhrwv3dq4CNH
	tOSYV//COxcOj9PiQLee9Ff40FW98kG4miE1QEuc=
X-Gm-Gg: ASbGnct0yl/d/ukgYYnNtnI6EOelLRUCbSI13NPDBLL6Ykp6EnI/VqxD+p9sQlAbkCF
	mFSrLw/d3qvjA61mZ6T25ILriOOiL2CtjwZEAMSh+pDmwC2MA29PgbcRCY8G2liBYwMfN82kNLz
	F3w0coz5oMyECLDkgpcnf9PntWjj2lsYCwhQM7T6WGOgibpC1t6G6j4AgpWlmPdjKUUMuYgSTKe
	9Ya+HxASQ==
X-Google-Smtp-Source: AGHT+IFL3SISzUcrcXybbBMx6AhHQEDVIFJiU6H7xo98GoHrLcwxq/MMPKYRozB7mtmc7ktj70psiXt5uR8ZYsDRkRA=
X-Received: by 2002:a17:907:d25:b0:ae3:6ff6:1aad with SMTP id
 a640c23a62f3a-af9c6381f3fmr971977166b.14.1754855425832; Sun, 10 Aug 2025
 12:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20250810185846.114355-1-Achim.Gratz@Stromeko.DE> <20250810185846.114355-3-Achim.Gratz@Stromeko.DE>
In-Reply-To: <20250810185846.114355-3-Achim.Gratz@Stromeko.DE>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 10 Aug 2025 21:49:49 +0200
X-Gm-Features: Ac12FXwTc14I77BTD5UpggoeMWGhp1VOow9UIX-6Q4QBDLUu92x2QBE8saFcFAg
Message-ID: <CAHp75VdYRRR8OOSSkC+x3ihcUVjvm5eDinsZhGq4bCr2FJKYrg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/9] iio: pressure: bmp280: implement adaptive wait
 for BMx280 devices
To: Achim Gratz <Achim.Gratz@stromeko.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 8:59=E2=80=AFPM Achim Gratz <Achim.Gratz@stromeko.d=
e> wrote:
>
> Currently the measurement wait time is fixed at the maximum value
> according to the datasheet, resulting in about 15% overhead compared
> the typical values.  Implement an adaptive wait that uses
> regmap_read_poll_timeout() and optimize the polling parameters so that
> the overhead is reduced.

> Link: https://lore.kernel.org/linux-iio/CAHp75VfQxSgQwJQsym9X58G6o4UUgz6E=
Q4ouhhx82aOHv_if2g@mail.gmail.com/
> Suggested-by: Andy Shevchenko <andy@kernel.org>

I'm not sure this tag may be used as I suggested implementation detail
and not the idea behind the change as a whole.

> Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

This is confusing. Does it mean you haven't tested the patches without this=
 tag?
Note, it's a must to test by the author that's why the tag is
_implied_, no need to make it explicit. I.o.w. author of the code is
supposed to test that before sending (or comment that the code is
untested in the cover letter and/or comment block of the email).

> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

...

> +       /*
> +        * Split the wait into an initial wait of ~94% of the typical

wait --> waiting time

> +        * measurement time (which is ~87% of the maximum measurement
> +        * time we have calculated) and then use a polling wait until
> +        * the measurement finishes. Provide 2ms extra slack in the
> +        * timeout value to compensate for any error in accumulated
> +        * actual wait time.  Minimum two poll cycles, but maximum 2ms
> +        * duration where found to be the best compromise in overhead

where --> were

> +        * over a range of oversampling settings.
> +        */
> +       initial_wait =3D (13 * meas_time_us) / 16;
> +       fsleep(initial_wait);

What if meas_time_us =3D=3D 1?

> +       meas_time_us -=3D initial_wait;
> +       ret =3D regmap_read_poll_timeout(data->regmap, BMP280_REG_STATUS,=
 reg,
> +                                      !(reg & BMP280_REG_STATUS_MEAS_BIT=
),

> +                                      MIN((2 * USEC_PER_MSEC), (meas_tim=
e_us >> 1)),

MIN() is for the constants, please change it to the proper macro.
Also note that this is a C language and not LISP, i.e. remove unneeded
parentheses.

> +                                      (2 * USEC_PER_MSEC + meas_time_us)=
);

Ditto.

--=20
With Best Regards,
Andy Shevchenko

