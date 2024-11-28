Return-Path: <linux-iio+bounces-12760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4AB9DB2D7
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 07:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6E5B22A3F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED12145A09;
	Thu, 28 Nov 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2+dg07m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B190341C94;
	Thu, 28 Nov 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776086; cv=none; b=PtVOM4PG6r5WH69RlihQp7VNrNlqZBJDO5wGWBotj784tDfyWVN+/5k27CUphgp8bUSVQG2Nno/KxlQeMiIhPgce/y2uv/SzftXsITd1mIDBjmSdXz/yPBzUxq/oaApx9ORync5HlhxlvyyOYJyQ61+b9HxFuYjtVLhsnuFEV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776086; c=relaxed/simple;
	bh=wXx7wCzo93AbKs5lA1ligLcJYJ2bbj24jDnIBcmiE8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWgb1I7a3LqkTbyxT6eW0yxEBTNP055+0F6Si463sqg7/fUL6fNFhLDUDzzgMGamU+ltf0ct/phE17pWYT8dwPTlJvDFeKi2acE2+cxrRS9HEMxPfwIWN5g77swTcq9+sCQ9gjrv1ANtCWRGEnEurKuQhQGgak+zi/X3KCI9Oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2+dg07m; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so7394841fa.0;
        Wed, 27 Nov 2024 22:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732776083; x=1733380883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXx7wCzo93AbKs5lA1ligLcJYJ2bbj24jDnIBcmiE8k=;
        b=k2+dg07mBwwhHvLRxFCTQKJkfnK8KRclO7sRIMAHIqfCzc6rImS6y5/JlvY2UfSVoo
         J9OwZgGxGAZiZFyWQntMoEcUnjUMw2Mxw34YIRypv53WklCCvVZEh0YMEXu5O2MNdCv4
         QdUNZFTua+EZBs6K88zbQUPd7lVn7K95FGpxQ8V+WGwH8qmeYuGTad1M3txn/N75WOmJ
         nvyH8FyzoCjkubNubXQ+lIbNmMN2c5d/GnJ6Um1jrHjD0A8AXBDh0fBkOR5s9K6fuycl
         ekdeC0W9DSWx45ejOlVygLcRePgiMxd2UBRA7gojRPI1S/T/X2CB8vxqOX20FumnEIl0
         viHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732776083; x=1733380883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXx7wCzo93AbKs5lA1ligLcJYJ2bbj24jDnIBcmiE8k=;
        b=woDOIEwaQhHkIQ3N62s9bF16GItyK/oVaR6Q59Pc4O/VOXRPrxrHpItR4qVshBBW8E
         trGRLfwNpG8IknDb0ljSB2XyINfoldhwmtQ9MbFpMSrCPWS6r7p2fW/gYEfjkgVvDJIB
         OEa38aWKG4crZxXdZCTz//YMFOucwfcxyE4+Wx7OVeX0ihwuw4VcNgKs7qUZz0rssLi7
         upJffsxDhVVHQAXmTjvMIPDT+Qu3Gd7o3JfLwTWUFJZMvKBn/XzhpAnAqYDlUdbGI31r
         +JvvH/tJdWi6iIY8gLAOI+92EZ6T9A3qg54P2Xu7Nv0/AZZJdE4t8XcLnLYjrTsvseVz
         HciQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCEfMbMh49PgqLf8210KyaLXBQg4tQeynMIgo306LwyK4ji+VNwEu+31y5zFMf4L8P9hqOIS5NXn0=@vger.kernel.org, AJvYcCWWEoYM4uxmJuw/PBOZiSLbBhTgakYv0aoUFubD7FitZjvfr7r0RSoXRpqMFjoqmEV2U2aa+yXKSTVMf1uR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqi4vmr5YLs3P9tlf4P3/HI1qXNVeAAxcPh328ekN8CpOEiLPs
	uYyYk78SVzWjSRdVaJiIoYOE4kJCAuTLVz7hSODBQfHIAT7q1BGzG8wNq/+UdN/pYRswQTCToKF
	6LjxDgdbWYG4ns7ykDaySoFB+zmQ=
X-Gm-Gg: ASbGnct2XowtOVm+3UudCh1gAfNXrWXrxgyjDMdLf9bUM19Zbe19MFiANygx3TCx/j/
	Ayn4ozdxiYBl94/a3pfJ3LVlSFZfsh5U=
X-Google-Smtp-Source: AGHT+IFbPZNh7ZdWOCP3ANdplqGIg7uMiFS/QJd0iHm5fma5NVfgs6i53QvU9j1CV8wEkfb2gW3vsDzguTe8nxiJTFA=
X-Received: by 2002:a05:651c:548:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2ffd6025feemr42723701fa.17.1732776082364; Wed, 27 Nov 2024
 22:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
 <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-3-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-3-b6d7022b7466@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Nov 2024 08:40:45 +0200
Message-ID: <CAHp75VcTasNFyx99x4nPaRsjZtp8mEMBOw08e4RfFnsmXx-4SQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7173: don't make copy of
 ad_sigma_delta_info struct
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Guillaume Ranquet <granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 10:02=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Use two separate static const struct ad_sigma_delta_info instances
> instead of making a copy for each driver instance.
>
> Typically in the IIO subsystem, we use multiple static const instances
> of the same struct when there are different variants of the same family
> of devices as opposed to making a copy for each driver instance and
> modifying it.

...

> Whether this patch is an improvement or not is debatable. It makes
> things a bit more verbose, but to me it seems more consistent with
> how such cases are handled in the IIO subsystem. So take this one or
> leave it.

Constifications are always an improvement. This makes the related
pieces of data to be moved to rodata sections and hence have proper
page flag settings at runtime avoiding any modifications of the data
which might be used for ROP gadgets or something like that in some
cases.

--=20
With Best Regards,
Andy Shevchenko

