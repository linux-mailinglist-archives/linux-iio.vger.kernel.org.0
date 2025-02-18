Return-Path: <linux-iio+bounces-15741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B5A3A5A0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1480E188A7B0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204F2356CA;
	Tue, 18 Feb 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZSLBLrgv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA62356AF
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903493; cv=none; b=jhmxj2PrKb+Gy7XOh7v+HPNWfjthkZvrsvxQ+xo4VqwHGXv+SsiUB1c9Hn0wbwMpYWxaE5PLn3RMX+7skPuJFj3lP0+5JjXM0zAOyTJopzOVmVepuWHOtkkMS42GMFz4TymuypWtPV4pMSBTW2QtvATMGY/siZz/mZASIBwAEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903493; c=relaxed/simple;
	bh=+1JUjUrwC42svzQCL6ryzGRhcCwHzMxI7HWBO+i5t4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SP29GYczuN14Ehbr18/urr1bCQu8oQhnmdyKmkA1Yz/97rGdMleKUXaIvFZmDHiHHdx6TjOkguh6Zt+4C6FZiaeknsflFuph1k0rlqdyDsQtmrZyZyHhA3jUd2b6uJMj6MUkL0ZB39lA7hGDOmRsMVpafZMY7Zw5PCGYzPrYuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZSLBLrgv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so1422295e9.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903489; x=1740508289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSBCBYZKU3t+FPGl4W0sLmscCJsM3m5rfCalrdYMQF4=;
        b=ZSLBLrgvLM4gHomhid8ixPt+VHRB9t8gC4Sdf+wnXwOORa+NUczJ1OjnPuQ4Zhp0oj
         D1POF3spv8PXOsiPMwvjyTLE9HsvrSmzP6yJGo9I/H9YPnzTi6eze/Q0VOVCEFJU5HKJ
         vMy0ZsNXY3yGhRgV3EoKyTNxBVYynYOTCTQAV0R07AkfCtZLmnZ6uTwbla57id1MuhFm
         ygUcAq4lqufE4IdK8ybn1J9G9VHG3DtOSlM2h21GfoQnU/s7H58bMPKIWu/qkLL7po+e
         DIa/3uxocB02d0Cqeb32JPWdICzz1WuQ/oeLHrrgnjlbvQ06Y/n4dEzMucaUojG8X28S
         6FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903489; x=1740508289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSBCBYZKU3t+FPGl4W0sLmscCJsM3m5rfCalrdYMQF4=;
        b=dhQWuqMQs+UKma8Ci/Z3BFF740PUDX7e840odj2owguFN27vVOhtpv/EsYUEdrcSPK
         nCmC8IWO6khjHoKV4BWssa+vZxvvtklbEDkSK/qWV4fB8nl2NDhUbdQ3oHjaa3qXgRjt
         UcbX9npxjMOas3YZyRRAL/wKl0oMN/Cb2rAOILtSOUf7RsP2lXSU7uNV64EiMmTYiXkK
         WRvqOPjQi/2qMmbc+/oWWfDnXpikTrTHognhBmCRwwzEK8vhdlTp2jhERke64Tt48oQd
         VHj3sJsJdD8DTtaKHaRcCYdLHbrBBIyhN/OeAF5Gki9LrQ987Nb9AMkUMgK1BAdd8ceW
         1/lw==
X-Gm-Message-State: AOJu0YzCtfWqPU6WSG+yVzwozBZxu9h+C8BtISm2U2lBwjMijJ54nrKb
	2xnwzp73mNDHRMBa7suhV9eSwkldL9pGF32yezT0ROUyKOtX3kBDOpKGPShkDn8=
