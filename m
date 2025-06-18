Return-Path: <linux-iio+bounces-20757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01BADE83F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170257A83DF
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF789285062;
	Wed, 18 Jun 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJgl9yHq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71251F9A8B
	for <linux-iio@vger.kernel.org>; Wed, 18 Jun 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241726; cv=none; b=W9KSFnGEX+qPJqTV+OBSUuCuMG9nvvCaiaLSWZLccAiwq9m3XnFM4wC2mm3a7Lx6vwJFiuoCaY+0aLOXhpdsyaqxAgijMF/vs4upLAIz8x44VIpjHzj5Dl/KvKpd2vyhe6Cm24WwdHhtW1WF+exVw6rFSC6p9PPNR1pf7m7oHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241726; c=relaxed/simple;
	bh=jD921DQHaDQ1ESWyrhW1JyQ7YkUvB798UiZzCJTny/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc9hL5O+pCI9tRFjTdUKQ6+Qhcv8uyVTvzHi8noIN1ImyNyykCMMNmEiQsUVxzEuldGvo5/gRGITJ8CxBW4/oocBTbC8Bs0FIcmah68cN6HwgbQ/8xt9oWkLapDy+YvR6n4Jcftw6sp6MkLyMo3hJgjluopHvocg95YFF2xkkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJgl9yHq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b43846e8cso40529361fa.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Jun 2025 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750241723; x=1750846523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD921DQHaDQ1ESWyrhW1JyQ7YkUvB798UiZzCJTny/I=;
        b=lJgl9yHqBu8jryFDFVQ4GSv9B+Z8KJq/GKGTBxW9xGW/sWdtlDPr4FwVt/Ms4tYBw/
         wzKjkA7uMQt+M5fRcqW4WnnYuVrzDu19CLbuYJZvJGxdHdD8c7HYr8xidqWaTZ/zprWv
         MsND+kOgGtUfAzW/gPhbA1wgOZyiaEpAZjLL5+Q4lpMQA2Bh76RDvXRokkIoFpBEKbpQ
         UvWFJq2eYm7A2Lxa3BRZHaRQ5+ZmKPLgoNsLi8DVBuTUPf/xFJXj8i4XN+soFPB+pF04
         9T2MGXBT2y96bDhfzrSXSwi6qq38wufY8ertY9hZt2o4k2UXrSmqvqtOjX90BoKutrph
         QabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241723; x=1750846523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD921DQHaDQ1ESWyrhW1JyQ7YkUvB798UiZzCJTny/I=;
        b=gYm7kjSpc49LVlItxmefytaf9vQROxfZA9IP2cU9In1DAonEtremmZlENIynz3t9n+
         YfyFo2CZDkRDVdmmY7V4+d6jbFG1FKmI1FGe3Rk8DVS6ccXYryeG4tCLwCIf84dfmEtH
         otkD0ha0B5V8i8uPkR9zmkXDQx3L80HdyM01MgHcJKXKuOFmZq/f4QHpuEASY1il0SBx
         Sdd3ZuFCJvAG/sLuAZDPcqy0Fye6uu7tm5YBAKwuaUuhdf1ZpQxC4ecRHk2DeWL9cvKT
         cw9svEyY8au7jS+JEZnJfbJp1w7gqqNHQmrcV2H6G0f1d9lsghgiSplLQofTbCm7EEOC
         MYCw==
X-Gm-Message-State: AOJu0YzseRqg2fRMR53RGleSdSEr0l7mYCowkJ1B2FA/0eoLaDhMVYa8
	DNZPAcOxZ8cR3soQZCgOqSewm+7pb/Rt9uS7VFeNS3j0NVdV550TFeDJCZbl5pibRjYkYObABmp
	Hq92Y8bbCiXy06JTuKLkyGrfIlPOlAzZajKLZNPSD/BE1dlT+1PQO
X-Gm-Gg: ASbGncuwibpK/KgUPMa7D9Cf6dNqiEUBt5mznycLlODZW59MEmH7MZtC4vmUxolwFF0
	KkRm30VJut03XxE1tXKS67snp/meTCrAjtrij70iNUJvBLDx+7DteMhxoVg16XwLDUpl6EiYECq
	WUTgC02gATBjan1Og1ImNhjzKTwwbA1WOScb3ZzF1DZ2U=
X-Google-Smtp-Source: AGHT+IFgJoTNO+BsB4HVVc11Iwmn03x/+8pEoCMR5VEUoD09rS2tyjDc5RccGdUlZPyD0CvACF53jo8rK9pUhRXX4xI=
X-Received: by 2002:a2e:a546:0:b0:32a:648e:7ee3 with SMTP id
 38308e7fff4ca-32b4a6dbc53mr60545701fa.25.1750241723005; Wed, 18 Jun 2025
 03:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749582679.git.marcelo.schmitt@analog.com> <834e630a45f8b3ffe93f5663b356046d6c6fdd95.1749582679.git.marcelo.schmitt@analog.com>
In-Reply-To: <834e630a45f8b3ffe93f5663b356046d6c6fdd95.1749582679.git.marcelo.schmitt@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 12:15:12 +0200
X-Gm-Features: AX0GCFu0MlYcjSENoy5QcqrOme-qHw-2bn5oP7jO7v4dKtoPQUQWh1af-rRa5E8
Message-ID: <CACRpkdax5amh2ei9QJDzT12FQwg33Mnnv5iJphzM31gL1mupMw@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] iio: adc: ad4170: Add GPIO controller support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:33=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:

> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
>
> Implement gpio_chip callbacks to make AD4170 GPIO pins controllable throu=
gh
> the gpiochip interface.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Looks good to me!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

