Return-Path: <linux-iio+bounces-3331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8D870455
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 15:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51B41F2759B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625F23FB8B;
	Mon,  4 Mar 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rnkdutt+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B3CF6D
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563130; cv=none; b=Yzy3gBgcGFk2L0cl087JbhYJfj5rvsHe30snd7pRflkXxtzeeAr6jhhLsMnWXWMffoz+xuIy8Lqn0PCSRXpRpWB5YrUIZN4wmFooZG1jk/cBF0Tc2xwEN09dwq/GXKV2Maoh3riCQC66bmuGvdHr/iE4b2a/ypWlt7Hhy6RLJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563130; c=relaxed/simple;
	bh=qU9WNpMyWUHKr7MKslVSMGQDRgtoSQw/GY7z8LoMZ2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmiNbqi+KdpmT+vOTHn6daocZkuT92Xj4vqPUrSUVqX67rVwRKDKDUp/BmUutvn5Qk7OD20mMhzaOqlX5Tr6IVZ4n5kYcaFTx102J85UQrAtrJSMNdcOaNQHy796ZhxTR4uf1rWPca81xy/jj5zFQxJOONBYuW5q2WWfdFw5ZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rnkdutt+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d23d301452so51051971fa.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709563126; x=1710167926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU9WNpMyWUHKr7MKslVSMGQDRgtoSQw/GY7z8LoMZ2U=;
        b=rnkdutt+tv2CVpbiSF0y3vNFEE6pK0OdKz5DY+VkdBxLBaq/UA5KWjDcWeLsThD4F0
         dd4XWmgDkHMGodAmzRdV7n5riGQT7WbtXSlrYzuOpaipIFXip5HDT80Io5y0+HeqU6zT
         21QZOnqp0W7OBlUNICMFNuWWypl9O+e0nsTnwgxRA/mXei5AXStAqmUv7N3/rLcQ0GJl
         5jx3+PkjlxLA/dmZzhN7BKcTju7fP2fez9RHgRDF4x4c7GuDdhYZY7FSH1wh6XNgcV2k
         mkiqeP5lVpUZhecNEfPH9erwa6Tw/+5lnZaMu/4vC0uy4EI965tjLqbAbuKfFsq+glAk
         10Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563126; x=1710167926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU9WNpMyWUHKr7MKslVSMGQDRgtoSQw/GY7z8LoMZ2U=;
        b=eoSv+9Gu6EXHY62qQGhc/TlWYxVafeOWzlewtVEewInS6EnGWaqPS6s3Ov8Bw1LYN7
         GxYlJXifXmsMl5ibWNTWa496DqZPROZmYQntf8FejQbsFIdDavZHQKxMp3hrTuxm5KdX
         MNQNbmm5+hp4yJZilRDhdKHh8wmjgU/7tLRJP+DNyUrkdDr2lq0qTGmsz4bCrmiaDA1z
         LbWnFr4LVddw5cZwVKBE/YfTBFmfl+e+6/1MEY55fnmuglvUmm3PBZ2mFqQDbJCG++lS
         njnyYU/kMS69iQaZNT4DoBHexM4k7a2xjqqM+zCSmoQeVYYfk2bWtgr4k6W3FZXO8DiF
         un2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrdB4zJLwDFNyN8GmJtIRTK9mY8rN5nDPOA/wSbZsQiJ6mPpw0fT+NnpfCckF2QDNHuOTwlzSEgidOrpdHR2XimvwXIjLcGzFm
X-Gm-Message-State: AOJu0YwMsPitC8/mzTOcE6QHp1jcQZD/QvN47XXqTUXISZvtmfR//sTP
	9bVHvk07R/ZOHvM6Su0z2oXsTMM+0zuyIi7VSfzb3pitKIg2ReFx9SaJoASfPrjmdSlJwdhB4qv
	iRDoRztT3fTAMcoq1mUmcgDgvhc4fPeVR8et9ag==
X-Google-Smtp-Source: AGHT+IGrq7QwKYL1dk8yxSMLcA7hcn+tsX0msC1QfTPWnQXc8/I5mFOvs88g9KdSEenmdfiIwSlkpBrtX0Nm5rqEH8E=
X-Received: by 2002:a2e:a222:0:b0:2d2:db6e:77e with SMTP id
 i2-20020a2ea222000000b002d2db6e077emr5597355ljm.15.1709563126213; Mon, 04 Mar
 2024 06:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com> <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 08:38:35 -0600
Message-ID: <CAMknhBFioXpPwTqTYEiwE2U2CEnYMwqu8SSFegdM3wfRpBSnLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: core: Calculate alloc_size only once in iio_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:07=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

