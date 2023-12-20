Return-Path: <linux-iio+bounces-1169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FBE81A729
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CAAB23256
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E2482E3;
	Wed, 20 Dec 2023 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0BIZ1Vv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AA482D7
	for <linux-iio@vger.kernel.org>; Wed, 20 Dec 2023 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbdb124491cso639370276.1
        for <linux-iio@vger.kernel.org>; Wed, 20 Dec 2023 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703099289; x=1703704089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/hbo7J2frnI9kAcgSjgY3xoG0ekm9nQwa7Ih1omnQ4=;
        b=U0BIZ1VvqXHypq1VUp/aYEMSvgCCZ4DpS0DuRc2S19FPF78tnUh5l6Wq0mwdOIdgsG
         Wevz/ecnMmiAO1JruO3hRJituWTJnATl4EOX7fbJmRvFDkxPnc4wWFPV2HNHVHhfxFH0
         FK14ANAclxYxdjaRciMCv6mEQPoZLBHo/7Jx/hT4sj2N6TPs9cO5E7s0a+3x+k6v61NA
         UBOh+G1zXW+hGOwdhIQl9taWuu5FeZQkSqQhg52YyMEHzsUsvFWGrN+h3id+2iQPMGT8
         /Hi5f4I+XdjiGvVWQjLBdJ7Y+1+td91WTgF3evB1EZfFJ2WbJsMEkMT6l3t6aobuZqaX
         ys+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703099289; x=1703704089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/hbo7J2frnI9kAcgSjgY3xoG0ekm9nQwa7Ih1omnQ4=;
        b=Nrg/piKP03xrllgQgiyU/RU6ZWGNljAkUEo+C6E8FkX+8MbjPYr270kb+vcFEnZBlA
         wik0Dl7SyEigcD0o5vEpXDYBjlsv178+gWlmyFswiAinGKX9oQHVyxo9JN4KEKz6Hqf3
         vQvl5oV+u9GNlUZJWtuJjFqicVYp24o4U3Xz7SlZgXKm7k7Pr5MqNANMcJzOaUk9QQJ9
         T12wgS90ezRc2F9EQ4Y9s60VMcQ8+zmgrztP2SeGDQ0jxGCTosd5Sz+Bmi1YxBg1kUgI
         aSQknKLPYyNRrPgwwkLb69T8Q6SClVx5NzkFSlFYcgpzT4e9eduBLmrsWfezDec0E0wc
         Q/BQ==
X-Gm-Message-State: AOJu0YzqwErRBdq+3ehw23P+R4cxSgbnmw6uxiO64TbwXgdf/FYYuHk8
	Rr2K/hG6Y/X9T7ejeDJWCD+inl1Hmwvm9nak834Q1A==
X-Google-Smtp-Source: AGHT+IHES4XmlzfwBWZdC1UDww21Rn5I7OAnN+fxvvKEl2wobubYyI3zjvqPyMcH1YdH3qPmCuQCooUKaYAGGo1TwYY=
X-Received: by 2002:a25:c543:0:b0:db9:84c4:151a with SMTP id
 v64-20020a25c543000000b00db984c4151amr126523ybe.34.1703099289362; Wed, 20 Dec
 2023 11:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220184753.6472-1-semen.protsenko@linaro.org>
In-Reply-To: <20231220184753.6472-1-semen.protsenko@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 20:07:57 +0100
Message-ID: <CACRpkdZqjX39knEMVnhZPCZZAF8YN0yDww5nvS0tEn_pP0R2fg@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:47=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:

> "bmp085" is missing in bmp280_spi_id[] table, which leads to the next
> warning in dmesg:
>
>     SPI driver bmp280 has no spi_device_id for bosch,bmp085
>
> Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
> bmp280_of_spi_match[] table to fix the above warning.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: b26b4e91700f ("iio: pressure: bmp280: add SPI interface driver")

Right! Thanks for fixing this Sam!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

