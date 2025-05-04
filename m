Return-Path: <linux-iio+bounces-19031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4F0AA862C
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F57177C19
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707519DF98;
	Sun,  4 May 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvrASp2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DB41AAC;
	Sun,  4 May 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746357361; cv=none; b=GsP+plL6Om8u/a4bcVXYr4kP/6yeGr02K7vibAq+SAM5K8DUA2UqFkA5JLt73qDhQNp3ttLz1D8u9NVrWLAWDhdjMYHMVvD1spSxkX+aPHMrkwXypsUrhrWagBbMeu5L09qNtQTx8YNxbqTjJzKUx4PjKbEnFFm5LM6r96JiwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746357361; c=relaxed/simple;
	bh=hWx8872nRG2owf+dWaC+w6SN4/npRrVZ/8Ejukj8DZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzSc/yKtgGfiNZmlaOgrZ+mHY4Py7Kc0Z2jLVufxWxRnZuMiORA6XF6Es5Sc6FjpMn+v8GAtwHmFvzPAHRV5JgiyBxWoLB82+UzTm+SiIqDD2rpInJJJbsdGBN9aQJItrEqI6ObpXRK7qOOb/prKm5wWihvbPJs4A+KM1w0k/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvrASp2z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so41133745ad.2;
        Sun, 04 May 2025 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746357359; x=1746962159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQcB8pOIo7fPfcqU8UCrjsrQ9eSJMuMR7jwg4emfdt4=;
        b=WvrASp2z+iiTuew3eUlv1bzp2rtoEhOTyEGpZ23jWEtJdBaVui8y0pk/EdGEyVC4B4
         1x762Njy58t9L7ehHJKFATV71+cU8E8NzhO0q166C9tgen8CRgdN4M3VPRJgMiILiIit
         K/cd0PR/Z6GsxLDlYCWnoeSSoy3kKtStCJqMwXShrl5M/Fvt+/MeF3tY1mfoeyFZUPBj
         Iq3XFqJyWMx6F8lHwUEJPLpzWIFBSuqJuuDmTBHAlMxDSBFRbuUOY/m5CYVauhG3OIlP
         AREsuXePwn3n6J7qA36nKknlxWR9U3+ptGAk82U/05Bj+2CslI8WXAZW0hENvxQec+mP
         7+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746357359; x=1746962159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQcB8pOIo7fPfcqU8UCrjsrQ9eSJMuMR7jwg4emfdt4=;
        b=cE9DS4YPWI8EPJqrXIgb5LV217ZDa5VOZOSS4k1JBK8BKi8u47lYaZ6bJg4pnFUNVq
         mio5LBmylLE+hX0ziRVGBIJ0xh/WyjYuZvvrRkt0YtvkMzuolT+J5bCNKdA/tIct5hqT
         +ojvvGot9/poqP3KkiKSVUhSYamy4djH/gevJOirR8ffEuo9QcXa/42TifJPTvnNscbP
         adRIn8btERatPTetqdyN75L0qLLG9XY2bmRtwyWPz/sdHUkdyIsbNZ0R3tnNTIgoDn+s
         RA9g9SbozHGO3vs2DPhggwvUIZ2ddMbqAZQW8Zduh91c/iVFdxHSGH0emdBfPUojtGxW
         MWpA==
X-Forwarded-Encrypted: i=1; AJvYcCVHecJvlj9zWc6ct0UytPcItsf6KPihwqbaZ/MXMdUDViIps+dU0Nz8xMhgwbuuzqF7JK+v8RyyYiCO8gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYl3a7K985Nu4dLH4bb4CiwRP0X2oJ14GGR04q+/1mGgDJ91F
	gbi4+jBZw70lYHlRccDDijkYKdQmG3diH+DmkBwctH0N5ru34+4Xwekp/3cgLxCLZsEtsdTUHRY
	o+VJhIflBAABI0AFnkdrYGA2OGT0=
X-Gm-Gg: ASbGncto9i55sDiiNRU43lVNxM/Qy883iYze3A4S5pQB06Uvb8BanOWoBsgMBVrSD/6
	V4EVxqAmj4gLUrmvyx9QbGMaCTrp+fYvq8G2UdeIn8sf+eMBq0R4Wp1X8R66EFaMq5Zgmais+ZL
	wwgzNb5naeCnqaufGMktl+iDI=
X-Google-Smtp-Source: AGHT+IFwJ0bVq8qmQb1iICzTrvm99FhNoBMEQBMsIKFiztk4YpS9zDgTuqJJKxrDcV00P8Ffyh/QQhNDPV0iOg8NBEM=
X-Received: by 2002:a17:902:d508:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22e103570bemr128940815ad.39.1746357359027; Sun, 04 May 2025
 04:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503190044.32511-1-gye976@gmail.com>
In-Reply-To: <20250503190044.32511-1-gye976@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 4 May 2025 20:15:48 +0900
X-Gm-Features: ATxdqUGR_pnAy0VjpWxihzW6bSNaMuLqZmFSSkzOW6eu420sbs8DXYWWADSAFoo
Message-ID: <CAKbEznvW8vFs2fuzhWb8o-yt4UjTt2Su9wJR-jCX7A41M_kDVw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices requiring
 top half
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 4:00=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> wro=
te:
>

> +{
> +       struct iio_poll_func *pf =3D indio_dev->pollfunc;

Sorry, it should be `indio_dev->pollfunc_event` instead of
`indio_dev->pollfunc`. Please ignore this patch.

> +
> +       /* Only iio timestamp grabbing is allowed. */
> +       if (pf->h && pf->h !=3D iio_pollfunc_store_time)
> +               return -EINVAL;
> +
> +       return 0;
> +}

