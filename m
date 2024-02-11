Return-Path: <linux-iio+bounces-2405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD83850A5E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2E0282E66
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835615B681;
	Sun, 11 Feb 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpApeCEL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58D33F7;
	Sun, 11 Feb 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670402; cv=none; b=qpFJfF7M/zftMnlajcpsF94LeY+fULUba2sIcDyna8eHb5GCuJXdDSCYPRzCbVC14lr4iqChbbk4xziRVaOQZ9xgPORZcPTmQOyptGedR2vMzPgAxJ11XdzDDY+GR5gWxG5St2+xeRwFv1eXs11FT/Y1Rh3spybgy3Ik/foXcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670402; c=relaxed/simple;
	bh=UOqitgCbDS6u/kjgfRF+tcluNmRJPm7FfXFVdsyedeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAIKXFpIMiB6pEZ6k/os4f9e7OEV1QilaGJveH34qCY/Zjufan6xotW950lghlSRBSZOFgcjUYa2eumig8BhOyd7kP3EBcQyNSM7nYjGl5uET47K8hjv6utfryWaw0tn5rluSqZ0+q9vKBmLrXcy1mRlaCiMW/VKv+6s25oVg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpApeCEL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so3195456a12.0;
        Sun, 11 Feb 2024 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707670399; x=1708275199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcwtXnPJm1vgvsXfpV3kIsP8h50v5pzqIP49vhict3E=;
        b=CpApeCELcU+s4juAm4jnJSS7omUuMgfTYYCOi9sjunp6eWvEh2NuAzAo/fTIywSz0E
         IN4NV3nR6Xzl7S5RfR24lMlthfcEA8JGnCxjtT+H9RImhqptXzrV/KDuiEb++cTx/sg4
         Y6hcFSvTiAIsWafMMS9J/uRrlzuYybk95COLZ8T8lM07CaNYx9oqT1uAS3NquIAWYdYa
         XqWEUyOg4hN1EdXQ5clmioSdrfgm+ugWsmN9/pD0AqddStd6n2ajm73g9UeXmbx3UcbN
         DBTwAG2Thqw9HnoHBVASfaphmj8/1wUP+gbuQn5/BvxD7xwjBsEaxsShoL4YWdSKMjS/
         qMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707670399; x=1708275199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcwtXnPJm1vgvsXfpV3kIsP8h50v5pzqIP49vhict3E=;
        b=Wfvm9WkcmbaPSaCxqPWq+Vz29a4ENXxLl5bAt2Y+LKW9MYz86fiyA0sWpocTgdDqXB
         qHKm+59GV+ltLHLiTvw1U0oh4Rce8gh1rp0z6nFXnnuGzN9EdGkk0wdOSqGVd8sJdrzp
         y0Tb9AIMJGki7kDdq03uk6Nc8Tgy+SFhvhNyPTlVA9mkoX6LSUr71/W+hXQSkuMXXqPV
         Ft3NxQUCUuAegkBNuVbXKUloImikmWwPM85uhoewAK35tTL8SbbhSDl21x/xodXrXOpJ
         4DYXFrWbIkO6o/AJu89eTAeUF3nlbZ9zPqf3GOmuaDH8bKwE6zfG6zfhb7jwZ+DQANs/
         pZyg==
X-Gm-Message-State: AOJu0YzgfvoAusO6hD3rkFDs9YfBFiHrLyTqzIz38/mzWjZX+RCbyozz
	YAJvVnVOs2OvwdLh/wqFQlkuySVxx+oNeiWe1pUtzMWbCr0Gf/FeGFEkGPvd4F2Wg2fkJkRf72B
	sIjYLegB6/9dWTMyDoizmxmJLmDs=
X-Google-Smtp-Source: AGHT+IGZXdffGNCYYwj5CZYHHwD95RVV2llBTWLD8Bte1O0lcq3y5684e3/ZzKrbTi8WZaU9pAp0Dvzb0U9Fubdz6to=
X-Received: by 2002:a17:906:f114:b0:a37:249d:2799 with SMTP id
 gv20-20020a170906f11400b00a37249d2799mr2758032ejb.62.1707670398703; Sun, 11
 Feb 2024 08:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com> <20240210-iio-backend-v11-7-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-7-f5242a5fb42a@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 18:52:41 +0200
Message-ID: <CAHp75VfiM0cqFsdN3nQQzZkea+cKfbFKkSM1J4LdE3LYGFedWg@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] iio: adc: adi-axi-adc: move to backend framework
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 10:57=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> Move to the IIO backend framework. Devices supported by adi-axi-adc now
> register themselves as backend devices.

...

>  struct adi_axi_adc_state {
>         struct regmap                           *regmap;
>         struct device                           *dev;
>  };

So, not sure you need these two as one can be derived from the other one (I=
IUC).
In any case, it may be amended in a follow up.

...

> +       fsleep(10000);

As I pointed out, the comment is good to have. Maybe you can add it
when reducing the timeout in a follow up patch...

--=20
With Best Regards,
Andy Shevchenko

