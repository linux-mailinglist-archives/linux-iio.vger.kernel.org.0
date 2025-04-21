Return-Path: <linux-iio+bounces-18432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F3A9514A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2891893E4B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F43265623;
	Mon, 21 Apr 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQnO/FFW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C591C862B;
	Mon, 21 Apr 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240431; cv=none; b=LqhDnKyX3esMirZnOQKcgZTIgksihEyRobHvgLjDKNlGl3XI2JkccNFQcFJxJp6ksdlo1xUnxvbr/ubLWboKQ/48oZ4iIiluMr9LTvWycZ293yt8kQzJrJrWRNu579F1oLrpEKNGAup56GgboDyOHkRxewPURLM2PmIMztTPuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240431; c=relaxed/simple;
	bh=4UaHNppdWI88ytEG/iUUOZ9pHL0mN5nJbgb6u8r7EVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8CEyzTs0GQlQ/RLN+em+TR2GQPvT55RnPNFRXJ7hbQMTpnI1/ykUo4kI5dhusqVNzOl9LQh7NEsh/pH9H6QXfBxFA4y6eLidwnVTIcPQYDexqnJKKhU38vNNPaTcEGSPilh/YHRMDk3HgD17c5PxgUlqVJ0obpb6niP5vWz2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQnO/FFW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso31386435e9.0;
        Mon, 21 Apr 2025 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745240428; x=1745845228; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4UaHNppdWI88ytEG/iUUOZ9pHL0mN5nJbgb6u8r7EVQ=;
        b=BQnO/FFWOIH1ABYGC0bW+KFlOxZbafP3zRErGE3Yk4c9r5dxr1QFFZcK7Xa2sBhvHA
         x0nyY0eflCJ+T8eksW0KenE7QVmS6dp857QkfirMBDgINSksk3AILqryEWK7EhomvCtw
         e0f3j0ioidONk0Mn3Dw4NWjClsGQG7sIJ9RnfTf/Jrsh8sD7QA/YRpP6ywKUhqA8xjEa
         TbYO8D5p8N3OMMrBJ4RFnGWzNXsdvkVUoh28RV2Ebhk7sy8XRuyt/o7HzSWytk4Yw6cg
         hi3Iio3K9O7Yqs8E+oHQ5oFfMp5Szg19zC2g6XfXXu9bXUoaTXJiMOhyS1kJtie1QrVQ
         8V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240428; x=1745845228;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UaHNppdWI88ytEG/iUUOZ9pHL0mN5nJbgb6u8r7EVQ=;
        b=MM9okAwJ2nxOXD5sFDeSpsBO73uXpVHtdyPtZ6j+xYEJbdYoO5o0FiTIhI9Mn6oZzh
         jR32TX6qWYmSIcaZlSPuvnmUjBySAguORrUxMz8WWhROceRBtUfJuyLyMuNQwQT6k518
         wcXrxR7eFBMcCNMhIAip95TQLKT/LtDL+qErJG5GJbcheYGYgGAxy0VD77kIu9Q/Pjsb
         w2lqaMRsIUIerlsu/KINtdWGIVenUlOK2+X8j49nJYMGYoG6EbNXuW/Bq+SuB7hohGJU
         Ot0txQ3iXVrOTLaatw06R/XufWW2z00/jMlEkbXoREqJQDhNnxsIapoyB19wO3oyfak5
         7Ugg==
X-Forwarded-Encrypted: i=1; AJvYcCUJZdplo+ZIiyeWrAmnvE70yWgG1ywzImLn7/3ln90jkhc61Rf9mi+3+nQpvcEPaVgRluKOZuMzX2XoDGhn@vger.kernel.org, AJvYcCUkI0gCBp5mHR74PTmItcofLNSiumy6CRF0o5/L9sgSLbrnvBOBwizIZB+bWxj1tSBeycPKcSh+Kn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqlIzx3ZZx+soAMJeT83bVNL3vq/EOpvH7rNrP/voHFFn6jYHU
	AUApFOX8wB3b3maEVXaVhrM8WiaFWeZiouB/uORFWwapc6fy4ny+
