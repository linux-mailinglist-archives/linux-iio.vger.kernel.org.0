Return-Path: <linux-iio+bounces-3682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798588749C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 22:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A251C212E6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14D81721;
	Fri, 22 Mar 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LNWnRmAI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1822E626DD
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144345; cv=none; b=ErsZ/vsjZeWTcDK+FY1oPOd1zqqdH0QsmzA0EYXz1m2PbBpWeAhFqZ+mjadCPI0NVx3eHOy3zPemLgTl159e0PPZkUFQ7aK2fwGsa2eMFhSkKfPRMU0zeujNbHXxcic1PKl3Piyci2JdteLx6SaPEg+DYKocG9DyPTCPGtAAN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144345; c=relaxed/simple;
	bh=QlTqEsO2TsVk3NPU604rIYaD6jup2qoBPbonOZtI+Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/o1MGiANSRAl8VIA4WfFcgNLR6IMQvrWqRmvs7anP4j3X4eNmK4xO1arszpulW6EWGMRnHHP+Xs/G+B4Odt3NNH0LX8NpstuHGGcU8T9Slv0kXuahDlB/DQW91aPyzuRNFTgx7VpOGywS3jr2LygNQYVam60E/EeiQbkGtIUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LNWnRmAI; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c39bc142edso1619561b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711144341; x=1711749141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bW3Fb7iejEg4tj5X+RVj4vpN/+Q8c926JQhIhRi4Pos=;
        b=LNWnRmAIx2OyElcqeYnZO6H/m0efx4rMcZdLMpgl7jCXsTnyM++T/pN3RbUWgVrD6H
         IJnaxJ23UwN1BNvXhgim6qNO6Y3JYDqj4J+5YBrCBdlmhqmQuqr7aUz1MP78n3hshTjJ
         ufTpIW4Es9uzq6O9noPIkq1ApY720JnrFvdHHu6308KN41KXyrruXVTKxQCUxyDi5X2Q
         8M+B6fRo2Q3JfGkfEt7sYUuiBNXCnM02rxUPoYJ+gYWA1zj/A/vO3FWw/nRt8maW4q7n
         7/IvLXv9TyBl2KSLoA/SF7vEDrnEwsc5hoQii80aGjHj3RO3P2JsT11X0/BquwYtM3Jz
         0QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144341; x=1711749141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW3Fb7iejEg4tj5X+RVj4vpN/+Q8c926JQhIhRi4Pos=;
        b=BHM9DL2jUBuOBkcdUWmrW5Wv1YGDCtZ65JiZw5GZjsNKx5z0qHqkfKT0ZGyK9OXAfk
         IjwpaaDaeWq5pIjahW242eTNepGozO9aogVStl//dA9aBwsnjp7TIBBgTxtIExlqSXpm
         1lCUw+0V3TLquWkufs2kmQy5CnPt3I0+9iafwx8980yrrcH+5geLyqfxQO6Oevx3bNsf
         k21PNMFLWdW+ba+vUvmiiFftz+/jfNpONaY9rLBHFEirhY1YkQ4JWy7bhcVaUfRfuzWR
         gWxqNNilZ3zZlJmjW6QByuKo4UXXEsdo6UgKz7adno8/SGqfGtpyiXmUWD57VJqM+RI6
         4yFw==
X-Forwarded-Encrypted: i=1; AJvYcCUG81S6B8Dt8EOZE2JU3N0pPUy2GC1WveP9A+DNqX/FG8mM+LUwGWpmvJpu5Jo8wCDjLH7ZzpnqF8THeIS3hscnFNmc8G388IDf
X-Gm-Message-State: AOJu0YxHafpB9JiPQIRvMqQlHSELtv/g80Q1Sv36iQvqNWg1NeDLYEED
	jYiZhOCl2uyrl4BYdAbffSDmykBFoMz1mKnpK/EyBvLgy6SehxERMu0AzAYA8U0K66lRQrffkRz
	m
X-Google-Smtp-Source: AGHT+IG5K/x1SArkjAi1tYMTJB3EFQXWywkw+M7QJzFI07Zyb1xRjvbADlF7E+QaGaKiuDLkcldu0w==
X-Received: by 2002:a05:6808:99b:b0:3c3:bf34:60fb with SMTP id a27-20020a056808099b00b003c3bf3460fbmr872864oic.51.1711144341071;
        Fri, 22 Mar 2024 14:52:21 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id x20-20020a544014000000b003c37b3571d3sm88254oie.8.2024.03.22.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:52:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] docs: iio: new docs for ad7944 driver
Date: Fri, 22 Mar 2024 16:52:12 -0500
Message-ID: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Adding documentation for the recently applied ad7944 driver.

Note: this also covers the features added in [1] that hasn't been
applied yet.

[1]: https://lore.kernel.org/linux-iio/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com/

Also updating the MAINTAINERS file to catch iio documentation since this
seems to have been overlooked.

---
Changes in v2:
- Removed some paragraphs that would be redundant for most drivers,
  e.g. most of the buffer section.
- Link to v1: https://lore.kernel.org/r/20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com

---
David Lechner (2):
      MAINTAINERS: add Documentation/iio/ to IIO subsystem
      docs: iio: new docs for ad7944 driver

 Documentation/iio/ad7944.rst | 130 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   2 +
 3 files changed, 133 insertions(+)
---
base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
change-id: 20240313-mainline-ad7944-doc-285b47ed6d35

