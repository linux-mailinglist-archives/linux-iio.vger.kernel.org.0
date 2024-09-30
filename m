Return-Path: <linux-iio+bounces-9926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F298A45B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D89D28292F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 13:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271518FC93;
	Mon, 30 Sep 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZOEIdwe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FB18F2DD;
	Mon, 30 Sep 2024 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701856; cv=none; b=KE+2F3snyoXPumeIQ5X8m26tSaC+HQWzbMICZwbGcpmf9vC9VAawt2EYjq0B62TeptbTqvto9iz4XYdhogA6APYlD6sn4FznhhQ657hazj4bYHGENz5A0+QIt3+l/UQr6R42+6ZldLD8O7dr3ZPCa7m52iarZVGdgWR3TGb2NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701856; c=relaxed/simple;
	bh=MsNBzkkOxOwUVNVjEhVI8pun/ecfev3LMj5pMkngkAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugGAEHVUVLWO7T5DTBXYB49NxINu+9sm6EaO6Yb118guKbjvLEu7l/Zvm66i0AGUxp27DgYCDxkZ8KPOkd08AUatOklPK8K58S+/i80Cq1CfKNdBvdwH4nAV3zjOYEiRqtZ8Gl7Emmv5agbRShSYu0D6ybhAqE4cr+aDZopAKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZOEIdwe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398939d29eso3041678e87.0;
        Mon, 30 Sep 2024 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727701853; x=1728306653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsNBzkkOxOwUVNVjEhVI8pun/ecfev3LMj5pMkngkAE=;
        b=ZZOEIdwej7XTtQfD/dsM1C9/U96tAI+gvakmEeWtSgY54xKCSZbx+qwYb3g1dpMQwq
         yL1EvgPq8ouTuUt0SdPNlnE3hDqLPCUMLTz2bGC985hblBu+scCuYv/s2/rQrfAtCc+T
         soidmb1ju8lujoST7mO0YX3C1nhPf3Wjf5zKJeEjBPlnYnEWqelNUn3fIeAIOLSnEbJD
         c+uIt4lVV+sTBI6zNxLIuK3SMRLnkZrAKeCNrDWydsmDSro0TaRr185bjZGMKjQgMKn0
         ivsOy+EhDKDaQDCNFdcry+wMhL6zDtCTKymDsyzpskhc05mt5fWllxIuyZMmmIEab9Za
         xWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701853; x=1728306653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsNBzkkOxOwUVNVjEhVI8pun/ecfev3LMj5pMkngkAE=;
        b=WdhYD/iBNCklA/rBFC86Gsn5rHVOkolKhPYpaSbb5J5qENfGhKqfFQtvRSPmSon8at
         VIvp8XKZWVTgvk7gihY0GiaOPOA+Xn7mCkOdeEXm6/+SEfJl0k8ETqoRHpfPoWBF6Vxs
         /WuvEL+kCEil7vFN3vYPksyfORrhbKGeaBkJJw+j5PQaxMHks3yGEPopY5cr60h1Qsvi
         dl+NrS5qE9NMIZm+oFU90uQvRtGaFWnEh/4c8Hos/3J8CuZLm1/3iIQVtbsTWo71MTuf
         ZS9kHcoV0vkYoUdAVeKssMalD2o00bAtvol+1HIMXEFMHEicSP0NtD0Bc3ONMRMdrrt8
         JDuw==
X-Forwarded-Encrypted: i=1; AJvYcCUJLOzPma9/kRuGi78x7uer6/8AkScmA6kGaXJ9dx44/dT0KM/n8FZVdfjc166Pr9dVJ/CS5XrHd8Qb@vger.kernel.org, AJvYcCUfGglNxO8FiGZYFt6youH4dxMV/fsdg6Bl3c9uowv5xsHofSg7jFmkSiqEEygtJscP3dJtNcdy39nw@vger.kernel.org, AJvYcCVP4MRDkE4yW0vHjPJ5BDv97ye4ovO/pTJcTOE7rM4heD1FwGMmMUa7hNgo9nLDDhK7SQGo6OlekAfF@vger.kernel.org, AJvYcCX1hpecKjM1P0XSebojurPShlENMTjdwIYu/wOv9mqG97FPmCT5sCmkFXkxSTym6Tzl/bDGI3LAvpgfBcyP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RaGKKJ4qY3o5xbHoa74N5RwfnDDDyFmUUXbp3i9ZLPzmzpAn
	oVOcHdi2R8YGRZ2aErKQxx1x1TiIAeN0m4aHCFs1XCPH05LpWX0a
X-Google-Smtp-Source: AGHT+IGJaBMVIPRV8/Hnao8AWBVPUIlmy3kBZTBg1lwUwo0SO22GBzigdY+To11KOesjNu6mJq/oTg==
X-Received: by 2002:a05:6512:3e05:b0:533:47b5:c023 with SMTP id 2adb3069b0e04-5389fc3bb57mr5468997e87.13.1727701851197;
        Mon, 30 Sep 2024 06:10:51 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88640fe9asm3469538a12.82.2024.09.30.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:10:50 -0700 (PDT)
Message-ID: <6ce76f0a7c503cc800b4795e682f91c8bfc0bb7a.camel@gmail.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r
 axi variant
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com, Mark Brown
 <broonie@kernel.org>, 	linux-spi@vger.kernel.org
Date: Mon, 30 Sep 2024 15:15:03 +0200
In-Reply-To: <sowmuxfsedwdshyothf7jc6mcrbzqbs2vzw7x4p3tg3iqnlnjt@5qa3kazkce46>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
	 <20240929114606.7500ba7e@jic23-huawei>
	 <sowmuxfsedwdshyothf7jc6mcrbzqbs2vzw7x4p3tg3iqnlnjt@5qa3kazkce46>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 14:52 +0200, Angelo Dureghello wrote:
> On 29.09.2024 11:46, Jonathan Cameron wrote:
> > On Thu, 19 Sep 2024 11:19:58 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >=20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add a new compatible and related bindigns for the fpga-based
> > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > >=20
> > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > mainly to reach high speed transfer rates using an additional QSPI
> >=20
> > I'd drop the word additional as I assume it is an 'either/or' situation
> > for the interfaces.
> >=20
> > Do we have other devices using this same IP?=C2=A0 I.e. does it make
> > sense to provide a more generic compatible as a fallback for this one
> > so that other devices would work without the need for explicit support?
> >=20
> >=20
> no, actually ad3552r-axi is only interfacing to ad3552r.
> I could eventually set adi,axi-dac-9.1.b as a fallback, since it
> is the "gneric" AXI implementation.

Yes but the generic IP does not have this spi bus implementation so the dev=
ice
would be unusable (unless I'm missing something)

- Nuno S=C3=A1



