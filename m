Return-Path: <linux-iio+bounces-14107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8CA098BE
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 18:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E09D1884990
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF79213E66;
	Fri, 10 Jan 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sP7MZSVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1E212B1C
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530815; cv=none; b=ILIrSlkTbW+2/c24WO3DENi6Lr1sbTYj+fpXW1IhlKap8rpNp6HnrYYeTE23oR6nphhP4AW82ifY3aMKLxg7ypZkNuUlo5hr1P6VvTzNLNBVR5ObThDXpx5otP1kbxRukwVZFC5M/Frr25dw959RXz1sykcHpTKxCkGWTGDl8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530815; c=relaxed/simple;
	bh=F2Cz22JuLMDTqM4eXxFMrRaym8j9btQ2mtwLkNnHK0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hnk9voVmZIaG7JITmyN0IOjxy3QUPevKYhzS/d8DhddnqJtczGZfgF0mkfW3H2JTrB+lZCeFS/bm0O7fyHLtJj4v8XZjickKstNyo4laLF32mJvSYuyORa8dOHvyOczr5/iAHXkmC3cXiVJdbE3SXnTKxPJnSRu5MAdUmTC+x+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sP7MZSVj; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb7edfa42dso991824b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736530813; x=1737135613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf69nspx1UASBjxRM+kRJ6Tl50tDGhlBKRym8hMWYiY=;
        b=sP7MZSVjWt1J9G8adXk6gaoUM0ypos6VpTrtgYs1dhh0JO0Lc59FxGqaZtP5WeT07o
         k3A60wHdiFtbrwhbJPnWylqveWxeaSB+CjbQVO14sp0WoSDLJNXWnXp/vOQMBUH8Xj6L
         FyYwC6/R7LHfPSsxCQDhCo03H6HKgFetYk58St/kLn7HmHMP2Q+i6nFvViZItDsRCndD
         mISldHP81F293cH78JpmQoZ8seehUpt2betQ10Dcash8UKbPV3prc3JE/IaEK1S4O2Ek
         z12WTD+M/rOaDbLe+l/X9EQ+dqMUp1Ckpcw8pPadmxaXc7EYNlsu7w8fZ9zkypgvUTXK
         vDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530813; x=1737135613;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf69nspx1UASBjxRM+kRJ6Tl50tDGhlBKRym8hMWYiY=;
        b=UZs+T38Z9pZY5kdl+w+ALei4LS8vuAXphCxxVHC8LxQFBC4lFo9yXZz25vx4rLo+xc
         yNwmlw0npaWFVgvTast9HFIB75p8ubiZ3+QIKYsKyWqQ9bfa/mgAlmzGa4L8MfM+3Xgg
         MRUXDj80/YaZovt1T7oy8JbK66S1nT0baqW3EJUU00Yrjk6YcWaTHciH2AihWfiVFFfM
         Y1ihXdHowXpZhgwPGtIlM9vis1OyG0s0COn2P9BD3z/8x98UrUbW2CxJQrs5/uf3+eZy
         mi2Miik1lMQ6CspK6pIO9veU+vJsiL7mGWKUEedKYaulteIiYpy4+PHnwkjR6q5fYCG8
         d3/g==
X-Forwarded-Encrypted: i=1; AJvYcCV6CAgzwFXVuMq2V9RT10YkIDSUzJSxK+6pLsRKfkPjzyL64FI7nqQ5vwmMKZPex3kcqdg3RmJApJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVWW3f+t2cSMyUYXkifhKdrkYJ7UdcmM9DDgo09yPwT9cdSqx
	2bT7BBzB3iS2IbvBYoh9Up6MhgKCWzf2j+IqE0MsQPfWU6HB22sMVJF8C/jbyzw=
X-Gm-Gg: ASbGncuCvOdQN8Nz16H/Bss+dsRMrt+9Eob/EdWVOJfmsfk3vzweXd1telFxXBMkizb
	dkOVsbefCJLwn6w7pzKVmwOiMDa6P3KEhVgB8ZKAZ1ap43yXD5NZVbisOwCvKVuDXIMimmBt8cA
	aMlb80JN42Xb3FDeox1giIQBY6KH8WPpwfXj6Cg9ME7EyzdTnbacgV3du7DsT194BjqLR4NyZgN
	hnTO2F1k5qd/h3UsDD/noKHDUxLVdQPX/a91YQAQKQEl0Rcrq3kNurz3cB98Y0QZp8YXwdhsBh2
	Q0pfdYsTasEv
X-Google-Smtp-Source: AGHT+IHccU47uyrpntcj5g/jQaiYCJAXmmCPJLwo5wRF89RNYMSyDzy2pgoKn9zOAUGgixEgowVr0Q==
X-Received: by 2002:a05:6808:309f:b0:3e7:a201:db0f with SMTP id 5614622812f47-3ef2ecb1fadmr6828292b6e.25.1736530811419;
        Fri, 10 Jan 2025 09:40:11 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f03769a8f8sm842165b6e.26.2025.01.10.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:40:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/2] iio: adc: ad7173: fix non-const info struct
Date: Fri, 10 Jan 2025 11:40:05 -0600
Message-Id: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVbgWcC/52NQQ6CMBBFr0K6dkw7BRpceQ/jgpZRJtHWtEgkh
 LtbWBl3upjFm/y8N4tEkSmJQzGLSCMnDj6D3hXC9a2/EnCXWaDEUilEYA7Qdi6f0UrDhV/ggwc
 XfBqA/SVAGuLTDdAgVY1tFBGSyLpHpDzeUqdz5p7TEOK0lUe1fv+IjAokdLJyEjWW1uijbacb2
 0h7F+5i7Yz46TY/uDG7bd0ZiWhNWddf7mVZ3qXrEGM/AQAA
X-Change-ID: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

While working ad7124, Uwe pointed out a bug in the ad7173 driver.
static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
and was being modified during driver probe, which could lead to race
conditions if two instances of the driver were probed at the same time.

The fix from v2 has already been picked up, so these are the remaining
patches that can now be applied since the fix has made it's way back
into the iio/togreg branch.

---
Changes in v3:
- Dropped first patch that was already applied.
- Fixed compile error due to spurious rebasing artifact.
- Rebased on top of latest iio tree and resolved conflicts.
- Link to v2: https://lore.kernel.org/r/20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com

Changes in v2:
- Fixed chip name in a few places.
- Add new simpler patch for "fix" that gets backported.
- Rebase other patches on this and incorporate feedback.
- Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com

---
David Lechner (2):
      iio: adc: ad7173: remove special handling for irq number
      iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct

 drivers/iio/adc/ad7173.c               | 487 +++++++++++++++++----------------
 drivers/iio/adc/ad_sigma_delta.c       |   5 +-
 include/linux/iio/adc/ad_sigma_delta.h |   2 -
 3 files changed, 255 insertions(+), 239 deletions(-)
---
base-commit: 56ea2bb4297338aa1c185696b287d384ec27c0d4
change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


