Return-Path: <linux-iio+bounces-2264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A083184BBCB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12821C2142D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1496FD9;
	Tue,  6 Feb 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KmzThdhK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D98F68
	for <linux-iio@vger.kernel.org>; Tue,  6 Feb 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240409; cv=none; b=AZ8BjsWxQrJ2nFFcIAjDfxBshP899WunRHxLM9EXsmV6KDabeaiDXyoamNVL86PdY7ff3ICxBFthcoa7llKyqfJzsU5EX7wbinTPEouWTgkkeaoAiU6IWfiiIws+82GXKgWaqZBU27UsWH425uXocxzkZN5MxOAgNMPa9kr3qWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240409; c=relaxed/simple;
	bh=BfTby594yomSr39OkR8dsB/m8qoJuIVVRgZTWAvJlSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fFcnC7AKr6dGSUwJ6GOdjhMrq07DVgDA24Q51j127qBb74gRjx4SzxxkclNGV4q9SxaUR2kgodyj54MXzV89NpEQ4sPNJQQDLFW+Kt/hkGjnzpS9USgrF3tibd6cIV+msQ/qPwViFg/yhraDoNagUYjWXqog/gD+7uf/ge0ctkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KmzThdhK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-218642337c9so4122262fac.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Feb 2024 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707240406; x=1707845206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwEVzMP+YuTarO+Ls6i1n9q9k3PZ5k4DiqvF9r8CPRo=;
        b=KmzThdhKj2D9ndQ5h53gO/d/PmP697u8A6u1ZBES7lAu7VyajiKIOGkjb7SYssEDcM
         dz/dG1EFs6yc02JfeyiaYe2fQkqXgaMnn7md1VpHC7w7U7HpjVu5Pv7rJGSAzgtgSxj8
         uYHXEHxYViVbIHf1SN8s6ChAJJZpdVnjUXXVUXrD05PZ3sk99AEjWbuPXAXCYEif/WCU
         s1q16FABe+pWxhMWI9K2UFQwfQCaRBOXWHBT8EyuQZtDk4/omhiw3cnaggFJTPD7J+KQ
         XMyK2m2m6EL4hvQLRNY5S8PEIr4Tfa8qvWPz8gqBRuREGgdHWS4k4Evh0d7UENVRdxrT
         cFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240406; x=1707845206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwEVzMP+YuTarO+Ls6i1n9q9k3PZ5k4DiqvF9r8CPRo=;
        b=l9a8k+iicClyLC/G7Q1fpim561P2YzU+fWe09JSHNOnp0nn9PcKKIwu555a3rLRbc/
         cbNcoX8Ox8v2dDc8hKtdN4IymTfoh4juAni3KbeqgyPzpKJk9Y6aTP7M3rxPtVG0E5EO
         FQ9kvunC4KvmFmX4CEiCNbIkFtoorvGgpLMSEjdqZS588rWIXZSU5YKKcPCjPfF3/k7N
         sz05GNEwSBurYJwirNFb5zC/F5wItdpxFOR96DKJaqepnDBTfQLEtKsL0zNelkcP5g0I
         JDStWaN9MIBJfjB90gNgkeoXvsP0mqwvDsYwgibAD8Powv785R8iE+V32EjuMQcCrIsR
         A5oA==
X-Gm-Message-State: AOJu0YwD0tN/dZUmOGPv1nMw/oyFfYyC+oQlTjB8aSF+0VG5O0aPm33h
	fmU7Lx797rWiEX5tI/+y+kVcQQc7CjNNON73PuX73QE46QlRu0o0VQ20zf3EXXnnlw8UFO8g0SC
	4
X-Google-Smtp-Source: AGHT+IGrvGFJ1HxrH6ZL54D2CWnGWyIJHoGJUC/OWNMDawGlDVvVGCNRL6Ja+el4YI77MX/zLQGO1g==
X-Received: by 2002:a05:6870:63aa:b0:219:7a41:348e with SMTP id t42-20020a05687063aa00b002197a41348emr3301185oap.49.1707240406000;
        Tue, 06 Feb 2024 09:26:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtXXPYJ4MD7WbIZ1EpcypM+2l63YiDdlkdKTUzBJi1ByXZVaNhfcwJJI7+V4HCMKDi3yvE/KoS+Rd59HEWZ+HoeX+0jt7FBf2z4EzN9XJcNtvvveuX5AtZc+7x9G3bFiYFfv5I9TiZNemS9VQWO5VKwAxE2cvYh4ULMCo/lcB9cSdwsp4qM90/HAsqGd6Hsv3X4lmHetULIa+RC5t0W8QUU0uITQe8Qh6zBUx3fAWSx8Ykj1NKIKM6lM1SX7HQnQxtzN5mDnotfwZUDig/JlMi5oLiBGHxfexLzRAkhMo32JZjn67pIk9VrfIXd2K9Mw6YdFgsETR2zU+Geer6fg6eu58KEXlt7wN83bZKp1ksXFbGcq23bX5mj3Z40lTnMrLj
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ea9-20020a056870070900b0021998dc2bf1sm510172oab.36.2024.02.06.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:26:45 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad7944: new driver
Date: Tue,  6 Feb 2024 11:25:58 -0600
Message-ID: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is a new driver for the Analog Devices AD7944/AD7985/AD7986 family
of ADCs. These are fairly simple chips (e.g. no configuration registers).
The initial driver is only supporting the 4-wire SPI mode. We plan to
follow up with support for the 3-wire SPI mode.

This work is done on behalf of Analog Devices, Inc., hence the
MAINTAINERS are @analog.com folks.

This has been tested using an EVAL-AD7985FMCZ evaluation board with a
Xilinx ZedBoard.

---
David Lechner (2):
      dt-bindings: iio: adc: add ad7944 ADCs
      iio: adc: ad7944: add driver for AD7944/AD7985/AD7986

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 ++++++++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7944.c                           | 397 +++++++++++++++++++++
 5 files changed, 648 insertions(+)
---
base-commit: 81e8e40ea16329914f78ca1f454d04f570540ca8
change-id: 20240206-ad7944-mainline-17c968aa0967

