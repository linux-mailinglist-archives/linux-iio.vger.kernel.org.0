Return-Path: <linux-iio+bounces-13063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260669E3032
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 00:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C05EB277CA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B320C00B;
	Tue,  3 Dec 2024 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAJ2wTuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC720B7ED;
	Tue,  3 Dec 2024 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270154; cv=none; b=Se1hzcw3ddZ9+ZclNjp0Mv+heizMNIm22/KBGCn+MI8sr4uCJ4+h7vMEuP3rqZBVJC+F66lWY1K7DypSMRhIE8Fwr4nNF056YoSNXt6ZgVYFlaIBvsaaKZBQmTptAvvbYYB8UV52xWVBgXAsgpbA3TaUGbyB9uyWGAox66GV1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270154; c=relaxed/simple;
	bh=ZJy+O9wAN5psXY5U1XwM4rfLbaZm+Ldb/OiSmxBOm5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1hwkLX5nPF8GjdXxf1yR6KowcWJIOIsJPzq3rzS21EQKPuFNWuhNIb/i81kHXJDYYu7yb7HRl4M6iX4uQEluWtUA3uUvyA0kALWQTLgCg5vHnDY3VP/CTVgI1PisWqfPYjdNAOqUWgbFCIR3GTmsWdIkNjf2RikPAk+98F9KV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAJ2wTuX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a8640763so51453245e9.1;
        Tue, 03 Dec 2024 15:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733270151; x=1733874951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4mvtSDDIU4b4TfX3DZsirgFj9Aga5ZvWdRIoTLMLpA=;
        b=MAJ2wTuX9Bw4ZCUOT08S9CfjFvI7jy0y6TORDj/JeCosfZdzeYPhC1n4a1JN+W9rhg
         GejE7D4/408c62DaBopqEjOnLy2C5F04RH8b+0zL3v1nUB+Zpa8RtzG7W0vlfM4UgTCs
         C+x/6X23rB2RH1wLkxlK1QC1CJlkC5AScpodb7/v5/5B0JaDk9n92eoNh8RInbBP+ynF
         5M8RdB3wkQVgev2kF5RIxU0kJHW6s2ZgyA8PKCbdp5/+d5ndiD1sRCU2//RVfDYP2wyW
         0+4dfyLN6UNLFN+nluL+mbjEyc65ImSJx4WF3c9GWjFabV8gls5Ak/H+Uc323XgnYH7H
         mggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270151; x=1733874951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4mvtSDDIU4b4TfX3DZsirgFj9Aga5ZvWdRIoTLMLpA=;
        b=osAw37iFHhHEDuGNMxek5cUnX8n0MrJwXtmsQ7UcspNw9HAPlZ0JzzznbJGHVtKQm9
         UFargjDq5gn41Qjj4c5sxpfrfjDj/UZZIbADXEdEwb/3PQAloT8aimhCZK0rjIZiIUhd
         wVrGpkWKnZhVV8eZJuvBDx3z+QkuZhq0KlHAXBjiiYCuztpjcn4xRRGMvYixkOeKjOqM
         vtGMvXyNI9kOg0U4ZV4nyqvt+lZGirGFvRO6KTFETqyrOiOGC5t8U54qrq9RT9giJ8s2
         mMeq5SkRPNieangNV4NeAc74M7RT7H92kUgb9xuAgnfILCOL+wt6T8tljAaOX7mN0LgZ
         eg9g==
X-Forwarded-Encrypted: i=1; AJvYcCUgjnjC7EGTO8CNP6cPANtfEwxCZAq/6DNCpRzHMhSlx4lLiF+s1p/m7ljUtAmAPp3zwQVMZWVMG/QEACSg@vger.kernel.org, AJvYcCVwulWuslu1zfu3GjZTcP0Kud+i7koQ4NeUwCZvatPWX+hfaPywDv0Gvs+Qr2OpgyMMJmtU3DtH@vger.kernel.org, AJvYcCW8nbOTU9PQ0Sok+jLlyI1re/mEYdCiPZZnZZMMBhn0df69laja5xkpZISyn4s1tQ/3XxHUO2fVuxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzorrX5pPzu75ERvbwP/mrKs3cBIOpXG6RZ2oC1f6SCp6byTpOA
	01FHAP+65yJed+hmLzjazpyhOWMIPW0VRHczuq22/RWfW8ZOy3oi
