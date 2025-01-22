Return-Path: <linux-iio+bounces-14529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE8A1926E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922947A21E1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418521324F;
	Wed, 22 Jan 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVzhUUmc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B321323E;
	Wed, 22 Jan 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552532; cv=none; b=nm9KsLqllO8wKFoiJsKkvAKA9nGfG7txoPmSRHUJwkKKoSXid5wfjm2T8GamwqbPD2jroPviKw8/QwsJ+5UwPtEkC1gglQEanNW0GDTyUv5AtYniVjqZ4IEOeRYXb5mUY9ZuakRHFmYDghvtD5GG+/wOSUeEz8a85SG6hXd3WQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552532; c=relaxed/simple;
	bh=I3ZgJthKn/5LDVmiEKxsfh4XsWGmGMHh4GZBkGxse4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCgqyUxX52EipQ3KmKoI32O36ITB4JJjokinYqbdcCwWO5HQixZuoFEhhQm0tGXl6ui7rsDAgeZiCsQsnjD2pMRSmFKcov5bgK2xBXkAxmH1639xZWrbrwwcBCRgYNLgHLlVtUBNLOTfDyWbjyoCQJhYKQBcevaFHXZVkk+9/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVzhUUmc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43626213fffso5633195e9.1;
        Wed, 22 Jan 2025 05:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737552528; x=1738157328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNcmf2G29Xm3UYUwAJtDRRxd8fmd0FSrNhzjHvoDxlE=;
        b=HVzhUUmcJUxdBS4YOzllGQTxMVd5wbNkRg0K/HzGZ69g7j/W+Syic/PPw70V3st2K7
         S0NAoQU8RJaRWZkp4sJtTuJBzjN8WNaWgOWROrGcz8cmcpDd99ri8gqi2X2t74yFBh2s
         iFGVMuiwIzcM4DWnPQDPTD8s/kwyDL6Ke9U7U83xSdJcbKJ9Zg4txnpBjvxtUNq04R/o
         TAClO/zmTx02yMw3V5NQL8PZidu0a7H3VpIMqRT4jbYsLbP8tNGvLqTOU3ACxa/zAeTt
         RhrJ+AhQ+05jed1Fkbknf32sClchKGgYPaFWRFDLbBPtifobbeMulnjCIwz6e/1uB65j
         xXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737552528; x=1738157328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNcmf2G29Xm3UYUwAJtDRRxd8fmd0FSrNhzjHvoDxlE=;
        b=aiHwFN6hsnkGfV6A4AS283O4o5+QtwCERDb9XQMq3SRoNi3lrN31BfzUsrZgcs+CAM
         zg2P8H2aQgkesqSGGe5Mu80540q92jQYMrQ1yJLtKvM8f+YXS6nQWFHUaOzu68VIM1Yf
         OyfkkOSg0IUTZ9RogjoSdSjoWCBPhBp7PrwwTpk0OLemrLA+r7N1RJUFJve2LZuBCDpL
         5wkeo7qSdvLJ5U9GGI1DyucW4A3VqszgrZOv67er9RInmKZ6mG/qP1VQvmmlBLLVdobG
         /9DJ2jNVK0uHhyXwUZKHSTidY4I9gihK8wE+IggwWG7OvePLK3fDmigwtVV5nHZfULnj
         INVg==
X-Forwarded-Encrypted: i=1; AJvYcCUGBEW9SqIJIyPaaGP1ntl6y/sfyUWmDuTskFll62a41noGgviNmyAPzUdAXHUlui7wJEsIummLMC443Q==@vger.kernel.org, AJvYcCUOS9YGXu0HwJ+S0nljDTicSOZXE/3Y/BFf2dLPBiS7B9u1KNYaA8W4rwcFD0lrwCiAg08CG48HEnA0@vger.kernel.org, AJvYcCUR9jDFSWRD701JIYE1TGdAditOnwETooX7W/dVbTgHy7k9waBdfFR0MaWoeX7WAJaxjwKHUhTyjqGZfLW6@vger.kernel.org, AJvYcCUhAGBw/7QH+nuUjU5mkfHsmNOCUzSc0uROTfaYu2DZhhafAad5b1KP+9GZ+MHZVgxernDZ4lNeAeK1@vger.kernel.org
X-Gm-Message-State: AOJu0YzAgYDG+JPA1UpPcWA3OhhtMV3ekFGQ77MsDsZ6m0cNQ/g1/5Ou
	RsNyNATEYOThHbn5WsaqpEkIgKSjVMsAWi949QfbxultrNQpQ1U8
X-Gm-Gg: ASbGncuinXMxh5QdSnoQeRRuoedd/kJgzRVYvWOQVxv7gqiEGCHNOwjuhPisoLTi/F8
	z9NAk23ff8KxSMo/OuQlL6sq2+/SyKa5t3OxPaRvj56Qfqx2YPpbnnMttu/Lt5eu91mvdGF5ymR
	y8A3IJ/8F5Sro0DfLE46prexq4WVCKxtD4g6UIKXbuU07YBcHGMQ+eNsI89YSfuGDIfopoVfLff
	HEKQPM97aEas6EYFmTu9+1tsomXGA5hq3WmoLgWFZEss8W6ymec35zyTem/9uFc
X-Google-Smtp-Source: AGHT+IEY41Uh4ITMjhsoQlxLQ5J+u5vmkWOP2nOiO5qxRSsGIB/nva7MEBWOUD0S6StlmmMoJM4lPg==
X-Received: by 2002:a5d:64cb:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38bec505eb1mr23604015f8f.15.1737552528328;
        Wed, 22 Jan 2025 05:28:48 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328847esm16481241f8f.98.2025.01.22.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:28:47 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] Add support for AD7191
Date: Wed, 22 Jan 2025 15:20:38 +0200
Message-ID: <20250122132821.126600-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you for your feedback! Here is the updated series of patches for
adding AD7191 support.

Kind regards,
Alisa-Dariana Roman.

---

v1: https://lore.kernel.org/all/20241221155926.81954-1-alisa.roman@analog.com/

v1 -> v2:
	- removed patch adding function in ad_sigma_delta.h/.c
	- added a function set_cs() for asserting/deasserting the cs
	- handle pinstrapping cases
	- refactored all clock handling
	- updated bindings: corrected and added new things
	- -> address of the channels is used in set_channel()
	- addressed all the other changes


