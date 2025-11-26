Return-Path: <linux-iio+bounces-26489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81678C8B305
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 061DC3476CD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20D27815E;
	Wed, 26 Nov 2025 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfLfyYpB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3828F48
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177922; cv=none; b=daKACsQAzHIdqZtBuseHEysSLqgdEg0s0PetwsMze4SrOgZa4RRx+Kfk8YSlGc6DbGGJIAs9LH6tNptDdgCtiBjMm6hrx4P6NOFvrxvTVMIJLe5TJidDzz+0cP+DH4EIF0DSYqQadZkdDYJYiqLBT4yB3SqSeG11oyTtmnrSYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177922; c=relaxed/simple;
	bh=ZR2BCoS2VI9SOFOmkDzGTvDFhgBip9NJJilV6uc8dH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axxwYk9nX2UzrjNY7F9JLq/EE6DHUexTY2qX+OsfqaeP5fiVHqvTIbTVKGULk3yLaHTXUKZeh/abn7v514+uYu9wJtjf4wLeZCHivHdzqgoDc6zi83lvyW+fXiGkvW2giBuM2figt8FNBwT5nrJiP2t08PmygmDGmbB5VLUGlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfLfyYpB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b26461e78so21556e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764177920; x=1764782720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ps4xu0wvfpDSAZgUi95TPIwOTPm/BAN+loYLbToXY=;
        b=OfLfyYpB0rfZmn0AAY3gTn4+NAVdGTGJZvUqPZhB/NivzA0BEdoKKkvpFIYpTmxU+8
         jzaME7WfGGk2JGd/r8HClXsWeYCBnzRwXhTbRZkhylCT2kXlX5EF7mL+vfssUwdJAdUh
         66BGYrroAI+wVisCtsA7M/OfaArcgYKRmI/xRibvCeWOPNwCNF8pKYgiibZ+yoCfJdRj
         BzKDRGhVohYcKW2j9kCjreLzTjljkN77Bdjj09DpiPa0DHhrbbbhycG36FntMae5yj/t
         Kpj6dRDhvYt9xBaI6526X5u9zgxuTbJ0Pdb39+vIH2TDBRNG24nt4JL2YSGES1TAsUsS
         4czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177920; x=1764782720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6ps4xu0wvfpDSAZgUi95TPIwOTPm/BAN+loYLbToXY=;
        b=u5ww6qa7FXxSJHiZFY1BIjqY8Y036JeTHT2s8cLGhTpftiu4PYRSpS+lll9uvwXH/5
         SYHPhkbX1xwt4YDeaGXU6g7Nz+YifQ3cCkJ4W7e/MCydjQ20o5MzqCoR0DFk7o1DxE6x
         X3AodnEY4pKPCp0cfoMiDlne7SbH1ubM/zhW+ukKzw6J86YtCdA2Y2bG/mIeFS+w2MOz
         LEPBRnDqJ+GY5MVtrxErUAJbOGgprrnFinXsxMVkc2/Ork4QYrk56fwXn06HH0WUU2eP
         uGH+3H+rIOKr72kjtZeohqpqklAnpRlccHaSlGDrkXDKYFBigd9mxkXIRlzTyfseWC4Z
         Cgtg==
X-Forwarded-Encrypted: i=1; AJvYcCUVI8bOipjyhbM48jpwmnxks7+ewJEm9NRZaVFRCFwgJmr+sGEmdFiFMM1FsAQ1YaRZ6EOoVrpjZ64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRkKdAdE7TqrREZgnpUjFvY5gjKnfa2ScgitDCTl0wqTsqqHs
	EBHZLjMggm8nT7MR1tObfwW80GaHo7bZf7na/1+JhJHxHBWyt19ra1Ldv6atHlF2+Ok=
X-Gm-Gg: ASbGncsJMLdv+fBMzXnYmcvf39Vw+4P1HiHHX4IssZhnoElZmTLCjheOF4b1ZZTA9rg
	+ao46KUCOTrZPl6kANeUbPl+I5KuKMj77e52hzLPG4qwn0pUq6Rwn5ULxPr5ja4VjNP+dJJrVnZ
	gVU+2A5d0+tASj9IUyRE/gu/xszhFJI0vLYK4xhCv2mGpBN8dsCC5A2dDgS6kLJ+VCyubAcs1Z7
	r/JNjaFp0NAgIic7ao3t84C4o0zB1KVXDr7/RzRZb8TQL9PHfY/Ha6os0i9Iogn0vQMEA0tlfIr
	C1/kTlecFBXYCa/ioj/NYHeYbyJoHrL3nXun/VZIeu9wsbqgCHx1iKOeL2qsz1p4Ie32eEXKb0/
	LPTnkviGIhohPHIeXB75Ozoz/WWcj4Y8lvT3aHnJ72hW+k9nn6BJvDX7BNUwC/GhDeoXAMBwost
	yf4jnrAPjwkWiQ6d8ZRjOBr38YMslZuAfPMRo48IymDVBQPCmiQJGle5I7ROOIociGqzA0c+skU
	/TBkFDy5jZnXGs2ixV2RhA/eB/nHRcxXIMyEHnVM9GInTyFtrB2VLb+Fd2xGJJijTeRUfhhnQ==
X-Google-Smtp-Source: AGHT+IHD1qEgyXruFux5Qs0x/S1VL4FWVRN35LhE9bfS6Qyo3qXkfdJR1Ai1V2rPIwc+SoWkirIT1Q==
X-Received: by 2002:a05:6122:8298:b0:55b:305b:4e3e with SMTP id 71dfb90a1353d-55b8f01c456mr6365695e0c.20.1764177920014;
        Wed, 26 Nov 2025 09:25:20 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.230])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a1133sm8533066e0c.18.2025.11.26.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:25:19 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2] iio: isl29018.c: replace sprintf with safer alternatives
Date: Wed, 26 Nov 2025 14:24:32 -0300
Message-ID: <20251126172432.5532-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces sprintf with sysfs_emit and sysfs_emit_at safer alternative
with no functional changes.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
V2:
- Fixed recipient list to include all reviewers (no code changes)

 drivers/iio/light/isl29018.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 1b4c18423..d00e951c5 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -273,7 +273,7 @@ static ssize_t in_illuminance_scale_available_show
 
 	mutex_lock(&chip->lock);
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
-		len += sprintf(buf + len, "%d.%06d ",
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
 			       isl29018_scales[chip->int_time][i].scale,
 			       isl29018_scales[chip->int_time][i].uscale);
 	mutex_unlock(&chip->lock);
@@ -293,7 +293,7 @@ static ssize_t in_illuminance_integration_time_available_show
 	int len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(isl29018_int_utimes[chip->type]); ++i)
-		len += sprintf(buf + len, "0.%06d ",
+		len += sysfs_emit_at(buf, len, "0.%06d ",
 			       isl29018_int_utimes[chip->type][i]);
 
 	buf[len - 1] = '\n';
@@ -330,7 +330,7 @@ static ssize_t proximity_on_chip_ambient_infrared_suppression_show
 	 * Return the "proximity scheme" i.e. if the chip does on chip
 	 * infrared suppression (1 means perform on chip suppression)
 	 */
-	return sprintf(buf, "%d\n", chip->prox_scheme);
+	return sysfs_emit(buf, "%d\n", chip->prox_scheme);
 }
 
 static ssize_t proximity_on_chip_ambient_infrared_suppression_store
-- 
2.43.0


