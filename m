Return-Path: <linux-iio+bounces-19986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF60AC65C0
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1AC1BC43CA
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BC277027;
	Wed, 28 May 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAd1fAK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DC275100;
	Wed, 28 May 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424168; cv=none; b=AsqVxzG6BX/IFpZ6DRmDM5APicwULjTZiqxBpZ6dZTWN988xWOdouZOvZlq4SJxubGVSsaN+Dp4ZqkdvnfHFXpgpwrxQQrg5oU9Oj+b8cv0RqWpn1hNUs0i/uvKL2NDA5oxngAXoGC5yHuUQabrxJ18MAq9mLITZSchha2EYflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424168; c=relaxed/simple;
	bh=Z5HyxWdH0KaGnOZO7JeE8+gXZA+GfoyeQH+lmP4o4As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOWDM70C9KrBH0+jrcVkWav40ufS95c8AuwbCqMY8hbQ/3zNuAZNpNF1RTG8e1ZqfUV9HlRszR8TDLuiSABepNpkPk6SzE//QUnW5wHjjTzR/BDpLr4hY6OMq3MDZOuFg05FQADd5wDVVzfaN5A7hU6PVTXc02mgwd34zsYUDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAd1fAK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad52d9be53cso639974866b.2;
        Wed, 28 May 2025 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748424164; x=1749028964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5HyxWdH0KaGnOZO7JeE8+gXZA+GfoyeQH+lmP4o4As=;
        b=YsAd1fAKA31OgV/R3qlpxx1gZPIn+r97hykZDGK/LpI+jGcQ8DMflT3uo1nuHfuGuD
         xgs/HsCCCjRhKA0QJr5IG7UGjlL4Sw4PES8PBTjF/DAdppGVY51ToUM85J1ZPtzVu0eJ
         sv4af1Vg/5ax7aylfeDgfX5OEOafXWZMJrNDEy3Biq9g9uBx7CubiS3WSsbNL65c5h2/
         UfL6oy291HvFEQXw6LiRqwkW1WN1hwW3BeuC7cTIF+Km68MK44tlH3JHkQ3rjgOQ17Vt
         1zNaBdIK3v66AOpARq/TIVEpeCvljG1MbRXJNH3syWO/2OghlFigV19A19q0uHdCCYaa
         a4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748424164; x=1749028964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5HyxWdH0KaGnOZO7JeE8+gXZA+GfoyeQH+lmP4o4As=;
        b=Ud6ZcD5XN2BcY1ZEMEd5xWKMMMagCtNMVHgxXf5ISOOfO+aKaRQI8VND5Xh7SSU/gz
         1bu7ZV9pR7+chQ7qYZXhLDwA8xxA1S/2wi3I8fPGUcT/e+Qre/KTSLD/sEAmmBICdMNi
         jNjv4g2BSF7z8ddHncBmfLtV4/QoiZPOhloFWOx7Wsa1uCg7+bgQrae35KoCdvyxTcoC
         3bHZBOshu8iVWEmzF+6KywQNLipGupLgCG4MwwIt6G/WtG0audvqW5L/eah+BJCP9TsC
         isXV5vOD9X6JisFBq9m1aU0/bSkz/6Q4Fp9q1a4FuND5X9OJF7y1o8l8/CqZZeI+2E1z
         pK3w==
X-Forwarded-Encrypted: i=1; AJvYcCViGr4I26EolfpycoJKLSuOGLlFVT1jWmPULFRhrf/c4iLCOc/GH8tNvS7Fz2nWZhhcXyTs++fD77Z/8fY7@vger.kernel.org, AJvYcCWJUFMjvCp1BZd/x/UHyR2KbAZ9hrY30HcqYcxwC+kIUHxEn/40fo0/9JdRdSS5rONUBRtHwZGOS7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywud1tloyzEiVXx3uhKtRXG295zJ2B8nQsS7dPYyPAG7JvHOA2B
	WJf4lPGHW8ZNgQf2UFUT5l2qSJ8O9OOo8ocQTCvknEk2ZG93ZAtm2sMQ1gUgD1cKqz9DC09TxFj
	4hhhi7sXasgjmKyRafh/kODGeZ5p56TY=
X-Gm-Gg: ASbGncttv1XUFMyzxdNHRH6qSD3WvkIXxMllIOYS4OKm/OegyQZhnnZHnUBPWlQ62w4
	/4piCitQE4LJX6rgK/0LgcshvpH0RUJQNFV6PONd/fzJd2273tbNUcW2/JBgIV8bjwIWtzd65an
	ZkP8u4eE5pMLGGGJ5GNsl3Z0eRoz97+t4DIYw=
X-Google-Smtp-Source: AGHT+IFKYN9n2rkV2PZefCaqRfYU3re0P4utva0VpHPFE+K2BVhU6PWrUUJ2nKg/dYSV1lYeauSugGZrxtVP3B7ICIU=
X-Received: by 2002:a17:906:f587:b0:ad8:a2a8:23db with SMTP id
 a640c23a62f3a-ad8a2a825bbmr104381166b.56.1748424164196; Wed, 28 May 2025
 02:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528080119.9380-1-gye976@gmail.com>
In-Reply-To: <20250528080119.9380-1-gye976@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 May 2025 11:22:07 +0200
X-Gm-Features: AX0GCFvCaaze7T6kJScaIwxolgrLro7kCQGTu5210iyv7oSEWYbCeoX0cpurpd4
Message-ID: <CAHp75VdhgftCKAuBuoDJ4d9HcKLqkGJ+bdx5gxQmkCSWO7SBAw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: Avoid data race
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 10:01=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> w=
rote:
>
> A data race could occur between `atomic_read()` and `atomic_set()`.
> Use `atomic_cmpxchg_relaxed()` to group them atomically.
>
> Previously the main logic was executed when `use_count` was 0.
> Now it returns early when `use_count` was not 0.

This needs Fixes tag, otherwise LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

