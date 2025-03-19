Return-Path: <linux-iio+bounces-17091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BFA68C75
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B3317E7F3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22E25525D;
	Wed, 19 Mar 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF4ECv6K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0A254AEF;
	Wed, 19 Mar 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386260; cv=none; b=i6yPAfCX/6DXt9p6yOu4nb53XJpV/DGKCUU3a+bqQkuXFbMSr/iqLpXtMvm2L0NylhE+6HoEizZuUwLDTy6wnCTDqdVzIJDCAcNPRRJJCpIUt3XB/ENnSv6cGtChsYBC2j1yovvEmLKZEqydm9p7vz1o4frDjMyC+6Ycl5k/6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386260; c=relaxed/simple;
	bh=6FzJ+F8KuQB/pKddXtvW8Wf229ggqFqlFOuIH4EZG1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCDvsaUgRz/YGEreznP2A1enXg9s1OyFxn4QWBBqyGJ+Cl7Adp4m3+7WgdFoJ0BqHukdtugVA6xl6k0izG75f08IvRtXob6q5l2IqgFSZkQFzC4dEI0eB/UXa/tARWEV/lkqQROemjpJkwvIr53I5iRs1aQEmLYQIsljxEQ9/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF4ECv6K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso46082645e9.3;
        Wed, 19 Mar 2025 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742386257; x=1742991057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZ6Y/6JZnHwB+tqXspOlEp/mQKFnpjqyiYuwKnFS+8E=;
        b=IF4ECv6K7Cz64riV5O3IWX2udjKjsalu3OXf9rrHn+R1Y2rxTQ3I7VMIB0O2brVCh6
         UOrkX6wEr+twMVLmlSbAwSJsAUb8SekBa0zYW8fih6TVwqmJ7hw1x3xk0En1u/sdEWbq
         pHUorYc2KDZrJ61N6x/tL+yb7/fD+8a8RckGh8MwMEiK3MGMbJ7JYLAGgWrSS26pY94P
         3U0vbMIV1DMejdNFYWKnV76ufXN/nqXUzBwPu20gB7lF5THbX/v30RyoVe1MixyCn8o6
         uY/GbiZpofbjnOd86qGJ+aqbxiehwv+4n1mFR2km3qbF7l0D3A9EoO0rejiwNj8i6Yd5
         PuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386257; x=1742991057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6Y/6JZnHwB+tqXspOlEp/mQKFnpjqyiYuwKnFS+8E=;
        b=SaJN7a6dj2V+cIHTqgg2KF6xTAhPB5DuACQotUkS+v1AqbzNC1Sh/2jJpaxyNbC4QJ
         1yCUUb+4huRkYaEPNW2DROT+th/B+CEQ5iASX3NbR3JQPS4rsVSJZUtomMVub7DZqXsu
         bU+F3FeRtPP/LMDSbqSxCfPc38tLVus2ZcTE7LlZ7sVe8hNo7lyv1RF+0Ivs9W/qb1H4
         HWrY3Rb7ABKHkJKTWgh8bo8/faVwVHm2OpyCPBKygHFA61Ib7prs0Bx4E5pzklphX5ym
         EtYm71wx7A5aCLimF5SKajXcFgjOB3QRYfZe1GHk5J4z84L/BF0BZwnvCHa9r7fK4vwZ
         f1hw==
X-Forwarded-Encrypted: i=1; AJvYcCUs1VTvqhATBPCzoXfqVgdFLSxiFRimf94MNMeq/lsSjO/oH32/QrAD+JAP26t8F88NhmxkDG1OMt1Ozis=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkcPhEpKVGqa0B+aGQGFHuWWNtX0yfXEzWWSXDK9j9Hl6S1+7
	RpSY4tG7zc5QcHhIZD7uajTgMk1/FlyQVeRaPp9Be6w2tYF/0htl77+LZonCQESTww==
X-Gm-Gg: ASbGnct+uWiBXC3pCyYcVTSf8lQl67teS+bJpC8JSj+2peEmX4BgEN/viymfCF2YZci
	mmghde1sEmzxiQHF3iuuJXogytZmooyDHftMZArn54ovbB2vKkAMcd6KHN4pDJAgb82xnGM9zvQ
	jSMoyXYoGcgWmOBs/Ok9whWLVvVtglzs5GTpTwkZzAi2k34Cv32f8uVrJQnS3scUTeaQf8nbP70
	IJGSTwH99AfvdrcCL6M/moSNF0hx+Z+wA82T3j+dpPQN5H3WngP8JlspEoXcirNWtdKG85GJ0lM
	HSgYnnyPBjx+LGjwxwWlKXbed+cqlMrpZJgmlGMI6oGMwiIsYtxMcwAfsmd0I8pACcmb/pJRP17
	Qk3s7ofwZFGrh2uOr
X-Google-Smtp-Source: AGHT+IF/pVrA48AAw6ShHcAEDbfOztm2wWAkWb2+uFoH3bqcw/uNvSiaxmAQYTiWFosjBqcib6zQEg==
X-Received: by 2002:adf:9bca:0:b0:398:fd9b:b935 with SMTP id ffacd0b85a97d-39973b35379mr2246840f8f.53.1742386256921;
        Wed, 19 Mar 2025 05:10:56 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b83sm21471605f8f.52.2025.03.19.05.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:10:56 -0700 (PDT)
Message-ID: <83ee5dd5c427355b38c1c5a63cdae4a114acd1ce.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: add debugfs reg access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Mar 2025 12:11:03 +0000
In-Reply-To: <20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com>
References: <20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-19 at 12:02 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add debugfs register access.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Minor nit you might consider to change if a v2 is needed for some reason...

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 31 +++++++++++++++++++++++++++++++
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index
> cd8dabb60c5548780f0fce5d1b68c494cd71321d..7bb6d8817a545f16de9432526ae2878=
7af1a
> 0146 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include <linux/iio/backend.h>
> @@ -56,6 +57,15 @@ struct ad3552r_hs_state {
> =C2=A0	u32 config_d;
> =C2=A0};
> =C2=A0
> +static int ad3552r_hs_get_reg_length(unsigned int reg)
> +{
> +	/*
> +	 * There is no 3 or 4 bytes r/w len possible in HDL, so keeping 2
> +	 * also for the 24bit area.
> +	 */
> +	return (reg > AD3552R_SECONDARY_REGION_START) ? 2 : 1;
> +}
> +

I wonder about the added value of the above. Since it's really only used on=
ce, I
would do it inline


