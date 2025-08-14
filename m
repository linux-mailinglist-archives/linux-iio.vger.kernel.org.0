Return-Path: <linux-iio+bounces-22716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA5B25EF4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED275A2A2A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4BD2D63E0;
	Thu, 14 Aug 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIYycoX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE20239581;
	Thu, 14 Aug 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160506; cv=none; b=FZhoIjsiF5q/QpMkr2mRywhErs2OqeAAERPwF9NjFimjh3S+onMtI5BivdmEfGXXxHqAa50AGf1BNzrdSJvcizYNkVlS18NPPO6Tg5V06iP5SVvU6DwKs41L8mYBZV2c2SY5/14h/wk8a4jwhM4OD9oDbPSNoBxij6EVaRRoBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160506; c=relaxed/simple;
	bh=btMaktMsMFdvjb/8kiNjF7N+VOtWOxJQuOFY4wPqgbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PMQXABACZh3W1iVeWD9XIvgDXtPSCRWpu+Pw5y6Ggk/tVedj1oTDlRAAQHIhKirFUfCThmb+R+xa8W67EgxSw9lyHHoDM8bvfGjHXghfAzQyZv9hUxyxlWsKN72dS9cKGTbTrmmAoW/03yjcPtGk+7CoBjI6UjlHevP0xHfmwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIYycoX5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f92a69d4so5069301fa.2;
        Thu, 14 Aug 2025 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160503; x=1755765303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7aR8S9FRLta1axStaNt4O0Wb6l880Eq2jEsm/C+nIM=;
        b=hIYycoX51mM186Jjc3Dyi6QOsiichlPNvaGGn6AgkjYcjrxuAQJXg0iS5U3jMRUZbU
         Om9hgcy+5+IqqQ7GHlJb2WPBz01ihEV5L//l4SA1lwKi5qH28+o7IZe4Wp5IGTvPRDc3
         zKiQdiCNeBgW2IMbfuuiq2YGda+OeWRzjrbtIBFlFZtNQMfXFSJemrvnwIDF1gbaPsIE
         76PONA4kniwYiGuC8JpBDiOtOSalYVfjI5DbyPlVwQDm6JiNZM6htbBUyzgCHH37Ody6
         1FxZGyYdd+Dp4B7n5stQ7YT4sgLsp14vhiq/4PuMKDfClD+JYinW5cQGTino/SufrDVB
         DyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160503; x=1755765303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7aR8S9FRLta1axStaNt4O0Wb6l880Eq2jEsm/C+nIM=;
        b=UXTyaBFaXe26zYy+HPPvafjl6NtsIy940mKJAMcNDc0msaxj0ISHnVIOlk/NfeLR7X
         cqKYALKdma9+xxnMDmtsNaCXp4kEVB5jK0w89NdCyfc9fgA12ADF80FyIU65GVCRSyZA
         JYfSsRc36+pKT1d8EKVUljmWDwZjXqKW9ThGOYCtNqMC4C8Fl9izhE4rNR0QbtkMR2Bg
         KwWJvjxwI+fVZL/FUZP8fCrNaYW42rneTxfFpajYDsfOWW/RoDOjjWwezyytDvY+qqhh
         qWqIDmRm2NrWQLgxzHt3ABoVjKSYkWR14nwQOCsVK+KiM+phCCCsjiXyZN/Yg3YQdgJr
         bCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEBYyFEyRvoM5s5aIpxRaoJn8NBdh57zHk+Wwl21THcGZKZjAvBnzZQFN8Ta73v+tBAZVrFmZmK3MO@vger.kernel.org, AJvYcCV0Vgj7FoOzghyDnJa3bgAuzLuj4oVAXJ+YTygiMJOA0Qa3O3Tnf6D1SHR9RVpQz7yqKDAcGvPDFbbn2Paj@vger.kernel.org, AJvYcCX0lzLOeoqm78bruuhSPQ3h/ffhzCT/zx1mpeHCnE+mdceZoYpatxieZTb+mn58NvYKe7GLJqXTRmaY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8OdsfcoALTosqv4aIxDGzda7pQsMuasjInNrEsHTYoiNDvt8
	KRY3hpHo1KC+rt9stlqWyseo4gY1WcdqeQvSKwFObSVf6obi1cYmJeX6
