Return-Path: <linux-iio+bounces-19991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB0AC6A5D
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E379E04BD
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34628314A;
	Wed, 28 May 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGOvaoOM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF221280CD6;
	Wed, 28 May 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438858; cv=none; b=TGV8Rv/jSNNP9CV+AAI/yyXikPuZ7RpgZ46F9K0Zh3FYpYP6SPqbJP6T0bgKSNKs3rufdUS3XTjExOL31I6CfA4Qmdqk5bDxCmlIKTXdF/qyuu3P5OhAXtLR9J53K8wnDKbeJmMZq/raDfxY2Y7Y/Km7q1qb6C2osSejsWX8l2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438858; c=relaxed/simple;
	bh=lSfHkFCVDHLdXBRkbgVAw2G4M1lVP1t+7+KMdCqg+HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RayTqy02Lq99GD5KCsaGoHJ9fp+CwsdLaJ+MUkY4ZTlK/RZKBwu41JTFQXhbB/UkZvRJaPt+ncDNddEHSyOgYHubtK6r+OqPxLv9CiHiJUivHDpAvPxmStAhqbN6eMzzpxZlSxsc5d5dEVPS1g2B1hkLeMO3Kjx3/W+D5/F/rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGOvaoOM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so1903272a12.3;
        Wed, 28 May 2025 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748438856; x=1749043656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSfHkFCVDHLdXBRkbgVAw2G4M1lVP1t+7+KMdCqg+HM=;
        b=IGOvaoOMETaupxEevkps8f2p5IQnl//JAS/THS+AnQxb7rDkd0216kjK8D6unIsMk4
         US6g8bwU4ifKJ/aD+ka3B51mi7ussB2eYdrzowIGnGY6cAYbYNQBw/kXV5wnt9de5teE
         662e0Gqah5MAZ4ar51y6Kwx8Rpt0UKXrqSr9OvPO7eWgsHnIb/zM1MTbmNa5R47MGXGm
         CWDvXvaSh4GScarsZ6VOK5w5ArMBNcoAu7sV87hvNZRaTcWX5Ztl9tUbVTnJjXzYqM3B
         MoJ46JzgGzI85Ipu2PWtk2FDe8+te8D7GicptTckXBEcKnkS3B2z6/6Y0MBiZvZqJe78
         iU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438856; x=1749043656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSfHkFCVDHLdXBRkbgVAw2G4M1lVP1t+7+KMdCqg+HM=;
        b=tsE3XXz6lzu51xj816N2LKtcDIAgeDtxkJJvx83Ii6nVQMaZO0vocPQXXyredDIyzJ
         MheqmE7V/XedbBdVEvxIfIRkJoGSHfXjXh9+XvnW/CwWXUzwpzhhZjff96BRqLIql8Sk
         ZWQt7gPjeITjn16wZ8zwdRqsK9wREsDobZpTAVYTzkvxD7nEpn/cspX03RNORGs1jYNo
         aEGfe3DP7kgCrz/TTyRY6OHmQImcKHa5GcSGNoziccoNYiV+AzlqcbVc1m+a4roPCneR
         q7XMUC+Wf/qQQeIqL9tCW0vizasTczR4u/IRH4qFU6UkKiASlSO2saMcqzmcGyPaDE36
         PDDg==
X-Forwarded-Encrypted: i=1; AJvYcCUP4KTvTUnRWtQFlcGeKKfenhMf1TEGLPGjkLaA9JXx3sFHxgOG/Q373BVrG7lcYfv+nlyjXgDf7js=@vger.kernel.org, AJvYcCXGV3OTIgN83Fmf0SGQgOiQMvIzr/KDi3Udbyg4buZHSM5S/3x/L4bf56QJrsfEdXg6PJCQ0ZAYsiUgjv/A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vdSSs8RMtNKUCgwmI7vOSqimZQjUBNrXlaUo47j1V8ivP/1l
	BaHqsLC3NKyBVoF/F6FhSAmSHGowLgs/Bj/jBhkkIkeZWpY+kLc07frafzAIf55X30omCVxGLyN
	JKWpbUNaGsjHszyx6E/KmNLRfwwGKWAI=
X-Gm-Gg: ASbGncuXoZXQNifZx8KliNGCoCAM2zcHvkhMBhpfeFSC7R1i8G7syrq8sEn/vmlpgNC
	aAjXHip2MjNOrV8FyqGIKPT1tsUVafA6Y5sPLRS0X4Rsvjr3OeS9Sp62M8KFr3KMUJk0Bjbbuiv
	tLYWB4uNK1aaQsSPUKKmheGAaKL5noWm5gJQ==
X-Google-Smtp-Source: AGHT+IE8A/WefRhv+yEHpkfsasM6OCUafbW3rvLcBYLAQRHpXljhc+qmXMPPcSHp1aceeBzxtwjfg2gk8PQd+3suTmc=
X-Received: by 2002:a17:90b:4f91:b0:311:d670:a10d with SMTP id
 98e67ed59e1d1-311d670ad63mr5041465a91.26.1748438856040; Wed, 28 May 2025
 06:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528080119.9380-1-gye976@gmail.com> <CAHp75VdhgftCKAuBuoDJ4d9HcKLqkGJ+bdx5gxQmkCSWO7SBAw@mail.gmail.com>
In-Reply-To: <CAHp75VdhgftCKAuBuoDJ4d9HcKLqkGJ+bdx5gxQmkCSWO7SBAw@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 28 May 2025 22:27:25 +0900
X-Gm-Features: AX0GCFv5n5Tx1GeAZ6E4RTBC15ADAix-zpm_A13yjpAq9CwDIQUgVGzs-ktRiIc
Message-ID: <CAKbEznv+GCBOaWxkgcufJrX4knYT=JKQC3iekowFThs7b7CuXw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: Avoid data race
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:22=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, May 28, 2025 at 10:01=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com>=
 wrote:
> >
> > A data race could occur between `atomic_read()` and `atomic_set()`.
> > Use `atomic_cmpxchg_relaxed()` to group them atomically.
> >
> > Previously the main logic was executed when `use_count` was 0.
> > Now it returns early when `use_count` was not 0.
>
> This needs Fixes tag, otherwise LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Yes, then I'll send v3, thanks!

> --
> With Best Regards,
> Andy Shevchenko

