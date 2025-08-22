Return-Path: <linux-iio+bounces-23157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DEB3203A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874E51D63D47
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEB279DC3;
	Fri, 22 Aug 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b="ZnNCh69a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C12405E1
	for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878826; cv=none; b=U28Sg/MiWqdNvST48TTb2LE1PUwUUdqLjFlPt2fNZIkXJa+s8MbIk3xDFMY4gkQb6hd1XAa51/hKGRdKN7bVWPjRr3v+lmgvxhQci+WNaUte6PJy5lpR9tv/qguwTzhP12motuZrTEGz5wQfOjnERo6TgxGU/pQb9GGu54a/HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878826; c=relaxed/simple;
	bh=PeFWqmKvO1chHjKzpamnENPM1xecjmZuSEwZ1WqrNeU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oTZkD0YhXxGfFaVIoN6WzhmUBEVu59N/Vdk1yYYMgmm7d85BgeJmLEegEoHVn4X/bAuQZN7GgLWzVRlhZ0P233N9VEUNmyMrkIs5cEmq9+L9+WyBicMf6UbAy0gfSDswBVkxQyxrYMl//HPcu0SX5Uiqye1CNY5nEukfdOG2z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b=ZnNCh69a; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b1099192b0so37504491cf.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter.com; s=google; t=1755878823; x=1756483623; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3a0v0yEWcj3RiPcDwFFeqOwhcQzYtQNA5v8wZVyGNw=;
        b=ZnNCh69aYatPDomewHW3izDxvTaBbOmll+HCCioEBkaP+q8OoqigkBu19KJDsO8pa9
         D4DmSAlBX5a06MTjjFc3iWNcwg2louEdBB9YwV/gxXN1IfOLyZhHqrEnamHwHOdOU/Hl
         zaXim4jO71kDYLCI/4gMc/F4jmEB0D5KNSM6YOJ0t+R5vtrAPLN9/xVJzgNUZXFugMCY
         /+j5qR6x2OCUGpTWs3Qf+Fw+cACwMTomXD1KjEP0S3fxJ3l9K5tCpNPDZolaDpTSxulv
         zXuK9RCIItVPnjyoGv6L3PG3O79kghlBAqQdrVpaokCMl/eHiMqN1aGd71uOOnHvENd2
         Qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878823; x=1756483623;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3a0v0yEWcj3RiPcDwFFeqOwhcQzYtQNA5v8wZVyGNw=;
        b=UBfJ4tkYjzBQZhN410BN2U2B9NJsR8Z/kut1JKUhAh3T5uvWdHy/Z3Ghk2hv6L3R7D
         /n2NrI349G1GK0em3gIEPpVeWErBeOnvtUmDGc8qxwOpFCk83AJO1YE5dQoG56XxzlbS
         d2qsDooa7WoAYKXsCOfTahW6/8u7g3I35JJURCwftr8xaWckxjb3PQuwwKhwRGfkK/EM
         4j4Sv3eslaFVJTtlBKXoDNq0tEGcgJb7P9xGwqOedqYXi/LMpSWRtdG1lwhd8nHhmiZL
         262bs7zwIDY6LTsoh/afTGq0EeM93yQtH5e+jkboeNJuOWXQOFoq9RBvuZcmVFgnSxYh
         AbOA==
X-Forwarded-Encrypted: i=1; AJvYcCVyx5qatv+qaeZGZRR1UGSGoUsoYHaB3/eSppml4eloV/npFhu+FegrQLmUqwViuJTXVW4QamNhZ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWil2umIU/SPUguSdZXPX0qqKtKQIOaRdiL8GZhtCbQ+WAD2j
	aqCUMmmpXWuI8WGN145kp4UIponQvsSvenkWji1O553A9KGSx2PELtGzFKYUwPC3XQ==
X-Gm-Gg: ASbGncvcvnGA085Ho57sd7XemGXCyh+5PtKp3MJqhaaAdCvlCIYkcNlna1ZbxGojIis
	sJCESQalKjVbi0XgrB+G3hzS4twFkU5hmVV4RImrdzsTRkfzKs+Stp32UoJ6lHbZRARUT53TEDv
	GaFEmLKREgoAH2PwDCf8yPJMPah85tgtPOSOpn+AP9ExyEm8x4fCkVpwjhreEDui7+Qzta4j78A
	6bnc5kdPK+4AEuEsdYEJ72ygizyWc5jlSx+bJ+ThgoOBxqtAaxS0uof0SjbdW0yWr0eFrs6MPzy
	KAWyl3YmmI7NbzxyCTmYHRvjZYh0tTCq6mHU7genyhoBgBt9UaGBULbQJHXhjGMMJGnX9L56zVN
	ZNEchWu2LeHVChi5rHkDugFZ3V8yQKYhshGdl0faueQ==
X-Google-Smtp-Source: AGHT+IHAD7H5L6yCdeTC6tSubZLEJn8ENm+E+LtaoKzBuMfi/WRcDB8L8WglMrH9i33FpqnhIRJ71A==
X-Received: by 2002:a05:622a:4e06:b0:4b2:8ac4:f07c with SMTP id d75a77b69052e-4b2aab8ac98mr53224851cf.78.1755878823153;
        Fri, 22 Aug 2025 09:07:03 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e514fesm1661981cf.50.2025.08.22.09.07.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2025 09:07:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v8 4/5] iio: mcp9600: Recognize chip id for mcp9601
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <CAHp75VdMCY3=bL2t7zWw0D1WqtiLXrWi+ptjpaxK16b8J1KVSg@mail.gmail.com>
Date: Fri, 22 Aug 2025 12:06:51 -0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C976B5E-781D-472B-B2C8-3AD22550E036@watter.com>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-4-40bb1739e3e2@watter.com>
 <CAHp75VdMCY3=bL2t7zWw0D1WqtiLXrWi+ptjpaxK16b8J1KVSg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> On Aug 22, 2025, at 11:57=E2=80=AFAM, Andy Shevchenko =
<andy.shevchenko@gmail.com> wrote:
>=20
> On Fri, Aug 22, 2025 at 4:24=E2=80=AFPM Ben Collins =
<bcollins@watter.com> wrote:
>>=20
>> The current driver works with mcp9601, but emits a warning because it
>> does not recognize the chip id.
>>=20
>> MCP9601 is a superset of MCP9600. The drivers works without changes
>> on this chipset.
>>=20
>> However, the 9601 chip supports open/closed-circuit detection if =
wired
>> properly, so we'll need to be able to differentiate between them.
>>=20
>> Moved "struct mcp9600_data" up in the file since a later patch will
>> need it and chip_info before the declarations.
>=20
> ...
>=20
>> +struct mcp9600_data {
>> +       struct i2c_client *client;
>> +};
>> +
>=20
>> -struct mcp9600_data {
>> -       struct i2c_client *client;
>> -};
>> -
>=20
> Seems we discussed this. And my suggestion was to defer the change to
> when it will be needed.

And my response was that it=E2=80=99s needed in 5/5 where I add the =
mcp9600_config()
function. That function will need to be before mcp9600_channels[] in the
IIR patch series.

So either I move mcp9600_data now, or I leave it and put =
mcp9600_config()
below it, and then in the IIR series I=E2=80=99ll have to move both up.

Didn=E2=80=99t seem to make sense to move 30 lines of code later when I =
can move
3 lines now.

Regards,
  Ben=

