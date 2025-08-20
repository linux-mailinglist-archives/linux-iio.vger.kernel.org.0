Return-Path: <linux-iio+bounces-23040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD4B2DAD4
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615A416D686
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6722E36EA;
	Wed, 20 Aug 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b="dpUfAp1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B11DD0EF
	for <linux-iio@vger.kernel.org>; Wed, 20 Aug 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689041; cv=none; b=GOW2o2yeBRd2PfO/WyDF0NrUI4tg6M4emx82KOFAGkn32HI9V9admjATlngPgWEy2xY1mgQYgd7Z7F+yfBX81LQSQvOCp5Pxopcvd272QOqPbQ9FItMoxj+h3xv9Q/EAnyVUHDjbtRMnEKkP4IcHuE97G96As7ewYd81oCz/usA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689041; c=relaxed/simple;
	bh=UhHyPozX0odQpJc/n9XPTsJIGk9+e4KXyVt3bylUIPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CAfDTbOIgSDkQ9HUZ3iwrkBeyfRn4Ux20Rbgntt2ER7uTf0EvnN6UV/AyIJPCCJShqvFbjJCG6WrtE74BMQICyy81ATok9mJTYZHUJDoJJxwdlM5P0QK3Rk/xayWfFgE7YhPBXEzyZ6T0TSL2S61wvzKVonSTNwGz3oBKeA2xfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b=dpUfAp1J; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a88dd062eso53239836d6.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Aug 2025 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter.com; s=google; t=1755689039; x=1756293839; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCMtCboUfW94QpH+yFncs/9W+nHz1Cv0mheEViGA0Oc=;
        b=dpUfAp1J4Q9AVVsw8353ZSEzGyRjNQ0if621fDCaw95/hvP/2rNSbJgd5PwGAxuAtM
         oMgj4Or8cJLGhp1G/lhn9ZnOrRP/5c7MHq2u7EXo8UZ/mJaMoBkvVHkXgLAwrAa51EZA
         VMIWsXKyyI4QFV3LcaTwgvRAx58rqfnYCfBM6ILeDZ1ceF6dC2bh+WL+EIraiaiyFAOG
         9vpEPDEd1gJud8mpreY4O2cPqjPCU19890T2d6qx2e/mcSEWsSaMJBIpfRloD+XJWAJU
         isGxpZPhgGIkfqbKC5FJjwpq4HUUVCBBsaRrc5QORwAAyDVV49ggTEiKma/Ojr67jYXR
         w/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689039; x=1756293839;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCMtCboUfW94QpH+yFncs/9W+nHz1Cv0mheEViGA0Oc=;
        b=MMjM2oaJ1qh/tUlyk1D145TW+iIhpQWgDVZEfae33hDRTJzJKrKRr+u01ASEkoRgol
         O0R5Q/tkluzqCrhcr2qr5uA+vZLDJOaPgnX/QtJruB0dljfmQP++NjXd/ZLbFf8SY3Xd
         mKZhHYIolaMy4GSeuwq/uaBj2pK0fkASSTXzBPi0GlTCzZ9/g9bmk+kO0DvY533+OiBS
         OGACXRlcwsfaOg7NOVzGa5fSoEBAN7bLNkJdh381qAq5WczaGeLng8lyVruGq/5+PyHU
         PEtLKAUV8YFoLpjM5cFFQJ4oDEno1a2PJ67zZSaPGSKwBYajXnjvSBzmwcg9hG4MjRwx
         MLMA==
X-Forwarded-Encrypted: i=1; AJvYcCUDqW1Dti3gzUaOmJSaIFjatF3eyf249mo49lHrzszTXiCIFNRqSFOhQwGAf3EOTDjHmY2067+fMkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZfOsxPYTPIm8a7RK6eK/lCb4yeXFcPXS6qG5Ud9jt6Qd/1Ej
	OTc45N90+0E6xr8j5BU7sxIF3PjbD/oI9KFwVmVbi2VXOj8HL29D19zDC07asnkV9A==
