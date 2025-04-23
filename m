Return-Path: <linux-iio+bounces-18574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1141A9978D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F0D92087E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0A28D83A;
	Wed, 23 Apr 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyuM3LmS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4B175D47;
	Wed, 23 Apr 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432023; cv=none; b=bIKAlkj9Bmb3XadfTK2vkOWe3RqgoSTpiXBuOhFGo5E0yIOl2XaAKGdNqwSsMy+EPBGxGUcp5hsj3f5kVKcMkyjtJ4P3JUgQ38K6BoHL+OHRb9ZxDokId8hlqgXBT4L5cOkxQ9s2wd7d9/4t5O68kwzfGrnjpk8q0nS1fU9jo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432023; c=relaxed/simple;
	bh=qXtrvCsA3+3JrgwEaAdODp1qT84ppQWrEQVajR6IVDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgyF7bBdyyt5MBk5zFbbK2WKTxtSnl9KPznmXT0kC0rxVa7mUjEMH+sNRozHWMVeAhlw7xvRIxVXqwsqDbrWKdq6QWLHCV8DC1ma7SlFbiEGvZZTA4HWZQWM/lU7vGFq/qmHnFEnho38WALSOo4xiLQwkmFM3tlyvsGfIVzZCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyuM3LmS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac29fd22163so26198166b.3;
        Wed, 23 Apr 2025 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745432020; x=1746036820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqZC2cvHybw215HtjOE35s4MFqOf4otsAy8qU3GB0pk=;
        b=UyuM3LmSY+1iNoTVEUiBCfKtMVSgyec0koSqkGRXjrpPJgNzOpXxAOO5YST8S/8Ue4
         yIjY2+fYrpJAeUHrO5s3Th/kvShDK2/HqlHH5hnputpS3Txpij1Mwfsq6ndxpOwjBZPA
         ALMktNbBv2W/V4dEnfvG66Ds9YQJGOi7nzZfgnC2FQPVJhsLuzrrpGDVuV0wC9ksQpZo
         uKPyUjyI5Ni8YlMe8aHU3bQ6PBgt9tkQm5itCfWcTknOIHDXjuGr0D2uNOy9lnFw25gq
         9dFqudHsiH9HLvqymKQHueIhbCG/OOGCD20iGl6brhB5vIdSHoyl7MRV5/J9uU+bDHh0
         CpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432020; x=1746036820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqZC2cvHybw215HtjOE35s4MFqOf4otsAy8qU3GB0pk=;
        b=cqNO1CJk29hYPSdupeA4JU74ioEGeLCphF/v4nOQmdIyj+oHEvTbhM/RcavDqXwFlI
         uKHu0PRU0PP6XPNfH2Z5ax4uAJN07XzfCYUgXxn2h+iMzK5v8DLrq4uqyA+YsAhEM8lG
         0bq/eIG/LErRZ+z5XSHu4kPEu5En2vb04m/RyLQ1GtA5RdUGrQy1ZJg8dacB4VfsZRvp
         nR4beHIrnCfTS1phI+8iFMzCNpx+J6q3Z45vkG2xWZliMtEZT8EjKLObVexmgS7w0gqD
         f4tdEuX4jI9gxhSva5wGqX2f8xoi++lqXBP0AeeUEan+GZLQp2ExrMMWqrWOEGlsbys5
         a+3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9tcJKP+cr/3g1lmsG1SLO7RIxQknNKEzTKQRG3iBV5JRDcroF8mGQVcG0LcYDeqCX6SKWDcXwW4A=@vger.kernel.org, AJvYcCV6VdktTIrq5TM9laBIfQhA6kMCp4M5Djugh7/pB5C3vYS+R8eO4Qzqixx1VVnJG5gBw67Smm4Ofqhx0RRZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHU7dhFoBXHyl0JRf+NXlpqSaVd7lxypFhj3JaO9Jh0qd9ONI
	U0hFWoYmIKs4cWXQyk/Odm8/WkRkVt1BivF85KI/VZePtbLf86MgxPjIV1vRMOESfRK0m2B+XbZ
	Nzfd+WxZYoI2jLPNFbUWRj0F5MJk=
X-Gm-Gg: ASbGncsMZ9PtWLv3n7E6cnHv3IFWj8VDWDtyA+96FjmRCPljQUX41J+im6LXtmZgm4s
	Z+KVO9H+jg1e0tjq3fEm55XHcYZy05NoJpaJ0XMqSzzM0mspPkgDBXzc88iY8aXjrPWZJorJSct
	BQybftR8V7hUmRME5lyFsLOYs9
X-Google-Smtp-Source: AGHT+IFv3b4xO8qwHY3gQEQHEhIGCt6mh/mCsF1e6HEI/uGpWwIWMAle7lnSVJBD0A3N5hpCr6SjEZKUiSTzhoVMIBY=
X-Received: by 2002:a17:906:d153:b0:acd:89ba:8069 with SMTP id
 a640c23a62f3a-acd89baac19mr645890466b.7.1745432020041; Wed, 23 Apr 2025
 11:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423170526.15143-1-andrew.lopes@alumni.usp.br>
In-Reply-To: <20250423170526.15143-1-andrew.lopes@alumni.usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 21:13:03 +0300
X-Gm-Features: ATxdqUHrjl502dqMW3pSVFtWg2PL7AsEHm3l3XtvdMz9Fb2sNN-W6SgU_JzzQTU
Message-ID: <CAHp75VeCNt2nVZ4V5XXvd5iTfGjM0g2Ur-bA+B3HORiOaP5h-A@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: sca3000: remove duplicated code in sca3000_read_data
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:06=E2=80=AFPM Andrew Ijano <andrew.ijano@gmail.co=
m> wrote:
>
> Remove duplicated code between sca3000_read_data and
> sca3000_read_data_short functions.
>
> The common behavior is centralized in just one sca3000_read_data
> function and used for every case.

We refer to the functions as func() (mind the parentheses).

...

> +       ret =3D spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> +       if (ret) {
> +               dev_err(&st->us->dev, "problem reading register\n");

> +               return ret;
> +       }
>
> -       return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> +       return 0;

Simply return ret instead of 4 LoCs we get only one.

--=20
With Best Regards,
Andy Shevchenko

