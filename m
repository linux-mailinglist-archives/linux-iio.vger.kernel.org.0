Return-Path: <linux-iio+bounces-18243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C305DA935E8
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5690467320
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C551270EAB;
	Fri, 18 Apr 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwqgol5G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1F2528EA;
	Fri, 18 Apr 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971449; cv=none; b=VwbNhrxegvec/saza9LDnsm7fp/xSEaPzrO+nWUydiuYrf/weauoqHfcvS0EZEyH8LhdcE89E7gsE41QMpyhSKuUmixVCsamY0bC5d+rVyYInxGvZ7fhQ/zh6QNhyewVSWZVDB8Zv0LbIe5LAdtXDfYUAWyJUBiWZgAR0xakQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971449; c=relaxed/simple;
	bh=4KJ3pqPNZl0W1Qclx3i8pKb/2af0vd6bFKDYm18M7wI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLF8AebzWJUNUr+6xDZUgWMvOyC6RxuisbyukqwEHGRTsRvxrG1R00QGBmsCVcVsBuwKuEdO4Nk80eWI6iAcdxwsqvoAcwkWl4h4ZikPdcgaVJtTqPqAa5+l6MoYKDotW6IFKwVRYuwfcG1+f2a/HW3ZgX3Ert4iwFltD9bziNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwqgol5G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1250683f8f.1;
        Fri, 18 Apr 2025 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744971446; x=1745576246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eOmMWBXTx1M9wulu1amjVALQyNz4yRMvByQadLNPKSQ=;
        b=Gwqgol5Gwv5F5aZ8mdkLu62muk1YjBdyxaWkXsLw44SMDQBZfoCkaDl22PEYhCLs/p
         I1Pgzu/4BOiUh/jCR9+0MN7Eb/3x/ZqZNwlY1JpvRoo8RLHiHVkrM7HLVIX6jNprveX+
         efEzp32y9fkwfX30iARznfYk5sXj11T3jnN6G+zqY6IuDRp3IfDOfiX0KhBhuBLO+fOw
         rQu9Nd8ZE5loWLJuCZpS8PMDaADD83gnx1T51JcF4CLeyO3he20hXN2S/jJfKWV/buW7
         hZgfqGCWHcUIQUQbxe2Z1XVqOLw5AGqcYpFwYmuCzX7wdgNw7ek5r3+oFJl4MsOayuQO
         /sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971446; x=1745576246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOmMWBXTx1M9wulu1amjVALQyNz4yRMvByQadLNPKSQ=;
        b=m1/7+8pV53LiE8kPH9TV0wFCsUzPow8pa9UnPX86jtWL6rFk5wTf2CMZgZE2Oituqt
         dQmzVuvpiT44Mff0UCo23o0iETOH+k7GkVPETKatOuHPQ5utPUBlMRvNijSQp6UI2uNT
         0Ryg9dYL6g5i5VMcs4iPkjyqo1PDErgRlUMHCzDTF4fKd4drn026SHZ/Fr/y1Guc7pmu
         vXExdErZvHNwUJQT4Yp+19I1sfK2nE2t443Lt8vi2jECSML3QoMFeVJzSXYmM8rKPmmc
         bl7WvxFIeQfJZczsVzfxUOf6nxTDd36I2C/7USq2JAwSNpqf6YXUpv/dNQsCz0nECwVF
         Jg/w==
X-Forwarded-Encrypted: i=1; AJvYcCX2Oi22q66g3ygBPd2BF7sPzyrRobZ1JQ0QyiDRJmNyjsEVeYRY+TEbsWRIgTi8GHrgzQB9F97CGF4Co26K@vger.kernel.org, AJvYcCXymtKl5LUPI0U7aXNotd7oM6oLNlQxkX0UXR795F+5VoGBKYNwwyDwKZvj6kniKcKdUiU4MMClyAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qp6pyQhEvZ0dEsB8M9cDa6bxHzWBQlFSVxyEuDN8GGMjhEci
	VHNYfZZZ0+yLa/uFbr954YyLbbE/aCuKjDRQhBgdC16N6EuTiXBW
