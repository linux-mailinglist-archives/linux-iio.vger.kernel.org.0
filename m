Return-Path: <linux-iio+bounces-18376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F2A9489C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FF6188DA18
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2220DD72;
	Sun, 20 Apr 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrDymEmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601E20CCCA;
	Sun, 20 Apr 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171252; cv=none; b=Wok6TdUM74fTwzqhsXKVpK+85xdn4U31QXc6mS1O0QrBsvwd4pYYqYCsp0KXUPuVdmFaLxbk7EXp+ru90kLofN93dB3fUgc99ph1a9BiqXaP8DJvUKWdTO6rsRMElQRr+LlWVtb86PZV26oCKSxId94d3gOpqa6VY4a+5VcAHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171252; c=relaxed/simple;
	bh=Yjwh6DrsjcKU5bFRc6zRRnv4rV0fIl8jZH8L4C5u09I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZlWHlDjOC4Ww+jBcriia8qkRJMnD0l1q9SV7omVqOt9ZA4MLXlzVRC20L10De9IoDgkuLwCYY39c4LWstKd7OqsTPw6VmZLekhtH2hRgBYt7iXXtqybi8o0gV8fRdvFbipyqUFf+cucyIHLorXF3coByl53o3WJ9TyZ3NBbdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrDymEmg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0ad74483fso39134596d6.1;
        Sun, 20 Apr 2025 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171250; x=1745776050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzOgfJm3r4ap/eGSZdUiYEYs4uCCNfYQBrjOjwlLAKQ=;
        b=BrDymEmguZunLrgbM0rpqJYvXvsQIUBtNBUxoPN8SVD4fHmUh5LQephJ9g9Y2XJPy5
         2KPDJ+H0lHrs20x9RQUheMZyCUuPTkLDTLlitc6lW2iYsSZ5gu3gZIzFfoDms8RZgGds
         E1o6JWXsYHYFoy3nS3ZhUZLwt8fVVym7FJRsyHO/s6qQKJQCAdujmCISUnbNWsUbp76g
         Wr+xXs+jYL62uAZ5AuR6DmTgW5+r7TzCBmGluvF1DRo+vWEVOO25UF+vlrYFdqcR9c+A
         XpW3IkOA4+wHJAKTfz0QQOL1gKOuqc3qY+4PY24eHsdkt4xytyR4tGwM036EjMJ2kFxn
         bq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171250; x=1745776050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzOgfJm3r4ap/eGSZdUiYEYs4uCCNfYQBrjOjwlLAKQ=;
        b=Vo064xtdFpdgF30p/a78FwSANKnlPIaNiIPhwyYuQKT2W+OZXW89PZkUz26mMipJ3o
         fJ+wZ5dHICo7Oamr5Ks9gzKujBXwqhYVWeHkbGXy4ZtGQLcd34Byjdm4x4bPExlXlx3W
         RIcayMK94O96IniYZ2d9hqdDQOI6fvOUak300FpkmmIJ6ElnanIc7kW5qdSnXRxsS212
         9NZUKvo39PjMIJaEptl5eaSSkU2mifJSpZMhCI3hRKq8dEStAcX0Gjom1qoTC+6HWBK1
         LXd2ncxUFcEdYCYT5QhHIOBzHAtt5tI8JTGiZ5TozzipgIPZkB+1oyYnU6QfRcomiYuR
         LJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdjLcfmkcBHE4o5EHvVe8oEpBPbsa3UX/Y14F80EuXOpz9jp1BLpsZkilYukJQKXOB/zZz7tlmew8/h0cC@vger.kernel.org, AJvYcCVJympAu4vT9GVEd5FP9p2X1j4gtk+/ezixtl0hf7jpAGHGge7prl7UJFcXBE6DCbSxj/nHDBaT5/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLo2ojISevuxgUnvm4rDV9GPk6gcnQ71AGcoiPa5rZIqqft5t
	LIfNl6uYRzHi29Q/3OJsWzptTl6uZnaKUl/FL1q26URQVdjgB+dQ
X-Gm-Gg: ASbGnct+7DcaxDy9lwFTc7f1C1zPTtVWpV6IWxE7qirw7k7m8The5rHs2vy4k24zaDZ
	PuAJ1rffqPvRhynKJt5lVto2/ewtYnbP7WHe9N34TDMfuIQnLDRy+6lxECNRo2X1IUSPbOGN2XL
	vVNl55YmOazSERUdER5apwjR4HETeBh/JVij5/Z53YGpQ9FwGGFyz55wBZUEyx7qriijfSUyE40
	1Dy053Gp3P+Un2/NU21FM3pXDXoEjmRPTdiDGscPnW/wBAC1ngnIlLymwPenXAxBWUfjwmDYHSI
	V7ce5SiKG+zZYLKb9M59jTT7TIyuDENuurViRss9m6U2RgdtogyxRn0=
X-Google-Smtp-Source: AGHT+IH9iK+h688srjo2GEMmT43pFIn1JTTyr94V8Hjcrdy3ZjQHR0kwwvkdR/Su2ueEF2lYQIVFog==
X-Received: by 2002:a05:6214:5182:b0:6e6:646e:a0f0 with SMTP id 6a1803df08f44-6f2c454679fmr141748466d6.12.1745171250146;
        Sun, 20 Apr 2025 10:47:30 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd3e4sm34110156d6.85.2025.04.20.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:47:29 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 3/3] staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown
Date: Sun, 20 Apr 2025 13:47:25 -0400
Message-ID: <20250420174725.887242-4-gshahrouzi@gmail.com>
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

Minimize size of type that needs to be used by replacing unsigned long
with bool. Avoid redundancy by checking if cached power state is the
same as the one requested.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a8fc20379efed..2ab6026d56b5c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -173,13 +173,19 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9832_state *st = iio_priv(indio_dev);
 	int ret;
-	unsigned long val;
+	bool val;
+	bool cur;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = kstrtobool(buf, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	mutex_lock(&st->lock);
+
+	cur = !!(st->ctrl_src & AD9832_SLEEP);
+	if (val == cur)
+		goto unlock;
+
 	if (val)
 		st->ctrl_src |= AD9832_SLEEP;
 	else
@@ -189,10 +195,10 @@ static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribut
 	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
 				st->ctrl_src);
 	ret = spi_sync(st->spi, &st->msg);
-	mutex_unlock(&st->lock);
 
-error_ret:
-	return ret ? ret : len;
+unlock:
+	mutex_unlock(&st->lock);
+	return len;
 }
 
 static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


