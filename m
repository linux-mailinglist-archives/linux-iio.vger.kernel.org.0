Return-Path: <linux-iio+bounces-9758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3D9848AE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A581F22507
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378D1AB6E4;
	Tue, 24 Sep 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aX7geoRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A61AAE13
	for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191733; cv=none; b=D12qugXJb33B3ke3lKgexLd6y9AaPYeOqAA6Qh8+3Xjf6KWdFTFoKumWsgyjcd+xDRCz3NvMA7qsOYfvntjucDQrNRUMVIbitC+90QIJpWz5uMX/A38WjlQd+uEU03U34H0g+T0Ix2dBT6jVDGhJ6n6VETA7nR2WyfRUHefFz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191733; c=relaxed/simple;
	bh=74nw8Yvk24lLH6hdT5nJYTantYKEd67J8V9gFMR6xL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qp8NpHjd5Vq2jboroSZfqTE5C9T9VXs8M/eOs+QpCGAKYkAWN4cjgArgdaHVU2Yq/d6a9vG00mtXaK+n1Sh8JngUmbkzHIoyv45h7+1Qv50gYF9aEaHfvStyOm79EGThA8T9hj77WDHfzHZUHqer0qin8xMyCRszgtkzF01sv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aX7geoRY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f762de00fbso57959801fa.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2024 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727191730; x=1727796530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmlVyryjCtvGHksJcc6V++AP+cdUY7HjAK/zPP6l7tw=;
        b=aX7geoRY70kLIk1e+rnU+KXfOxNdcxgKd69anSyZbdqL+dQayRLpwUCP+l841WUKUj
         zP+0LVoz9vCgIrBVzwOqtrZ43Z32Z7POrvqfDt4Onc+mfBnfS90yDfKFyOyPPbu8anKn
         LC4cwp9UgIOYd748p8rcLkecvlaaT/VQmgva2U3cEbLEyLTUWmC1/mWK3G07UvC4r4LR
         FPVjtKnt6MWvsPrV/SvjNcJOyAJCIc0xHbFNrJsrETc3QvpPdkpDzN0AH+msWF2sPuBf
         RKH/h1xeXt4h7z/0mWQ6xjtkjDcefFtzE0HXopfMlUo2dck/4W82LuR28hfX23Q4GHOF
         dB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191730; x=1727796530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmlVyryjCtvGHksJcc6V++AP+cdUY7HjAK/zPP6l7tw=;
        b=pcxRTOtw8oxjqvjZF/ExdiGeIAinaoYyMdkBwhL6Lbg1bR74z/wXdQ6SpZJzjgf0yM
         Z8LeljXFQTc4Z6eg9qBupaPycMz6Y1tuFqlfRlWJg3ugfNnWHsqRlbtfK+RqMETxiBc9
         ynDzqC1C/l9S+kPrLhtM+3DsUZn9m1U9TJD1aP+YohrEcweNsySLdA2I9QbleTXvhxff
         AS7G8A/VkORYik3wWN3xl2xwQZG/4bz9paOv27aohXL11zcmFDnwKLRA7+oKnWlDux3B
         LhHHJTVW0dtnWkO0o1AoYQrLE+SqWIy9d4NHN59mCzIHxXLvgMq2KbtOlDPm4pa+ZOVm
         dQig==
X-Forwarded-Encrypted: i=1; AJvYcCWPz1H0sy/oySNrAeGrRoCFNHYpUaCGxw24MryK95ouijZwEsW814kR5rG9+xf7b4zPJtRuMTqIsZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuM3iy13K64PJ9qpFvkHC2ELMu+m4LKSV2d8782iW83JO4oeF3
	9o0fhbkuXeSeG3yJBr7ohJmHRC1mKfKb6ygVRJ1UiXnIDFW9UrFPEjJN8NOEBsxSApsduj4T+p7
	bFciMhmHqOaTCdAc3Of+snslViXw2q1RmPTYdCQ==
X-Google-Smtp-Source: AGHT+IEiOfWTtLmsrDQ4TAouRu2fOFMZSXhyqrITr0PEM2aNFE7efRiKdQGx+uXKj1N+eO0yWScOIk2M4ULt5Z/yxrs=
X-Received: by 2002:a2e:be9e:0:b0:2f7:cba9:6098 with SMTP id
 38308e7fff4ca-2f7cba9614dmr90175461fa.19.1727191729752; Tue, 24 Sep 2024
 08:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 24 Sep 2024 17:28:38 +0200
Message-ID: <CAMknhBGOn_vhvHJU8g89A2TDmA6yFv9urpZ4A96jOMLdTtR-Bw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
To: Guillaume Stols <gstols@baylibre.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, aardelean@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 7:33=E2=80=AFPM Guillaume Stols <gstols@baylibre.co=
m> wrote:
>
> On the parallel version, the current implementation is only compatible
> with id tables and won't work with fw_nodes, this commit intends to fix
> it.
>
> Also, chip info is moved in the .h file so to be accessible to all the
> driver files that can set a pointer to the corresponding chip as the
> driver data.

This sounds like two unrelated changes, so maybe we should have two patches=
?


>  static const struct of_device_id ad7606_of_match[] =3D {
> -       { .compatible =3D "adi,ad7605-4" },
> -       { .compatible =3D "adi,ad7606-4" },
> -       { .compatible =3D "adi,ad7606-6" },
> -       { .compatible =3D "adi,ad7606-8" },
> -       { .compatible =3D "adi,ad7606b" },
> -       { .compatible =3D "adi,ad7616" },
> +       { .compatible =3D "adi,ad7605-4", &ad7605_4_info },
> +       { .compatible =3D "adi,ad7606-4", &ad7606_4_info },
> +       { .compatible =3D "adi,ad7606-6", &ad7606_6_info },
> +       { .compatible =3D "adi,ad7606-8", &ad7606_8_info },
> +       { .compatible =3D "adi,ad7606b", &ad7606b_info },
> +       { .compatible =3D "adi,ad7616", &ad7616_info },

Since we have .compatible =3D , we should also have .data =3D for the chip =
info.

