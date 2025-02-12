Return-Path: <linux-iio+bounces-15422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388A2A32079
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789933A5EBF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB002046BD;
	Wed, 12 Feb 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVnX3oGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2301CB31D;
	Wed, 12 Feb 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347159; cv=none; b=FiI3KmMY6Xovkg5ILuTiao0VULUQkeQQ2CzsFZPiUYEZnFGmI9afSlBerDjCcCpH/VhbzafNRsO/lQ5yuGO/2SdlwgDyx7dE7VNCLuZQej3Vq3Di3RMeBSv60eqc8O7hdb9Jymhaq+M2gQ8AZs1gBqzkZA7RXaDHCPQN0uDHL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347159; c=relaxed/simple;
	bh=kmE+a+rMZPk6SbwcvZuve+G9NeqY3nYlWpAAYw29Ihg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4Jn3XPbbnr4ZyaGXVXJy7PDBJqd1aEaMoHb5OqYZbIBXwCtYZPaK10YtZdg9RTiLnGu/W9jKy1PjwiISCw1HoXqPsNCLkQQKSWplJSjyTfFSOORlFpXL3FO1u59spHmExpUEgS1r6LApRT5eYMTFZ25tjRG+CW2dps3hiroKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVnX3oGT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543d8badc30so6738136e87.0;
        Tue, 11 Feb 2025 23:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739347155; x=1739951955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv0GhJL/R4in4Vn8Ofx8yxqMCUurvzPMIRxBdypJOK8=;
        b=BVnX3oGTG9Dt3kRSWCmHHE4Y+bNi+XHkmr23kJJppxYRT08fpTvXBeLvblOm8lba3U
         6pAcgXyb1lWd8FtxsbiA23Z3WgxtfoTLUEp/OhAUiMReb6Xl0oOJYNTow0SSlCNZn74u
         4yqXxbAnmrkkYBcM8nDq7AmP8csQodNysSGupQq89nfg1MNQWUAozSFllSyd7KodQWvc
         HrOGc7AMBXRi1w/D6j0kX24h9Hz9dLz/91RhwUiZTqOYRMbUDIJVyMuNpDG9XKIjCzA8
         Kt5SOfyrgbbE/MN3ZCVDFjy5MBwY2XbXI8Z3j8Wz1hu1QjvWhewIT7eSnOorakxyXjgT
         vQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739347155; x=1739951955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv0GhJL/R4in4Vn8Ofx8yxqMCUurvzPMIRxBdypJOK8=;
        b=dVvJK2Gy3UrC/DHjJwRSpbBCGxi56zN01ikoLbEHyxFqswY2FU7wzgR0Gb1+lTBmto
         jW9MwhPiGY02nWEZNabECBdJqfdrZK8uL1G7+eKra45BYz2RQi6HjOMZcHSdIEU+2iYr
         gH/jLQFVPN0WvCPRyRDIjv8KLbiNUAPD800dKoytef+JhixAr8xHHsgx3+4JJuVbjbQH
         WA0Vd2dG7jb1RUaWijbqiRUz4tyLlP9l2YBIOsK7RmdzSGtZmqiq/K0hDMy8Tl2OigZ5
         r6sKGOQRIweQivLoZWrEPZ1YOUxttB9Ai0/mNYEx8oFHSsKdMJZ5f0ghS12a/SYQndXP
         qpgA==
X-Forwarded-Encrypted: i=1; AJvYcCV9mDsPNqGBPnxpkc8BJRS4P6g+2mWRdzp/3mJMKvv0bHT+iFOOjLPl+cb13GBDZgDVVvcBaiczGN3/wtjH@vger.kernel.org, AJvYcCVkPqqE3Urm4vYv1BezDWLwyRkiJVUPZRyDmwcpf0AQ6ALWbIIybTryz3P59c1YMaZ5/dTEyfs/lSxi@vger.kernel.org, AJvYcCWih34JtKQQVf7WgLPymU+wKFaNFQ6JoQOIzevN5p5znpCjtDcuMr3QmbJBZvliwxgDq7iKbjIscsz6KQ==@vger.kernel.org, AJvYcCX6OlofPf1Qz1dBv8Sza3OMHSo6Me9BlBg65yg49dg5lR0UNUylzPwMluEwVEt5fIFfeHdOjiOpplW5jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1YsbZdo4q38uMWuscu5GuWdFSLOiUks2QW+Cz2OzfaIi/b4n
	4aXesuLSw2kyADYj4X1isDgJLOKGPN2qc+IBLOGUYHmM7hfJnN8C
X-Gm-Gg: ASbGnctufAmANVE2aOFW1FFZdw9iWxObNL77gY7dR47N/l0yIXTJZlnecWQ8vwTuwig
	i9d3iDObzntsVq4B1ll1nVIocIDaUaGUCZu8xw/yRftBYa3/8y9aAKoXydPAli2ixrwt66iCkSJ
	BSNCaM7ssGpQvgBdU+M2/u7Sro7Cl1OihKX5QPf0+Fn/2SewwubUUUgzC7sKlIEfbLCXSDymvSa
	crLWvwLaUhl8Ra5JZxjG2faRscOjVPJy1zVrNjIHPMaZfyBzZpYHSKI3MpWTO9oS/R/JJpiKROx
	BxJZhbE=
X-Google-Smtp-Source: AGHT+IEWCPu+93+2rHmlSJUSCShTSZW5NXY2rvx6S35bgz3OSkiN9RIMowHcRkWsDjFpbQ96aMGwjw==
X-Received: by 2002:a05:6512:2251:b0:545:169b:9b51 with SMTP id 2adb3069b0e04-54518123291mr684139e87.24.1739347154984;
        Tue, 11 Feb 2025 23:59:14 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eacfsm1797880e87.38.2025.02.11.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:59:14 -0800 (PST)
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
Subject: [PATCH v1 0/2] mfd: lm3533: convert to use OF
Date: Wed, 12 Feb 2025 09:58:40 +0200
Message-ID: <20250212075845.11338-1-clamor95@gmail.com>
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

Svyatoslav Ryhel (2):
  dt-bindings: mfd: Document TI LM3533 MFD
  mfd: lm3533: convert to use OF

 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 221 ++++++++++++++++++
 drivers/iio/light/lm3533-als.c                |  58 ++++-
 drivers/leds/leds-lm3533.c                    |  69 +++++-
 drivers/mfd/lm3533-core.c                     |  79 +++++--
 drivers/video/backlight/lm3533_bl.c           |  72 +++++-
 include/dt-bindings/mfd/lm3533.h              |  19 ++
 include/linux/mfd/lm3533.h                    |   1 +
 7 files changed, 496 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
 create mode 100644 include/dt-bindings/mfd/lm3533.h

-- 
2.43.0


