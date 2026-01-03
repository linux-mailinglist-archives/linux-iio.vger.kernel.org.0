Return-Path: <linux-iio+bounces-27474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161DCF04EE
	for <lists+linux-iio@lfdr.de>; Sat, 03 Jan 2026 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8EF9300119D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jan 2026 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061102DA757;
	Sat,  3 Jan 2026 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGNXUXlI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4322AE45
	for <linux-iio@vger.kernel.org>; Sat,  3 Jan 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767468322; cv=none; b=Z9KDEcE6vjnWKHttS4ldM6rghx57gtB1TH5GB7mjphy0uAG4Saokt29UtrqbWVP9RBfRoA7v+cPpwv2yLYDHTTDNddrcHD1ZIcX6VesKj9uyxDkmMq1v9pw1hccJKz9tdlkLUApiE8s0AjF64bV+tL9OgT/f4ylTGCKWJMWGUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767468322; c=relaxed/simple;
	bh=YPf+Fy6IoB8pAZxaLwwE//Rgr5vCLFJF/49f7mKUjDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loYhAq57crxyR38HaX4G96jskcmkXVS9Dq+udX0r53N56SyNNzmu8EcfCiRd68S2qc2mG8DBhYhNkq4HLnBdl7JTKUVS94r4DbmR9UX0meMU+d+Uoo2/X7zoB+6VOL4tR3JwXjWbpv+uBSaGgBzOREyQ/YrOWZa4RwhhnVB6swY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGNXUXlI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so14061483a91.1
        for <linux-iio@vger.kernel.org>; Sat, 03 Jan 2026 11:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767468320; x=1768073120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOXLh2bucqD84uZkLgEZpa5hDWux6/Xm7yrcd6eLUtc=;
        b=TGNXUXlIn7K666jKupS9liaJoGfRB+/8OyLjFmq80NOv0hCCQYSE7GJ27s3PwXQOlO
         BMdc7Op1XOpis/Ear6lsxNgwoaZNi8AomhF/owsImSRPvIBdT1WZ2vuCrXgNcezTgto8
         7Cd9FgBt9fogy0rSTTYSabr94JS/PXXR/wHkhG6dH8xQEfl8Zvi476P7yKdQ9mXBI6ad
         e0xGdxGeqcgZQwR+9smvz4JMdZniqeWRINijJdlTI0Z4VhcvHnoKuY/XP5QsE7kbg4CD
         DnjU00sO0a9+6XjEHwXXMohRVEgIx305k6LnzVD+EjkXIm2HgLYz3hKf3STWRKDLVHCC
         DXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767468320; x=1768073120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOXLh2bucqD84uZkLgEZpa5hDWux6/Xm7yrcd6eLUtc=;
        b=hv1Q1Fc3R4qISq0R+06xeiq140D6/tymDUO7/yxs7TYKTsCOrkqI1n93tGI5ewY8DH
         B0Aj2eVrUTvo+qcPlAqzd3MImHnZIswChXk5YlCRzYXlrI3xr5tJELW4y1qxB5EqMsZ0
         1AgMO58dPvrpZERKNpnLtvKda/09Pvf5N2uaBuoxgkROaio/jPzm735jcA1no80QjeB7
         A/okQ+n4Geki/cqsRUxiM9bGP794CTvwfh9BCMXY5y03YvXYYeYjarimTDf0Rb2ESB4T
         TYAAvsBTPVS5pNIB0xSz3C9LJ64sTxT0Rh9JPzepAEEAZ6aW6T+q8pvtLFm+Dz98YX1E
         0NLg==
X-Gm-Message-State: AOJu0Yx8fihuR0cvztYyeFSVe4sJ4i6zyNZ88AGWNQxGsKbVXQ+7Bfrr
	Ag0Em1A6M3FuKE2eH6OpaafGLE1NTLHOovPg0zDkbEUIXutJ54Rh+T3b
X-Gm-Gg: AY/fxX5Xz1fc0wg7H1Oc8aHb2l0dlsCFe+1vdT+ewL6ht3OElahbuCHWYF5+2Iyuaaf
	Ez6DpHFkHqpkMLK0/dosREWSPXjJcMbFqe+RdpaSCO3vzcHL9XHipiyBVhJax8jn59rmR0vLIQ0
	5Flx2mGbTqx11XMT+Hn8ycGOYvRf3rYrkwZrvW3nuD/oapeJkXXyY/ue6SwhMk6EdWbrrInjaai
	vQ6/qOEetNCB6VAGPk1l4NmeqDZoFI1Uz8ukY9q9Bh08ai2bLpeMBqr3SIFwM4Ah2uuJWtVB1yE
	2x7ReyTzXOGjrKCUfx+876Fh0LpAdpv5AnX3+lgKZVuX4bxNi6yy39OJFs5NGOU7zqsvAdaVvZk
	QCRDOsu5Q5D4Is22RTMvQzcwWfXC8HDZ5nR8Pi05UhLzjWAkYsH98+kSz1u494W/IdjzYZVENa8
	Dv49PKstMBw/YqEEeJS9Vlgg4yq2I=
X-Google-Smtp-Source: AGHT+IFEtFItx0iXXbKdGGRBDIq9rYW83LPwnyHxp+2dtx+cEalGoMz3WvGXrLnbDq/ZIs9aFc7kjw==
X-Received: by 2002:a05:7022:3f06:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-121722ec349mr44291907c88.34.1767468320426;
        Sat, 03 Jan 2026 11:25:20 -0800 (PST)
Received: from localhost.localdomain ([2804:20:28:7d9:9e7e:e417:97c4:ca77])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfc0esm159029838c88.2.2026.01.03.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 11:25:20 -0800 (PST)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gabrielsousa230@gmail.com
Subject: [PATCH] iio: light: zopt2201: use lock guards
Date: Sat,  3 Jan 2026 16:24:42 -0300
Message-ID: <20260103192442.10826-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() to handle the mutex lock instead of manually
locking and unlocking it.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
 drivers/iio/light/zopt2201.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 1dba1b949cc3..f5a41c293d9c 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -351,15 +351,13 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
 	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
 
-unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
-- 
2.43.0


