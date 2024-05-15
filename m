Return-Path: <linux-iio+bounces-5058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DC8C6EB0
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 00:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C057285B56
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2024 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C33D984;
	Wed, 15 May 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ucT2g4nJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97403C062
	for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812535; cv=none; b=bc7iJK3G0eQlQquhbz94+T3CdxLZoD6La7PIHHVp8qUsI3ro5qcanez9mWlrhn0E46yz6d1HAn+MDRXFKdpx0J/1j6oGqPIvmqy/wGteEgR6GRAB42Rzc2tMP9Uqeu2qjxjvCHSycpVXVPCehVH8knc/ryyH8x2z7QA+OqByf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812535; c=relaxed/simple;
	bh=vktetzpySCvQLvCXDvzQZRw/Rs7o4P2yYPLlYK2EVj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ+6+yzlh3YJqe/34+0zyOB2Tc//dQpOVLikytUItKVVs9NqHw97PG8jruvdmPTzeENxKkiSMPnveJ6EElTGOhTzR2jVn4qEMhJoZA/6DSZYRMxj6SsYD4DlbkQrSDaznqffwocXUvJQ0P3M9vU+SD7n5jWHBqwX4bq8cWvFpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ucT2g4nJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e1fa824504so1252161fa.0
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715812532; x=1716417332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rVl+enTuDi9w2MOrjGjweaRouxzpBZR9ryTcvYoIX8=;
        b=ucT2g4nJF6K3LJpRAwQXZECsaWKI692i/IKedyyTtLKtOg/mR5OXTJBN3GKU1rJSEs
         /OWUhmLJFmg807zAbES9FQOo7sYk4y1SgRynuXifrWRX/n1dk2AuZ0Ryd8XeMVzFYLD/
         RCMxPXaBmxD8I5YuPORKpk45tSiCZyAxS6+4vDOJpAImN0N4iHuSKdysjHe7nVjsaMH/
         XJVMJYTpFi+PWsqa8b9o7VN1FW5Ygklp59TSFno6Nkey/zpJZsdqfD3u8XzZWehbVdWU
         yvxos6AiVaUJarb51FP4G3yfhRu9bzm9CMER8goXGgMv/qyEqLxELdGL+DxXAR9Ca4iM
         n5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715812532; x=1716417332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rVl+enTuDi9w2MOrjGjweaRouxzpBZR9ryTcvYoIX8=;
        b=L5Dmcr4Q3nN5fPTD9btpIqi/733e4BrfWK0oaf2EStP5W+j5ZvWPDeAJQpDnkld+db
         HFRtqbE1+720ZpWZ8WetlblfuogLYTlKn1kLKF8PgyOL+rm/6X6Yx7ZE52fly5I4mdSK
         9muxwuIs00wXUnltqn5z9IDoCc4L/EupaCg9apWqQXCRvSd4p2TqBlNQ/g5dVwvJip+V
         SoMF3aZt3Z4A4uOwRCYWjnmWjDQ25sUzvPMRKzeKJSmE1kC3WNTIb/QBUL81Ai2BaMNT
         xdbQgE5bL6yprjzZZDisSQ2cmJKFhzrMdMtkguK61QHP1tC6fMZxr/Z0GeS94ZDRmbaS
         apLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5D+c8L1qZ0bOU9ZDRljBXx22UFnJB7RBPuMp4bq4Z+t8hNmpU9P/TJjPvVplHK82J7TYQIwYU4Pyy1inK19f5RnT+22Q6T7cM
X-Gm-Message-State: AOJu0YxYVUme5xQKNWoGsKSGDeMytHSxHcMaw4x4GLq/IstyBdJ7ry6r
	m94UDi//hBvIqnmjNPPGmTkmkxhhgHs838IjVwZW7nLuR3IJ7QSOegkeTj40GKbrH7F5imv4HYO
	Eg6su8eJ8wQCRu/0yjiWnYjq5T73IA/nKRQoVLQ==
X-Google-Smtp-Source: AGHT+IGqnZkKYQnOVn+HSs5FH73e17TplT1mBxitZPxH93qjnAbG4BNbpSj1W8ujJeaV0LWFIV3snuE0goz8orkF5qU=
X-Received: by 2002:a2e:934b:0:b0:2df:d071:76ed with SMTP id
 38308e7fff4ca-2e51fd4ae06mr107081721fa.10.1715812532093; Wed, 15 May 2024
 15:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 15 May 2024 17:35:20 -0500
Message-ID: <CAMknhBGUHB65FALiy4pC2kHs0hXuF-51uwL5CTXOVWaBh_QpDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add support for AD411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> This patch series adds support for the Analog Devices AD4111, AD4112,
>  AD4114, AD4115, AD4116 within the existing AD7173 driver.
>

It looks like most of the patches in this series are cleanups and
fixes of the existing driver unrelated to adding AD411x. Perhaps it
would be better to split those out into a separate series so we can
focus on that first? Especially since several of them need to be sent
as fixes for the v6.10 kernel to avoid breaking usespace or bindings
in the next release.

