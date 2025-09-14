Return-Path: <linux-iio+bounces-24087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B051EB567F5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6977F3B94AE
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 11:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76EF248F5A;
	Sun, 14 Sep 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzyoTVga"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09C2367CE
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850086; cv=none; b=CaCW8oRueVYRHKi9x3oIQeB1UGU/3WihTUy0cpCCQKWoq+lqi5spUf43ulX6sJNLTwmJDP5b6hD44oMhN3NqJrCXgpRUpjrictzbdcLKLDq1yB7UjVy93V8C+z4PntOyc0WQdWtEvcE4y60k023oG9UFxfSoOB6GnpkZUEultj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850086; c=relaxed/simple;
	bh=USED9SSTq30I5Iv3xaKuXQzkbUhRv94tw97rZZ3jDvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4K5niicL8q05kCfWXmzgdIKMg6/6yKeyFT7qSlhK2kcNo+MWG9hvjRMOXyV3zSED4GmghPWtscJ6guaXd/y3eRWHtHhGlBwZIZh2L9hoYGxdECM4MFmxSM2DjczWCBFeMkipTSbsP3aSPckyqILzB8azVijxKuG17vmIV6yyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzyoTVga; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0418f6fc27so564067166b.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757850083; x=1758454883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFE6FxzSZI/jNpqYTwjPIoXW6ZJAD8JeqJ6auD/7/HM=;
        b=PzyoTVgaEl+r1GFHthU9M+tjtDjIsGeNK9KIRSJ61QtJsYUl0fh1dcqDVe4KW/OyKY
         I1WX9ahUEb13dFrBdCLC2OKvIeaWkQ0IBqGg5YW9EsVQq/zCW+jWkinUjm9fe3N9Rfze
         FfjiRgr4rOrLXvEmIua6O1fMRrc/Xu6sljV5KwXGxuENlhHKbTKlSrkKlPry+SLPwKa3
         fnHX0ulOuBuR+aQmDGiiX6wKBwsbzXQQpJWolz1/ZPIMlAB1y9Msg2RhDvbLD9DE8tJr
         y404Zb7yFWihI6yiWsR96WXUdMmGaECGDW44dqYtmtwrlgbMMOL74M3j1PH5CKIK3GhV
         Bi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850083; x=1758454883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFE6FxzSZI/jNpqYTwjPIoXW6ZJAD8JeqJ6auD/7/HM=;
        b=epd32r8IVbYh97sNhQpuLLh8JoxXurDIxfBpCkxTxL3yGfPdG57AkUN12TMPVbPKV7
         k6wlsiBP9AVmhFSlewc1NkypL6WIQHLJGBM3srvsJQ5I/bgPAcyNa+ICgnUfkwP1aqyH
         nN+5WAT8VmMPmX91hqbU0RRwE+ofoPPFj495XE6yWpDfa6mpaf+f/rh9JUO0HQLl/0h6
         kLygrQbt7o9oPRJptLWtCU8oUNBrRBhxqeEmwwQ2nN8MRPuycr+fI3S9bMRPjShfxwFE
         kJiCT1/sjpKpHJLLOTRDGwtuNigy6dZCk98MoyOwUvf7piXPNE0ihy9Q/vhSEM9P/sdu
         6R5A==
X-Forwarded-Encrypted: i=1; AJvYcCV1cQw/O/A8sgdF41axCSK/2K/WjOOOmgrz/kV0q4lCSFD8y5BVfE94WN7I1eWd2x7M1GrkhYvHYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkp5AQf+tLZz0dsqVR/UdS3kQP/8tFP9it7RzwtOBHQp2D6ufB
	IqrCOsCAWUZUCappAp8TkTRmnUh/Dw60CS4rbjI0NfvVXha8VXGbhojtBcDz3H8Rd5hMIS5U7D1
	OKZS8ycaBl1QLsXuqLeSXxRnTUagulCc=
X-Gm-Gg: ASbGncuBoeEpKJ3IZ1YdHzLLYY1qhPRfKT5lspXBbSOV6Y8V3nNqggyr7hylHk+Od2w
	Jdiz2ZGREuMdarunYBGWoZltQaWejjvSuLPdBNzewPuBO1z4rAsqiE6oxuFVNCr1Wucfm2LCk5m
	QdAmjOqUolqsUuIm+TRnOMg9+GBQO7meIo91CsKPoKmRfBq9I5VFvlZCkS7Lby8dXst7LKR4gm9
	vKjOCmfKQQCytG4MQ==
X-Google-Smtp-Source: AGHT+IFhxYcEHRcnFk9fqIj4afX1A1ypXUJ2GDopC4rmnJx/cQtj7/LgHTam9NLE6Z4WaFa/M5/aBtmhxFL97wBEDMY=
X-Received: by 2002:a17:907:1b08:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b07c35fb999mr907487766b.40.1757850082917; Sun, 14 Sep 2025
 04:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-2-gustavograzs@gmail.com> <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
 <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
In-Reply-To: <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 14:40:46 +0300
X-Gm-Features: Ac12FXyAqKuPJpMqtVwrTmiAAzq6DxjqtDXr05FkTf4OlVpcEC5OvnqceFmLAlQ
Message-ID: <CAHp75VfAe2=ok4U07M27B_b=BxGMcNPT=upCmv7WfNFdxTVt0Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:45=E2=80=AFPM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
> On Sat, Aug 30, 2025 at 03:44:37PM +0300, Andy Shevchenko wrote:
>
> > > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> > > +       ((val) * (scale) + ((val2) * (scale)) / MEGA)
> > > +#define BMI270_RAW_TO_MICRO(raw, scale) \
> > > +       ((((raw) % (scale)) * MEGA) / scale)
> >
> > In the macro names "MICRO" in the implementation "MEGA", please make
> > this consistent.
> >
> These macros are intended to work with values of type
> IIO_VAL_INT_PLUS_MICRO. The division by MEGA is what produces the
> fractional part in micro, so the naming was chosen to reflect the
> result.
> If you prefer, I can rename them for clarity. But please note that the
> same naming is already used in the BMI323 driver, and I kept it
> consistent here.

Ah, okay, this makes sense. So, if we ever want to switch it's better
to do it with both (or more?) drivers.

--=20
With Best Regards,
Andy Shevchenko

