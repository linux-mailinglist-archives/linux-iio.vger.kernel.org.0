Return-Path: <linux-iio+bounces-27397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A926CE0129
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1733E301C3DD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC047632;
	Sat, 27 Dec 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSOokB+9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE3280325
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766861080; cv=none; b=IARK77y0j8jrKRhVld/80wGJkE36xqKOEYvGTQmzMFXkisQdphcI0CPVme9MOD4AwUByRK8FZrNp/Q855lHU2xyOghN6splxsLodgAAe6zQb1g5mYTiJf9anaLKIaGbj9V9zayPIC6bc1HNg61ZWdkGvIepMoaANDjqjsHFZ8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766861080; c=relaxed/simple;
	bh=rdhIBTfFdXUktQ9sa/Bcoyf0GMkDmxm1f+vi1Bd9iOU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DCYcsFDxqEeRIxhK7m6Uq52fi+hk+AOF+fVZGS0+zm8KmW5S6G+UJjPWZfy0/p4qr2nOUf44awXA5thJ3RpeUsYOrDpUsOhA3ww2IsV9CRZ/B4n6h6KbeAV+XWDOa4ni3SLl4UTGN9nW5tuPT9QYfm22Q2U5AQ2hd/Vd4bpJtc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSOokB+9; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so5695804137.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766861078; x=1767465878; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7kO+jmMKH7V5UQhMAssLbKi2imCsali/qeRnKC3XxI=;
        b=WSOokB+9XvdLvBTsJxRhw2m3F7vqAL0+EfKQhMaam4FRKK0DxkiD118gwH/ERy5xc1
         ZpJQK52nb6l+mWEY62sPbP9fQ06tJ/mD+ChCO8RvS56R2B2IT+MY7zTYTyi5oGD8A5FX
         sWJ9v+abOt27Iz0lwou7qMfy+YC+xnYTXwjgpoUcjiw4ouWoaRq9SllvpIYeSb7NFYus
         gd7wN2isosVVc1gHCgnJfQxsvXQHUPvNBhDNpIaeRivhOzadwcshbskXeQynLcB6zT8C
         REL+NRxjcgNVBIo0CvbYxK9LmP5B7XcDIgQiNc/sf/FYUJNMJG9CmutQNqO3kNDiXuji
         SRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766861078; x=1767465878;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7kO+jmMKH7V5UQhMAssLbKi2imCsali/qeRnKC3XxI=;
        b=t0/UqKeefdfcIIUGMNiSGlyzobgLjnhP0VkLsHR1mqhYp5dL6WW7LJQKuq4Jkq/NZ0
         enCLcMITKdmfqUhPdZ36Lo3FuwBdYTxK27lW6X6cUVajXBSy0Q6SumOkhnbPlGvBoxoO
         y8JdvOqh+qNMLaUToGVd1juQTbdWcCc9aRFdz1/Ma6Q4v7XqInCroUEAw7Kkxcr6n6XU
         J6GRHskVDC5bca5C1mPhYTZ6Deh6OuVb+qaf7oAOm16pmMBQb20RQF3RkK6SNrP+jvZf
         l4s9PhOU+Qpq9x6JBhimjfk0Nb8E8nRqlMSunzdQOAbJU1rjAMzsOP/Z3DyOhLPQNk53
         pq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeu3y/hQN0z/H/GntjmDCUWcxM5x0rYm6EXKb8vM+0gTpCBNSTrnwDkt/l6/STZOKU2+l7yzMFFMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGpJq2J4WyepH9pfll7KvpoggaZJUuNxDgmk2wC3dv1UbdejQ
	LMxUgRftbOer1QLRBBf1XXNR9DR8uTXfg/LkRKEOfMOQVfVpFLqB4HAB
X-Gm-Gg: AY/fxX6IZt00KaWB0A14ClDCXCtx+t8FKTuQDHMqt7Mowv99E2fh2jO0Iv7Pwr6BFYC
	l/TffN/ElZ6ONu+z0tOVeV6IgKyXU2xlezf/TDEgJJvtPQF4BoVfn1t0jtVSVgumXnNQSCjX/bz
	0uI+Jmgk9JpXDiIVAEkM3Tq+28IyhX3bOELORDCGCHaXa0kOZAonJY87JSz6x0rAMRC8A70sPa7
	bZ+/006FxtK3xrlWDN8aYdEBvF2UuVMwY5Kzea/HDZ/fGlUvGj+8EeNxwOpQdhI2qx7qFd6d7lB
	+bQYiVQN6+gnEapzNhGNv8g0mkCh7ughkMAuK7YMS5r71cy+/djZY8emYlBKS+EUn69NSlkdoOa
	vii7/a9KLh28UHZOL4rqifU5r77/IO6/GyTGK4zB++mv3LmBH4oY33cHVpEY/hGC1PwYuNZ1oOI
	pdlHWHtS1aZIW3
X-Google-Smtp-Source: AGHT+IEZcQ/IcoUf7aH/caNcZC+d2KO1dJbj+QLlr65L47GvTlxUk1imjM7pKXq3ZG6lkoTMvo/JAA==
X-Received: by 2002:a05:6102:2c81:b0:5db:deb6:b261 with SMTP id ada2fe7eead31-5eb1a687a81mr8750016137.13.1766861078123;
        Sat, 27 Dec 2025 10:44:38 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1aa4f32dsm8215153137.3.2025.12.27.10.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 13:44:35 -0500
Message-Id: <DF97Z8HIH640.49M8GK9XPEXZ@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
 <20251227144707.1bebcf27@jic23-huawei>
 <DF97CCMNGWVP.2JBZR7CQF1FID@gmail.com>
 <f1c1ca8d-7896-4ccd-b59b-8c6c1bf4fa66@baylibre.com>
In-Reply-To: <f1c1ca8d-7896-4ccd-b59b-8c6c1bf4fa66@baylibre.com>

On Sat Dec 27, 2025 at 1:24 PM -05, David Lechner wrote:
> On 12/27/25 12:14 PM, Kurt Borja wrote:
>> On Sat Dec 27, 2025 at 9:47 AM -05, Jonathan Cameron wrote:
>>> On Thu, 11 Dec 2025 21:45:21 -0500
>>> Kurt Borja <kuurtb@gmail.com> wrote:
>>>
>
> ...
>
>>> Given earlier discussion about this one being rather more tricky
>>> to name than the claim_direct because claim_buffer sounds like
>>> we are grabbing the buffer, I'm not sure on the best naming to have
>>> here. iio_device_claim_buffer_m maybe?  Ugly though and
>>> these are super rare so maybe this isn't a particularly major
>>> concern.
>>=20
>> Yes, it's a bit ugly, but as I proposed in the cover letter, if we go
>> for a full API rename, it shouldn't matter for now?
>>=20
>> What do you think about that?
>>=20
>> I'll go for iio_device_claim_buffer_m() if I can't think of something
>> better.
>
> iio_device_try_claim_buffer_mode()?
>

Yes, that's better.

--=20
 ~ Kurt

