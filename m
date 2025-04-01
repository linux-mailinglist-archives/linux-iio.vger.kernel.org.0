Return-Path: <linux-iio+bounces-17508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA1EA77794
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994FE188F262
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F31EE7B6;
	Tue,  1 Apr 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzuSPGtT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FF1EDA29;
	Tue,  1 Apr 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499218; cv=none; b=ZixoBUDLiEOEFPw5rsDnG4BMLsspo+ez65EzqmF1B6hO4JJ0HtxOuKDHjUtQvasUk7A8hu2yhk3/8o8P/46CNmDO7Vp34ktzMJjPLqO7EwqmgII1GzjBtOTV9vLfq8dx/i4QEN6ZZHADCzNoUToISb/Ycwatl4uTtd2T8VeE09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499218; c=relaxed/simple;
	bh=Q4+/Q8eUvUq9Y9bXzIY4bPaeeK3kIkEBNnD8hv86/C4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTareiwE+aTMN7oGIgcqhzPiZ5MjuzOfumNpwXRH3nSOtBzgy5FeaB6EigjYacxEUC5CN6ESq+0aFZy0VoWpw+a6kGDWAx4L0Tp938JLACjoQwHTG6gbggIgxRoBP5sLdCdB/zBCIu0aYgtZqR/gHbDL2db+03Hssebwyx90lK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzuSPGtT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso4158479f8f.2;
        Tue, 01 Apr 2025 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743499215; x=1744104015; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4+/Q8eUvUq9Y9bXzIY4bPaeeK3kIkEBNnD8hv86/C4=;
        b=CzuSPGtT1QjTYbd1N9j82OLOZ7c60BuntkouWsfkZ06Mx1vvmu92hFH8puO6AFTnDz
         UxJ06b5EsBc3yaR7YjTcd8l7eKPGU8ay3VcNVROsOPihYKuq8zHkS2OJMSvQzQ9EMWIx
         5UrhaMakNNVoib6b0/eQbueev2dqZSLmHBw4DUusgnVHUC39IxuDR8MSKoPrxujVguEw
         v1/2UvDJLPSgsNkWFEZEsC9gpsBdLEi2eRIs47WXMgpj8HWRtWfnZ/mcZQT8Mtx8C5vD
         5mbHgqMpQEOueskC4/hhXCkwCmmtski4XPyKGiV4bO565+qQ3wI10I9CwD8IsvvjxOHC
         UreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499215; x=1744104015;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4+/Q8eUvUq9Y9bXzIY4bPaeeK3kIkEBNnD8hv86/C4=;
        b=FugOza79mdIF/FSLPObiBRysksDHaiVw+LEW7fJ11MIdsV4exo5Bg4f+jgODE1PgE2
         49Y1+9vFZsePkzxVh1H2XUrbe0Rm+Zq5dR/fuf+GlDhkKC4Aae1Ei80DiwGn0PHfNReZ
         zGbVQRs9OQf8z9+LZo0BkmRq4B2EXjE7YRGQOUWpQAjsA43auh8lqJE3oTPaU3zIhyuY
         Kn111lH5x2+VIeRlrZvHlQteOgcosPm6Bj5fCOv0XgvrgI2380G7BhmvfAwUCQ5P+7VP
         beMqrU0IC4qMps7TVAOZu5ZhLrGT06I9lrK4rWWzV9Vocega5YT+eKIbfT6vbeBVimRc
         T+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIKHHLyFm4BwNsjeh9e/g4AEfK8CLi1AlTC41W1LXLDF1ukeg63px7u2S296nzAL7OqVPLq0Kt8aKb@vger.kernel.org, AJvYcCV4x/PdGwlRn7WoaSaKg4mYnGs5B18oCB2OtRZG2Hs5vafwWbM7DL7pVc8lVnN1VSSkTFbHgMkmdZ8=@vger.kernel.org, AJvYcCW8VjEKxGu27stu3hH9zIB5bj48cPXbVbHnaTfh9fxUR3L/5xhG6wrWs3H2DiriIdjRuVL8D9aBdPEHZhgt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FFKZUb7m+Wy0zaPhDAK+UMAU4q21bDS/NgHJAoXOdohG34Xz
	pmMxttdwR/CBvNGogTnpSdbmJu+Yftm1JywvJuwN0avsfxJyamd3
X-Gm-Gg: ASbGncvXItDlltUFDT1S31o/xAwiYjQYhsV4IUvrgn6Wyestqn4C83b/oFj9GzdBAFD
	2es0CUHWqhfvLbAzKCSCfRIAD9+IDI+xMuCp0ze/EFegR/0rC/wv1epxm7BclKlyRWyZs6UdrBT
	/PTreh8wFYrJOZ/g/mOUgBHKYcTYqNgV6bloWe+VIciPGIPFro4B8hzu7CEw0PMKD2sB71B7H+H
	m3sQs4pbHQMf8TEWTLfbQwOeTGlFkDiW3aWumU30ALeROTiZrG9wfJSfmFRofnwMb7tsfLyrwxM
	5BPy8i9rcnGwC+MOuAc8vCGwh5TKZyPTp1A38OhIAbcUUUE/+a34jH766bFpb+iMThBMf51EDEI
	k/iPTpPqiB1KtBlEJ
X-Google-Smtp-Source: AGHT+IEKRREFuu7xEnipiixpvfhmZzkY1DBDCub5I8hZzD7/4QR7Y/PaCTDAGQ/hCQo64SSj0QbH/Q==
X-Received: by 2002:a05:6000:220f:b0:39c:268b:83a7 with SMTP id ffacd0b85a97d-39c268b83c6mr1093103f8f.5.1743499214596;
        Tue, 01 Apr 2025 02:20:14 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a962sm13396538f8f.46.2025.04.01.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:20:14 -0700 (PDT)
Message-ID: <a56cd1676fd267b7be691955f90c02db01959c3d.camel@gmail.com>
Subject: Re: [PATCH 0/4] iio: ad3552r-hs: add support for internal ramp
 generator
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, 	linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 01 Apr 2025 10:20:14 +0100
In-Reply-To: <ucmb7wfkovo6mssmmrx4fmfv2hliulshjhob4efz2phczbnu74@3xphjz5schp4>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	 <20250330175350.6cebf779@jic23-huawei>
	 <ucmb7wfkovo6mssmmrx4fmfv2hliulshjhob4efz2phczbnu74@3xphjz5schp4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-31 at 21:11 +0200, Angelo Dureghello wrote:
> Hi Jonathan,
>=20
> On 30.03.2025 17:53, Jonathan Cameron wrote:
> > On Fri, 21 Mar 2025 21:28:47 +0100
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >=20
> > > Add support to enable the HDL IP core internal ramp generator,
> > > actually managed by the adi-axi-dac backend.=20
> >=20
> > What is it for?=C2=A0 Circuit testing or something else?
> > We have in the past had pattern generators in IIO (currently under
> > frequency drivers, though I'm not sure what we have in the way of
> > waveforms in the stuff outside staging) so I'd like to be sure
> > this is about debug rather than a pattern that is actually expected
> > to be useful.
> >=20
>=20
> Sorry form some reason seen this too late, just sent a v2.
>=20
> Anyway, the signal is a tooth wave at 280Hz, not sure that pattern
> can be of any use except for some dabug cases, or noise tests.
>=20

Yes, typical usecase for this is to debug/validate the serial interfaces. I=
'm
used to this see for LVDS/CMOS though (but I would assume the principle to =
be
the same).

- Nuno S=C3=A1


