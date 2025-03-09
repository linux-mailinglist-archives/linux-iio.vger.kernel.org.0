Return-Path: <linux-iio+bounces-16585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF5A580DD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 06:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FD218906E9
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 05:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D2126BFA;
	Sun,  9 Mar 2025 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr6eMVcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B949433AC;
	Sun,  9 Mar 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499336; cv=none; b=Yy+zWmXZQZLDFOh0ZqRmCdyfurVxD2gCVFwH1bXDH/PAVBS6m/5//dEa/3WgWXv/RdYDAcrpJIQ220+suXsOnDAr+0VXuGjREjDr5LO9svrZcnq+XUQiPfnEzqjmEKR/ypitYTxHtxXhoaaSRwFIUmpWN9ZNaOhZTUQgMMGtZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499336; c=relaxed/simple;
	bh=0+vUFsq883gp4a88Om3aIZZNxVbvT/09ZAgkqJiFKhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/xmCKwpY/6JS50UKv7IBZnv+qIwdS54rb6geUnUgGitVd4JA8uoDGCg5MQrzPG8z3+77xB4oA82RmgLmw8Mp31kuKvAslE0SvevxAZQ0aGdlMlWM4QafGrJ943F+fFrKdY4ot4WCaMS7NiW+DAr93yOPC3Zbx7h6hlBxlPw0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr6eMVcB; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6343c68b8fso2330832276.2;
        Sat, 08 Mar 2025 21:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741499334; x=1742104134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+vUFsq883gp4a88Om3aIZZNxVbvT/09ZAgkqJiFKhE=;
        b=Gr6eMVcB+Y2Vy9y0zuoL2aI64RrY8EDw7VOqoNjJmslhcV4q84NnNa8MoU4IvXOJyS
         gNibIYYKzmjKck5Ly7x4q3W2TStNY4mWJ4IcdDjHLviO6usSNMdMLMTyAEMhYME7Abdw
         CDZLJqwEFG6tAekSadTNy27/UAOWXsCN16zVk5SZEUaddiXj6Ld2lnsKW/zYlpi/hZ0j
         icd8Q+7YhllmnPbRz6N4jD/L+L2cepswHPVUseDOEF3As2JtbTOIyiPIg52TJqRx36UD
         dTLvieuWGl6NglUfCCgRtz1N4H8VwuBscpLMQgJJqdHbzrxWcq14Rzs1Nl/ljsx8TD3Z
         5FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499334; x=1742104134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+vUFsq883gp4a88Om3aIZZNxVbvT/09ZAgkqJiFKhE=;
        b=pXR5B2d5kEkUXFEA//PCK+z6qk2X9uM5lG0sUWFmKq+uXg8Pfk51GckgRIPbq0pkhv
         ZT+4pCcb22RhAZxpWPghs9kRyl/L3cYAMMwpAKAhFrJ77mREs0FfgWuUOrPOfryDzlXP
         EQJmoFxjZMXERqEdBuObHX3mpaLVe9P1zd+/E+JyCRGWLdiMcbDDjsDMtiDh9N0ckev+
         9KSE5gOQg0xw4WaDPvFuLVz3fG6iT5uIXx5cwhzL8WvwrGU9wweGMae3Nl+0kP/zXqws
         yh+rh0ra2vsXeoC8D+k8tB4qyYZWfXGcryfHVu2Hzn3O8LqRoZHtfgAtdK5yDvYcDnJ3
         2l4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgLce0Nt/ZzaFOJUoYVxMHbl2uQhu0RgMqJcL+XqmjU/jUbZECwh5Fb6hHg8IbeN/th33fDijJlY+qPeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU3O10Mw/tFE37ER/jS7S/PQokK4sK8RvGjBMeAE9JFMVjP2a
	NNaEhij3rzOeapK1a0Vk6KmIfFXl7rcaEcq6WrXzzIFf5ceFGkRvUaNAlCeNjGbIMDx54eM6Yz6
	qTvywpldzEjjcx2K+iFBlqAZGYnA=
X-Gm-Gg: ASbGncvlLWAfpVCQOR5d/FyquMrLv9P0POuSPgzNulVGaZIq5kwVguDzqjPalx9oNOk
	IQO3abUjeN3QI8Cc9hZf5a0ELV/4uz4nnPWlbKImEPFtoM8k0AnQJJsH3hVkhc+tvf7N+lFtyMr
	CPiAJLb1KpPWk3c4bDM3zSRQ==
X-Google-Smtp-Source: AGHT+IGkM54VeRWhECXsPDF52IJ3lObNKFVMQZNCzIi+4MVCGhChHnkm7xcYx4R3VwX820vnJT8hwqDQG3epj7DrCI4=
X-Received: by 2002:a05:6902:1201:b0:e57:87b3:d2e0 with SMTP id
 3f1490d57ef6-e635c10191cmr13060935276.3.1741499334070; Sat, 08 Mar 2025
 21:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305155712.49833-2-simeddon@gmail.com> <20250308144357.20f24fa6@jic23-huawei>
 <20250308144944.668d79b5@jic23-huawei>
In-Reply-To: <20250308144944.668d79b5@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Sun, 9 Mar 2025 11:18:18 +0530
X-Gm-Features: AQ5f1Jr8iMs5wRpKB_SDTiXKTS02-KTePjS_i1SGrxVLXCES9nMY-YEBd4G5tA0
Message-ID: <CAGd6pzO492FA4bijFgkGvusrbqo2mkT=kpkY150Xg-nMfHrpZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: accel: adis16203: cleanup and standardization
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com, 
	gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Mar 2025 at 20:19, Jonathan Cameron <jic23@kernel.org> wrote:
>
> > I'm not going to apply these because I think you correct
> > identified that the device support should just be added
> > to the adis16201 driver and this one dropped.
> > Good thing you were more awake on this than me ;)
> >
> Sorry - wrong person.

Well, I=E2=80=99ll assume these won't be getting applied.

Siddharth Menon

