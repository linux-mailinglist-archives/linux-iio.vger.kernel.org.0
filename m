Return-Path: <linux-iio+bounces-16318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB9A4D5A1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E271A3ACE40
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD281F8BC6;
	Tue,  4 Mar 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgBS43XP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F91F418D
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075412; cv=none; b=EeiZQLEN/QoViDEpoBtR5qCbrZu8ufizh2HBWMBfPNtOV3nErYeLUGq9vpPdX10QNE5Sxwhx439R48+yEtaggtBmV/CQ94LIfUYi/+eGBDRlPoyMjLGXwrmrmjlt8bfc5sy4Tw4QArgYUrHKOL0GC5o02iSe94vabWOI+WI81IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075412; c=relaxed/simple;
	bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeFAi5N4l50EpK49TaHlmm6Y1baJtBKCV6MrxYRdJLyoEStgmjgZTtXiw1K0FZaNZW1rGW5Wn9M/B6XavnWhpL63zhm9ogR04WlxiWMnWH2EOqFGz/gJBjr8u/aZ1yPNLayB/aZBaZWzLU4iwK6eKODjjCYszbhC/sRSFrbstFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XgBS43XP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f7031ea11cso53074997b3.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075410; x=1741680210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
        b=XgBS43XPcG2wwxRE9KV5jdzfqRfVF8+N+tpI7MQ2IFFxNq+nXrlhJ2i3/FTXxTSVEM
         v8RM3LKSEYuvXOvfVNH8Mr+xkcPsRsaGbJF+LRYJnagE/KcgiN1A1PCP05kPhs1SbnQf
         ScqXjYJDKFtUd/WLxDSQZQZeEUTKNUFaMQdfidaxn5hOYKAcYkpBUzWGjDmBHP9eBJvK
         qYdhmnGAipqPh6ERSydEsQEaa+FXg9sHlfuSoOC9hsuuzdO/BKuhKVL7rR85Go2yDS8a
         5/3pBW5F4ickxOBFfjtegB/meorebGuv/T9PKLdYyyqMYRexSJisblCR8DjQ0tC8ruuY
         nnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075410; x=1741680210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
        b=wGmO8MMzDk5qyeZwmoNWyurm/4Vk+sDRjlSZzSHagr1L1xUs4bX8S5oaGBi0ziHJQX
         wlzpCwBxhGYvwNLwBrwwfNVrB2xMMv1aXGUnrBULy1ZtfBba2YGJ9QQsA/ULaj1ifXoM
         lvW7E1dbvfFnpt+TD46uUwBF1WiwvvmzS4Td5vRA5oflLe8Q6ZfHwXYft6NMWAwQteQC
         2yn6ZFcNPNZwFQiCrmSGknW4dtjmKmweMuNtS7JHKEzohTRqceUlAl5lWZNV9qsVUNQ1
         HSFgnJbyDuBXwZwGPPgLNby2FOaMU0oZ8rE2K0mYL28uU5JeX4FK9d8S2HMn3TtmwSAQ
         nlew==
X-Gm-Message-State: AOJu0YyekDsMuRPqCdxL5c1t9pTCeNFhPHM/5C1HQ4b1RTcTNvsRX9MY
	tAfBmEgP2k1OJ48XhstzrpTvFsInar3eSXk96xypZSt1LK4yTTijJWfCRE0rT4o0+wsbKVkf6cc
	ZRIDjs4m6dtYsbi/1FmBtw2ql6KVEhDGGC7fXNA==
X-Gm-Gg: ASbGnctut2OV1MmOt+SfhD2+9STWvlxkgI1sWYPGgsA2fy0NwHdcZOcIvURV/Hts/uU
	+I5/ldO3XdMrkt4Q5QZUdWVJMVXrDZD3MF2ObcEYfQ4QwaqaWRTxUrckIgG+1Ybc/BDBFVSGQiU
	dFXD1YdMu7I2dZsNtq6jtjFlEjcA==
X-Google-Smtp-Source: AGHT+IEEoxQEPmMeNx+XEx9rkwZRXQB9YKGVY6m/vP0iLmUHK18l917gZWQsMmtFgQl4b3vadQ/cMN9FK0Rq3Ekx2lk=
X-Received: by 2002:a05:690c:6303:b0:6fd:3f88:e0a9 with SMTP id
 00721157ae682-6fd49e2a409mr226555917b3.0.1741075410313; Tue, 04 Mar 2025
 00:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739368121.git.Jonathan.Santos@analog.com> <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
In-Reply-To: <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:03:17 +0100
X-Gm-Features: AQ5f1Jpa3u1-3cwOQyz0J2BUK0baxhGY_dz89fz0VCdOr7PNxW2y9ZPrMs2iGPo
Message-ID: <CACRpkdbMdpQhFq1K4AbLVa-fh=Hv5W8GnJwF_hh=h3x29h203A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:20=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

I'm convinced!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

