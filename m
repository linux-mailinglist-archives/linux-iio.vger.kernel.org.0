Return-Path: <linux-iio+bounces-18380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91738A948A6
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A863AB624
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95820E33A;
	Sun, 20 Apr 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVc7wSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3B20D4F6;
	Sun, 20 Apr 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171666; cv=none; b=T1++s1CEVu8fdOvZo4c1LUB4ET9imQmjtqjSFaCmauniwyh0smTBc+6g3kAHLl6t1+aTc8d0QfN5U1E3TJuE9fj3neOO/u+yjo9OtB2TJqGs31vewz/DW9xleidsnFsaQRsDrpPvC9v15d+VgKN3NloGcgf6obt9EAmDJ7SQqsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171666; c=relaxed/simple;
	bh=Yjwh6DrsjcKU5bFRc6zRRnv4rV0fIl8jZH8L4C5u09I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJIhEuJSxMnWshcGufGXhFztAuZy30TOQqspgXKy6Cv/BW2MQhc4bTfGfRcWqjbYRU+dMBVpOB74huiT+o3MDd6WOLBP+TIcWnCcC0FwGUiBM+t1G+2JI2RZbTenJs1xrkjzFVoYKoS3JJ6RRnf3MkgpcmIyyDVoo023i+DW44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNVc7wSt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso32145986d6.2;
        Sun, 20 Apr 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171664; x=1745776464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzOgfJm3r4ap/eGSZdUiYEYs4uCCNfYQBrjOjwlLAKQ=;
        b=PNVc7wStlUtPU0KjcVdk1st3Mxxm/X5CWKgpaNTCRdRn+Eav3s8vhyj8D0ZMRJrPKZ
         IMJZelb0JkQ5F3/OVsRyQt78GtPjiKe0nO7wTn5e/tHqQ2ArizqziLq6AB4P6cBEpw7y
         VtE/93rFE25GykXkOVqjBXZKJHHouIfpIKcM+7Gv+4YVs+DtSAsiX1nJa+ICkb+ScNbX
         5Mn5XGu4+3hCClXPlpfo3m3jZ8WtOLTouH89iU7XnExx5oz97sK+k+gCKRJzCozaRfKm
         Ye7HN3h4Wlq1ChyWhHcLSq+SmWMJV+msKL/1XCNpeJHg03zEjmlMVf9iGUgGjSxEEJ3u
         d5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171664; x=1745776464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzOgfJm3r4ap/eGSZdUiYEYs4uCCNfYQBrjOjwlLAKQ=;
        b=qU5I5tberMq29XgKmRTygi+iYi2lvXGBdX4vjKT7kA1Bdv7tjDYm8XJSmxLZLVpnjo
         UgdMCKJo4VGAqpGM0k/2wqkX5riGxGCPsiDxys1CwKfNusySYXaPiup5BLAco/lHZuD6
         +zziXukslPXyAPOujE7c8Xb1/pKe7zqKPEiE6zJp1fdWyQiLInih51kMCZxYgBAFBBpK
         R86XyTYSZ68kfYB1p5u5m6f1qmdF6GX4FDC3UX3a2ROPpGkU2xWfT+6ftjcz2pIJOd63
         l7ze7LToq3kK50JKRuYrnBQSL0FbVSVndYfGGM/P9pSOdyXdTFChTZGhmDTE2x21vFkM
         0ouw==
X-Forwarded-Encrypted: i=1; AJvYcCUBEFqaHDKcRADgdc6nJaH5bLJ4pHHsoxFRrWoq80WqIcOkGTSyfas+cNloxMK6wunmK1shmoeGeeEiDXIU@vger.kernel.org, AJvYcCXSTMRg2wpGWceGq60xCYYdhy5OJaVIOvWIjCa/sPcPIvF8ThhJ2holU1GTmipcB4+z7f3N7QMLVAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn07D26r1iiahTQmuO4DWf2mEYxHSlnnkafgya3Z/+BFZjfH1X
	o4q/TB/iGbePlsuzQagEW6gxSh399am3/gUN0MP3UPM8tKENnqUg
X-Gm-Gg: ASbGncvspa/C8M7Eij8gblyr/EYCjadjo8M13R37+gxJ4aqoYjssi3B0F6NO449NR4W
	BKWBUmdEIMyRjurcnh6V+sQ3v9K7y23pusza2+OEHUD/GpcVzZnjfQEW1c/v+4lJPlt9Jb+2QOq
	mCObLjM1XNbPNPMDjEbN3rV2b7k3YNna4pW7eSkloMwP6uBklZ2PdbpQZRst5ydez1NmOC3RkBi
	OBOCIRVhVKNBOV6FwYnXkG05AdXbaWLdnEQknmS/cbXaRMcJD21QDlYrtDd98YECviQive38iht
	sduLYvhZ5La1F6Xpc0aQNg65km35xsg3yZMUTU7jxXcKjtYwEm2ubz0zkYBWgiUerw==
X-Google-Smtp-Source: AGHT+IHTykkMY2VPub0zs/b0tL0+U9e4zfzJQjPRSmVQA++TxLoy1VpNTKXhr0XTBBaywyQwZ0gxig==
X-Received: by 2002:a05:6214:4004:b0:6e8:f3af:ed59 with SMTP id 6a1803df08f44-6f2c4578776mr128057446d6.22.1745171664054;
        Sun, 20 Apr 2025 10:54:24 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0c1bcsm34801286d6.26.2025.04.20.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:54:23 -0700 (PDT)
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
Subject: [PATCH v3 3/3] staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown
Date: Sun, 20 Apr 2025 13:54:19 -0400
Message-ID: <20250420175419.889544-4-gshahrouzi@gmail.com>
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