X-Gm-Gg: ASbGnct1YMG+f/yB/ajJXVI5jw6k5S63wVqE07LE3PUQ5l22q789MFRQMD3uAHs9WBi
	UyzYO/GBkDcK1buFcnN3AFzCJSnjt/9rJR6LWjTlsMeG5EW8ZPgfOCF9IdK0uEXyR8u14Oq/tKk
	CKhECQ4frNzjiXwy5qtbi581wDNXhEKu7FiD3daBka9OlZplr5+nsZnKsZUyErJpqqoqCAa5DpI
	5agGbs3OyM5bFFLaYY/onC3gWY2rrF1XciwHpCS6+VEGAJFXTQYHOfnDyIU9tenHdpsgXFM3kyJ
	RLZh7MD6b3uRVm65N7/4zCs1sZkw3TMPGeLRe74Il/RkyDAWa7ASS9ukNWl91mmY4/XSSUtFt1V
	mxOYYwapQvMpfrOrEgE9A7cP2
X-Google-Smtp-Source: AGHT+IEZeHzlXMMVE4kRk5QCaLTyFIuAx0jVdWQvsbTeSj+GjEtfhbgXIYu9OpDKv1NCBoqSdv8c2Q==
X-Received: by 2002:a2e:2e1a:0:b0:333:f952:e3da with SMTP id 38308e7fff4ca-333fa824acdmr3588921fa.31.1755160502712;
        Thu, 14 Aug 2025 01:35:02 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cbbfd3sm1920661fa.3.2025.08.14.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:35:01 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:34:50 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sukrut Bellary <sbellary@baylibre.com>,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 0/3] Support ROHM BD7910[0,1,2,3]
Message-ID: <cover.1755159847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bf1rqEWCO5/UOXc+"
Content-Disposition: inline


--Bf1rqEWCO5/UOXc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add support for ROHM BD7910[0,1,2,3] ADCs.

The ROHM BD79100, BD79101, BD79102 and BD79103 are ADCs derived from the
BD79104. According to the data-sheets, the BD79103 is compatible with the
BD79104. Rest of the ICs have different number of analog input channels.

This series adds support for these ICs using the ti-adc128s052.c.

NOTE: There has been work on couple of other patch series [1][2] touching
this same driver. I haven't considered those changes because, AFAICS,
there has been no new revisions of these series since mid June.

[1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.=
com/
[2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.co=
m/


Matti Vaittinen (3):
  dt-bindings: iio: adc: Add BD7910[0,1,2,3]
  iio: adc: adc128s052: Simplify matching chip_data
  iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]

 .../bindings/iio/adc/rohm,bd79104.yaml        |  11 +-
 drivers/iio/adc/ti-adc128s052.c               | 114 ++++++++++++------
 2 files changed, 87 insertions(+), 38 deletions(-)


base-commit: 856d7be7f3c459a6d646b1f8432c6f616ade0d10
--=20
2.50.1


--Bf1rqEWCO5/UOXc+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmidn6MACgkQeFA3/03a
ocX1Jgf/cmjpNbrghOnqLYHfkVAYA/QfNxEgLBQQFPptiQuWTYO+Ya8b0QQjwEHx
s0lscWStFTwd8hVNsgcmxX2DSrG3+eUizMm9rUexpEkiB+//QC3WeHKPblNOx/Iy
FpHD1KR7uvXUADiGl//9WMPil7P7KThQKYJJLtbCHGo7rt9aY5HBk76HM6XtlgV8
k/VKdXIamyQt8GdTOh5xRtqni4/S95LNqy1Kvajyxpt9G1naMZjT1FCvBwBy5HFg
A44vNP84pUfgc3ll8ipOxzi3z/rbfZ/XFN5ZA2Ci7Kr0QN+5CI1ASqmGJ+BTkKsW
reC9pt5YQeGuGfB83VbtUTtIylIOrQ==
=cw0a
-----END PGP SIGNATURE-----

--Bf1rqEWCO5/UOXc+--

