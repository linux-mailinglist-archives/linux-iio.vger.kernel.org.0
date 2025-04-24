Return-Path: <linux-iio+bounces-18609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA080A9BAE4
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E448C1BA429D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200028FFE0;
	Thu, 24 Apr 2025 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWRAFYzU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF128E605;
	Thu, 24 Apr 2025 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534308; cv=none; b=YQwessLBRzdyH6vYacH3VKi7pcx2IMn717Q3VAUDZJWEzojzNVSCiLLR8Dbfxm3+nyhqkAeubyS/lpz764w0fTE2Bu+svYcWH3CdUPD4sK70mWdPDG2iY+fNoharROrSmAytbL7G/hn5ZZLpYvxn7ET3cI8eCScoLbnCAog1y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534308; c=relaxed/simple;
	bh=JKypq8qih4lXaXfNq9Dl3IZCz0FczV4G/Wz0gPP66gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zx7+LJIh2DY5aK0WM/77Zz4eReAfMbp2LN2Y0uipS3EiNnlilGyK89qVzNxKrnXCmnoVlEPaSpSy1voBqFDAAhd29Bej84dYH24LbslDmBjMChSIM1lDad9Aot+F/eZ7WHTyfU6fMQnT8cEeAUiIyLt4s1YueW20TJtgJymzYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWRAFYzU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so23122331cf.3;
        Thu, 24 Apr 2025 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745534305; x=1746139105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8qup4R95rJYDYPy2qb6xG8UgpgTWCy0PZH7PtmrTKc=;
        b=KWRAFYzU7oXvplRnJdz4DYW/FzVf9iBdMVJ3O5+0mySDY48ph1tfTtGTTya1g9ZOTf
         jwB15iEX6xxfEqzSknaSRVGPDL6RqLS+y/e1rtrzKaW22wPprfJCle/9hXLME4zn6qfC
         oXLepVdYDXUcxVWtQizEAl2lzwtwW9/0G1HhkFa45tpMAaqppgDu7xA+KG25yPPcqgfZ
         ceyWPWHYM9Q55OoaPLu5mPZgXB44t4RCmDYS4LFIOxlFtkxZLy7y0ZDAEN9LdsP6NYHC
         qlPfyrG78WNa8XJNhw1dXxMlqmC9wXsFeVpm5+PhhzAPIXB9vpOvi7mua/hD1jOvfI3L
         W8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534305; x=1746139105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8qup4R95rJYDYPy2qb6xG8UgpgTWCy0PZH7PtmrTKc=;
        b=lsGoMDFM/HO2zVsadXCfH0lgtSrMmiSTUVZ4hPSZZnkW3r+H903A06BZBWu+w2FxLB
         WpEfTNRFIjhXdXHYtsQT3KpjcyySCce/zYINJq+xh3zNT2CEoBQRMBWBRq8eF6Iy5PrK
         /VoglzQsK6TjsotaaQq+H5tlYcvoWNUvD9gFCgWGMxnx1wE0Yw+UxO6VAEhM9tpBaLsy
         2kc+Bre3tq3rCuFudCf1npd8qwB4nxNJ/OYIG/ySKcr1jNw9vC1T8xSnyFr0TBfS6psA
         tbQAdGUlZAbo+t/lhv6tvg1E1uJUQ1ZrzUNZn3wnNEK2DhiCFBW3RVYdhdrIdgI5JaI5
         ZUVw==
X-Forwarded-Encrypted: i=1; AJvYcCVeq6x+5/omixWAauUrZIEA8GzYPqL4WGZAfGsdrBlQ1ubzb4TpVqASlXO6zofSyMz0FC/eXMpTVxo=@vger.kernel.org, AJvYcCXS1fugotBOwm5bzi9jg8CB6zyJtik17qZvxBSmbo8uj0GHZzHcAoyRz0/jaYclo1eF0fY981uBo7sT+fYa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+3XhX3VouHFhZxuiSIUlGwVrgsA581/ENLZRAwAZfr3wQaZL
	CEx2zx+EWNFZGEHRSDO3MjMseMYxv2Jij3RbLJu58ujTXPnfMSUYRUiJQRQo4JeWygf1TYtfGHG
	Mhxk0CIXn/LqcZ0R/NQNnYz+MsoM=
X-Gm-Gg: ASbGnctgcncyHvQ1PnFDpwo61QFN7/V5/G5bggYlAQ+kMI9+lBSadzWOMUz1C6LD4Xr
	2Mzj6MDTJKJipVr83jqu12f2DTiWH9r9iTVwS3/vQXomyXN1ICABKp+Amq+d6FgHYMBJPFeJp90
	N46vh/BRxZ0oytMnwIcwLW93HoKwKOFd2ofVY9ost81oCLFivKtL0vSXBkjTmSnhuc
X-Google-Smtp-Source: AGHT+IH0O6zZS3/GaX00Y2cZO2iVsV9rjsJgGIyhjsh4xJbnONWObZHNuJrLfqpqvzsHBgniry1lw5UVA+owfnhBtVM=
X-Received: by 2002:a05:622a:30d:b0:47b:610:c952 with SMTP id
 d75a77b69052e-4801ca7ce44mr2683911cf.15.1745534305484; Thu, 24 Apr 2025
 15:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424223210.91317-1-gshahrouzi@gmail.com>
In-Reply-To: <20250424223210.91317-1-gshahrouzi@gmail.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 24 Apr 2025 18:38:13 -0400
X-Gm-Features: ATxdqUEFXdTfMjffJUTT1ZQkR5p9qZEXR8wMZCtajA4p5kgSKjMtevSFbH0UcaQ
Message-ID: <CAKUZ0zKw2Qq_Ct-BFk9ri-LnM1opG77N6-pzmm88_qCscD7PZw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] staging: iio: frequency: ad9832: Fix and
To: andy@kernel.org, dlechner@baylibre.com, gregkh@linuxfoundation.org, 
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:34=E2=80=AFPM Gabriel Shahrouzi <gshahrouzi@gmail=
.com> wrote:
>
> Patch 1 includes the initial fix.
>
> Patch 2 refactors the code to use the out_altvoltage_powerdown ABI via
> an extended attribute.
>
> Gabriel Shahrouzi (2):
>   iio: frequency: Use SLEEP bit instead of RESET to disable output
>   staging: iio: ad9832: Refactor powerdown control
>
>  drivers/staging/iio/frequency/ad9832.c | 69 +++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 18 deletions(-)
>
> --
> 2.43.0
>
Whoops. Didn't realize reformatting the title on the cover letter so
it fits within the width requirement would cause part of title to be
omitted. Title should be: Subject: [PATCH v4 0/2] staging: iio:
frequency: ad9832: Fix and refactor output disable logic.