X-Gm-Gg: ASbGnctKIybNmUUA99pP7fWuEcc5OiD09BseCSbzF3f+aZefR6iWIizq9hJJ8mW8C4y
	SuZQRakD59+ifniRfKVDbvlMF/7cdisEVqyaZB96LzQMZMOZqOLdQATnWY6+tHgA3P1KYDi1aQl
	0CPEz9VXFqCE4dUqu3ugiX3XJi4vf9jWzbPT5VHVOhghtBhKkGZxqFG4ZS/b/T4C5Ic+xaTAT/Y
	Avkkv/tnfgRCoJCyAiB99b2oGx6PriLt2gImNCBzgESeF42oAWBG4B1GtnN+dzKHx0XVaPrpy01
	S1W5dWfPHaWhkfp96sfGB06TGBwnA7ozshey6SP5z2gFp+GDxJ9e+lIPSQ==
X-Google-Smtp-Source: AGHT+IEMcPrvgGg72n3epGthMb/4WINiCu/K70iOheQ2yXe+8J9JwmsIIRiXxWDk5jg9CquGEyrEWQ==
X-Received: by 2002:a05:600c:350b:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-43999d8de25mr6824515e9.9.1739903488666;
        Tue, 18 Feb 2025 10:31:28 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439948eb34esm25729035e9.38.2025.02.18.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 0/6] iio: adc: ad{4130,7124,7173}: A few fixes and ad7124 calibration
Date: Tue, 18 Feb 2025 19:31:07 +0100
Message-ID: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=+1JUjUrwC42svzQCL6ryzGRhcCwHzMxI7HWBO+i5t4A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNHssmN6klinDlxf8dcy0zPwidfFv0CQqysyx F3v7DmHHc+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR7AAKCRCPgPtYfRL+ TtDgCACq3ZXAdVqnxKKOJRuim0nUsh26g6e5/SrPWUspiUyICy6mxJ7+n3+/7NGC0dWlMqakFE6 dGmSU6tgGUJwPdUC8kO9kha9+t8tWOdvIi02zTt/3SHKE0STHAgemZWL2uS98ijvo3gLONeolkj H31ogSzHEWLJ7luZQh9inM7pHDPSVhkbl7uRR31Gln6N3m0jfDDnBgMNBGKF/Lahc+SnScvWeM7 3t9YXXnanfo58NhzuPFs2q4VyOr6Ix0ydGBsYrDnUqU+hJGZGUp+ceghP/kUpPISFZzrtO1TgkP P4/uFBq8tsBfLrUe85XVQlMEvlImGLBFqfc/4eln+LitJIv/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this v2 series is a rework of two series:

	https://lore.kernel.org/iio/20250212105322.10243-5-u.kleine-koenig@baylibre.com
	https://lore.kernel.org/iio/cover.1738258777.git.u.kleine-koenig@baylibre.com

; they overlap thematically and so I put them together in a single
series.

Changes since their (implicit) v1:

 - Use static_assert instead of BUILD_BUG, add more comments to the "Fix
   comparison" patches
 - Make ad7124 internal calibration actually compile
 - Sort the fix to the front of the series and add a Fixes: tag
 - Implement system calibration
 - More comments and commit log improvements

The "Fix comparison" patches trigger a checkpatch warning because the
struct members are considered wrongly indented. For me the indention
looks right, but I don't feel strong here and happily adapt if
requested.

Best regards
Uwe

Uwe Kleine-König (6):
  iio: adc: ad_sigma_delta: Disable channel after calibration
  iio: adc: ad4130: Fix comparison of channel setups
  iio: adc: ad7124: Fix comparison of channel configs
  iio: adc: ad7173: Fix comparison of channel configs
  iio: adc: ad7124: Implement internal calibration at probe time
  iio: adc: ad7124: Implement system calibration

 drivers/iio/adc/ad4130.c         |  41 ++++-
 drivers/iio/adc/ad7124.c         | 293 ++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7173.c         |  25 ++-
 drivers/iio/adc/ad_sigma_delta.c |   1 +
 4 files changed, 331 insertions(+), 29 deletions(-)

base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
-- 
2.47.1


