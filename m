Return-Path: <linux-iio+bounces-11016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE949AD49F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 21:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7C5283933
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166C1D0E18;
	Wed, 23 Oct 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jh3XAiz4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F101CFECE
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711201; cv=none; b=lYT/UZXAuhyCmx0oe6mCxGTZ2eZeoAVB9YB80LSVkumGT2V1T27Vzes1aRFM6mVivH3kLeI39V5xkgikqupPu/6VPNnfDV2KkJjePob0TW+5cZv0rZ7a6IfE7/DfAKtL4haBwN18zo7Qv9gweZrXNLKxVrj1XZH7RmN6/gPyABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711201; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7lcUcf5BiQ6JrO56ZTC0B79XGO+aHX2zeEupQ/XabQaCMtKOFN34WCl6zI6ozIJTSHaq+v2uiYZbkV6D3LcTSQM/Te+qNy4EJcFQNeKJj9OfGBDc12yDtKJgpPIQQZlONAmUW2Lhc/ecmreTzK/qC/iJDcVzg9Qz0t/bjADCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jh3XAiz4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so147981a12.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711197; x=1730315997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=Jh3XAiz4X+p+NMv9Z3v0DaoNUm/NyQJRjUGVGVTkrRlnMQAiiiNewDe4noafUJaIP6
         ug8NggQa+RKdSiGXWCo3otaQ/oRA5FYlYc89f+adMFUgm4uDxCKojRISecPpI3WuzWhE
         Kmr7FVDeWyZcy+Vo9PC6/igKDcwkF/WuzORkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711197; x=1730315997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=BYRir2NbO503ioNaYU/X+KCeqT5DU8Rb+J2SGPHpenJcCapEK+m6++AhcEjzf9ESjH
         U+/l6OTLvcQ74FEKFFNQ+1WEn+8bc0uH7ky/TnSwYat22DHzG/PzjTCP1YMHcnya137X
         X/9wHCllxprQn8xKCkaNkIoT4ckKnWwmjQKEGKEfZ2zMHs60o9X04jQmlAkN9V7EmibV
         bCEAXf2obBEqnzD/bWsd+ogNtO8sqvodOeRe1Kqp5vQIZJ7ity9RatKaGdalGb4x2A9r
         cHDtQFz15gG/xCnroJ0KfNctB3HDR4EQsTZjL4EPL+no/yge1WcD1LnlZRfU6NeLQ15M
         b67w==
X-Forwarded-Encrypted: i=1; AJvYcCVQlUlnyYyJ0Ta/93GvaP+Ll2bmYtpoUZTH45x/+l6AA25t8sXI1U7g/wO2pd8dZvsC26di/kvS7Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHm2OZzz9YYgsalI1K92d45Hr8lwkmXhfLYP+KldXkNSOjDMk1
	yVsHEQdt+2qQSBuYrsUm0wH3MdoVv7CbnSf87ZrfNnRqnS5X3r++VTxZRb0qNX4OUGjNVV7w64+
	ZBNVRVQ==
X-Google-Smtp-Source: AGHT+IFifrD36rgy4YnQuqgc01TLxDb+guM2EMlZ/+OVieaxzJM5q3CJElC/IBLeRWjKQZ6gF7L01Q==
X-Received: by 2002:a17:907:3fa5:b0:a9a:422:ec7 with SMTP id a640c23a62f3a-a9abf8a153cmr358124766b.32.1729711196942;
        Wed, 23 Oct 2024 12:19:56 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91597c05sm510847566b.195.2024.10.23.12.19.54
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:19:55 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9aa8895facso9988266b.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 12:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlTwhRJONdP12qRfBpGdyVaZSzdqS8GGg1HEM8tbsMwholKQ2+9QYo0y7oqnOb0p3hAq8+LR/ONzc=@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus

