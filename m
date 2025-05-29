Return-Path: <linux-iio+bounces-20012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2636AC8165
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91121C04B4A
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578522F176;
	Thu, 29 May 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCiRTT0L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9661C84C6;
	Thu, 29 May 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538087; cv=none; b=pMRT3ZkKkeSZzspxwDhDWts1N92Kovv59lzWts51CGmlF+ww1Rv6cvzSpZ3RHxMM5cCAJ+PHSqraKlble04JE7fo9r1Q4zov0mTcpT+Cc+6GasTkwMomILyxPAUPbt8aNNaKTaZwG1MQOUqMpaYV+BqR2JNihyTMDEbpUA359kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538087; c=relaxed/simple;
	bh=Qon+5AIEhGN/U2Ml0PzbagpjZv5nBG0yly2bPaMLFYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iM6d5L18GO3OROTg5YNVFQq0g4tdreffAmX9TMdghhFTfYRJhR/JkMJXuDGsQ3k/00V8gJZORsOCqWNKbvbe13JFGgCKSDS8BPisM/jEd0KDHyizCQgkCfk3gPdkqIDisec4U37LB/iKjOJ9mPm7gPPJeo8CN8sdpdM8AS67Tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCiRTT0L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349282084bso14875335ad.1;
        Thu, 29 May 2025 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748538085; x=1749142885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qon+5AIEhGN/U2Ml0PzbagpjZv5nBG0yly2bPaMLFYg=;
        b=TCiRTT0LLb2alGI/WCepl57tnl1FHeUOLbwD8UMmGNn97ldwSfHfvFW/pCXob38hj7
         YzBdpqHYO3UOZzsHKAWNHFlyhUgaXpWpaGN8A66nFtgM0TjAKykrrATVPs8WIMeFx329
         yQusXgpO0aoqLI8JLxA+ixlvg2JbUmMFFOKo3ZG4AqhSQuAqTmMZtfAFI8DyY7lbqEiU
         t3Yn6WOsqFbq7u/Ybd4AZclV0ZBS9vX6K8QjFQ4bKIzOfQSvsBUwUvAlcpgLPbD3iJ+A
         FsABXk61WQf20SrEIPkUWnzdsrf2fM2AxxaRvcAhU1QbwqO3iqEfF/i+WhloAQ0+VXe0
         GiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538085; x=1749142885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qon+5AIEhGN/U2Ml0PzbagpjZv5nBG0yly2bPaMLFYg=;
        b=wOekApubejW3U+9cXRcT7280uSQfHVjk5jGx3WPnOEpcZMxlOWSWu8zZq/bkQ62vrM
         MDGTjXmPVIx2Z9XVAD3Y8FbwtFCVR3BCYMFjVIJr9Dcn40tnd+0g0Dky7G0f97joRnpX
         4/w/PGO8+eozaTxZHrquWNheu6o+h7xqC6NaSUraURaxA7PgTh3thegY9wpaa6hfCbyY
         rCkyLQ1pZ27qlyp9d5dKfDZ6UZ+lpv/50c0AW3jctB9INp7LcpJAnKR8Uv942+P/HpTE
         eGQPfwaDvT1/VFqQZi5pZ1UNlxSNWUcMWpVoNgN4uAwMME7OwBu3ZY7akoRRpM36U5ym
         Lzbg==
X-Forwarded-Encrypted: i=1; AJvYcCV5WcEyEwA9r9VKXPzBoRO/7YAKC1iI+3fEvFp6vlQTVuhWp+hzO8ibq+zRt6TQ3g4YukO9MOG50QOmbeH3@vger.kernel.org, AJvYcCVEbr5cTQqlSEJPu4AlnSbbLT+k9VwCQiXLsQwiPA/YAWYRB9v/E6KL1IeewQg0dcxdjuhYXFu2hf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0+VWDaIZyTnVR3LMS0X2QcUied/KudfllHUoqTO0UjLNbK/h
	C+r9B6546HS7wyJY8JtxRZ5SIGWm7E6WhSwX1vYAEjBuO8eYZfC77VyUtEFMEezYbZTYqTGiax6
	8PcNVzXnwJXk/vNvCiz9YK76T9x04icQ=
X-Gm-Gg: ASbGnctFLjoqJkigYYG1e7HiF1E/2U+oVky6dy3xyL3oX2fFL9ZjNVYsstrZvYhjTs1
	Il9ceFObdF5n/l4RKCFYexYzIUHzYyctzFViVxd3NzFtnmx04MkMf0bloC/qBTjC1vqW23mi7Pb
	0W7oJPHmvi8ZOcJnoyu+gDJRKlLEdOR7YKPtdurUpCwNFF
X-Google-Smtp-Source: AGHT+IFgkNP7vkcrTlYYHlOtz69B/akTJbc6L2wvPEc1Ps7LHmn5FBeLxi/zMLqmHRyEptAlLY/KDlED/nG9Iabckpw=
X-Received: by 2002:a17:90b:3b52:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-31241a805femr414821a91.35.1748538083548; Thu, 29 May 2025
 10:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528080119.9380-1-gye976@gmail.com> <CAHp75VdhgftCKAuBuoDJ4d9HcKLqkGJ+bdx5gxQmkCSWO7SBAw@mail.gmail.com>
 <CAKbEznv+GCBOaWxkgcufJrX4knYT=JKQC3iekowFThs7b7CuXw@mail.gmail.com> <20250528180305.000079b7@huawei.com>
In-Reply-To: <20250528180305.000079b7@huawei.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 30 May 2025 02:01:11 +0900
X-Gm-Features: AX0GCFuyJmo4JEbVA_vmmzf3ceUBnLThRWzdizDbc0waB5aWRAl4voTxru1_4FY
Message-ID: <CAKbEznto+=5JQSrnEVM-n+svfsRSA_ebm9msj3gaoCjFkqPw8w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: trigger: Avoid data race
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 2:03=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 28 May 2025 22:27:25 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > On Wed, May 28, 2025 at 6:22=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, May 28, 2025 at 10:01=E2=80=AFAM Gyeyoung Baek <gye976@gmail.=
com> wrote:

> >
> > Yes, then I'll send v3, thanks!
> Slow down :)
>
> Reply to v1. In general don't rush new versions out so quickly.

Yes, I should have waited for your review...
I thought the situation was pretty simple,
but there were many details as you pointed out.
I'll be more careful going forward, thanks.

--
Best regards,
Gyeyoung

