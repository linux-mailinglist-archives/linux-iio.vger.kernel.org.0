Return-Path: <linux-iio+bounces-23131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52EB30EB9
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BB1CE4BB5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBB2E336C;
	Fri, 22 Aug 2025 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWdXbViW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A8289378;
	Fri, 22 Aug 2025 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843580; cv=none; b=NPXu2OZIjYxdysj8OzPOzg1QdI82Ne8VV1rd37e4Hpdc+dlixOiD2mQuttOWq8xDp+GIQlhLtNjClHT0Fsvz7qgtMDIrZLrL4CIqnxFjpFOyeccvL/CK+Y8wPuaGtf2NMT9gxe63/jFrHVfCV8GEkB6j3UaQ+/D8WhjaUWDcc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843580; c=relaxed/simple;
	bh=v8a3z04Uh0u/uSmoBokGI0Tk49vBcGLpTfeWGAwsaHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8Rn4Z/kldD3dBsciu9is6XDm0NKXAXk4d/fWUogCmVac8iZarq5qAvDoA1eqb7PpoCTFO2TTZrD9emh2npunxNwlL+2bxKxg+w5E7SuMiBItfVlaQ+loeffy9iFQ8X+5OKK6G76Raxh74s9+RK+MvtbSsD+INrB6FMvDLxjFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWdXbViW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7af30a5so282758766b.3;
        Thu, 21 Aug 2025 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843578; x=1756448378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8a3z04Uh0u/uSmoBokGI0Tk49vBcGLpTfeWGAwsaHM=;
        b=QWdXbViWI4Q/kIl+wGlw/L7DIbGv8KbV2WhldGWUq9Q4wY+h8IPN04daZpBXpBzQ8w
         7l+lGUfanCwENwn0Javh1WSdoWLaSD0vTCPn/cheJA2NzLQE/hCVUd2bY2n1DRCixUAy
         NBn4j00s7ETbg5NWy+zVKlVnXgEfSP06fgUTEnRSSmnWFroTwoeQ2t0RTsJbsyaM91kD
         HXa5at+v+dyNGdbD5dMGUNDfCCaaqm5+p64+YZcRblRGC9+3UQSD0PppVhWKBFBsMnMG
         WKpEom5DLAFYdMtI6xfbDx7ayV16ZW+i7AkvLHmr/7X4p7+xblnxsaq/B1bixIe5mKwJ
         14Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843578; x=1756448378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8a3z04Uh0u/uSmoBokGI0Tk49vBcGLpTfeWGAwsaHM=;
        b=kRw6iLyn8/1Hlq3huuFIlBCwcWg69GQWG1PGWW0WN595JRpgWimI2c39HwyYcQPrLl
         IwYPE6dxyBDsJv9AI2J3kxX8Az2SVdAYF2e6geVMrBJuYMQ/EkHDchLuOwj8dAGW1iTG
         02fUt/MQjsLbbdSWzEE6lQnr0HRmg4R6R/hw7fXPdZTyhxPj4Bdi+jxfA/HjGFkby14Q
         6s8K0KjL3gTrrW6EZ1Vk/1FalD/M/ZKGyxiEPun6HmIDxsQTAi88irpBmZRAdQrYIrnr
         7K8EuFbbzmPDYyC9rMHu2SEtRY6ncK2s7wpyVUuU1LBQO97B8eN5nsWXk1bIR5+82OSK
         tMAg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ju/kct++cUClDhgHCz3FSuclOBU4ky0qtEyC05jk7cjklHPeXtbAKbUE558tlg4TmcnmvJlkG4rO29e6@vger.kernel.org, AJvYcCURn6/6mklc19gIPgmZ5aO5THaTrNRrlNzuO2WjZ72OgmCPvUZO7CAq+aIvkaBamQUgzODfyFz45pr/OQS2fukRW4E=@vger.kernel.org, AJvYcCVk9Cd8N/BhjqksyJs8b8kVq59Nqh+IL0k98KrKcxRD6P6Ajbs1MBnR287I0nYdLOJkrJ9YGjoufzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmHnuQfg9Tb1OCXl2o+k+4rtmNzt13Pi8k+/1SG98oOeIp/vT
	ICzHnzX3dpnSZY5GWCB7YRvCWFAV/7TPBdg+eFIPKg+0dLyeFrApQirIdoALtrzARJyqPRef+Ap
	pebx8xT8w838C5HDaVtkzd3Wf5z1uOdw=
X-Gm-Gg: ASbGncsHuUIcxLhazQO1TNnBFMjpzYeSb+GdAz81SKpXkPBpCpuLreYVbjmRthfHiEO
	LMcmukdHEZjNT4dfL39V79H+T64W7AzmhpJ8ICGAcus239ddJAPtFzGZ5tYq1ODUiS3v50xW9h/
	lSpsQj8aOH6A0M3kVXgf9JOrtmbNy5SPprH0ZP1kkn7fhGLMcPIpwRofkVl7iyxW+mBIH6MP2EO
	mjSOeXiA/OdXPlxRQ==
X-Google-Smtp-Source: AGHT+IE+QSuwTRWNnEst85zd/nVk0XCWCT3dBHW+V785HwC5spF07O83YE3tf7aS5P/QoM3Upoe1DUKm+4/yzGTsmC4=
X-Received: by 2002:a17:907:1c17:b0:af9:1184:68b3 with SMTP id
 a640c23a62f3a-afe296358ebmr171036766b.55.1755843577528; Thu, 21 Aug 2025
 23:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
In-Reply-To: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 09:19:01 +0300
X-Gm-Features: Ac12FXwT5-FuVxm-aLv8k_QiDyCdQQYyidQq38gD1A8xq-6f9ed_haxl-pVwx0A
Message-ID: <CAHp75VeTD5Y1bi-jYyfRnCPDfB4=WO+QF1uK5MSaSq=oUUMFdQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] iio: Drop unnecessary -ENOMEM messages
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andreas Klinger <ak@it-klinger.de>, 
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:50=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
>
> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().
> With these patches, all the iio drivers now has uniform handling
> of the -ENOMEM while device_allocation and trigger_allocation
> calls.

I don't understand. Don't you have a subscription to linux-iio@ ML?
https://lore.kernel.org/linux-iio/CAHp75VdL9kV2fyi63zqPZnW4CaeYPmJ74tmGEgU=
=3DM7FSYBv0ww@mail.gmail.com/T/#t
If you found something new, please base it on that series as it was
already sent and reviewed.

--=20
With Best Regards,
Andy Shevchenko

