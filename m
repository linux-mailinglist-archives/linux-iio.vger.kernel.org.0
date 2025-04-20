Return-Path: <linux-iio+bounces-18378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C5AA948A1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B364817089F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8020D4FA;
	Sun, 20 Apr 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDqgK6aP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712771E9B02;
	Sun, 20 Apr 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171664; cv=none; b=hFZtCozX8LiQrt9nSidxlvb1VZ1Ggv69MxtHuCXhFIWX068SgH7rfn1I2Vtd0q8QjYsYgwOBjiS2sdRKFaru7pTJgjIXsxvKyykR/8h1qMf1Y7DSkJipc5c7IyqxjSorBucF2YvqsXCqusiU/gA8A0LuT2vF8b3pEIoX0oUWgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171664; c=relaxed/simple;
	bh=G7cQA1vbU7ME82rND+ta8qnI8kBAvliO793si5bKvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUquoZ3brQ6FwAiNtiW7/hMYWp2LsNnmKCLofu82gEU4UYzGce0JDV4/+AzIZh5YHauacbzaNr+BIwYReKkRhZ0vyT6/zRXpvMLyBOY5zgeKdi2eltEW+qhZZSKgYxgNoE/lYa2dR34nPPYOk1HDToxpUlBJmu/kS1q20dP/9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDqgK6aP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47688ae873fso35465361cf.0;
        Sun, 20 Apr 2025 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171662; x=1745776462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=ZDqgK6aPcieRWCotSwz1dqbt/797gIyT5pGCwHv3zO3aSz5cUTCBxp9UCeStQ9pNk1
         4oYVQH5udjWWW+uzpJ0ePIJEIgtolTflNscDM85AbMbXhB2hKHZ7z4zqPFsxTMtBxEsq
         9grYga846Zpd7usnIlvOjXdw7SzlFFfvOgoKMcV4+4p1HyQEhCigJhXxnI5N1GD4wS37
         ySFw1FTfXx3xu66iEv3m8hcbX22O2KFnk67cNNgdVeczXuusTJ4Kb4Nex74T8/EtuInU
         bN9ds92fohFGfmKgsX4f+X7e2N5I7rQZpJES70pFdNB+fyvBtrvIGj9YTeFYOBsJchtO
         O28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171662; x=1745776462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwMHB2nUwzNcRVsw3OgexWqiEt8JRdlA5caQ8STPGxo=;
        b=VFfVST83nzEE+Zvv5Vg9QOkU7nPLeNd7UkHoCC9JwwWuV6k14F0oaqDNyu8Rwz/+PE
         Xzt1KCZiYokmW90XkPgt+si9ijO8Rcc0yqKvWdZb+400rhyZd1DwT2hn6TVAeDn3gPNq
         vmG4tHVmvZYY+CInQU1FZg0s2y5OM+K31GA/sVZ8b6efaAe/FBllSOQTFu6BM29LthHY
         hNotH+y3dX2zY/3xy90Kb8PoH/uxDagQyG3iY65DolYEQ1EqZTmW/HQ0fpOYlb08AG5u
         FtTgHeMUsQXcK5U06GNdiNKsTCZqNliSqjfWyqYCMjnicJ9XCL4LANKCuMVq6xqzeqcZ
         /dWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRc0thZUBicsZTTmmiY93NBQWpZl5xpGYaJbQnsl2rRMRMMvCFpWjYikbt3AAgkTJLMX3Q3Tmf@vger.kernel.org, AJvYcCWfpJd9P2mZ3HA5ely9Xwq5hg4pLTttSC9Eti0cTSpX4tELgb8MTdYynhCSlk1nNXpklCapYy30lDLSPPCI@vger.kernel.org, AJvYcCWtoaoZuO8f5f13maVJMBsyf+osMcZO+LWrWjmiUpKmBvH+8tZ/Jg3VplN8mCEk2dYMXjvVR2qXBqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTposQcD0YRPyy2N63OGPbGqN0TYjmoxyU7gagraScRSZJokk
	CRPOt8jcjKPXVvjw0qY4dhruzobl0Tw1tn0nFq26kJejv5Sd+rAF
X-Gm-Gg: ASbGncvHB0dapN0XCGaUO9D8eKO/BF4rrmNnd43FHgeVEKflCBGB4bQqTSEix0ek6M4
	TXjzZnpZTmUhG4aTbcBLxzObRk7+v4YmlyIpBvbhLQHZ+SxZzg2sYXY0gtjbqK+0B5jwmFv9crj
	LKKxbG033TWgqlvLT5raBUdIF/iW2h4JD2yOGgehRzVyiLVihdySivQpiljpD/gpfEEIMyPENWi
	5sccmhp9/jYAeI0nnPrVfUitsT98fc68dfLgko80XYW/kMqvxoQH8a5566eskBdhok7rgkXntvG
	5X6mpcWdZ82Du5hSut5+GoGCf532wcflQMiCXlxvkDCZvJuuq+TLkRx749X6ojYUtw==
X-Google-Smtp-Source: AGHT+IFh3Npe3ogkMASCYKQUaCIKFNmK5UDJSRG/Ql7bxSc7zZ6ONLkKYqeskbLzkROXB5vowu1hdQ==
X-Received: by 2002:a05:6214:23cd:b0:6e6:5bd5:f3a8 with SMTP id 6a1803df08f44-6f2c4665531mr123099406d6.29.1745171662125;
        Sun, 20 Apr 2025 10:54:22 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0c1bcsm34801286d6.26.2025.04.20.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:54:21 -0700 (PDT)
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
Subject: [PATCH v3 1/3] iio: frequency: Use SLEEP bit instead of RESET to disable output
Date: Sun, 20 Apr 2025 13:54:17 -0400
Message-ID: <20250420175419.889544-2-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420175419.889544-1-gshahrouzi@gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
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


