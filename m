Return-Path: <linux-iio+bounces-17004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93692A6691C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 06:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755B23ABCEA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 05:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996F1DE2C8;
	Tue, 18 Mar 2025 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHm6x8oc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A01D8DFE;
	Tue, 18 Mar 2025 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274905; cv=none; b=oRlPf8CIjweFmCTiMQASS7bKqJqimsQYlZDfffTh0MbZWOY7uiuKVhmWMtQUFFaUKUaPOO5V0QuKDzwJ8yCW+mhNo+CjyztVRUd4ic2RTZQdAdD3fCj2Kg6QnelxZZY+Ee5bdSZQ8jelu8qgdtS7tX25GeemQszPAylzR5+UNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274905; c=relaxed/simple;
	bh=sRo5AfpTLLl4UggpWPfYVdiOTjrouYBCBc+ap4nS8bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJlg5+ChB0uUUfn2qiHxiNQQF14Ud/Klc79+7sBh5lkeJkLo3+jSL4Fvju+URRz8W1d2JI1G7bx/L3C9pXThMZz7joy1P/tEZP3RNwzTiejmkIF0qTWfldt42/N3B6A/BOkHHWn0Z4bMFVxFask7eceC0IH9EJoew2QeaWCbk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHm6x8oc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fed0620395so46522377b3.3;
        Mon, 17 Mar 2025 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742274903; x=1742879703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AwVcmAerm2I3agFAoKgR6VMg8KZgC4Z3oXuKqPYpdD8=;
        b=LHm6x8ocz1uFNOCh+xUsQ0egl8td1GVMN7+LnIungv2daVDpl6yz1sHLS6RL0X7Td8
         GWhlrMKwQkO3VQ78T31Qld85blvOEi/34AdJCq1hIoxQNI6nU15mPlmkVIyV7Qobcpkp
         4WHeJDq3o06NrdeLK5+qseyW79WMl1Np4fIq/9uLs0MMHIQhihFKot2HmExIUjnicVfK
         ZezNsRoMQW4OLo/Ur1ZzbTrjiYeM4L+jd9AQXY0A3FlO3FgSBjIHc0m/W+UpU1SCQLCx
         99YKXc0vBp4vD2MxOSTLFK1m5ySTFfjcARiMKBaNDJseFbe8Ut8w2Smqa3jD4RYR/tnM
         5cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742274903; x=1742879703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwVcmAerm2I3agFAoKgR6VMg8KZgC4Z3oXuKqPYpdD8=;
        b=ogTq/jvFtegAY1mLkAH28DsPBiX3K/8Lm3ZhWgMTCvUTostEb6k9xU/nHrGH4huyYK
         bFhlPLZU+7PqAc02TdcBrfnHx/tMnG3dvpD2RdIHG42o2+4udWGKLcsRC43kHqAhkV24
         0cnKxsrdlBWH63ZxPebFgzy+6nqxZhI6Z25ZJ9+0Q5dR/eEjazTvb+weyJywl2Gsz6oQ
         LhmEBonuaytrTjj804d39flFOIdzWSlb+OCJe4OXOpXQ8+HH8ra2fa+6QsKqLOTLUYnI
         DPZx1C1RQNLZoSGToJXTdZFP43oMX7F9iPeuhYG7uNCoa4ysEMiIFgxmeg3f1K4FYPvy
         KPhw==
X-Forwarded-Encrypted: i=1; AJvYcCWHRtfnXijsKFQ/xUFZRZemc0EJxxHgK8V5MH77WRNJwdz2yUNQWoABoVsvtbBK9GSzQtWim7/PTYcxCn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3G9gxR+FJZVSJm/yU8c7OQemp4PzSx7ngq6DItcgn2vWpL2X
	jf9zLGGW1ouF1wP1J5h0snWmNK8+9aXr2fTjU+D3Eba/JDB+jGbY7uwmjltqpmQXztIPi1sc0Uk
	PuulBD3prGf9NKjJRjkXcoOxTC0mUrEavEI2o6g==
X-Gm-Gg: ASbGncvyBA2L+UYT84ZLi4jn09zBy1y0Ly4IdW3fV+ZdPckcRQNA8VfngAzjQse3+fe
	M1N5ArX18Lj6SPjak9LBnSgH99PjP3zyPvRlanzmAF3UesRIai907Pj7qZrj3qSK5Y5spdRJxCl
	TLUWyWL8R/rcUqQ00JJNeT5p8MK6M=
X-Google-Smtp-Source: AGHT+IGG/1GbRgvoVaxsGWyKRWfKIbVXYiO6rz0S7vikJc/SuS85IPUmS1Xp+tx3ddDJGAUm34NArPeLmt/pRGkfhkM=
X-Received: by 2002:a05:690c:4d88:b0:6f9:afa2:acbd with SMTP id
 00721157ae682-6ff46025a67mr174369027b3.38.1742274902874; Mon, 17 Mar 2025
 22:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317173355.157536-1-simeddon@gmail.com> <Z9j52jGqft2jvT2O@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z9j52jGqft2jvT2O@debian-BULLSEYE-live-builder-AMD64>
From: Siddharth Menon <simeddon@gmail.com>
Date: Tue, 18 Mar 2025 10:44:26 +0530
X-Gm-Features: AQ5f1Jr0fox1K1wNfHQ3MOYiau_4uQjmxtx4DQjmQLB8gvNqc53ard16Ia1hCp4
Message-ID: <CAGd6pzPFdPGSxn13r4b8mA+do1KCpjBgGp6iCDfkHuAyb_nCeg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 10:12, Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Hi Siddharth,
>
> On 03/17, Siddharth Menon wrote:
> > Refactor code to use the FIELD_PREP macro for setting bit fields
> > instead of manual bit manipulation.
> >
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > ---
> ...
> > +#define CMD_MASK_2   GENMASK(15, 12)
> > +#define ADD_MASK_2   GENMASK(11, 8)
> > +#define DATA_MASK_2  GENMASK(7, 0)
>
> DATA_MASK_2? Did we already have a data mask?
> What about adding the device prefix to the mask name (e.g. AD9832_CMD_MASK)?

I'm sorry, I was comparing the values in a custom driver and copy pasted
the wrong variable names.

> Also, this patch fails to compile. Please, apply your patches and build the
> kernel before sending the patches to the mailing list. Also, run checkpatch on them.
> E.g.
> ./scripts/checkpatch.pl --terse --codespell --color=always -strict my_patch.patch

I shall send in a new patch after testing.

