Return-Path: <linux-iio+bounces-18008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B9A86D0D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54227B5C31
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299931E0E15;
	Sat, 12 Apr 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Myt1k5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518271E480;
	Sat, 12 Apr 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462575; cv=none; b=sGY8DxVfGYYPGV8dKhr8nkAGPXAWDVDJVZFm2zoQesfVXjIRiGsE2Hzq5pJTgZ209yaCgl1c4BLD/hOmH2k2Ugpn5wb722R8P10Q5yEB+t1Toy7V1oHmTUONxXD3a0XmkQBMH+3FIRPHgiVrYaWWhTealSh3afTlXDsBLOrRP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462575; c=relaxed/simple;
	bh=e6ALmVXs3dRCfZTxJlIzbzoJqYppBA9zA8EGod9SB0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6bI4q8+3M/5Ng6YNylPizxmvS4keUydCzuzPhlVjPzA0/E2xB8BXUEsUyZxa80wthf1MlygZLf0ZOwYR+oDFtde75YVZ71931P0uaMROYcEbQprG6YBvwDEKdPImu2jG2PxNTnIBf28Vm6ep8QWNeval6+kcxfdVGZuh+p8GeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2Myt1k5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso6938691a12.0;
        Sat, 12 Apr 2025 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744462572; x=1745067372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6ALmVXs3dRCfZTxJlIzbzoJqYppBA9zA8EGod9SB0Y=;
        b=N2Myt1k54ijhni9JmPbXitpA/RKgVsOmInydH4Q35S+l2+6wNfY0aQT90BxrZnNDDQ
         0QdMUBcOvfiytip0IT62JiY+o2+d5Hi8xs2oFGLjVL0eas44XnC1oDN4Sng4v+K/S52z
         MLx9Gobo6IFBxaiLjZ9beyQKYZET6FJTfk1h9H/XNLE+Qp4Wg79Vb6O5VbFfQZzyYiMl
         5OK332+P0GFNNElmrmsbkkTESvNQaKA0nFedPNYcPugrl+rAFTNehIJl8S5DKN20/Ta7
         Dk9S8uDGndKnSroimnZlJ/6XKeXfSSt1yxsLhxGgzYeM1ZumL7mut9G1YaUNwEjajK/C
         LzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744462572; x=1745067372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6ALmVXs3dRCfZTxJlIzbzoJqYppBA9zA8EGod9SB0Y=;
        b=CTcA9eE+9ROFKazKIRm8Ehv2Y922q7Iq94Q27gZaqzcev1JZcuzY8mS8DmQYU+wFd2
         BHEEIiwFmVenJNCJdQFCAWuFazgnS9bOnxL18w8d8x0STanzKq6nHl6JDQY26Jah00Ex
         pDyvWeFbecIVjl/vmzrJnhQyTQNMJg7gatyRdfQs7u8Kg/WjqjjXADFl1XzKKtDjpERg
         r2wewDfehYGTVnzl2az0LLxyHC/sZmId/uUIEhBXjkh4Jw9YhvLuAN5/NaAxDuCKQQwG
         2ExiBYQJ7JcUx6k8SP1Q/Otpxc1W3Bm1K/zqJbYR3jTWPvqFzPItn8hcGF3UUD3Q8vRZ
         m0IA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJ/KYDl2OlmWOFNpa5D9I4oPQmWpyeEGEuGbMPCrJChBEOaraYYyHJTNl/OlaGbT3LVwBTkpuR4I=@vger.kernel.org, AJvYcCWekUBYq3iAp+wSzoE+S61XljD0ZUdorpMzIiDM/6aGukrpt42cYNgP6GY8L3Nbi9midqTCbBZQ7rzMX/iX@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeNIg08RYvgcmBeXgJaRxdjpY4nt9O1fxUEQJMePdUQ2vNtr0
	YVDQapD4i+5nGREvDGZxenzM8pIYSCCGNNsg+aNS8Kxteow13LxbXKEDTxFgNNNC//nnrG/XQUP
	dBNERTb89LWZ0ZQGq4cXoySZqUGY=
X-Gm-Gg: ASbGncvcTXCKr2iFOLJJe+xyYEIUXwyAkbC8roPaPh7WqzI1HpEpRfsbAGmgpCbIBeM
	AcRzARbPJamFkeMAPaRzD/XE/rysK78bjS/r390Lc00C+ZorCR3rZ84V1xSwl/NLH5zggdAJUPb
	ZlKlq+oI7PErXRNRAupUiZlQ==
X-Google-Smtp-Source: AGHT+IFMV3c/itAhZMzgVcBzOSMPT/Nx2JEUkLQ0az6enKAPX6J5POv79lL3g6YHPYu4rFFIUoJtFa1vTLscwjb9pBc=
X-Received: by 2002:a17:907:9281:b0:ac1:791c:153a with SMTP id
 a640c23a62f3a-acad193e9d3mr499437166b.27.1744462572253; Sat, 12 Apr 2025
 05:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-iio-sentinel-normalization-v1-1-d293de3e3d93@baylibre.com>
In-Reply-To: <20250411-iio-sentinel-normalization-v1-1-d293de3e3d93@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 15:55:35 +0300
X-Gm-Features: ATxdqUF3o76DXfTWlQBqRAnEllXdv-mSiXdscMBSIoE5Jyr5rlKb-JPEcZ2kvSc
Message-ID: <CAHp75VcdpPC2faWNMupXL-RaEM3QsSYEyfSC+A7KEsmD24U=+Q@mail.gmail.com>
Subject: Re: [PATCH] iio: normalize array sentinel style
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:50=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Use `\t(\{ ?\},|\{\}|\{\s*/\*.*\*/\s*\},?)$` regex to find and replace
> the array sentinel in all IIO drivers to the same style.
>
> For some time, we've been trying to consistently use `{ }` (no trailing
> comma, no comment, one space between braces) for array sentinels in the
> IIO subsystem. Still nearly 50% of existing code uses a different style.
> To save reviewers from having to request this trivial change as
> frequently, let's normalize the style in all existing IIO drivers.
> At least when code is copy/pasted to new drivers, the style will be
> consistent.

With or without iiner space, but same style. What is important is that
you removed the trailing commas.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