X-Gm-Gg: ASbGncuCtfbQhUzUTkynjOu1HPrIAiYP7t2TAFzBux7Jwe3XboVNG9ABHKzoplmIjZ2
	FiWFjMXKjfqCIyzjms79ZuMcwTx0qRf6tSU6hltBY8nEHVKwvLKEliEgZnyU0RLwH8IVhBkYES0
	oBcqNgbsM4Rpa/u0lH6TUyUBX1cd97W9iGI1kMxbwet2MVGbnnrEfjPtQeAL4sBoPgmNgbd8C7n
	oOIWvlrDtBEOoqqECbQY0Mcnf+xMVUBubJWjXM+I4LKkebfdGxMT4fh77HibYYI4vDGdqTMUP27
	x/ndrcmcJZfOrNRY8mKiH9AT+AgkybggMXNCHZpu7Ei9zVQUGox5KSCFM5PFjgbIeMzlKIBP
X-Google-Smtp-Source: AGHT+IH1PEiLlez5u7cIOYP8lz3vPaYwfOqcP2PsVBS+elkdoDcUfrfRJh98/H8DHZijEK/fHVThVA==
X-Received: by 2002:a05:600c:19c8:b0:431:5d89:646e with SMTP id 5b1f17b1804b1-434d2268fb8mr28531065e9.32.1733270151033;
        Tue, 03 Dec 2024 15:55:51 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-5e3a-77ab-7b2b-a993.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5e3a:77ab:7b2b:a993])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e287sm3871025e9.12.2024.12.03.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:55:50 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 04 Dec 2024 00:55:32 +0100
Subject: [PATCH v2 2/2] iio: light: as73211: fix channel handling in
 only-color triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-iio_memset_scan_holes-v2-2-3f941592a76d@gmail.com>
References: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
In-Reply-To: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Antoni Pokusinski <apokusinski01@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733270145; l=1997;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZJy+O9wAN5psXY5U1XwM4rfLbaZm+Ldb/OiSmxBOm5Q=;
 b=uFVC5j35izd0O5MfAM25DtBA7BXdzdXbkXuLcJnrugXPOUgrTNuZVmd3u6QAMlKiLCbJqnyWp
 mqIZfQ9qRSXB3rqy22JPT8RcpKTKvrJb6G7lAlO45SboLHuuJLxea9G
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
set (optimized path for color channel readings), and it must be shifted
instead of leaving an empty channel for the temperature when it is off.

Once the channel index is fixed, the uninitialized channel must be set
to zero to avoid pushing uninitialized data.

Cc: stable@vger.kernel.org
Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebb..2d45dfeda406 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -672,9 +672,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 
 		/* AS73211 starts reading at address 2 */
 		ret = i2c_master_recv(data->client,
-				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
+				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
 		if (ret < 0)
 			goto done;
+
+		/* Avoid pushing uninitialized data */
+		scan.chan[3] = 0;
 	}
 
 	if (data_result) {
@@ -682,9 +685,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		 * Saturate all channels (in case of overflows). Temperature channel
 		 * is not affected by overflows.
 		 */
-		scan.chan[1] = cpu_to_le16(U16_MAX);
-		scan.chan[2] = cpu_to_le16(U16_MAX);
-		scan.chan[3] = cpu_to_le16(U16_MAX);
+		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+			scan.chan[3] = cpu_to_le16(U16_MAX);
+		} else {
+			scan.chan[0] = cpu_to_le16(U16_MAX);
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));

-- 
2.43.0


