Return-Path: <linux-iio+bounces-22449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FDB1E876
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E8B18C1E37
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647CB279915;
	Fri,  8 Aug 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/8chpXv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC041FBEB6;
	Fri,  8 Aug 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656541; cv=none; b=WOK7fn794v74ttpmN7edktqxct0f7c0iu6RigmPiB8gJVUam3UfluCzmaZ5MIZLGUuNcPmzxrwDpnW22OXWclnpbJeZGfCJUWmkISa+rhmqPren64cxrvaGNn7GHh9y+wG+7XlhfGsHUgQjnOLt3CodZMfPQkC229Al7pRYZiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656541; c=relaxed/simple;
	bh=DBUrRohCnAaDgN3a8rl0rDSbV3emnKD9qv2m8fLMOZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFW70538TWxdutokY/CzIJwQB5IWql5ipSxtW3qUQD1RaOwAN5mgwBEWE8oePr7hg9FLoGQFfRFynAXlLOeqaaGoFdOgij4mLpZtLa3AePEoKjgmBURh6i2o8pdUklTDuE2Eb+X8wCmgtdS8xrY83lgnGu6ox0w6BWoaIoUAb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/8chpXv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so5062637a12.0;
        Fri, 08 Aug 2025 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754656538; x=1755261338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDSYh5lya2y6QD4ijxMsZsR33rbgiCTEcFPK31qmRrs=;
        b=J/8chpXv6fJQmaRLLZS5L+wrE3ctf88r7aIyGxXwyJN+Uu+QD2ForxkF4LeHJJJUeF
         guxZOrZld8I8SHNaTssLVYxoMEgbo3H00w0AkqoKRUjbeurMsi9BLofnJPM4B1hHhtI+
         hcZN2ydOaS5vgBYORjJAhlmyfx09FGzOsHt4zAtn8nKL0nAv6qX8cS5HdI4u0yjR4/Wl
         2H5MAudHKbVpIwtubQWaSoAfpK9N7f0He08Sepd56UmByR9t7IGdCNka9CzihY6EpDgj
         UpuS4PPVg/W59jtChiecHP8mODKzq6QqEWan4VB1fjE4apLnOFqswAqUsZPRjFZKZxOD
         UtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656538; x=1755261338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDSYh5lya2y6QD4ijxMsZsR33rbgiCTEcFPK31qmRrs=;
        b=sTaPT23nlxrhhW1LrbDOS7ZyxWWzWPppZGolEBAf1nCsBJC8h9j+I5xjcceugvpxDT
         O1srwMWJVnSrt3MQTqVV0x5I7KG9n45nwNg1mIl+MERvMpfXkaXzKCwcZegjzX5Zym1k
         IQjzccWj9bpB7E9fsN5L3KtVjVLFihx5rqCJF/dZqsm9TrEcq4NGJO7XGOrlnqf/Pin0
         inK4C37JvZ14MolEpKSfKg2yAMOe5F1gIMZV6jt2VoF+HGwpV2fUZHX+TUQjWqZJjzp6
         q5SnJZimRkEJJa7Cmj68W2QVkCDZnw6SzE5pTc/FigwICFHSZSTJF4iCuw6gEZmC7iHH
         Zpbg==
X-Forwarded-Encrypted: i=1; AJvYcCXEC8SwXzWG6TXxCrTcZ+3+jZXWOtmJx/8tLoN5N8FJOVUMmNvXJa/s1ASVJ5vTIFql/uAJInY5iDmF6mLe@vger.kernel.org, AJvYcCXKxM/TdVU05HwDl02KsxQdlGI+Gs7gugze5+FapCBbS/YhgljPL40RLhjU3uiraTr0hWB15kmS4Qo=@vger.kernel.org, AJvYcCXLwWtT25X0wb3oAPSyrZ5eOU5wncTHuHqkzJrNNG7KFu1XQhSw9nl7bPSmOcFDtwybLlPlIOQh@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkFwE2CW8mlpw0OJJJsQGwu9LF4TI/LUY+V8Us+fTDXf4hu5B
	zRn7utn4eG3f3WBF7nl7MC1EMfNZoA9GvK2ebkLmaBPIDSVnxdtTt/DKUOlw8ck+6P+Cxv01A2l
	dHgVGG3Rvp4+ztlaoQmD7oWTZzvJ04r4=
X-Gm-Gg: ASbGnctJ4OwRfHxbXsCQmrCAYjM01IvshKIl93UXrCgjB5f8d2XLdbsUbb6AmoRysFL
	mBQy6VU0URfWJmv7FvIc3fzvzNklJFOHQVyd6PBDWcjQZBmKdgVSYVQuZIBje2omkePTDEC0u9s
	jA9kaUIni6A13NLTsjSFMDZr7hFU9p0r2HRJOaR4V3GpcWinmPJsxNy2iiWNPe7Orkco20wq28d
	AqpMJxpRQ==
X-Google-Smtp-Source: AGHT+IH32kHNPZMnPqhCs9ebrCdy5MTCTTWaqqRa76UGtZ3/T38hE/+4EwwwkIQ1oM6LDdnK/9b2jIKB3o5mmZTsJf8=
X-Received: by 2002:a17:907:1c28:b0:ae3:ee3a:56ee with SMTP id
 a640c23a62f3a-af9c6e2731dmr277972366b.3.1754656537579; Fri, 08 Aug 2025
 05:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
In-Reply-To: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 14:35:00 +0200
X-Gm-Features: Ac12FXyUIPj4_cHk-J2g6XoI9XXAOYyAwh9-yx6DvxsNiVg9fEZXdZq1W3bA-mM
Message-ID: <CAHp75Vcw5Q_ENzEJvH2+xHmPD-DUPAEaOOD2QoiCXoh7UiQJxQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: change invalid data error to EBUSY
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:40=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Relay
<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
>
> Temperature sensor returns the temperature of the mechanical parts
> of the chip. If both accel and gyro are off, temperature sensor is

the temperature

> also automatically turned off and return invalid data.

returns

> In this case, returning EBUSY error code is better then EINVAL and

-EBUSY
than
-EINVAL

> indicates userspace that it needs to retry reading temperature in
> another context.

...

> +       /*
> +        * Temperature data is invalid if both accel and gyro are off.
> +        * Return EBUSY in this case.

-EBUSY

> +        */
>         if (*temp =3D=3D INV_ICM42600_DATA_INVALID)
> -               ret =3D -EINVAL;
> +               ret =3D -EBUSY;
>
>  exit:
>         mutex_unlock(&st->lock);

...

No need to resend just for the above, I hope Jonathan tweaks this
whilst applying.
Reviewed-by: Andy Shevchenko <andy@kernel.org>
(assuming typos and signs are fixed)

--=20
With Best Regards,
Andy Shevchenko