X-Gm-Gg: ASbGncuy9/8p6XH+k/P/Q8t2FpddB5j6ZljJ66/WGGF8psjZSeeE1QGYCQtvD0JCixx
	vWENgr2C1m6hAv9nyHPFp+AqlJIle9yCDTBxCxi2Gz1gW20xyTcBULzSSNuMnxVz8H3PjuMXgkp
	QtWEhx8m3xl5vFOuKpVeANRXS7zUC0BKO+OL2LKHXeCFReBc9FkdYZU8+FOgk8a05GJjptJNl8l
	5ZkbmpmLDePQeOlZtmjy3hmpkpXuxNFDO2xcu1pDBbypjoEPvzduwWUk5XuUm70zg7iJsouuuTq
	ilS9OMjNB9R9czzAw49CKI4cYWtvGAEq6IajfG0aSwurW6BceqOHynh+F4NO/IyiqZJ0GZUcoOA
	gjst46U7YXTjp13o=
X-Google-Smtp-Source: AGHT+IEkbQ7voM8ncroqlk8dFE4Yp2MJiM8ArCnC7OxTSaJtSz0Be/gNlrys4JDijwJkyzTmUEnkmA==
X-Received: by 2002:a05:6000:4027:b0:39e:cbef:95ab with SMTP id ffacd0b85a97d-39efba397eamr1549484f8f.12.1744971445796;
        Fri, 18 Apr 2025 03:17:25 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db10csm16368235e9.27.2025.04.18.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:17:25 -0700 (PDT)
Message-ID: <5ba8def4eb147e0224bb82795aa8b01abb11c086.camel@gmail.com>
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>,  Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 10:17:46 +0100
In-Reply-To: <651b1f91-fd5e-4d59-b78b-fdd7f89247e4@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
	 <aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
	 <f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
	 <20250417184429.00002403@huawei.com>
	 <651b1f91-fd5e-4d59-b78b-fdd7f89247e4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 15:48 -0500, David Lechner wrote:
> On 4/17/25 12:44 PM, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 12:07:37 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > On 4/17/25 11:59 AM, Andy Shevchenko wrote:
> > > > On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:=C2=
=A0=20
> > > > > Align the buffers used with iio_push_to_buffers_with_timestamp() =
to
> > > > > ensure the s64 timestamp is aligned to 8 bytes.
> > > > >=20
> > > > > =C2=A0drivers/iio/accel/bmc150-accel.h | 2 +-
> > > > > =C2=A0drivers/iio/imu/adis16550.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2 +-=C2=A0=20
> > > >=20
> > > > Looks like a stray squash of the two independent commits.=C2=A0=20
> > >=20
> > > Oops, sure enough.
> > >=20
> > > >=20
> > > > ...
> > > > =C2=A0=20
> > > > > =C2=A0	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS=
];
> > > > > =C2=A0	struct mutex mutex;
> > > > > =C2=A0	u8 fifo_mode, watermark;
> > > > > -	s16 buffer[8];
> > > > > +	s16 buffer[8] __aligned(8);=C2=A0=20
> > > >=20
> > > > As for the code, would it be possible to convert to actually use a =
sturcture
> > > > rather than an array?=C2=A0=20
> > >=20
> > > I do personally prefer the struct pattern, but there are very many ot=
her
> > > drivers
> > > using this buffer pattern that I was not tempted to try to start conv=
erting
> > > them.
> >=20
> > For drivers like this one where there is no room for the timestamp
> > to sit earlier for minimal channels I think it is worth that conversion
> > if we are touching them anyway.=20
> >=20
> > Jonathan
> >=20
> There is actually a lot more wrong in this driver, so will save that for =
a
> separate series.
>=20

I think one of them is actually leaking some memory into userspace...

- Nuno S=C3=A1


