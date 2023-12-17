Return-Path: <linux-iio+bounces-1041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23D28163AB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 00:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E511281ED9
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 23:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7624B144;
	Sun, 17 Dec 2023 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JTDJxrRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F374B126
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc6acf5e3dso6834621fa.1
        for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702857531; x=1703462331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1+Vj0GokQ0yb3WUs43FQOf34J3ULcfp6330hg5zyE4=;
        b=JTDJxrRL4IkbIMdJDdbtmbR9u4t6lawUuDo6XwaNC3jMlyPueDc1rg02lUBw2JGeBM
         kXQOuHbFnA8CFuj+vi7OrnhK8No+zHTKRODVlVdwTdS4Zg54KjTvy4rWWGi0FCmwVkE3
         iB40FL1sewML9MhX25RdB84E1mKZffdczNSQLkIbtPN/56CmQ/+ISanidu08tplnz/vJ
         TObLi6QiWGgpOCZI9dNFXcD/IzUNh/2xmoco0OtPB3+FMWnsOtqW1N6wZvxHx/mwYalm
         kj6LjRCRjSp3Ir+dCB+RMygU7VEdKjuWG5KWgXGqdNOGWIgEUawilzOTyHr2B5t9pgTf
         +EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702857531; x=1703462331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1+Vj0GokQ0yb3WUs43FQOf34J3ULcfp6330hg5zyE4=;
        b=og9Ad0r91fkb37rrxJ+uuDDYsxZ8ubBvR21UvXeqzOujpoYtr1VWcNcgfZK9KAzyfs
         uXINFRI7eXjlMHcU60QaM5bYCg7F4RBUnNSvlRvvD0z5oKC5p1PWp+ZblwNvpdeU43nb
         x0S0mF4eo7HkU2ahrio6PwWBtFFth92GoGQx6zNteCfJBaZdPUaIFBu9GcbWGWB2NA9U
         GAjFDNqUOVtkO96DfOBVODVJhq9nwQSxLdMxkrM6bzL0BwdwQ1/y7qsjNNSDe+p+a6GC
         mxduSRooQoNF03kaneJLrfGqMLq2f/YUOvUQWTmtsWm5+ZpNvvE67f2uPrGMsZuqz1FV
         WVbg==
X-Gm-Message-State: AOJu0Yz3SIv854nk3aQiXPpa+8HVqzWF7ZbB+k6GGEf7lUvtkckweFKo
	Im6sRayDQovsunrivLp5a9g5bUOmcLwoWcH8sl1PFQ==
X-Google-Smtp-Source: AGHT+IGaz8CGfk95ssERrJrGdjHm0QmxcppryeIgG4vlgkwBEK9+C7hCrSc+bYPibQyK6FpM2xZFryUgEsAkt2Z82yQ=
X-Received: by 2002:a2e:b0f9:0:b0:2cc:6a80:45e with SMTP id
 h25-20020a2eb0f9000000b002cc6a80045emr317134ljl.90.1702857531079; Sun, 17 Dec
 2023 15:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com> <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 17:58:40 -0600
Message-ID: <CAMknhBFQ9APUAMA8nEwTJ0nhARwcD=hCcAB9HKrQ8g9qANqveA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] iio: adc: ad7091r: Allow users to configure
 device events
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, paul.cercueil@analog.com, 
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:52=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Implement event configuration callbacks allowing users to read/write
> event thresholds and enable/disable event generation.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> This is from a review suggestion David made on v3 [1].
>
> Is this the case for a Suggested-by tag?
>
> [1]: https://lore.kernel.org/linux-iio/CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaL=
CG+3n=3DZk4gyStqhgw@mail.gmail.com/#t
>

I suppose it fits the definition of Suggested-by well enough and would
be appreciated. Even more so on [PATCH v4 02/15] "iio: adc: ad7091r:
Pass iio_dev to event handler".

