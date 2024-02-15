Return-Path: <linux-iio+bounces-2575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB42855D3C
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 10:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48531C21BFA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19691BF54;
	Thu, 15 Feb 2024 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKLKmNSL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF61BDFA
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987541; cv=none; b=b9nuklB/SSfaOUfL0WFZpL0LomVaSrLTS+PMz98++E9CjV8vjj5Oi8Qu2PPu7q5fTH939x0RwdeRu0LuGUO5sNxkJSbVw9N5pE0WSfJk29WcSW8cpalpgWEyWvBAYFIaV80kOvZJ9O83HR1jwAKiCuco96YAP0K+h+v72hUjfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987541; c=relaxed/simple;
	bh=0/w+XeJsxTN6oUVuOUvliusQTH1QPpToWXsFwR6Rs1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHlp6AzgsYyYLvVUhUpjc9st6adQX8vtGcKNc2HCySWcWQHUPbB9u+q8HO/+p0AEv3wbn7hPUEsNFMev2kApUNuvVcv6y1iPUGf6f+gP4Hyl1Qwm86SJuSnFfANx0ozZrni8gtL605iTS3UB0c3aapzUyxNi7EFYT3XomKYMS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKLKmNSL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso61813866b.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707987538; x=1708592338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/w+XeJsxTN6oUVuOUvliusQTH1QPpToWXsFwR6Rs1E=;
        b=dKLKmNSLxKw1q/iSjlCEXtRksM6U4eKsEIb1rGSHocYudY04Aw7TqQfmtHYB5pqcka
         ZU59R6BxkfDm2ChYGCuXewxy99AtbhopknpS41LsOOWhjFCOpNUuCVhaRPH+0tM6GqHU
         KPoGuOr6hHnH6nlX6oA+5yWVj6MOaWCo4qng9820O5oe9d2TVqml3XX1Ljpl9jKcv409
         Voc3A8UBxiyGpOxCXVUSV87THrVdD3KvtPgOWKHxe3yUWW5tjpyEK7v8PMabrpEgDMXR
         M2jpHAgaTkfOQluNyIERgYl50yAb0zvDR1Hhh/U9NiwXTtbWuu45dsR2PJDfYuumO03B
         Z4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707987538; x=1708592338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/w+XeJsxTN6oUVuOUvliusQTH1QPpToWXsFwR6Rs1E=;
        b=E2hd1etYyWTH9KYVvzuQzvF6eafUxElpQCRcGoauKgrvCIcVn+CDdZ2uLbhbVAhLsN
         UhaDb0nNDbnFh4XFsp3ctuCEGK+zeUJKvASPcxzETqeNK12qEru3wtE4vmngr+lBZWJN
         rXq0gP/d8ZitV/xTAD4rLjyxjMZWXeYN3auY6Bo1E23JrZwAJdy/7UgsvdCEsLJcwnWQ
         3DA1uBU6uSSpK2fGFM5KcqmKuAuEI3zLW/P03ldvbPp30XdylkixvbUWPog1fK0q+CMy
         JjArUG52Zub7Fj8f/YrxT7GD6w6pmvgSsKSp9o4rw+87ktwBIoz3AjQHLq1HVrKHj7jy
         j7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOq/6n3RDFTShJM2EZXTt0cpKvUGDBrg8qT8O9ZGVB3AOmlqegNfBRpnEP9l1SpA8+cub6zL8Dch1CwHQNjNrLmDQj1GaG7b3p
X-Gm-Message-State: AOJu0YwiWsm8iKg1G77wPWkYUulkICk/JwxIT18lcWpv27XaENhRoirf
	MOHrXXTGVgOnZEGjU59hSdyAcsvILIZJU9OmEvz8aFlwsrnAwOe+QRHOLSloAkdho4JpEzKuM2Q
	BuKxp4FJxoqK2gPbSs3A1kRQxEXk=
X-Google-Smtp-Source: AGHT+IGCvTYmxWRS8d2mQbGS0QpCEiJ85gfTBBVQdZ+XyivfUeRHx5ChqS96mytcm1dIlp2WINz5sfr4ZQfLAbdeUWo=
X-Received: by 2002:a17:906:11cc:b0:a3d:2cd0:c17a with SMTP id
 o12-20020a17090611cc00b00a3d2cd0c17amr775202eja.58.1707987537914; Thu, 15 Feb
 2024 00:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4563303.LvFx2qVVIh@nobara-ally-pc> <20240214225956.25731-1-jlobue10@gmail.com>
In-Reply-To: <20240214225956.25731-1-jlobue10@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2024 10:58:21 +0200
Message-ID: <CAHp75Vc8-vBtduY+LsQ=VTryBbP6mu1+5UoKK=H0TTU1HAt1Xw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: accel: bmc150: Duplicate ACPI entries
To: Jonathan LoBue <jlobue10@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, jagathjog1996@gmail.com, luke@ljones.dev, 
	benato.denis96@gmail.com, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc: documentation related people

On Thu, Feb 15, 2024 at 12:59=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com=
> wrote:
>
> This patch adds a description of the duplicate ACPI identifier issue
> between devices using bmc150 and bmi323.

> With the remarks below,

This line is not for a commit message :-)

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>

Your SoB (as submitter) should go last, but heh, we have ambiguity in
the Submitting Patches.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#deve=
loper-s-certificate-of-origin-1-1
"...the first SoB entry signalling primary authorship of a single author."

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when=
-to-use-acked-by-cc-and-co-developed-by
"Notably, the last Signed-off-by: must always be that of the developer
submitting the patch."

These excerpts contradict each other when the author and submitter is
the same person and the amount of SoBs > 1.

> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>


--=20
With Best Regards,
Andy Shevchenko

