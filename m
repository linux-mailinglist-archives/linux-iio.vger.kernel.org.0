Return-Path: <linux-iio+bounces-26729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04670CA3825
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7AA3085B39
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA4338F36;
	Thu,  4 Dec 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtreamYp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEF3358CD
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849342; cv=none; b=s5JZB8OIMFTOAxXMGzg77/rln5cZt4nKoF9vFR26ttpFbB4vOCTjO2WFbZFIA5Ur5KWAE1nTKNWZP8OjleZHuCOFwYFYwhTwv1dxb38Q2uAO5kFOGNNIs40UDptlTTxPts5+Sx/mRkbLGiqPocQA0Amk9ji7021A6GemFP9KeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849342; c=relaxed/simple;
	bh=IB+CVqmpzh0kLvvZg/Dd3zycTMcxF2M6DkP6u4fOVc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkUObZ8HkAv9eST6OuyuoWl1Iz1iXDOUClSpG/S5UVPupRwfzNpKBzGJZXTyjlhgtRXRsG1lmMZ30iSTZ2hd+/kQS+Zm8v6E9tNOnquyIFpJ9biEGd3QcBjVRrTqV4ZdkTuX0XE2SNJrYisST2Hmot3eGgq5uNCpQ4RLq0HE3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtreamYp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7697e8b01aso150375366b.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764849339; x=1765454139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R7tvInWg0RlbJhmXHjG8LzzcBi8ppE7VEkw+ToZ9tQ=;
        b=PtreamYpD2FtFMTBMfqG3DPUR4S8PaQGfxG6IHDZNkL7Zka5YyKUvkJOnHh0d+y2lR
         gd87jspnEZhhbgfiilqctnFGh5aggfCbpfifZcn1ZF18E1Re/ZSJMudpoJLt1Bh8761L
         BhKA9OYfJqlBcPowV8XSS33LzusJdkCj60hDGFVFmfrmmQGGnt/CUdVHhUjRBfjZcF4W
         Y/a52b4/KUtMfJgTbZ9MtVOJdPZTCOaTHrRHougYYmgiHqYTCuhQg5fM5FtPOHpjXAoD
         W4vjXEokPMxXAZhiD7eX23oznhygh8S6RAxcud4B+II+lTIcs6ip3YMk8gSFtxn99Ktc
         1lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764849339; x=1765454139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R7tvInWg0RlbJhmXHjG8LzzcBi8ppE7VEkw+ToZ9tQ=;
        b=Nr12ZjM9EiqvgavEUlTqoTP/ftkQt8u+P1EKozMsqfeYueEq4PLRVM3w09ZJkqL62p
         txxfOFypxro3fkrM4L6viYHvfQv24SXMYp/X+oM5Z1aa1lutCCVG2sp6lPXKUSAFymWQ
         IbOS3YsJ6wjctasS5K+QANKqN++ugyN35rYYEInG/3UH1MPrKkAs2cseamGMkmdxipc2
         wa/nIB72wHvWn+mgctYgYNuipM65jsMT9ds+RjKEdkNKVbSIB3C9fC6K7neygqErOas6
         qxJtN0ToB48cJc0N/k4lZ+7kDNSAVldD/Uf3T+sondbnJ/YuMApZjItqyvmTpvl9qNQo
         x4fA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QdikMBEXEXRri6Rxh7feKpkm7r2niNmkyeQRmhu5GsG6o10zS6VPSfXWfjqFblUF/YI9MrpUZkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5zNvH44g68zBdJkwh9FeVCe3SZWio9XYXYm/HPbPk2OGnCPS
	EoNsgYEhOrwVYvWx1ptlwfYvD8g9QvFmZk1CpkHx1wEiUi7noqxvCUl0sZwejlxdNXUefAmwhlg
	KaBvk5w+Nj3J33DY9RsEMwdS02et95aA=
X-Gm-Gg: ASbGncvh3SlhfNpZG/YvRF3D7TI8bBa0HkVDI+u9+Zum/oBBRO+EqEiktDzw1+s4ndR
	L7kKWuRotMxsfcwaOfLkmJQ1KUKkur4ionFvor+UYqnoeMgkni0gNDl2EgflvoORxGYgFcAV2lH
	TLMJ1fWCnlcNAgyANzksILaTk8HlivbNidVP5INLsKrc6MweoRuBzgdELoDgIob16Hc9AsWxVYR
	CrjyB/xDSzmVIpifrLMh9kKruCYryh1/Spprx84R5rJ35G5WJhiI6n82oZTV9XjgnIVDqkG/JLA
	32EYnzj16cV3sIq2TClWQBO3dA4uKf06T3WpEFPBuYxr/AJhuPcPn5FN+1kr3PsuiGFQvEk=
X-Google-Smtp-Source: AGHT+IGqmBkS00spfGR2RzYpuTRVImjFbTu//ZjLI1id/ns/1YIVfh3WBqHOr48ILyc8yDd00ojeF+TbMO0jgFySg0k=
X-Received: by 2002:a17:907:7ba1:b0:b73:8903:f4b9 with SMTP id
 a640c23a62f3a-b79dbeacd74mr630178266b.24.1764849339054; Thu, 04 Dec 2025
 03:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
 <aTBl9U1KS__Lkfbt@smile.fi.intel.com> <aTBmT605yRjGtTR1@smile.fi.intel.com> <9f42333103ad4a0703f557aad7a2b3954ac55fa8.camel@gmail.com>
In-Reply-To: <9f42333103ad4a0703f557aad7a2b3954ac55fa8.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 13:55:02 +0200
X-Gm-Features: AWmQ_bkrHpe1J2Uex-RdyIL3zpLIf5LvqpTW4FbsVrrOTlJI45sDg52v98oO9LU
Message-ID: <CAHp75VcUpHiu5J2OPYbUn2sxkStZQ063o6YGC5+AqGNKoyA=cg@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: buffer-dmaengine: Fix coding style complains
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 1:20=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Wed, 2025-12-03 at 18:33 +0200, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 06:31:53PM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 03, 2025 at 03:11:41PM +0000, Nuno S=C3=A1 via B4 Relay w=
rote:

...

> > > > Just making sure checkpatch is happy. No functional change intended=
.
> > >
> > > ...but trigger the fighters for 80 rule!
> >
> > I believe
> >
> >       scripts/checkpatch.pl --strict ...
> >
> > should catch this up.
>
> Don't think so. I do have b4 configured so that --check runs checkpatch w=
ith --strict.
>
> Checking patches using:
>   scripts/checkpatch.pl -q --terse --strict --no-summary --mailback --sho=
wfile

Hmm... okay, then I have (had) a wrong impression.


--=20
With Best Regards,
Andy Shevchenko