X-Gm-Gg: ASbGncu/561aJQ2xSIS2pNCnop2TpSeAatARGTdOzcEGu8x2BNwm5VSZ4AaWK+F6ANj
	QDwiF2gLkVgoGSR6typ+2vHbogoga1qGLNPeZ0Hr7dI1BJJBbXG9JhV6743nuVNmVflmnOJM07/
	U9muYdC7XdEeddaQDcWC83kah/UBUQ+vW9S2lKvVWQ3HqFgBPWkepSV7O/DUxE8GV7HMhY7X8nl
	ZfrFIiQaYw4iYVwOkkQ8xwrpB4XpIDIVx6ax9C2b9sfP51pd3KDM4lm6Kn0URTHjFXl0DOtqHo4
	87qxaxpq6+oD+wM00p1pJhhpzaWzT/O5abfWHeQtEPpRPcXDW4Y/28FbKxAvG1grDbWJotNLJrI
	HzltNIkff/7wkkG+dlFUZljocTN6uM6o4Q4xjVxuFHjQPJihU+xta
X-Google-Smtp-Source: AGHT+IH1hcwPIxMAOH1JIxmw72ltzpEz2LgTGzXf+jG1+prL3dn7s8ZR+qRo9R/s9FfyL+LmXMoFbg==
X-Received: by 2002:a05:6214:5018:b0:70d:6df4:1b17 with SMTP id 6a1803df08f44-70d771eb187mr23497496d6.52.1755689039040;
        Wed, 20 Aug 2025 04:23:59 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92f924bsm86632386d6.46.2025.08.20.04.23.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Aug 2025 04:23:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Recognize chip id for mcp9601
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <00D2ACBD-DE50-4132-8DF2-46DD97DBCE3B@watter.com>
Date: Wed, 20 Aug 2025 07:23:47 -0400
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
Message-Id: <1C592E6A-8F14-4BCF-A760-CABE6642276C@watter.com>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
 <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
 <CAHp75VfrRJmB-Q6TM+Tiy79_q63=cOvyrePMQwi6ZbvDNUPezQ@mail.gmail.com>
 <00D2ACBD-DE50-4132-8DF2-46DD97DBCE3B@watter.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 20, 2025, at 7:11=E2=80=AFAM, Ben Collins <bcollins@watter.com> =
wrote:
>=20
>>=20
>> On Aug 20, 2025, at 6:07=E2=80=AFAM, Andy Shevchenko =
<andy.shevchenko@gmail.com> wrote:
>>=20
>> On Wed, Aug 20, 2025 at 2:45=E2=80=AFAM Ben Collins =
<bcollins@watter.com> wrote:
>>>=20
>>> The current driver works with mcp9601, but emits a warning because =
it
>>> does not recognize the chip id.
>>>=20
>>> MCP9601 is a superset of MCP9600. The drivers works without changes
>>> on this chipset.
>>>=20
>>> However, the 9601 chip supports open/closed-circuit detection if =
wired
>>> properly, so we'll need to be able to differentiate between them.
>>>=20
>>> Moved "struct mcp9600_data" up in the file since a later patch will
>>> need it and chip_info before the declerations.
>>=20
>> declarations
>>=20
>> ...
>>=20
>>> +struct mcp9600_data {
>>> +       struct i2c_client *client;
>>> +};
>>> +
>>> #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, =
cj_ev_spec_off) \
>>>       {                                                              =
        \
>>>               {                                                      =
        \
>>> @@ -123,10 +133,6 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>>       MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
>>> };
>>>=20
>>> -struct mcp9600_data {
>>> -       struct i2c_client *client;
>>> -};
>>> -
>>=20
>> It's not obvious why this piece of change is needed. AFAICS it's a =
stray change.
>=20
> The explanation is in the changelog above. A follow up patch needs =
both struct
> declarations to be where I added one and moved mcp9600_data to. It=E2=80=
=99s just ordering
> so I don=E2=80=99t later have to forward declare new functions for =
filter_type, which make
> use of these structs, but need to be in the iio_chan_spec =
mcp9600_channels[]
> declaration.
>=20
> I guess I could move mcp9600_data in that series, but I had this in =
here before
> I split that series out, and it seemed simple enough to leave in.

Correction, patch 5/5 needs it. Either I move it in 4/5 (cleaner since I =
was
already adding a new related struct), or in 5/5, or a longer reorg to =
include
moving that struct and mcp9600_config() in the mcp9600-iir series.=

