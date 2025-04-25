Return-Path: <linux-iio+bounces-18614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C4DA9BD8A
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 06:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A577A9CA0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810FB21638E;
	Fri, 25 Apr 2025 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOb0pbdE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0987211C;
	Fri, 25 Apr 2025 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554950; cv=none; b=RYe19D5D5hLUQgXc1fjDCZ+6BGAfapK8hfSJLgJKQIb2G8o9w+ZF48U7tniovA9JAmlXVWQ7VT7n9IYxinjV0Wx5IAq63SjEX+xg/m99ua8NzkaZOiZl9OgZEhSlKR85FiOXLpNoHZy9kSaEUp+OSTF1bzdIcoRV1d/HQHKBSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554950; c=relaxed/simple;
	bh=wVmtfJ0+IHdRZdURO4e3LV7ZYiRRjbMZL+41Y+TJQSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udFDduVDY3Jr1Czlk4DxLXKCEylYVYoCeGwNTXkL6d8wnui/nP0uCnHivfAm4RrHRkt5H5BnlZBjei3sb7nqaF9Zvrh8oPankAy5mk8fxb7YLCTbMerw/HBTq4gzSRZEGWO/WOgHbyDro3TZPLpwvV3+9f9JoCLkczxPxmTkTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOb0pbdE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aca99fc253bso271539366b.0;
        Thu, 24 Apr 2025 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745554947; x=1746159747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkt3Fb0i8BWUPG3FcNT5RaUD+ZjJauG0htje5UaVJ0Y=;
        b=FOb0pbdEbPIqDRZWPQvme5DubIoNY0SjbQdEdq5FpHVxyR2yLBqVouIAWVlMrOzvtD
         Yg0txQy/ayKm1zEETKfzz0EHn72qYS/2FuosKGiWmkhAuKndZwuYy1KPCyL9H3wvE4J/
         SJOW1NEoTE/ZaAZUUi5q332oI6VmtFmw9dzwCa4JEeeHT8ccg5L7g1+P00SPHDsMyq8E
         arPIFozMTVEP2AP3NaYmW91GVSSK2bkM1npGid5rSR6znw26e2v5t0g/5BX8kOL9QO6h
         mZ01D6Km7rU3QdsF4fv5aYSuzwa40lN7QNXoviWPWxYjGvKCAVgZLoq0NqffsVfPH9kz
         MH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554947; x=1746159747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkt3Fb0i8BWUPG3FcNT5RaUD+ZjJauG0htje5UaVJ0Y=;
        b=ONRzqE9cuJnBgyfg/gmQZfwojDYJGL/ni8Rc3T0cVY5fGinxGg58qPNuncXjvL+cp5
         ep24srmsU0b+NdvTlEOSyKeeJD9pRZy7mcFSyKG7CRTosttRtBOZrcIbrVaORnReiCOa
         3MwJQ0b1XzfbIiRnHtL6ikIXWI5iJB/T3QbpWGRYad3njndQSFHNWfOg3pgvbKvVm4y8
         AhbF+ELd7QgR220OodWYeCm7Gxl7PQP3cKCluBKA6hS2gE8t7xmcS6m7Vk+YWgMvjEwx
         65wqoN0KuPVCT8dGRoXjFVdBW6KkIrrePDvvDHSdDkvuU0gPwNkzgPHn+NOS4wz4BMHU
         ayDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1d8L5ySwZr78F9S/LQDNrZ6OOQOw9Zb2jCRhbBSuGxGJUusce3eEw0NAIJjzHF8mDqxUct4wSxl/Fe0y@vger.kernel.org, AJvYcCW0OMjvS8zZA+JVI7rNn2+IPnuxeUgtCrqlQCQ/EG4hYn8QkdBwaU7pYrZO8mNC8/tQ5C68eKNZ@vger.kernel.org, AJvYcCWl/tTtX4ee560R7cP/EkpM0Kv0y1JO5rSeUPebwuQ8aCCesDQXthw5SCbh5E3TPk6o7WUH+w+3Oms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbMQGH/+0MY0WLmmY1ShJRNLmyz4juLRNAwQLyJI40VAKoBVT
	fq/C7WytIFBoOmj1cjx7KbFM48PmmkPWKm8LvVE4OCegetron4gmT3B3/k7F9aVYmWZ6hD6WCh5
	pyOMMaVDRBGqA1vReNdIAX95ekEg=
X-Gm-Gg: ASbGnctR2m5DBEs1TY7luJ1xZKRZu8Ci206694XTm4Zqf6VWbpSdUkUXMA4/RBOfOJq
	VGNEFy/QPibcP4CGFddqwSTAbGWzf7aBiM0gCC4j1quZKWI/AftOUppNJ5GzjQmecJ2ZTm+v5Hg
	42FqsRzT64pa/nnmY9hg8j1A==
X-Google-Smtp-Source: AGHT+IH+BM2yM/rGFp1Z11i1ILsWonHhYb005z8Jxr+yHkNXJFdekCIfbD17qMnLRljz8On+cUmW6DtvbwQ/DNGNpng=
X-Received: by 2002:a17:907:7d8a:b0:abf:7636:3cab with SMTP id
 a640c23a62f3a-ace71158aa5mr70087066b.29.1745554946609; Thu, 24 Apr 2025
 21:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424223210.91317-1-gshahrouzi@gmail.com> <20250424223210.91317-2-gshahrouzi@gmail.com>
In-Reply-To: <20250424223210.91317-2-gshahrouzi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Apr 2025 07:21:50 +0300
X-Gm-Features: ATxdqUF1UCKerji0yG_QpF0px61-9OXRWb5-42XDjrlc9ydh7FDnSk3X5-2_n5I
Message-ID: <CAHp75VfbyGKximuP5QKuyB5UKOSPydf6Zh8+nXzk1hvZhDUbJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] staging: iio: frequency: ad9832: Use SLEEP bit
 instead of RESET to disable output
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, gregkh@linuxfoundation.org, 
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:34=E2=80=AFAM Gabriel Shahrouzi <gshahrouzi@gmail=
.com> wrote:
>
> According to the AD9832 datasheet (Table 10, D12 description), setting
> the RESET bit forces the phase accumulator to zero, which corresponds to
> a full-scale DC output, rather than disabling the output signal.
>
> The correct way to disable the output and enter a low-power state is to
> set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
> the internal DAC current sources and disables internal clocks.

...

>                 if (val)
>                         st->ctrl_src &=3D ~(AD9832_RESET | AD9832_SLEEP |=
 AD9832_CLR);
>                 else
> -                       st->ctrl_src |=3D FIELD_PREP(AD9832_RESET, 1);
> +                       st->ctrl_src |=3D FIELD_PREP(AD9832_SLEEP, 1);

From the code perspective this allows combinations of the bits to be
set. So, what does the datasheet say about SLEEP+RESET, or RESET+CLR,
or other combinations of these 3 bits?

--=20
With Best Regards,
Andy Shevchenko