X-Gm-Gg: ASbGncs7pLkHfPF8HyE4Xh14lbnTgP4LwWyI/h3sQVlWxrDu6AR5M9fcXH+6ciu+RiJ
	iMlZM2W7f5LWfIKa5U2OSd0bdmCQRbsQ6VTxkb9DqcjGYUdKfG++980EqBi3g4lHJbxRIqWGcMP
	kifBP/V9doC8eQUQkrGHyBFv0SO9ztFPJu7NUmJTGPX4gZVfZ8jbAm+SOag8uOWv+ypzvyxadyj
	GFdmLyY/+hxM1YBlCWIT4b1EKC3rx6nWT/+ZJsU9tEkSUTmKGgk5Rp/P3IAAjzylkav2Oc5zjS6
	fW1DAI8nVWRW4/GWmcW6xe1biealJb/kKxcRT32BqF/ge/ylX6/NLcTDPvNB+Ta8IoUkNlminBd
	2azIph3mULK3o2LRtGwt3UoY=
X-Google-Smtp-Source: AGHT+IGVMQ4ne24Nx7XbzWYVkRotu3FUR6ZU6Bl2LRSj3DyRkFGaC62VUPRqLgCmqX10YsN7ScjLwQ==
X-Received: by 2002:a05:600c:1e88:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-4406ac0a847mr85627525e9.24.1745240427705;
        Mon, 21 Apr 2025 06:00:27 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44044508a7dsm121988085e9.1.2025.04.21.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:00:27 -0700 (PDT)
Message-ID: <3875da4e070f991484b8536f6066347615b0815a.camel@gmail.com>
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>
Date: Mon, 21 Apr 2025 14:00:30 +0100
In-Reply-To: <20250421115758.62c16f94@jic23-huawei>
References: 
	<20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
		<CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
		<ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
		<aAO7Lw13xrEGmZLL@smile.fi.intel.com>
		<9cdc7053-ae22-4ad5-801c-46df7398ebf9@baylibre.com>
	 <20250421115758.62c16f94@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 11:57 +0100, Jonathan Cameron wrote:
> On Sat, 19 Apr 2025 13:07:25 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 4/19/25 10:03 AM, Andy Shevchenko wrote:
> > > On Fri, Apr 18, 2025 at 02:09:04PM -0500, David Lechner wrote:=C2=A0=
=20
> > > > On 4/18/25 1:58 PM, Andy Shevchenko wrote:=C2=A0=20
> > > > > =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 18 =D0=BA=D0=B2=
=D1=96=D1=82=D0=BD=D1=8F 2025=E2=80=AF=D1=80. David Lechner
> > > > > <dlechner@baylibre.com=C2=A0<mailto:dlechner@baylibre.com>> =D0=
=BF=D0=B8=D1=88=D0=B5:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 Use DMA-safe memory instead of stack-allocated=
 memory for the call
> > > > > to
> > > > > =C2=A0=C2=A0=C2=A0 regmap_bulk_read() in the ada4250_init() funct=
ion as this could be
> > > > > used
> > > > > =C2=A0=C2=A0=C2=A0 directly by a SPI controller.
> > > > >=20
> > > > > Sorry, but can you elaborate more on this? If driver doesn=E2=80=
=99t override
> > > > > the
> > > > > callbacks the regmap SPI uses spi_write_then_read() which is supp=
osed
> > > > > to be
> > > > > dma safe.=C2=A0=C2=A0=20
> > > >=20
> > > > Ah, I didn't dig that far down. Will send a new patch that just cle=
ans
> > > > up the
> > > > unnecessary alignment and unaligned call.=C2=A0=20
> > >=20
> > > But do you have a real life issue with that? Coincidentally we discus=
sed
> > > similar case in another driver with colleague of mine, and he insists=
 that
> > > it
> > > might be still broken (somewhere).
> > > =C2=A0=20
> >=20
> > Some drivers that use regmap with SPI implement their own read and writ=
e
> > callbacks if the default one doesn't work, so maybe something like that=
?
> >=20
>=20
> I asked Mark about this long ago. Maybe the guidance has changed, but the
> request
> if my memory is correct was to treat bulk regmap accesses with the same c=
are
> wrt to
> DMA safety that we treat direct use of the underlying bus accessors.
> (unfortunately I have no idea what thread this was in!)
>=20
> The reasoning I think was that it was an implementation detail whether
> regmap copied the data or not for bulk accesses.=C2=A0 Back then I chased=
 through
> the SPI case and couldn't find a path that didn't bounce the data (though=
 some
> paths could have been made zero copy).
>=20

Looking on the implementation, indeed it looks like that everything should =
be
fine... However, IMO, David's reasoning about potential drivers using their=
 own
regmap_bus (or just overriding read and write) is perhaps justification eno=
ugh
for doing it.

- Nuno S=C3=A1=20

> Anyhow, +CC Mark as maybe I remembered that wrong or his view has
> changed!
>=20
> Jonathan

