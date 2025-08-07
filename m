Return-Path: <linux-iio+bounces-22412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067CB1DE9D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628C51AA1373
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45552212B2F;
	Thu,  7 Aug 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft12eDOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DF145B27;
	Thu,  7 Aug 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600776; cv=none; b=FC6I2jm/386w/WzQzQIqChiDaKtBnJVJGV80/LzZonC67JCVnc+FXx9/A+FCTr8LmiXpqyR3LpFGxQPN1lf7+ypzIggMlqH3xNtKtpDLqC9Qrp6WbvjR8qbTW4y/sHZ2eXh0j0Q2+PxDkzv3TC1CtWEQhNEDMBjSupfkbiIsjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600776; c=relaxed/simple;
	bh=9N/BQuerfWMHHbIc8HwJMkLkO/d6Bj1Ifp1EZ0On478=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFVlRawb5kw22W1qWhmlWjoHAF3SxPZhFxQh00bt7j31ZT+tR39kjW6KeVqeJUHrblqbQwMsjoCN4WrmqE48p7hZVx26y2EQzCPKI0LJ8t19o5Fm0mEmreP4Tv4ARfizewArGKcaxT+usSVpEipswzkHqbcm8lSgJk+f86dNgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft12eDOu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615c8ca53efso2545537a12.2;
        Thu, 07 Aug 2025 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600773; x=1755205573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N/BQuerfWMHHbIc8HwJMkLkO/d6Bj1Ifp1EZ0On478=;
        b=ft12eDOuGmE1I02xpBPhKgpqElAtIf7gaU7VEN+zigGqLNxUWWKxAtpNsMlwDirj98
         TNpG8GTpg0Iv93+ToTBjLsve3vjTe5JE35pwrzi0pYNtRkRxevKPTpGBN7HX9nC4biwc
         ZCW7yk2RfHto6+1fR4+fhHviFsUaN+cx6kZYXqU/nAHoE3cl646+9VymklhSEBDVOtro
         L8EajBtk+3LHC1X0kpPCYrcpuomYcdH8/8Sw+mJhuBeqGzgmwVszW8wA31R7BWtXYg15
         LNoSaGlaEN7qHgZ3SljVX1s5GfTPQujNucjvwFXWTgG+/5x5S939oFi9mLxmq99LZyZS
         /aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600773; x=1755205573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N/BQuerfWMHHbIc8HwJMkLkO/d6Bj1Ifp1EZ0On478=;
        b=T+vcOs3Z/hhbTpKg9P8SiNCVdH9sUEPzOIy+2w/BDm7uazm1bKGZBr1TOjPmm/ShG0
         nR047+rOXu/W6Pq6rV3feJ7eECnlFQafDJ+p40UZuGJNj69vVI/LrsmOvWTy7Qot9dyl
         BkF9Z2JyH82FCxaSpWHHc7pTta0gk4iSGJAgrKAYt/YkWLzl7Pej1bKoCItUgLvf3V0w
         a4Wn47t+mgAVaMGxrGpc3ad4vUOhVIEWw2KkXmzPLharDtD3M+WOHdnrVzH1XuSMza6B
         KyL8J3e6kcCR4GduO6T2z/oTcrGPJqbrqIogSkEXuwtU5wnCRE+egXOwWlqyy6cdkAGs
         RPzg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCEqeQ7b24EE9SqAAEgIgCUS8Lbg9mV6ho5MCP5liQpLpkYEjnrB5v4tE+daVKPoLx8/ZAHmJqZg=@vger.kernel.org, AJvYcCXQ+Pe5GOvaTYOqI0cvw/pdc/b+l0GJve8IOX3B3V8cS1TwXfaU3Nwl3D/3NFCOyQSKoPnmRLrXG3+/HBnN@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEnar6Zdn9ovH/xptnH3DTvtE+xR6fiuJZN+ZApPa1KwGt10n
	IBvTBshRAKA4Qs4NxLsA1/1kQeuuz+aaaW8ZyGYMc54R0dpjYW+fbdSylhBYDVeRjP5As72X5NB
	PUJqSJ5qFKVz7bFW+TGQ4NhBQSuALXdfGgcs4GJE=
X-Gm-Gg: ASbGncudmsSdn/kacFygwr8V/DGHHHidnBQsMMfnFW7ALx3pUtdCCwfV9Pik3DiOg8x
	pZ4WL5ruWzAZ0YkYL4srUGOtGqiT1fRmcf6uLbr12zyqCRt6bOne/vo0E6NmuZnRZM2KzWCSo+v
	YxZICniV9BNqIWLzmPYePviQPIOmvhwK81fXsGl+rO/d1zgJ0fytEfwMVEj5+qhQLNggA5x+8dm
	OwzsJ+9+pPAfo3zVM7GmmHApmat0ZOGLhHARv0W8Q==
X-Google-Smtp-Source: AGHT+IHRaIH3/PTcs+cQ6vBTZeqnwiYLiUNNURjRjQlXNDy/tBryV5OHFyjJrjrXx0Ish8VsBWMDowlqgh/AGHKBodU=
X-Received: by 2002:a17:906:f5aa:b0:af9:5a60:3319 with SMTP id
 a640c23a62f3a-af9c64674fdmr38423366b.19.1754600772738; Thu, 07 Aug 2025
 14:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807074850.130831-1-stefano.manni@gmail.com> <20250807074850.130831-2-stefano.manni@gmail.com>
In-Reply-To: <20250807074850.130831-2-stefano.manni@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:05:36 +0200
X-Gm-Features: Ac12FXxnn4r7_6lWiYbMhBkRfNddjIbX25gJ4TBrRzoFMTZ6xIespfWImOyQUmY
Message-ID: <CAHp75VeaZztGRjCEnzxHP-Zng6xKwZsaK1nfED7p__Zhy5BC1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ad799x: add reference voltage capability
 to chip_info
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:49=E2=80=AFAM Stefano Manni <stefano.manni@gmail.c=
om> wrote:
>
> If the chip supports an external reference voltage
> on REFIN pin then the "vref-supply" regulator may be used.
>
> This commit partially refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> to add the capability of the chip to have an external
> voltage reference and then remove the ugly conditional check
> on chip id.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

--=20
With Best Regards,
Andy Shevchenko

