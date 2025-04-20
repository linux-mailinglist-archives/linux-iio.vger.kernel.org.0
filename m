Return-Path: <linux-iio+bounces-18354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C68A9460C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBAB67AC0CD
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 00:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C322F9E8;
	Sun, 20 Apr 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIsl5Fax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E006EEB1;
	Sun, 20 Apr 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745109006; cv=none; b=jZmcntlC8ayDBqCck5g9xJk+6WYDrgRmsYX6QEnQFZLAy2kAmqY2/rKONB/3Qo+NbIpzS5VF6kGkz6pcUANNefUQbFWsOZ6MhzZEq9BN8/hQ6WPip5AfTnTp1+YKlQAoaxGHXowTdTAC+DfJp3e0TwqF/Rx8XNLgrVDgypbbRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745109006; c=relaxed/simple;
	bh=CCntJaSb9MDvFLR+jrrfjZXjcZnQs2OPtQYxHIZU6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W03tkSqlvr2XdLgqfNzz/5YVvxae4tuDDsYUvsSSjDmWV6SiW1phXYd2Gf7Pi875RhJcjXhixz7yOD7M2pFPbHUkhiW3OBWJG2V9EpOpKJ8zMgPTpqhz/hb95FIRqrRgIcWX5N2L0ovpKy3OtJJBIq2y/9PXgcDneQZXywrJ+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIsl5Fax; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fce04655so27318746d6.3;
        Sat, 19 Apr 2025 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745109003; x=1745713803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7oq4HIkBj4+ruAu2dWOyVk4qHejVBDW3R7KsUBqTQJg=;
        b=nIsl5FaxjnUQJ6NCYCImodMX4npRWROS4wV6HaNCRigFpYF5Jy680+AhpfDA9XioWU
         Z3xtWdxmLxla5WiKEmbQWG/VoKXe1H2Ca32BiKuCkO+vez5hPGJSJT+g8T5UtBmlSNwF
         oydvERqPxGUDt3iGoJS4sTP2M1/h10Drczg0B+McvE/CrC3Gw/O96ie/QjDZ5AmCLst9
         2H/P85bfUlIlL/Jmh+Wy7+z6tBhJ5d/vMTbNwp8u9wzOmjFWeX5j9ekuao6UVj3F+RXO
         DLGpfRuJan/FU3PtWXSVT9KIveAhrgiiPg2a3B5iJkHVlLTcNVw78KrLaz8TKkB3JC9M
         Omkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745109003; x=1745713803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oq4HIkBj4+ruAu2dWOyVk4qHejVBDW3R7KsUBqTQJg=;
        b=bDMF20dx7yp4v4Dg4zLHhtDIx5bDHlgIO9cVVEAAILInpH6xjeWfKa2xapBHD+i6ta
         AtweSDaY8n9UHSBDRtVrmV6JM8xSMfae1MXFNqtmMRO/3ozOtYg+i/m5J1rGKqJBkhhW
         LUOX9s5aEdSvRZRULZVc1GDCxezuwzZLkwwvhufRapjlR1UM/HKP6TUptQSG+8WKnqmC
         l4anMMv54DrYQ+NSw48zHQfqy94SLup+xSZwTvr4T5wkY89JRZBUcvoiTpvzBRobV5Mu
         fIDKkWQPkGQQLCQXWvRaVbc8YdQcZHaA/IWIU/fHJVOTTyKd4cZgb6npu28kMFrR2hHw
         wFog==
X-Forwarded-Encrypted: i=1; AJvYcCWDIG6yiQkuEbOLjhCFevLD4PLUUI/RpmAs8IzhNF1/y1JQVcoPAIi6xU9KtqTiHoco81W2FRMHaHM=@vger.kernel.org, AJvYcCWX/eEaYDENXTqLHgc/njVWLHFuF9qxj3usgRZjW5MTKVK16Ay+00/7HnPPWUvtI2uJO9xh2lCv82H9fo3C@vger.kernel.org, AJvYcCXVLdUOf5Rg8KvSkNQ/zycVC3ecuqreowExAkJD357fm1fsQ/NFCSt30PBJ9mYBMtW+LzDRuMof@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6MVyU99Dg9yitXQAtB3wofFFi7rCs0Iu1Pkia7uFUmuLZioX
	5UJy6VoMB7yEfe5qCpVfi3SaWWrdPRy9CouwRzx+UxbRLSOwNUc6
X-Gm-Gg: ASbGncuggdm1p7zrwYy3oglu2e6kf4P0Y9v+qrOKLgFs09H14AW4ub/n4Hbh3BgAmjG
	BResZ8JluQhQ8XLpGOVg4pU9Vplcw4BKGBshlf2F4Zpt+19C/JB2C3GxqsWJa5V8v6WZ8gQlCfM
	c5K307333Pz+/WOwD2kKIkz5q5fXsoR2+cBpXdF0jBpbfk77ngQhTi4D/jKofWEqOM0Nqkyr3Iv
	U7bnv+oVcBDThDDF4iyiQAV+Rmt3Qpjc+u0sDmkBwdotzp8Dzvbe4vFr5NjAReiYnBeXSTYDtrH
	+CqKZJDUERW8Te2a5/SEWveLM+PW7chr+b1eBrJovSg1/qCA7eKAex0ecrDwdfbc+lsDADo7PSI
	u/g9euN0UNlr/8Lobqic=
X-Google-Smtp-Source: AGHT+IEWsjtSj7e7lQR+vf9lcpERLYW7vibDfoa1VjlCCiRIm8Imf+936M+AgBjV1zysxDZRst2viQ==
X-Received: by 2002:a05:6214:c29:b0:6e8:fcde:58d5 with SMTP id 6a1803df08f44-6f2c4687cd2mr126456826d6.42.1745109003355;
        Sat, 19 Apr 2025 17:30:03 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af48c3sm26480846d6.8.2025.04.19.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 17:30:03 -0700 (PDT)
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
Subject: [PATCH v3] staging: iio: ad5933: Correct settling cycles encoding per datasheet
Date: Sat, 19 Apr 2025 20:30:00 -0400
Message-ID: <20250420003000.842747-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the settling cycles encoding as specified in the AD5933
datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
previous logic did not correctly translate the user-requested effective
cycle count into the required 9-bit base + 2-bit multiplier format
(D10..D0) for values exceeding 511.

Clamp the user input for out_altvoltage0_settling_cycles to the
maximum effective value of 2044 cycles (511 * 4x multiplier).

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
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


