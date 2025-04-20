Return-Path: <linux-iio+bounces-18360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A3A9465B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1494A7A9D51
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332382CCC5;
	Sun, 20 Apr 2025 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJppjJIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66116AD2D;
	Sun, 20 Apr 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745112615; cv=none; b=dqVaUAKQ15Rnztinm4aa6YBk30ZxlADp3tGf+SK7W2M/yPwZfSeccyXBOWQSMbFmZz02s1HojtHClqGypLnSmIYc0MwbugXY/Iwz+U4Q21wBEJ3KSnHoJKmnMRZWAF0uNhiSqtZzHImVBCorvug/Lfwwf3qgC+BwqlQ0TFsLDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745112615; c=relaxed/simple;
	bh=CyuSRiVyKJEGI/x2kS5E1Rp/4iqAVY4WrRx/nkz9QqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jf+5ReW9fT3GQPh3QWQCrhCrl7JSgOR6Z6gkY/eEubKu78WeGD/JJw/6MAVIuwKLNUATulY1kYianV0jVkM+AQ9kCEfLS0dgVa006WxqsKmM2lAYt3kNpLdAcsTfYS4+eUCmEpuCp7TNU4A46HBuYM4xlSUR9B30ruPRM3WEZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJppjJIv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c55500d08cso301910285a.0;
        Sat, 19 Apr 2025 18:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745112612; x=1745717412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTJrgwusKmBJGDT7w2SBMbCLd44w3bPlBa47XAgc/1Q=;
        b=FJppjJIv6pWmK636ru4q2Gkbb/qWNcFe8i4+rgYSYmG3MmqbX5OHwy0G0P4l0NXonl
         J5YQ+H2c/+4sTvjqa/d8uVbFPeuaOiW8ziQczCUJduuyJoku4XFxrkiEcCfuq1AWGSmh
         7aDlvwV5Ej9SpxEzLUZJ+QpCdU2UxecP0lexsZU79oGy89ExjteT8jqr4FzrkEEOsppr
         b0+3Ji72F6uZ/Y+DVePHDfCJipkudSMFg0Z4tN+t0c9JpNHv3HurrhwB6TUWs6omTUBY
         yZFRaFil+U8ZBEkDyqRCoebySRWDORs7Cm3uLwoEatHZrgGWfHawK0q50SmsZxp1DZti
         H+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745112612; x=1745717412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTJrgwusKmBJGDT7w2SBMbCLd44w3bPlBa47XAgc/1Q=;
        b=D+iM/pHU8eA5g+8kf4SVY6t39uWk7yh7e4dd3pMlHgTI28/9Dz6Z1NmAJ8ERAG28si
         gWMXMaEBUTeGGH7RLcbvEMe7Ml7WfH74xOoATTX8gxZ03G2VwnCYrpyVjLwKLBm4Bm/Q
         WxNyjNYmAz0owDup6h8/vrOaT0odU2M5gU7WBPLBKCey25/8z8EvoMJ4nqXPkh3Olgat
         IXLujuHyWsbgPBWlyEkV1vSGW14gjIJKy81JdXdIhODJiiJ6BH69YUN+kpWlWXt3M9t0
         BfHPY25iqeNrjcSTeDgbVQl4WO9n/JzifK2olYLE5Qo31wXlxy37YbEHe5cgVwcysMxr
         kwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdHN+PL8f/2yolgGzeqqbzVHot8Ej/YoDETT5ZRu56V9Wb2zYFgpD3HnTO2HU0jxFXI2YN1/frmfI=@vger.kernel.org, AJvYcCV/nD/5rY9gHJvg1CfmbleClgtOo2CgKFxLjjE63lNUTaErQlF7sKWE6si7Q2SYKkW0h25ubkK0@vger.kernel.org, AJvYcCX7rNUF26bHlzEbsqE6GLaAOmY+/wqop3gY7R85bm+ESbtbXDRYOB7QE4E/ZLIvyrpUSVtqjSldzSpLLU+a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4b4SokQCSbKwHbbqwmntHv1vRnePgztsx4WkoESY63nEARQbk
	7VMBtl3w1eIXkZnbKs/QVA2u1Sstw1aoy1E+XYKtdHcZ9tQjskwF
X-Gm-Gg: ASbGncvQErsTFk5jMNRDfMgYWYzFpZFbcMsE55OXh9/uvCi6pcb38atn3EtJ29uhJeO
	LvcNE+UVAQUybDzwOlg/pC8bapvHM2P8npXYOMB9XUUpt20uOtFgGrGItWmoQILQF29nF6Dj+dB
	kQXaFj8WEDOsDJuRqTakuDvfQrYqFplPoMyChpc2n9o1S9GWDUxlUhBSc6wglPeH240iTvuuqMG
	OJNtebq0AW9z/TUB7KtAlAH3pU9IRnRIh6Kzy6LT2fmZSndK8p1pXtNcXueYUklxL0/TEPHJyHo
	y3dS2R+/SsdNtDY50A6AoUOnXhLnY4SolLPPZ98Xy5MJJS3fYn299Wa2dBVyKzpT3hz4FdZPrL4
	e3TBmgD9KdkWJi2MW1tU=
X-Google-Smtp-Source: AGHT+IHuRChHb64yjYSyNvCrPInTUCyNqDkr2FIU5+hyx3zlq5oe6v2nUcAjw9rPd5yYHVs51m7ZJQ==
X-Received: by 2002:a05:620a:1727:b0:7c5:5d9b:b626 with SMTP id af79cd13be357-7c92805d79cmr1629015385a.36.1745112612227;
        Sat, 19 Apr 2025 18:30:12 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8bf65sm266054685a.25.2025.04.19.18.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:30:11 -0700 (PDT)
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
Subject: [PATCH v4] staging: iio: ad5933: Correct settling cycles encoding per datasheet
Date: Sat, 19 Apr 2025 21:30:09 -0400
Message-ID: <20250420013009.847851-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5933 datasheet (Table 13) lists the maximum cycles to be 0x7FC
(2044).

Clamp the user input to the maximum effective value of 0x7FC cycles.

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes in v4:
	- Provide clear git body description.
Changes in v3:
	- Only include fix (remove refactoring which will be its own
	  separate patch).
Changes in v2:
        - Fix spacing in comment around '+'.
        - Define mask and values for settling cycle multipliers.
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d5544fc2fe989..f8fcc10ea8150 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -411,7 +411,7 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = ad5933_cmd(st, 0);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		val = clamp(val, (u16)0, (u16)0x7FF);
+		val = clamp(val, (u16)0, (u16)0x7FC);
 		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
-- 
2.43.0


