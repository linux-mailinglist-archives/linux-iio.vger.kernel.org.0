Return-Path: <linux-iio+bounces-8364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008294D1E5
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD82F1C21554
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBE196C7C;
	Fri,  9 Aug 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jULkZh8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968A190470;
	Fri,  9 Aug 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212737; cv=none; b=nR/LZ7DmR48B7Qb2jx6Zf26xcDOz/QF6YtEwALYzr4FWeizZBrjaVpv3WDmsBg0Svy8eCPIqsy7Fo94zmQaZXvX5szbS8Naz8Rlju29rR7g7/C2dFY4OIC2e7C1Ks8TLxrsv6r27S5ySWrHLY00PZQmKKWVJ+lCengcSQgo+WyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212737; c=relaxed/simple;
	bh=8trzoev/qoOx5nzavVt9N1QMPcwibmfbCnIw++QA6J0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5KHSwSju9dtUJ3er25L1Eo3l/ChYcuY9IGmH4IN2w95SZz/ath0x9b6BtdbNflBhEWqzSFvsuuTALHebmfRlEJct2cBfTbqFJz2rxd2ZdYI6Sacsyx+vMTO7NwUBweH1DuI2DJ2ugGj2xebkUMARRJtkkCAukuHbyVQlRiNYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jULkZh8J; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso2316966a12.2;
        Fri, 09 Aug 2024 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723212735; x=1723817535; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8trzoev/qoOx5nzavVt9N1QMPcwibmfbCnIw++QA6J0=;
        b=jULkZh8JE4nXzxfOD7Gl+ZYyQshbnkCw5gQmf7o/t8A8nrOTX4xCOABqCSSzta0Klx
         dK0yuwktBtbXGhclElQo5fh+7K9E8eVYu924LGJw9hQxZhzMfig48v8OltW3k1KxnYMk
         mAIi1ByiZ2144a04mUVSAT6JxsMyOAgaUQX3xM2P16Au8ypBjKy8avNZSMpKHd0+plOs
         N0sHMRvTDLqfwKPNkf31hmmMJRl5yA/Q0rJcbBf1jGTdpMyZ/C1ESRJm4bqhpWIVbBcn
         HfIFXHu3UNCkt9OSbu1DIebM7Tpec0C9vZe72bilqtmW1geESx0scd1xxTXMhdAOLexk
         nkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212735; x=1723817535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8trzoev/qoOx5nzavVt9N1QMPcwibmfbCnIw++QA6J0=;
        b=Jm3hQnqV5BPM597Ics87y/bfaKVHtd6DKp7OF2rYr7v44IBVjjOHoqcoppU04XwlnA
         hq4Q/5mHuopAwySeZJw0mcfnTErYWX7m353b1xm7ksfBYwn6KwxnnH5svEmtEO5vB9H2
         Te6boXEYng72RucrZmSUySN1QZ7xhdEyKW9wtlzXrIlztNsq88wKEhX0kocdyqIsOepK
         38w5yczw/iVVyF8ECu9s06jrn+OJQggslG8Gz6aXCehonshYd3641H18zO82HthYC+Dw
         BpWRLKsTebuuZMKHhINHvToUa+EuoJ4jDL8cFxUjXVYjNTlQkeCUVhd2PU9T55aqfofh
         ENjw==
X-Forwarded-Encrypted: i=1; AJvYcCVM8SR6+O8ZOq09jxBxDzO8bQDS2/uI+cGBrEALl4V5i2300E+Af/JnOfKX4kfOei/912Rd4fGRJ3dliZV23smkpUcWZfmV7KLiwfZlFZj7c8vBGYFlZbpBDkPnhoFmk3zO+ZWTdXev2A==
X-Gm-Message-State: AOJu0Yw58GZjCbgiWV0J4RvEkOAZrcvyrkREFuZ3r2EehGxSx8JzSCmP
	YtozytbMdUd0MINCXuF+uoIa1agFZ/SfzX8/f9tYSz/pc0BVIdkl
X-Google-Smtp-Source: AGHT+IGoRVpT0k8+hvXHLJJFKG5lErVDFjISyrXnXnx9nQks9sbygH4zccQ9yTmUiLuNtg/Dj55TEw==
X-Received: by 2002:a05:6402:51c9:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5bd0a5d86e3mr1201715a12.22.1723212734335;
        Fri, 09 Aug 2024 07:12:14 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf813bsm1550235a12.20.2024.08.09.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:12:13 -0700 (PDT)
Message-ID: <7b032190f3009dfac9ef88c972362b9dc0f6ead5.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for ad4113
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 09 Aug 2024 16:12:12 +0200
In-Reply-To: <39fa2711-7bd6-4c12-a668-9a3af33283d8@gmail.com>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
	 <20240809-ad4113-v2-2-2a70c101a1f4@analog.com>
	 <1a3dc92c4f91d271fd54f7b77b2850cd4d95301b.camel@gmail.com>
	 <39fa2711-7bd6-4c12-a668-9a3af33283d8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 15:32 +0300, Ceclan, Dumitru wrote:
> On 09/08/2024 15:26, Nuno S=C3=A1 wrote:
> > On Fri, 2024-08-09 at 13:33 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > This commit adds support for the AD4113 ADC.
> > > The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to=
-digital
> > > converter (ADC) that integrates an analog front end (AFE) for four
> > > fully differential or eight single-ended inputs.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> >=20
> > Any reason to drop my tag :)? There a b4 command that can help you with=
 it.
> >=20
> > - Nuno S=C3=A1
> >=20
> >=20
>=20
> Yes, I added a new field to the device info struct and changed dt parsing
> because I missed in V1 that this model actually has a 16 bit data registe=
r.
> I considered that the rb would not apply anymore and it would need a re-r=
eview.
>=20
> Thanks for the b4 suggestion but this was intentional :))

Got it. Next time mention that in the cover...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


