Return-Path: <linux-iio+bounces-21995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369CB10FFA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FBC3B1DD1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038702EAB66;
	Thu, 24 Jul 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMojyAsW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287B2EA723;
	Thu, 24 Jul 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376130; cv=none; b=F031NcYTZt7MTkBGuvLodGSS9LkUSk0CP3Wu39Fj56x+dScUuefKgiWhQg6vLS1e5ABHhJVS41UJgo8EoOGAYRr90eM1KzYQbMXvVX+WyRrKre1JlwKYib0T9A5d4u88HebgbpRbVsASnad6OhSnJ5tJ3oiVy0A9jfUMgkv/KQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376130; c=relaxed/simple;
	bh=vDYA1NhhThENwjZWZ4Eoud7CZqi+pj8rM+pGYQRjuYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqqhmCrdBVDyJDDyGL7dn6Tezq4OXW52NNGYG328wg/37NGrI0B1p1HDpXho8HcM0/Eyu37tcUZMN+vpJt6guiqfCo9Xe2GDp3Q1X7Gn7Ok/kpBiFyVLlMZLVWrmbxIUDw7SeCRHgaVr/cq80Lo9oJ8/CW2zZArbjfj74wAg7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMojyAsW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32f2947ab0bso9803191fa.3;
        Thu, 24 Jul 2025 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753376127; x=1753980927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+At4Ui3pp582i3bB5s4tY3mBzGHPgBqGnhbfW5ZsDA=;
        b=hMojyAsWwqia6FI/hTEAHBnScXjAezRJZtzrQ54rtAewhSGDqzdlEa0Q0Zxjjf1gb5
         Pcm5DeQPHOB/GVkPhmqMePNLvecmVqqthSO7fuKqs83040KYQtNdTNlsk828CQniLcbq
         OZVnlTYcuE6PFMYPTFtZwtMw1qANHe+MC2d3lmo6OAKUAwMhfo29TWcdGJ3kaHNc2Gi5
         Onrq7I/H4aEJK1zPD96mD/WBbVHbJk/DFlLJWTwEW+PzgB5nwPAXCLBYkmbLe/HoutvM
         Q6gmIpIH6JVrnshHxHh3SfzHiHe3U0WGtGbB4lFs7hgvj8ZkPdCcI7EQj012khKcF+Lp
         ukfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376127; x=1753980927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+At4Ui3pp582i3bB5s4tY3mBzGHPgBqGnhbfW5ZsDA=;
        b=jnVDMTEJmNMz+G+3TIJZxyyOeIc8ZUB4+xGpnkCRtr0jnZCNUVn5/rhtSbXpNVbfEH
         tKmXhYGKtgrj6e/f0wPVuJPqctYMJVCE5Aj73OMTyx0ZI47IKYpHftZyZe7/Tbp2HZcq
         sEWqBxlCU50AqF5eR36M7wEN9F7f/EN23s3Ly8QCf8JeefRfv+b+jQpigYOsZEuoBKrk
         K6fJnAnNJ3T0AjLhlcrOEig9IoangmC8XdJJDR3zulcAMNEs5m+SiCLLGYMujqh1Cz8s
         ZZYsd+gcjIRtueDxHQeQ3fGQ8aKKHHn8TyIcDTw3jiY3WCBzoLhpECutlZMnG1SM7gzL
         K4tw==
X-Forwarded-Encrypted: i=1; AJvYcCWcGccQVJpNsbUmRpnvBRWdmzUJG/fds6zZ3QT8XmdkHuvlIGhsm4nGSACvLL8GiuHbTQV2EyTLBzw=@vger.kernel.org, AJvYcCWdyWK63MTZGSGiMfYUj6LEgO/Op7Mj9JGchmyGaw/mvaB+rHWPI6cXKElMeMlvog/UeDZVlDl01HUkgmBH@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlX/NjI4Mro51OuRLH8ZrnIyNeQvz/s7tdvlxUYEU1/8Ii14O
	4QHMdAf1waG/0w3UibcMToWxecL8keyQzfWOo+5xTKOuroTyURyAptF4jubTu+pu3eaKnhwj0/b
	8EUth/Fi9dKMEb56bR5Wykr8IY4lMFB8=
X-Gm-Gg: ASbGncs/qVTAcv6LIBlPB81dKU5Z7BtcT6kJQU5lXgMJDSVUgZZPPXCDZT0vFrVWP90
	ZNj2XKM12PS4CiqtWVcA4PXQ37dtV+cYeqs1CRlPXbxMebOXs6OFa3HSq7FSd7YTiUAoqprTvj+
	ot/kguwo2lv3WJs97VpOBGRBqE/VfDaC6yLYiRtyNFAajKgcUBCevF7Y+DVyhewsfVgc884t1mQ
	ACQzBHg18Op/upofbQOPuxeknWxXlNoyLww1qGvMA==
X-Google-Smtp-Source: AGHT+IEqhLOp6yHUH5dQsCSfTeUo0stQF5I9wo3pzXXCIkAjrmH+erexTep2dBedqzmkJfJ+H7RGIW1nvJX4qsVZd3k=
X-Received: by 2002:a05:651c:516:b0:32c:ab57:126b with SMTP id
 38308e7fff4ca-330dfd15a37mr24115001fa.16.1753376126720; Thu, 24 Jul 2025
 09:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
 <a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com> <CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
 <8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com> <20250724133933.220d00e4@jic23-huawei>
In-Reply-To: <20250724133933.220d00e4@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Thu, 24 Jul 2025 22:25:14 +0530
X-Gm-Features: Ac12FXwNOOTQfqAMLiC95ekt7KZ72Z90WciZ_CBjMj_dmSO7lB5A3HTpo4t-zuc
Message-ID: <CAE3SzaQcsuHihe2-7VTnXAKYab03Cyu1kAPsA2-E4d1kQzCCNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, anshulusr@gmail.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 6:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> Agreed.  Is the interrupt wired on this board?  If it is and you
> want to do filtering with the knowledge that the data is fresh then
> add a data ready trigger and buffered capture support.
> It's a much bigger job, but it is standard ABI and as such of more
> general use.
>
> Jonathan
>
Yes, the interrupt is wired in and enabled.

For LTR390, data_freshness is not the same as data-ready.
Here the sensor does not support a data-ready interrupt.
It only supports threshold violation interrupts where thresholds are
configurable.
LTR390 datasheet Pg 17:
https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV=
_Final_%20DS_V1%201.pdf

Correct me, if I am wrong, but as per my understanding, trigger based inter=
rupts
are more appropriate where the application requires storing multiple sample=
s
in a buffer at specific time intervals, provided the sensor supports
data-ready interrupts.


Thanks,
Akshay

