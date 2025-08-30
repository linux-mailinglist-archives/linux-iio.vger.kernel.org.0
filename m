Return-Path: <linux-iio+bounces-23429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65436B3C821
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C235820E0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD2F1E5718;
	Sat, 30 Aug 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfYZ62uT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528B71E3769
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756531778; cv=none; b=s7biv/IG/LirBB6JeQ7RswmuJUJT65sDGHC9+Ja+qP+D0hp0jd+cfQ1+UOxaFyMw/b2YrXTaIh0/QzMVolsuy7DIgww1WxDD+cwni0dCpMWWfjG1DdVpeR0WfbY0OcNOPplVMdHpNe/5UuEfBpxCGxAtFW/B2cbtZ+SElNe9Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756531778; c=relaxed/simple;
	bh=x7fFM3byk/gH4WPtUVaScUp1i8Osp0wuCDBwbyjmcWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQWdX0xXYoxwABYX0iCrQnX/t6X0/0vrOn+a0btttpJ2ToR+04nDl/ajQnGaAYvc2FnRU4rc6DR2DYe0i0ZQRW0bA8PaSxei4gpeejBVu0xS9UEYKZx8l1YT60vMIbQmmoXV53U8bJozeK8EtsOzyHX0yzRs9oqj8LBJ6R4PCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfYZ62uT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb731caaaso424518966b.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756531775; x=1757136575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7fFM3byk/gH4WPtUVaScUp1i8Osp0wuCDBwbyjmcWg=;
        b=LfYZ62uTtIArqlBKwo8wYTZQrozW8GoP4bkRwHrCcvvcPThC27WF6bmvE19Wy0fsw6
         89k5nKifwhvfQQhWXfMCEbB+cSGX/P3hwWte+bXZjwzKpBEBR7Io5026ZHwEVYnylp7K
         9Q7ov9yqKPCpYRZWNUaXAKKO2DHRF3azfPrDkAaE9GV+ExzLllqL782Rg2yxk+AIT/Wq
         RKWEDiDzaZWi0HsncelO+hHAfIAPy4D3h9CGSyLLxCTIlay3mZJMbFJsR4DjydCrU/Ef
         eUjmWr4fc2SmORngQ63HWcwwc5RALUuCjUwlsGtO8ZJyR7SBxTumApPLt0KDOQaL7rZb
         uExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756531775; x=1757136575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7fFM3byk/gH4WPtUVaScUp1i8Osp0wuCDBwbyjmcWg=;
        b=SYgkl+BI1mey3TOeoJO7BxW3rSOQJ7Wr4SxVFDxtqMQONrHbs2tgX85b/XHWpMX0/e
         bhSK0HqXYRCbehX7sElZPLEIj01UsKtuZlxOZlMgM+NaUwsI/q6O1aosKBK8h2ohpHr2
         yLWvlBUglGf73xfvQiDQVTAVcaGUSjCOvw39ED7+fB9eVlSkoTvZCI5XAQFvusaJj1Mn
         u2u26VQoExg0w5ZINJapBCM/UeojHk3cHNbC/yV6S2yolPvqcuhwFaWvtV+kdNqYRHKu
         Dg58FE/CbnscedG4NdElOentb9Si0ARr/7f1muAIXE5L2z5np1pRYxyKjNTTVOr4gfFq
         Od9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrXq9vnXPL/xCw+4YPq8q3JmtVUtdiwmV+0AMKFM7hGxbKiuA9CvhPYBXkVw0IaDE/UyufYKbHEPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9VY6qYiXiGPlbWC50+eLwB8xe5YEGlpWTPk4LQEKJiuGAZRh
	JDqrjcHQbbGmmaW4E+CAh0xRb9u4+Lz8qNl26cbtr5WHtMePKmQx3Nk/XPiQe6wha4nCTNf6vAW
	+fZ1XXOFEaar0C9rGfXk65QDPCgAteA4=
X-Gm-Gg: ASbGnctd56kzsXaVHZ5+4MmWI2GnbtGkyhWxbcUdv//ehHQtTDFUrIjINN7HOmJWZ/Q
	QY+56pVsAO8t0ME3GN+YQELKINNQdZY3fM3lwCGJANbwo8ra3smDQEt804mgjdRNwWVLctj8/YU
	YvIn94CMa8oCe/IIFHpRyGJlmQpQhs2dVAdeXeMoBIuUy84LCQa0BgAxY8kby4h91xxcJr4oO9v
	a7nSpAoIKNGZDP74zxvsOZ09ONTkw==
X-Google-Smtp-Source: AGHT+IGTrTFCrAtzj5YaHDE9y+Ls8BhO+/2dJlKu+ANr7bNJ7JcAqbynFP3YbLnJxY5rbM0cX3/Eftn74ZzU7exXd+U=
X-Received: by 2002:a17:907:6e8f:b0:afe:11:2141 with SMTP id
 a640c23a62f3a-b01d972f730mr71814066b.31.1756531774524; Fri, 29 Aug 2025
 22:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
 <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
 <CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com> <CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com>
In-Reply-To: <CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sat, 30 Aug 2025 11:14:22 +0545
X-Gm-Features: Ac12FXyJwbZOR_UTjxpU33_U9WD4z7OBr0qrgsl3xwZHLBSLcQpwdm6Drrx7Oxs
Message-ID: <CAJE-K+DXRC6A=1Coj-Yun6_Tzd4XGvnqoQPak2xwTJWWosyQ8w@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: Gyeyoung Baek <gye976@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Gyeyoung, thanks for the reply.
On Fri, Aug 29, 2025 at 9:48=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
>
> Ah, if the commands for z19c are not documented, then maybe it=E2=80=99s =
not
> ideal to unify them..
> But for this driver I don=E2=80=99t think we need to be that strict.
> So IMO we could just add it to the compatible list for now, with a
> comment noting the uncertainty.

Alright, Would you allow me to send the changes
on a patch mail.
--
Thanks,
Sidharth Seela

