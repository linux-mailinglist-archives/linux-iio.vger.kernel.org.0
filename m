Return-Path: <linux-iio+bounces-18170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB7A90630
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00968E21CD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E71FE444;
	Wed, 16 Apr 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm26r++w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705123774;
	Wed, 16 Apr 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812584; cv=none; b=iewWZhNYF89klsS1aXstAJmgS7xJhUvivbDx5mjJUB0hW/M5xKVJqXUD3M/2FTteaY2Cm2RksC95uThAH9Vu7K3UKM3QXeZM0Yf3orcD1xjmllFjJdDekJfj54C5lmfXYMgfPVVaDYFoh9ufu2JFZYrQAIqNS3gEFjfM55wx+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812584; c=relaxed/simple;
	bh=FcJay02OXRgiKLviOP3wdoez0z47A0kpA1eKJc55HAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvzA4F/hKeoD+lJiPb6l2WTOwJsRQbDzr3/ub0jRz8TLc4tuIlxd/oWft92rj9tsoJcawFUpBxMBwoFJ3pBy25YMx2NaJ/0K+j4ze4u+E9C+YSRJkxIGaWio+TlFptmhdiLb96Hu7r+5zBsTB1Mgb+5gmlSgVtyqr+pTOhM7GtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm26r++w; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7053f85f059so60130927b3.2;
        Wed, 16 Apr 2025 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744812580; x=1745417380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcJay02OXRgiKLviOP3wdoez0z47A0kpA1eKJc55HAQ=;
        b=Nm26r++wU0RfOgzFm4U9hbQOWGQcqKws0TuzweAPjRhBiFK3GCSRiY+LZH3w14lBoo
         LmnoFWdYn/5xIsZyccp2sKHBOU8RMjJy9U0fO+WUh2GfETiNdY615FgfUJ8m21rhNK9F
         8LQ1HTvVWJZU2RrGBSjxR76PEdrKNQ6kHxci4iGjKu9Z7cWx9fMtsQzCp5t+B7bVc4aS
         I5ufJEPzKPRjf+Zbtkxo/43Mop4GxGQTCGUQAk8pXaw8Jbf41t3gf1jIhMNPLvC/mfBO
         fqYCqBAWHoy7LMjdnnPjwjueEpiBrYdUdQvJUenqaETHMlnFD2Utl6Nt5MHPtOHh+RPG
         LNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812580; x=1745417380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcJay02OXRgiKLviOP3wdoez0z47A0kpA1eKJc55HAQ=;
        b=xIOafhdZPNH3c41UGS+D9/Y8DdPhWglmkP41xhgOuWL9GHv6AOTamBUU3PbMbrwNEF
         S/ELh+wpoE7CmQxtXzhE1y5Ys7NoW4SuXsTI4Rpt2qoNm6C4J17dsQNRbWmux2pncVTC
         krAxqFoi+VIVZ57GQm3AdvSUSw8UG1NK1p+ECsFikIgQNL1gkW3wKMyc4Q9pW/nuEA/o
         UKUck1qK1pDKsp0sAjfcusQcq4XOzQx5oN7dAACE5GVt/iNWJANT8MyAzcqy4MOzTlZC
         t/k3hJ5aXLZwgOY0cHxSZI+KyUyiW63KIKt/IYo+v9J28K/0fte7WDIPUt1GriDj+ftj
         N61A==
X-Gm-Message-State: AOJu0YxPSXR5DpE5XCSPvoPWz8YSSXAEwRAEhR8o3j13OSSodvJKwPJw
	HtNh4hwaIEJ+St991eI2vKBm3B8xzxMF5TcmsnpA3Nu5848fynawXftmJOI71PwSukARx9YEQI3
	nZobwO6LJpZrhx8OmiHJ+/w7fplkpCfWQKTXZcA==
X-Gm-Gg: ASbGnctLdh74u9cfCo4GY0HTUwwZZvEoOg1Wxm+B2SBEJ6gqPJGOXR1z6zQvEdZzV8P
	hs+8lC5BAvfG3dp+XUSeBPPNQM9CukMvBQuO6XjkN1pvlNbXA8YFcp5RcAU2+B1GzGkSYKUiO8k
	BB+7xaf6gB0yHfV8jAh0o5DE6pzCYMOV7PCdqhzVYUDHSYKM1M1pe2iBs=
X-Google-Smtp-Source: AGHT+IH7BogyowVhZgdDdJ41SlGpngU1ACiv5K/50Yuk+QgLJ5P2BPxYjS2B20fpFM1iAX36mvGkHBEJCpEG+XPLOiE=
X-Received: by 2002:a05:690c:6c0a:b0:700:a6a1:66ae with SMTP id
 00721157ae682-706b32a622dmr28688397b3.16.1744812580534; Wed, 16 Apr 2025
 07:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416140259.13431-1-simeddon@gmail.com>
In-Reply-To: <20250416140259.13431-1-simeddon@gmail.com>
From: Siddharth Menon <simeddon@gmail.com>
Date: Wed, 16 Apr 2025 19:39:03 +0530
X-Gm-Features: ATxdqUFxkqVeEMkutQ2O9qZA2vLCBghk1w4Zl8nTIwNu3p7rC4e1BhIDGExKbXc
Message-ID: <CAGd6pzM6=A1=ioLm4C51Nc8TBai5sSELpWbLfShwScbxfs=HhA@mail.gmail.com>
Subject: Re: [PATCH v8] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	jic23@kernel.org, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 19:33, Siddharth Menon <simeddon@gmail.com> wrote:
>
> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
>
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>

I'm sorry... I forgot to add the reviewed by tag
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

