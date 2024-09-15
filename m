Return-Path: <linux-iio+bounces-9599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F25979868
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2024 21:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD601F21C68
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB51CA8D;
	Sun, 15 Sep 2024 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UshltKyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816C1C3F10;
	Sun, 15 Sep 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427983; cv=none; b=TD411JfmMBpyHEzihiszGX0YRe/WyQXC/WsXfEwiFjfChAH1OvV0K6cOu0SNqjP2DibiaBTMQH1CnG8Tc6IYc7z/KVL+BnH/wlYqwHk/sc4QeVWehFdR/rUhDRhye13h3GWbP44u6lT0+TWX3jQ6f8+p8Qu9JZu8n2fjTG5/HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427983; c=relaxed/simple;
	bh=708lwLH8kgUldSdBrGUqEeMSf4JMAe+w/y2GfFKCtek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeMWN053INBYkDvFKSG6d+ETaRa8mXld3YjPmqhzc6ABbXooS8RkIxhvuH5GoqURzPvVHz6X3N5ZTIKIfujHQDfds97SSzMb+ADVg3HkQMLSKlHPEGKA7vnvBZsINWOCaSRQ7yeJ5uXPmHgaUoNysWxO7lA/26qzSXTrbg0oAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UshltKyG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206aee40676so18459155ad.0;
        Sun, 15 Sep 2024 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726427981; x=1727032781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=708lwLH8kgUldSdBrGUqEeMSf4JMAe+w/y2GfFKCtek=;
        b=UshltKyG/zuocX4YVwLrS8gnR2ppAUtr3X7tppkAOB4ho6ot6RNym9Dzo4Xo3unWvK
         IHOHd0BUlWLtCChrVQkPrJjZCYGhN4qpUO42Mkbbh7aXuQZKiUEC/zYiduTnYYtEOb6n
         BFzRJuYOZ2lui2JQebAf/hIcZqyj1SnFDLp3cZ2Jfl34v6W9UGbrBIe9cBwfA17zNOGT
         BFu/p/tF6ISvozMtn9RLEhf5rax7e0O3O7Z40z4LHKz8Xpz1MXNruPV226Df+iHzOg96
         iSB/s7+roalvvlxDAZowHgfCJl2NPy+4/hQLyIoFFB4EUpGXOshUQDJSToG4OKDH9UqP
         /ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726427981; x=1727032781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=708lwLH8kgUldSdBrGUqEeMSf4JMAe+w/y2GfFKCtek=;
        b=aSrkWtG8C9hG+0P2THCq+wusWdq7qLUUNMbD0JcG61Z9+NML35zIutqx9BazdsgVm3
         NbB4ri80eP5i0x+QnGRc32l9+fBHb0BlU8A7e8xEfI+oJ8Uv4i8DOtP9Fw+uF88aheEL
         tAbsjbkejLYjfHsz6t5LllW5wGOgd9nT1dMtTMla4MymRAyfYsthma5bZlTRHTnleQlq
         5UN/HnwYDm4jYLnnntvaITTN2PiSLOC/hdqBsrYO3QvlNUhAP6U0YVBCx862CkWb8owd
         0+RahV6d4lvwx/di2BAjaRKPnYF0yDAfENcD6mTB55jtBgsJTAfrhel8pDAADuy2jcl4
         nsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/KNlo9592Js+M+DnZpKzOUGmfqy/zdGnW+HusanRwkqFaLrNxP3Q3Gcdc0V09dGYr1uItC49q4UkL@vger.kernel.org, AJvYcCVRNVWVDxPLh8/KtSooq2oHiBh8/ZByGj0Q1hKK+JfnJOX8kAikSZpdTRyn/5EVF/Ln8kzf5aLPZT7EPEgI@vger.kernel.org, AJvYcCWzmkEzIYZJSAaAj8HvkM/mkIsEf0IXpziw6+Z0Gf79GpNyfmLnKrXB10839jrX5B9Sza8+kDnDEhG0@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDiTsMSmZgZ1V4n572mtEQqL8EzyTgYeC8pjsXwx7+R27MBKG
	o6HsSph12JK/Xy8P2EceDxxetmOMhNfMCJqkD6Y3+AbRevNnwi5fOb0o/HineSWCYmtvL1L34pL
	gbjRBq3Q4SKOi93s+qUzEBL78sRHNAMi/
X-Google-Smtp-Source: AGHT+IHvTue3VPXMSdl6CALOVywCiXPbGmAkNLVju0FBZP7eje7azk2mvkyRC+3iQA7yFj3s5hKMfwKJ5dqWQggVy6k=
X-Received: by 2002:a17:902:d4d2:b0:205:560d:947c with SMTP id
 d9443c01a7336-20782967acdmr109283835ad.24.1726427981429; Sun, 15 Sep 2024
 12:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-amlogic-hhi-sysctrl-v1-1-b8c3180b2fba@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:19:30 +0200
Message-ID: <CAFBinCDYd0X-Bs18dOwT0DN789qxMTip9SHSpo3J5eXTOZwJdQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: also allow
 meson8-saradc to have amlogic,hhi-sysctrl property
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:29=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The SARADC on the Amlogic Meson8 SoC also requires the amlogic,hhi-sysctr=
l,
> property, document it by adding the amlogic,meson8-saradc compatible in t=
he
> adequate allOf:if:compatible:contains:enums along meson8b and meson8m2.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

