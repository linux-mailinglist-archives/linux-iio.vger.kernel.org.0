Return-Path: <linux-iio+bounces-18375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9AA9489B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843503A619A
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3620D502;
	Sun, 20 Apr 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqt8yxOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137A1DF98E;
	Sun, 20 Apr 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171252; cv=none; b=TDzkqk8S1+iQwLpoTNAatv6rab2BFci6tqM97CKKlQmN2ZqWAH9yeQbhRzQxP511xaC8gH3UVXluUsfP6EEFVeBXLBlgCO34ZRXJURKVL4a2huwD5CgSw2in2FEQ0Tl34GPDkzBc3gePGcNZrE6zVyJl/1NdnJo8DYT40qtQcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171252; c=relaxed/simple;
	bh=G7cQA1vbU7ME82rND+ta8qnI8kBAvliO793si5bKvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1P4z9loPDJ0XPjCvo4qVbAZ5vwWkG/Hoi0wSAwq+gZLeCIhwVnwsqXvaSdJMayWaQTB9OYSxtwbE0mAHDAXt7mzbZhJSju6nK043vZ9TYGoNe07ArCymCqIu9kOtsXAzzLgAf68weTOBKTepPpyT80Bbc6lHuKw4uKCLWRTZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqt8yxOX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47662449055so16501301cf.1;
        Sun, 20 Apr 2025 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171248; x=1745776048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=aqt8yxOXxjqsJsCIPZ7YZLHUz3jnpsLsolFxywuvgVMk+RadPyiEUvU1TlEr2WRyV8
         EVa96jKYVWaUgAxgxQrSSOjKsFWWfYWFg1hL6VzZX6Su6kHQlo84t03dwci/CfohOlLR
         wNzKipLgCCni7EUSZmSfD93L4YWzXdWt3ARVTCvFdKdXC5uJLaGXSWhg5wF2vTCzt+/s
         Shsa4oJFo/dqnnHjKk56FC59vjF0S9UrT1C6nasBsq2Akgjm1PFOi3w6yZWE/r0dzPTd
         7MMV6B0MJVjm6LpBOknerG4m4YCdu+LKvhefxPFAZDTeZ5pClDEz30a7Wscy5ATM9/jA
         JiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171248; x=1745776048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=Cv7/peuZ4Ex9uZLCHRn/qKl0eXi77blDTZkqBobe/U+vjLfLDdv5bVf/352tdJSCh3
         2D1aMRaoGDye1X8oIUm/o+tHJdqdMp1tFl8Csn+5hiL4CB98vf0U7vFec4oXCqUV33e3
         d89UNHMHAs6kwo05R1RmwNJLbfXTcj44htdf3iQwosaYxg6dlHupT5lgFMhBT4RTjOXn
         ty2ZsaHGWp+fyT7Fyg8nzzAiGuqTmz4VkGLUwGEy9qvNVD7oIDgrfI7JuneYB4Ars7PM
         6jSObmEKD2Ox/tc4NqdtlY0hIHFxgQ382vx+J8m2Jc5Y7WuPD18uPmd1qRHodOphLRUj
         op3g==
X-Forwarded-Encrypted: i=1; AJvYcCU0jAQQ3Hn/csBO3E2Z8ZvXoA2SimS5xbOFkxP7Sn9aRu1oyevW3jyPzyMsQ7S3uhZss5uevyuhOvqC/va7@vger.kernel.org, AJvYcCWMLaMHQTEa/4871tFwXhTY6udewoowAUlK2fMbFRhOBQ+IRfr3MR2c+ynquUc/nKWpQ1pYWDwk@vger.kernel.org, AJvYcCWyU9LzQXZa95AOsZKyFnl5Tx/u7qs4HtvuzskvFQuFgEUOJ8Akl3riaCIDhTmxv0ZQR5SK45VlmgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuniohBhL3oOyf/COdl46qfAoATdXfBIZdr1K24c6XM1qfel+Q
	Zmdy9bTrkl/Uv2Uvfqc9IWzGbGUCPDP50nPwpk+7xzCQ9qY2Bh2QruMhJsHc9ew=
X-Gm-Gg: ASbGncsdagSaW61zK8e9Xg6eUP30UvIGT0guiaIVwkH0RCO6UOH6HIg7YRUtNP3TqCy
	Ji/JwRif9R7gvVzZUX45Rsk5mA9dB7irXWhL3dPGsWRu4DRirmQp8HCKqEQoXbSuA6SRNHWLvPS
	+2VmqbKc0KXfmd3t0AsnDBW1CM4yPR11gAK+B2VslPhKZNuO8cgWTvMfl4BDMAAoZMERx4wQYv3
	ePMwiP2kRDSZ1lYbGlqbNq1kz/zs2c6zjnhDInr6ZZAB/4wSYgaTj/RmtciYhwW5mJXGJwimcFb
	OaO6kzt84j2e7z+kwzlEpn0LeXotWtHpRrOUTEtrWISd7PNuxYgCE3k=
X-Google-Smtp-Source: AGHT+IG0psL0GsQcZjIWDxL3CpYMMouucx4/293lu1Def4c/30lkEViKoNJRISzRxA+fpp0gxTi8KA==
X-Received: by 2002:a05:6214:1c49:b0:6e8:f568:22e8 with SMTP id 6a1803df08f44-6f2c4556801mr156707866d6.15.1745171248371;
        Sun, 20 Apr 2025 10:47:28 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd3e4sm34110156d6.85.2025.04.20.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:47:28 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] iio: frequency: Use SLEEP bit instead of RESET to disable output
Date: Sun, 20 Apr 2025 13:47:23 -0400
Message-ID: <20250420174725.887242-2-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420174725.887242-1-gshahrouzi@gmail.com>
References: <20250420174725.887242-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the AD9832 datasheet (Table 10, D12 description), setting
the RESET bit forces the phase accumulator to zero, which corresponds to
a full-scale DC output, rather than disabling the output signal.

The correct way to disable the output and enter a low-power state is to
set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
the internal DAC current sources and disables internal clocks.

Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index db42810c7664b..0872ff4ec4896 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -232,7 +232,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
 					AD9832_CLR);
 		else
-			st->ctrl_src |= AD9832_RESET;
+			st->ctrl_src |= AD9832_SLEEP;
 
 		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
 					st->ctrl_src);
-- 
2.43.0


