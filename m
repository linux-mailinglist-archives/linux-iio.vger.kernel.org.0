Return-Path: <linux-iio+bounces-15083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E41A2B187
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B3169AC1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37D239587;
	Thu,  6 Feb 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNGfUrI2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAD189BBB
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867555; cv=none; b=Qf+AsN5kRquCSPhMJE/ZGwWlrBfruX6Kl0d6IQIMm3OWfQ/VoV0/VYH/Wto1bohvd2GpW88JQgTbnWmcYwu4wQ3LEHk0ELZhbpn5c62dvsuLzeTLHc9gE1Ewkfh6hwz/faVKiGFsg65MZ9wflwMVCYUFKCJz0sTWl00c1OG/fko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867555; c=relaxed/simple;
	bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk7tKwEiDVcB4Bi0N3mFqpcbofBKwKbHSY4pquQ/nfv2ZdBO24bd2yPDW3C5wqZ15RnndYxWmwZiO1wq1P8luiKwSbG8gxD9HCjNDhF7CxNUNWIJm60wf0PtEOrK59x/lfwaMYxdScM7xVsQptMynqAsJvQ5iNjtewvFVYa9eDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNGfUrI2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307b8e4fc25so13122591fa.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738867552; x=1739472352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
        b=MNGfUrI2QJjLfNL7FN95W/o+6bCjZO3TuTVKS0f/h7L8vxqPtufMVpe5cVSGAuFeUC
         XrcTHuvPW4sbPuylvaaCr9QxZWqDxEqJJq1yE51tOHtXCAJPyy1AF9MU7CZl5vX651pe
         KIqV8wLK3LpR83E7O8pmn5TBYQNJl1d6P6HFr0s8TYPMo+rLKRXy564CSNigirwGChsJ
         pEAcAXFTaJ8DQY4yND+4wSyAjp6uaL3UycX9G0ay2pVcBoMz+hFzBRFtIE+1u0q5+0yZ
         rIaqF/Ksa5m/oxkUqW80Srol1Z3ODQUfBcCxh+FxRewuVbqhsMf3cMgciSHN4ooCwjtg
         OOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867552; x=1739472352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
        b=BDSb2xGR/hJ32yWGAioiUfGnv1fan4r+NK3DlPpdYqmg944/3eTXiSuG6gAsjRd/z5
         RG2i1Ya/c5qwEgJMnTF7iRmHWJEBzeNJhGFiqRJayZga9W86oJhX69gHDXhi5V3bXYTd
         E89cw6T9yLJ8Zgb3zYFAaanTgSSc0iLSeOWjD8vcht+Y9ltAyJhanM8t2ZSaIlbsS9vy
         fJdao8mFVv1XltX26fZTYMDQIHYCqCqeONDyNdkJrVKOan0w4hTaoQpjBgJQalugXvrg
         VmKZFisWrSW/vVcdorhJFH2ivDVcPAmBOx/LfRG5LNiMePH7PnhK6b8dyqFX4PxgiXpa
         y3/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2iYLo/KCbKCWGBzqzEutBB2u5W4ShGOwB5MbhNqOHCugZcueY2Sxaxa2GUXfGlwc5CY1BiBCJczE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEqUUMmmixiQmz3pT0BqTFxFPsmT+QBfPgc/fdshKCAxmtv1i
	/m79H5wezyHzJo9YGKxe89DYJxq6QuYLMbm483VxgYMEkWVtuufD1U2uDe/3TWXrztSa1/pelsQ
	b8Ll3/bJsMC66L8DhFehvY0rhig2SDtYpzaSFgw==
X-Gm-Gg: ASbGncuRTVvwSf3crcCEOl/eGff96p6hGVr8kfmT4zkM2bFXou+B5CZBQ2/HjUlrbtD
	srRuN5HVsERVUjka9cq552oN4HurHfVAhly3xuF9OjplIkG52rnER75KDBukStyYBDKpjAcU=
X-Google-Smtp-Source: AGHT+IGpDLY6SHQ668oUnbFgq2auSN1gE3jhzoMa4jDVlTNizXykYl/yxJFI/SmN6Q4nixNkxOa7mlXWwfcYQBp4TGg=
X-Received: by 2002:a2e:b16f:0:b0:302:3ff6:c8db with SMTP id
 38308e7fff4ca-307e5a7cf4dmr162071fa.24.1738867551683; Thu, 06 Feb 2025
 10:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080902.1864382-1-raag.jadav@intel.com> <20250203080902.1864382-6-raag.jadav@intel.com>
In-Reply-To: <20250203080902.1864382-6-raag.jadav@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Feb 2025 19:45:40 +0100
X-Gm-Features: AWEUYZk2YRZtcaKVdDcLea0eYDsFvswTZJTr6Ycy-zr9WIcLxtUKOfzaSSPbXpw
Message-ID: <CACRpkdaWm7Lo125AsgyU3+p=WB3unVZFqvudVD53SSLESsT0=A@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] pinctrl: baytrail: copy communities using devm_kmemdup_array()
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:09=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:

> Copy communities using devm_kmemdup_array() instead of doing it manually.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

