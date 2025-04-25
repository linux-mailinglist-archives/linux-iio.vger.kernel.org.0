Return-Path: <linux-iio+bounces-18618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D561CA9BDCE
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 07:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561395A4569
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8C2153E1;
	Fri, 25 Apr 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OihqDWR5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44720B808;
	Fri, 25 Apr 2025 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558739; cv=none; b=fpDwZoIlwdt8R3PcSRMkl0bdEfwyPP1fopd50ncf9lJ2buWs8oztpX4+sormzZr1mhKkotaFn6edXmfnY2fi7gQW1twS/MSqBv/0awL59VU4eyogdjVhtZKetpFnN1SKJttFU6IaRg4DRil83+mXsdQ5I8tx28Qu1Z0PjJWRZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558739; c=relaxed/simple;
	bh=HlsvxBC5eORk0GmOni1w64foEf97xe/4LuiUHN8gncg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmrT8xRG9pV6jBP0imJ9Y4aHfYDnHykvGF4GTjj6IWmUeX8SbjqgXUTc1GcZ9S/8owc5AKfjXPTDKxfqLajcgFRSgviuiZXODaayPMmwlnWZV7zkiTZQJynGcVAT+WCXgUDZRX0KIexd37vbght8bTcV/8Sjbh883q2UWZ6kNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OihqDWR5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2aeada833so361558966b.0;
        Thu, 24 Apr 2025 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745558736; x=1746163536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Joe4cacU207cEwpYtF1oPgE2LN9aPZV9D5RjPoUWcE=;
        b=OihqDWR5aNVnFvVdw/0h+nJyaJUQSecP9TVBlVrCcNzpnsic+Vh4wDdxpiiqEoXPfL
         G3KIGutFK8WHW6/ygGCA1Syo6uRFNME8LlDfElAjkUe7x/8uSyGGizcp2EMyj5eNc7cB
         +M5cEzHLxuvPgjW1VB6jTEx0CtDApZDSYacYSgaDMx1F6VVVojhbdmMqYgbtDL2glCHD
         ijTnJFQDRWRbXBliBwZ+11K6y2Ozh/oVcl6h7USXQ51mlQ7hB3ei5uqmxctWichTmpCo
         jjZjpNqJUzJyyunmOsCr0Cf8IvV4aRhbR9jyFnFeMwNFEaemYtY+0WB6s/DcQ2V4SLmc
         W32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745558736; x=1746163536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Joe4cacU207cEwpYtF1oPgE2LN9aPZV9D5RjPoUWcE=;
        b=Po0ELBnGKT5XYDjSzxg1/T0K6STgNHGIBnC7szjiL9JvRFnekCpXLLXAWPuUvteoz2
         KJwqPjT8SSzOe5+aFI3/uu2q583FZ/+MtSukTgfb0IpQGgEUAcmn4EJEGPRrvXeRC1Ut
         +xGnriXxGvegVNAAedyPErgSl7DcpAcFeIis4eZXDf4FQDD+0Z5+Y+f8dTrSuS9xmwej
         Y0LmaiojXRRU+GYvcLRzuCL7/XjYtx/IroF5XmYBoEAr6lSJ6q3OCaiyegKwTXY2NI6D
         V+0MydzT3A3EOhi/iO3AnAgiKrYck/TjJthUhYHPnuJ63ZrSOQa2o8tv+SRPpRxsOs5d
         RucA==
X-Forwarded-Encrypted: i=1; AJvYcCU4cPfSZBgUdHZJYQwiniKk6kcrzWjxMtuF9leUif0XokktQd8sGdz+2PO2cpBa8JsXcHmB8YP7OnJ7iCOK@vger.kernel.org, AJvYcCVhm6KdHd6VYYwu6o2xpRR+AQb7MwaInaTtSKOwQjZ8sYp/psRB4RXG0EvPYayS2ievdY1XxsDKecw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmEKkjDLIuRFFAu7AAlJyj0MKXEVP9vqPQfzCy9XcxUsQhfv0
	EHYujzvWAE5yvUSN5xyOMx0UfTdhUmah2vpEvWRJcayojPrthBdNyJIlWEPxRGf+VnuNIUPPOfS
	WEm4PY/EtdqMjb2J5dxqFHV95xsh8mmLl
X-Gm-Gg: ASbGncux1SAdaapb+ruqeUnLO6Dwxe15cvhOYmMOUEPJoN/qRWdeLtj8e+M+2BMgMQe
	uLH52R0mHQrcIJakrGpBUE5AKWvksEnYbJXoyG6+ah2+ixZg2ebQ+8xUN/h9qCWTXwyEdY3Jzj7
	U+Jhbb6OQYsqhf98q18fgydGssAHMBjM0g
X-Google-Smtp-Source: AGHT+IGYiTIq1f7Crr/j7gh2lQoV83ITW2vPMmF0XgTI3ArpxgZjUuqowulRjxjRhNgW5wzQVntOXveN6IN2MToTj2g=
X-Received: by 2002:a17:907:868b:b0:acb:36bd:9008 with SMTP id
 a640c23a62f3a-ace7339d7fbmr77828366b.6.1745558736160; Thu, 24 Apr 2025
 22:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com> <20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
In-Reply-To: <20250424-bmi270-events-v1-3-a6c722673e5f@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 08:25:00 +0300
X-Gm-Features: ATxdqUGoEn__TPcXsW3ZHtWPCpnTksBVTtuhy722nkM97lmYwxfhudb_bVJvVtU
Message-ID: <CAHp75VcxoyoHYkSJw_OudEs7kAsaan9urhPofZQXyOyOVdBWuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: imu: bmi270: add support for motion events
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:15=E2=80=AFAM Gustavo Silva <gustavograzs@gmail.c=
om> wrote:
>
> Add support for any-motion/no-motion events based on acceleration slope
> on each axis. Threshold and duration can be configured from userspace.

I'm wondering if you are using --histogram diff algo when preparing
the patches. If not, please do so for the next version.

...

> +       irq_reg =3D bmi270_int_map_reg(data->irq_pin);
> +       if (irq_reg < 0)
> +               return -EINVAL;

Why is the error code shadowed?

...

> +               case IIO_EV_INFO_PERIOD:
> +                       if (!in_range(val, 0, 163))

162 + 1

> +                               return -EINVAL;
> +
> +                       raw =3D BMI270_INT_MICRO_TO_RAW(val, val2,
> +                                                     BMI270_MOTION_DURAT=
_SCALE);
> +
> +                       return bmi270_update_feature_reg(data, reg,
> +                               BMI270_FEAT_MOTION_DURATION_MSK,
> +                               FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MS=
K,
> +                                          raw));

...

> +       case IIO_EV_TYPE_MAG:
> +               reg =3D bmi270_motion_config_reg(dir);
> +               if (reg < 0)
> +                       return -EINVAL;

Shadowed error code, why?

--=20
With Best Regards,
Andy Shevchenko

