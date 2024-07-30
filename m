Return-Path: <linux-iio+bounces-8074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E660894215A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33F9282C17
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216C18CC1A;
	Tue, 30 Jul 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFBPADVu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5F1667F1;
	Tue, 30 Jul 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370418; cv=none; b=XzumUHx/r843KKxh2zhzwMbzx5Z6fIeMS1KbSFNLYI1AQ1eWzR8hfxoWM7mPgz+uL1+oELcnOY9PQYyqYG4zhqVOzDuvfnW/Wi2z/RDvHq4raK+kxmsPka2yJMlGNsRCJ+v6M5viykhx6zd2XuJBx9lVLYt77uAMjWXgWMT+ZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370418; c=relaxed/simple;
	bh=lS5ymWF0CvjTZUAileBs6DhXKhlkS20xnG81Az3pj0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHStOOeFmoSHESBFUe1qcAYr/9VYN8z/X2tT3Xzpu0mF9pFqYGOZdlu6IoqkGuGWMhGldAy8mgFQvo9zOhfIrCWMTEzRGpREYgEslhjo/LWMRipGmPuW3qG54qk+RFfmidRXpN3P2l5FXhiMpisbSeIjO0nIaKwtv/Jbz2syu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFBPADVu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52fc4388a64so8547586e87.1;
        Tue, 30 Jul 2024 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370415; x=1722975215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS5ymWF0CvjTZUAileBs6DhXKhlkS20xnG81Az3pj0M=;
        b=DFBPADVu+kZRvLhTfa2kDkpHdVHFRMDV2F3EZUSemIIwEntUfs3PT4tFTRtg5vQicl
         +RsSQ0VKFDnQ64kMRonpwwpyjahngvTXD/2YeaNnY1fuCSep1ACh/tRH+nXJgV4nrLv2
         rnoWoR8KHw61hxx7MXkbIW02INow4qj699vf1gzNUH4IoHnmC0K+KBhwpqJ1ZTP6f3UN
         cxMzRdW/GwLrKRsnCy0ChRGot8uI638mAVuLYO6H3AOx3McXukFkzdxO8Fylrxd1nbmV
         WTgeFWSfZK/6pfdUiq46BJqpytRk4vtwoD6yND9pur4UkYWmXWVMkDOWaA/nVioukytx
         XD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370415; x=1722975215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS5ymWF0CvjTZUAileBs6DhXKhlkS20xnG81Az3pj0M=;
        b=IVtBm0j8MzYTjjTMMeHrE+tJAfci/P0DkqQht//4NSamwG6W+PjcSR2teI+ndrEICN
         tMs6kmn1r+hHr9AtRb3CDFSmP54XJGHtKmkY9Td+bUAJnPgqajsWo1u0Zr2leogvJAfH
         IWACQxc10n8KkrZfVZJnQH+6adPAE2EVVfy1lbpwsUaP0njG9qFg2MMxxodEYBzaLuWz
         HzE1QRvTOyDB9bzEEQdTU/ahAO1H+xz7dJ5DrZXAzClISLiGMLZKdhT2j+KvVCida0vk
         ju3LsiRYznSLGkMygOQIUa0uXm6EK1auiuf6jqh0q7l/c4kbl4RlMCrkyrGdm7JDS24/
         G+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWA91dmSpqdYAQBUaxmLlsglUBaHZjt/xxsZ4mbIzOPkmWn2O9ed3MLwh4biO+WG3PdeJvCZyCzvDVvAW5C/6mztP+CR0lQSfWyuGDsLJRBpLs46kMzycydjZjlAFD/nxpsA3JPYHW+DgOih+vJPJWHlGPTXxj7S9cbtI41OHz7KDni4A==
X-Gm-Message-State: AOJu0YxopMFvAc1ISkd5p5jAG/WUqZ4l4kT85TLuEhMKWJY0fugO3Is3
	f4Ro+EGHsS9VHpgj0k9U3gWOJkNO7559AAGi0kffUZRWP1DkAdtoGzedTq4y0nka07kxOrnYvUA
	LvPERRg4KpQfSf+aue/SzoZYrNYI=
X-Google-Smtp-Source: AGHT+IE/Htvw+zkNTT26DQCtKiH85EFRVdjXjDUFcZ13o/4tsPHnhoBsqSL2jYxdDvF+5Pk8pp9hi3yrGDsq/jM/lTQ=
X-Received: by 2002:a19:f007:0:b0:52f:44b:7d42 with SMTP id
 2adb3069b0e04-5309b2d8db5mr6545711e87.58.1722370414576; Tue, 30 Jul 2024
 13:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-3-b1d65b221811@gmail.com>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v7-3-b1d65b221811@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jul 2024 21:43:31 +0200
Message-ID: <CAHp75VfN56gPp1VVwfS715vTNUbA2p0uz9Dcq8PkehXG7bNjSw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Alexandru Ardelean <aardelean@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:31=E2=80=AFAM Yasin Lee <yasin.lee.x@gmail.com> w=
rote:
>
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>
> The device has the following entry points:
>
> Usual frequency:
> - sampling_frequency
>
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/

...

> Reported-by=EF=BC=9A Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202405170824.uhEslLI0-lkp@intel.com/
> Closes: https://lore.kernel.org/r/202406142001.swm6CU40-lkp@intel.com/
> Reported-by=EF=BC=9A kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202406081148.j9y5W5Ru-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202405310327.5dCrF4gX-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202405310010.dSPEpCuu-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202405300812.jv99FywV-lkp@i=
ntel.com/

The above shouldn't be present in a new code. This is NOT a fix-patch for s=
ure!


--=20
With Best Regards,
Andy Shevchenko

