Return-Path: <linux-iio+bounces-18026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6BCA86E9A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1F24407EA
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6B205E3B;
	Sat, 12 Apr 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHI0/OLx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9181F0E21;
	Sat, 12 Apr 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481301; cv=none; b=heYXb8IPgHj+FFKrp9inrcgrhg5xdZO8PkwQxi3V0bB3OsEtmzUigK/o5klAXfaOY6nfHVmD//NM/DDYnqoaV+PfmY7WQelAma/rXU5sF78pQU8ERDkNoNVVK4clT4TerWF7WteGQ4v3UI1hpcczxzTWV647H81pGNtaqM4LGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481301; c=relaxed/simple;
	bh=4dTqsGRTGY0t5K+LIOjuDzlZh6c2Mj0q/pqOoIFtsZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFeoZv74/IbGvWhxO1Hh2MHVvS4ky5x+yCDhogEMu9cPPQRxlWgNdkgqVCLciCIiGIxJXd5j8mcBVJlcP52U5OG9CYViUI8h1lJobL/W/fJe2pa7rV2t/V1/sQ76uDq9XtNce9c8Kw/XQfraIVd6lmSlHkHRYCepju9K09xUeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHI0/OLx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so505319466b.1;
        Sat, 12 Apr 2025 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481297; x=1745086097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dTqsGRTGY0t5K+LIOjuDzlZh6c2Mj0q/pqOoIFtsZM=;
        b=UHI0/OLxITdYsfBwH6phs3V/8O4Mv/dVbjSJaXiygKWowe6b5hHnhZF/nRf35u7BL/
         8sMVzQY8/lLs6H/syMeYBVbLzBRh5YncDmIOuwNlGOqpfJw3DI1lpfKCGgZdzR/u9/pf
         Cxw//1Dw1Ulk2h+E1kNHtsQDsXhueD7Qt8a1Ufqzx6ZgeAOrivdZMqt2L8VLAAP2gY8U
         Wwap7YBmdc1sk7qDeBs/2TJr+gQRXTtYvQ2Wxnw/pNiAW9It28Ytmo94GxBu355piPsH
         yRuy8q4zIVgmPI8L9RPcQVMMDwdzFDhs3hifDiPSUjNn/waMQUltROP9rwo8rRbWoA0S
         TBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481298; x=1745086098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dTqsGRTGY0t5K+LIOjuDzlZh6c2Mj0q/pqOoIFtsZM=;
        b=mETM0CTWmuKZN0X0A8sG1QaWg/oZUwXyW0bZQAAZGv6Pc0mG8dLT+xwEuGSpMFFgxn
         iKYJ1shqI+IMCFjLTSD75lZZQvIinn6DYPMeCn5hBaFDmJqYkfJVAYqaJ63Idq1Zs5x1
         lRJf78jd1sxjvKoJBakPICnT0kTvWs1Xt9o7HPwSTZT3sJxqJOLoldpmu0zYby94mdKA
         9Is+PWPSqmH6QwZTQS5bHAFRzx+1Y7NL/1HJGhiInzHFvRr0nLEnAW47CBpI1q57dYx4
         A86nyLGxopcwrImzDcx7DFGax6vkr5dAxl6XAVGP4EDtEDmCClpYlNWzWuqH8KnvRzHw
         bLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHX4IW9ut0HJqZKaCks+8cba0SBD0gDmO+lQ7AB7h1ELeIry1qiWPpyRaJ9C6j2cfPwX1HVeT0+70=@vger.kernel.org, AJvYcCUcWC+YQ3yHO5xnW1fepM5+xzxW5y6Nmv5QhJXXqsAxKXcyV8ESjr0eYxlPE/FkG/p3i+fdC54JXRbKBoGw@vger.kernel.org
X-Gm-Message-State: AOJu0YxRymwFBgAkc3Mx0y8wXUaAJ3bUCWvPXpQtihhU+c04umuTuR5U
	LiNChzVgIo+m6EbU5me18ThfJ74Q+b66YXnM1uRhiwQSN5jlGa/GGy8+hT4eFVHx7IlqIgH5hgK
	HhUDD33nIpQ24HKKWoIQ/ZHyA5KE=
X-Gm-Gg: ASbGncsu0BGYFMlO6hbekAPgsXwhbhgQaqvOHLt1WrrduDCB/5q6F3fu5M8b1a2NJ12
	cvqBZrmy9Z5hOiOlxDKwKWae+zutUv+hU57A56lZsBQhn3HuqOz/v6/v2Y+iMQlR1aiHgJf/ppD
	aNJnd2GwBTE61QxLAP1qbtyA==
X-Google-Smtp-Source: AGHT+IHwlMauSDYb3F4+xs9iOl49uDgO0Bqw97Xx22A+KavQlXG+0XcEY/aOXY8qAnhH/8FJz/p3UexMTPyWevIHvSk=
X-Received: by 2002:a17:907:8694:b0:aca:cc2c:862a with SMTP id
 a640c23a62f3a-acad3456e74mr687348866b.5.1744481297320; Sat, 12 Apr 2025
 11:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410135836.2091238-1-olivier.moysan@foss.st.com> <20250412142606.66673634@jic23-huawei>
In-Reply-To: <20250412142606.66673634@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 21:07:41 +0300
X-Gm-Features: ATxdqUHG8l2dJ0PpOTJX-K4td1_yt9Tsr0rZ-bQ6xLHZ1IHBrZe_mC4b0mFcaRk
Message-ID: <CAHp75VfUkStzq4zrKkaQ67REuuTSGhoD9o1LXU-YohUULBnd=w@mail.gmail.com>
Subject: Re: [PATCH v4] iio: adc: stm32: add oversampling support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 4:26=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Thu, 10 Apr 2025 15:58:35 +0200
> Olivier Moysan <olivier.moysan@foss.st.com> wrote:

...

> > The current support of the oversampling feature aims at increasing
> > the data SNR, without changing the data resolution.
> > As the oversampling by itself increases data resolution,
> > a right shift is applied to keep initial resolution.
> > Only the oversampling ratio corresponding to a power of two are
> > supported here, to get a direct link between right shift and
> > oversampling ratio. (2exp(n) ratio <=3D> n right shift)

I have just noticed the interesting (and perhaps misleading) symbols
in formulas here and in the comment in the code.

I would expect to see the above as 2^n. Because exp makes me think
about e (natural logarithm base) rather than about power.

--=20
With Best Regards,
Andy Shevchenko

