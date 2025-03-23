Return-Path: <linux-iio+bounces-17213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D801AA6D150
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91C43B36EC
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73971A83E7;
	Sun, 23 Mar 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co59UisU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9E136E;
	Sun, 23 Mar 2025 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742766611; cv=none; b=c85dEJR1S5JZkQ5mSH7hx9GAqCUWOzeLt22CZYj5uo8I78L0S7oQVOE8YGmBBtTGIBvYvJUAr5o+fC2Ni69AvrgAEcPw7P2NoNrZtCie4aT+IsxFxyUZSJC2iHAFOe/z+jgdFgWLKBNeYjaFtugPuGgko9cMKfoaSuL5ePEAt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742766611; c=relaxed/simple;
	bh=3y4rO/7RiCd/pFb4JYX3u+yiGImq7J+myMfUf5q/Th4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZApTT7v5YVeMfjsXYB5vIaRRFLvkvSX5kfsOxQ5uPP8mhuDsisJoKcErEEDhBFhtr6AIPTPbwMRvRZqEGzQ2lukGjmkwHdyEYV2j8UKVD4Nt/sWWx1nxfafGsbHBY/zcKhh26opwYBCy9jPrMmfQhBTCghfr/gUNgzMoA5v4c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co59UisU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fedf6aaed2so30652357b3.0;
        Sun, 23 Mar 2025 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742766609; x=1743371409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YK9hSEeXlqBd/dSx9S0EUy6JtoDUxXqJMzcXGhHJVo=;
        b=co59UisUrmOJ3dG2MiT+p31xFvaxegxkFm0huTt/wDZ9I+z3dL4cZ6YvPVy6XrqScJ
         9kIjGSClkiGkU0Yd2Y8sx6kAmWwt0AvIMPBvCxFESmMQF4s3REaMiKT4pNt+3H3xPhFD
         WlJqyQElE9vHvrXZGh2XYdwB5aI66eRIZWCs9i3gmAG2zUF4X4FHOsfCfJRqDkOXhoH4
         G40HF4Z2xPqu43exDxI7AFCobRrgAWJZSOh112Syzpt8amCud7TFEFKcOoyqmTHjhZPO
         CqVQka5+yt8ZCcDWOj6lRyXUItjN0X+FMTv9Ix5mOu2SQnk3Fevziyo9YuQxDNxwESV9
         gkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742766609; x=1743371409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YK9hSEeXlqBd/dSx9S0EUy6JtoDUxXqJMzcXGhHJVo=;
        b=RKR02cbREhdpHG8aqLl+yqNRiYL9qo/wLhDtn+SM1UnxapWwysZ5ZUaDt4f22c8wgK
         SxxoRxUODtBLTo6UHPIj9iXIHdQRYNiBEF/3acrhMHrsASuGkUKMye7Zz8LgXOMVI9PW
         28dudFZoLWqju1AdwrCYDAe7mhjD3uHcWoR51vhm8Ghyo1SIsua8JjJK/Gu0jpIWAtxl
         ClZU6N/OujF4Xz1C7C9QUiQiH865p1thLmuGKrcLE4zac7cjpGlGFSFXmypZo8Cg2pst
         OpBT1UluMiw6rF/20AnRKH9EWznLihh92ZSNmKzIN8bAa8lhvT5uZ8BwAKC1yZWMIohU
         ivqA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLmUA33/SWUv5OUWQYunTXqliNF+oe02VaNlXRAhI06acd2P4cjx8uU/ZQht60iC8QdLjHIPFZA9fTGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSU2fmL4uf64MEcJvGCjrxSQm6py8W8lhuUfSCObqBnjmBazyu
	QuY+lFx5gGJ7hMiXSMGDXHFuGzceDTXoBFFv3mSJBBcf6wbIXh0xN3s3fJBecNgMZp3ssc0zuRr
	/MvJyg4t45qlNhlNjKF9TgKgjCao=
X-Gm-Gg: ASbGncsfTk+3v/Y5vDK+bWYgAFK6SJEql1h5OoO1K8HgAUmwq8tnJmIieQYy0aEijhU
	l8cqLP7wWZpxgTNZNwJTrHof6cTBK4dR0XDG0Hc2tE2IQWiyNUNTopQEJk1g+5Cn+kEckQiT6Ox
	NHHczAV1DTFaDufpyuSlFBSK+lQsU=
X-Google-Smtp-Source: AGHT+IFqkFmsnw65ljFJDTbRHivLD243CgMFBjluIQd/vQXLJ7f83WCWOfwcqnfLBw3J69EpfZSkekGFMg+9jA4O95M=
X-Received: by 2002:a05:690c:a8b:b0:6fb:9e2e:93ed with SMTP id
 00721157ae682-700ba45461fmr155678577b3.18.1742766609091; Sun, 23 Mar 2025
 14:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322163211.253009-1-simeddon@gmail.com> <20250323120211.000b4305@jic23-huawei>
In-Reply-To: <20250323120211.000b4305@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Mon, 24 Mar 2025 03:19:31 +0530
X-Gm-Features: AQ5f1JqxnAyaVoEUute6A6Zj_lUmu0w1rFMtgvUA-U3DszY-WGtoSHNmAHudKLY
Message-ID: <CAGd6pzNL_TRfEhinDYa1Tveam-gvdV3dB976mRqOoE=vz+kpkA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 17:32, Jonathan Cameron <jic23@kernel.org> wrote:
> Marcelo gave a Reviewed-by tag.  This time I've picked it up
> manually but in general it is the responsibility of the submitter
> to include those on new versions. Obviously sometimes things race though so
> maybe that is what happened here!

Sorry, I was unsure whether the tag still applied after modifying a patch or
if it needed to be reviewed again.

Thanks,
Siddharth Menon

