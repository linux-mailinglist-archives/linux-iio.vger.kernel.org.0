Return-Path: <linux-iio+bounces-15728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60DA39D68
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343987A292E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595B26A0DF;
	Tue, 18 Feb 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEr9545+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987272686B4;
	Tue, 18 Feb 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885245; cv=none; b=PfBuWuM0a8eSvsymXyTRXEpMYbwYL7Vr99mT6fJQ7q2TPdDoOTm6mDRSHUDbyO6guNsK2mW/P9XFAImsUj6uEJ4Jg2LvXXNVJdF3upRYmfgPZ0cthsB951IzSAe4nQjTDT9NSmw0USt1rP/VxBq1tcpXpSqu7yhKNKmfOCD3QfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885245; c=relaxed/simple;
	bh=qfsXYrLmA4AiXHDUztY+1D+cHIvOYpHPfEtByfYz8DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A068KcT6RgRi/x92czOhUK61QCUrxjp/UyvWG70TAhQl03EPLiSZP0b9I9LGCjKeDpEndxsC1dp2wpa8eFTZknnV4x2ZpPW9n+GYpsSSk7KSPDD1nsvzmQZpw5jXSCmWBwVdGzoN1e/4brxpnjXylagzOGHkT1I5Z9Zgq+5GDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEr9545+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30613802a6bso56652731fa.1;
        Tue, 18 Feb 2025 05:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739885242; x=1740490042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaGZVVe+zRtQUgtJWBlyfhJRB0u+b0GzBi9QAf51pU4=;
        b=eEr9545+WIYcG58VPJqaW8+YJdY4isqJpQ2Nw+FZqIpf4Ea0ELaf68zwksi03CV3XP
         Q44umu0ozABwvDx1gMg4bdo++4yzgc8Qk4AS37g1k0QLhb8jn447umSfqZt93GVu3kyW
         xypyKXpJYv7J/GY598ijkyzeAdmdHHoTGbMU/yw20zLNCmNbbJGAHLp4Jucn1+knuIdB
         p+DlW/y7JCybxwVwyW9wMsDsCc+l1FQClo8vx7daxGZ02N+arJlNPVetwnMu4xqeDBTc
         e2JJt8QKo/N1q+HC2ThD52aNmQulGZlL9kNFT/EYHrmtpdosylFbNb+bKDqNeoIiZDr+
         vFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885242; x=1740490042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaGZVVe+zRtQUgtJWBlyfhJRB0u+b0GzBi9QAf51pU4=;
        b=XC006gcp6M7tSpgkatbvo1Pj8Dlq9Ac7bQblPph/AkYySF+I9cBi7ocKdG3T08jE9Q
         u+fuFQBbJcp7GM6KwCj1N3ig45Wrveq219ABEWJlsVDuTXPUMtvQgCdt3vnm7roayrgQ
         Th/seP1mYfPnnXmcfnQ7xPlyHKA3+YjyAB3+bzXZzpHR906WQ4YlmbuiVle2zylzpzM4
         94lndLkmMsQK9u8ooVXyW5skhP1IVLNcs2XAQ56X7zm7pKnMMiVTsCt+bw0e9mXqmhr6
         1UiD8BYufUTaGXef/ZqzLjDscGT9SFERqWloYVah3gmbPkKnh9hc8044T4/N4YpCCdqq
         KO2w==
X-Forwarded-Encrypted: i=1; AJvYcCVBwcnoSpcLMubw6e4h+E/X7FQNwMJJDtzB+HNruxvVa1dxsDOJIuVqFFTQwipLKhSwWH5MvfIUtLSqSg==@vger.kernel.org, AJvYcCVNoItb2Yv5dPnlFN+zUpxF+rNEJK29dD8HBoAR5NpqFLpfIB94u2t5PSBNlV6aYFa8v9uBQwwbf6iw@vger.kernel.org, AJvYcCWF+MeEWmlOVWE6HI8fUu9+xquygu1jU6S8xCgaYgKCsfmXiJh7Ar4pOcPQia7Ak6lNgz3HtnUmxE7/k4bC@vger.kernel.org, AJvYcCX1peET7DUc7teYih5DhLttRJWmeKGVnSzSvNpu3CmPXpMWyJQ+N+jhlr+JLDNgA/dttDqhBtshJkmuwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcjDGkUAGd35QRAsbO7SwIcKpaioL4ovkGmA9IySyJx6wajRW
	ALvVqt3u8mQWQwLWYXay8QGE8UBEueX0jINlBxIFWOTbTbu9NSxVmidrwg==
X-Gm-Gg: ASbGncth9dB4UK8eieS5i6NIOAnt0KWy4TtdF5JVnAXs4mqOuXCAGiF160mG6KsJ9oY
	23dFkfqSUuRPJmK4KS2aMwkuSIV5ZGtI+Mr2mLwhEHToVMGO9uPCaDJ+W9AXRLJ1zHEA9M4usvW
	TFDICqeeBuj+I++CL/ITEQl/y22iaLf84bqpZCOXt42ZbqIFsWSipcJb2Uf9ymmUgNaxhVMauSQ
	2oB0HEPACyOHUdhuOdSsjNYv6Yop3XBm4K/YUSHNVS+DtcuEd0o8oy3pXwPn8V70q1pY8AJd84E
	ZHmcZDY=
X-Google-Smtp-Source: AGHT+IFAsjt/u/YX+5ECDH9HYJb3vXVacCon8EEMKyGHasErL4EtjMCNuy102qVBSFHqh8hGHlzVYA==
X-Received: by 2002:a2e:8093:0:b0:308:f39c:96b3 with SMTP id 38308e7fff4ca-30927ad5236mr38589591fa.30.1739885241379;
        Tue, 18 Feb 2025 05:27:21 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30917da0e64sm18300851fa.88.2025.02.18.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:27:20 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/2] mfd: lm3533: convert to use OF
Date: Tue, 18 Feb 2025 15:26:58 +0200
Message-ID: <20250218132702.114669-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add schema and add support for lm3533 mfd to use device
tree bindings.

---
Changes on switching from v1 to v2:
- added unit seffix where it is suitable
- added vendor prefixes where it is suitable
- light sensor mover out of pattern properties
- added references to common schemas
- added detailed descriptions of properties
- removed platform data use
- devices bind and configure themself entirely
  using device tree
---

Svyatoslav Ryhel (2):
  dt-bindings: mfd: Document TI LM3533 MFD
  mfd: lm3533: convert to use OF

 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
 drivers/iio/light/lm3533-als.c                |  40 ++-
 drivers/leds/leds-lm3533.c                    |  45 ++--
 drivers/mfd/lm3533-core.c                     | 199 ++++++---------
 drivers/video/backlight/lm3533_bl.c           |  68 ++++--
 include/linux/mfd/lm3533.h                    |  35 +--
 6 files changed, 417 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml

-- 
2.43.0


