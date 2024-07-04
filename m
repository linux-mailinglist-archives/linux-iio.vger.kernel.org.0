Return-Path: <linux-iio+bounces-7291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395439270EB
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649A11C220E3
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10E1A38DD;
	Thu,  4 Jul 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBBi16IT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9E10A35;
	Thu,  4 Jul 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079399; cv=none; b=P3rs9Nznc3vuY6anZ4O89LW8rQSrtR1cGrWvVd4bmL0VCYvlwDiZwPLkcKGYz37F+uh0yzNQjdSLlFDWRBJJYMnU4aUvBO47uan2DGbB9WrY1I5kw2hw6UPhDPl5WKk2TbAG3Xrl6ksXg4ug9Ww251xTO7+IImbfBVu2LfrzjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079399; c=relaxed/simple;
	bh=eXoEfEDUhPIsdPFhEHPGkSbI+CpdLSHqxgirIgquARQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWsS0Ooww3e0Dbu8bSHeqDHnJpchKDigUBOOoLW5SHpTcxOnWZnIoVttNfRLzVEpPrbjzpYSNm2C5tqXtFkgGvPYmDsM3gBVeajYhTgQjaTUmUEC5YJ5HVNlzr2J3kiFmjiK1HHtKey+img+LJTJhG0aLPaFzQ0swFrhJ6xAizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBBi16IT; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-36740e64749so208464f8f.0;
        Thu, 04 Jul 2024 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720079396; x=1720684196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXF5fvNSVNnijHpAqaWCUXg0GRUfuvvx2Ri9liUQ3RQ=;
        b=JBBi16IT/mL0L35ylNlZ8CsLjo/GnBRV89Y0pbpsEQdWplOVQ1kXhW0vTHPbOHMIPT
         b+3bwe/iP2941m6vc22rJD5g5MRZgFI4R29RXOgRHbvr3C7fOuFJJzUeYpY6Q7dPRY6C
         ZIL9zhdpILpMZ9NgUNmsAVzvbml9bbX/RvJ4KUt8Lrz1I05L/aPQDt15SRy/0F6Li3F0
         yDJ5yV0putu7/BGKk9+1v4GtaexuB4VwdH8S4+Xa7EOuSGg4L5aGXwddT72KM7lcaXZ7
         Iyj9DUd9Q/DARFUdMfTDtn3dZbqAWmPoS2mvCcDye50FNidxPY6WLwEbqr6tblO7Vwuu
         drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079396; x=1720684196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXF5fvNSVNnijHpAqaWCUXg0GRUfuvvx2Ri9liUQ3RQ=;
        b=HDJH1U9GG48P8iziEZwJpYEHxOEm0XyNZMPc6Jv67fkRmhQuIEY1IniS/MeVexTlgF
         3LZy8QovU/tG0Q3Y9vQVN/nwHDH7LJgfF8EMvO377XB15nsDjQTYktSnsQ2oAefjUu/O
         p18xBYRPwTOFEZ90lpU2E/6Yj0upg0kaZX0ZWlzygUrDl7mYxN0at+N45H3nqHDzBjRK
         tyN2JE5U6d1KeK022oo3nd3WqG8PD8HhFfNp7P78XdLaKK/c3t+kBJho2l1ikE1gPt67
         L2r9lb5dBEZmqtDEwHypvry6Hg+xcqGVN6HKiciNGtogf8HM5yessHIQYR/VK0GMZe/u
         2J8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ0l9J727KB65HTKbBAwTdvb789A9Ekxy5B8C51l9WNMlzFZHr1TqiwsJtFZKV704x9OgEIsvW9yaR2Ps4uQkONJhpbDZgtq+EWbSd3s6rqtG1oLevvgoGSh6sVfFk2H7Hhf+7GGh/Q==
X-Gm-Message-State: AOJu0YwWbhBYqtjF+pRBLxOX0j2XI/ph460FD6ROrA6yX62Oo0602i6f
	CKXQhrxiyJ30jsDHN+k4YgWFySykHcpni3+T7HoeU3S7mYeTk/m+EuFpP+/NphtG1CqVf9CxUdL
	bHuEBISAgFlLaM9hDQD/0nh9iiCY=
X-Google-Smtp-Source: AGHT+IHqVULQoitx2c/DCLHKRuLlCEm/ZrRUleMD4LP1Y7vilrJmmjPSOZ5NfKZjflTllwID5//Xka+DuYnV0VxOLUw=
X-Received: by 2002:a5d:65c6:0:b0:367:43ce:9c91 with SMTP id
 ffacd0b85a97d-3679dd29679mr455950f8f.27.1720079396197; Thu, 04 Jul 2024
 00:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com> <64fd897b-f87d-4a17-af92-5c6ffb481061@linaro.org>
In-Reply-To: <64fd897b-f87d-4a17-af92-5c6ffb481061@linaro.org>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 09:49:45 +0200
Message-ID: <CADFWO8FF24UyoD9cfF5NL1OzcHErx8+=bJYLrajrJNHFseK2HQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> >
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor =
is
> > accessed over I2C.
> >
>
> ...
>
> > +
> > +static const struct of_device_id sdp500_of_match[] =3D {
> > +     { .compatible =3D "sensirion,sdp500" },
> > +     { .compatible =3D "sensirion,sdp510" },
>
> Devices look compatible, so express it in the bindings with fallback to
> sdp500 (oneOf, see example-schema).

Hi Krzysztof,
I tried to understand the explanation in the example-schema. I must say it =
is
a bit confusing, but I can't offer improvement because I'm not sure I
understand it fully yet.
Can you verify if this is what you expect the bindings file to read?
properties:
  compatible:
    oneOf:
      - items:
        - const: sensirion,sdp510
        - const: sensirion,sdp500
      - items:
        - const: sensirion,sdp500

So the device tree should have either this
  compatible =3D "sensirion,sdp510", "sensirion,sdp500"
Or
  compatible =3D "sensirion,sdp500"
The first would mean that 510 falls back to 500, right?

From what I've seen it is rare to have two strings in "compatible" so I did=
n't
know of this mechanism of "fallback" in the dts. I expected to just write t=
he
name of my device (let's say "sensirion,sdp510") and the driver would handl=
e it.
But I'm learning. Expectations change.

Regards,
Petar

>
> Best regards,
> Krzysztof
>

