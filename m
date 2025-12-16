Return-Path: <linux-iio+bounces-27108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328CCC0543
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 01:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBED7300F9C6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680D1FF7C7;
	Tue, 16 Dec 2025 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OunMdZ94"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF49475
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844292; cv=none; b=PTc4eBQfznmsE/0lM6GIifMG/tINtc+HA1S+M6GnbjnJplM4C1L+Q35dAOwUM09g05xBCxuAGOQKn1tzC88rQkzj/K0WwlJVbYC+K39A0YOOp+ZXbJ9x3uGYrcwOei5C5AYGAcMJc6pTI8UyGhKl6r3xoc9pTt/ljD/x3oUC48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844292; c=relaxed/simple;
	bh=kNIGwxsGMzRz5O92jeVCA+zRzwI6Qio/wmpjlgxRkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzfXkLVu9oN05cBg2cclTloI/N6BX4Rtpz6HBbKg7jlu4BrdlRpSq4pmt0TAZAAC+25ndqpQMoLn23kpTDN8wasaxae/Oda3miN9OLiQoEsBmShxF32e0l7EcrqdrrPown4rY99zm9f2Efqn+Rk2culjcmNB2+H7M3bLBzZRX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OunMdZ94; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a6a7654a4so37332217b3.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844290; x=1766449090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VztJAC7cCh5GP5QIAJCnCl3lm7nNzDysSmomi/iAMGE=;
        b=OunMdZ94TdMQ7ahvuv4Vzu/MPA2NfTJcLdJA9e5j0EF03L7gW3NFVY2nu+nXWobyFj
         D6yZuB98ayKI1U1Mbh77Lrmcuhkb7POgttum0rjtYIlUXDrtgBuYmrVGCJLQfVz7hTDw
         txU2YmQLQcR/c2Xv7fJsw4MwGKcghhI2ETjYseccFl6YVlFq5ybzSX5B57phVbwFg2mB
         sF8jnO3L8WIFkPel1oX5VH6F03oJxVu/D2l7fo6Ttp8p8IE3uNjXm6QqcB64fp+jJgZV
         Sxs6HAALrbCqNxnfjHKM5olo/KyCmKRUrToQGdw+lUD1s7rXfb/DOJZK/ES9ME7BlQPD
         A+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844290; x=1766449090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VztJAC7cCh5GP5QIAJCnCl3lm7nNzDysSmomi/iAMGE=;
        b=BZvHtGcXo7rcHYFb0Abl3LnEZkpdMPBrJGz+Ep3lCM6iD1kVsvtybygJjKucQmYmCs
         OrE7tlLojorXcHfUdXnWItjsGQk/0eqmxt/UzE2UN+y/jSNo9+iDZLeldWFZYI2tuOTq
         92ZcZiw4OskkSllTrAnv05YRyyvjftLUCbEUN+d4ifFZzyi9c3qQPLokmQcPE3r4bfy/
         zvgBEBnm3qOzmLQU/BSOBBLcCQmtNfPRcGxq8etdZwCwMySShFlASp2YW1PsfA38jfJF
         ae5PdFmrw/KjL9LI3bmZQjx8J57fzqQgkwv1V5nLXJnFd4KMtlVTzkGndSGx8Lql5C7K
         DzhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTqicGziND7b//zdbi4pmDe7ihol1qsnrilkn9uJxegYj/T3uM4GQNUk2UI1elbTr8GpB8cWOmv9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiuUgk0myxycFjbu1nQNJ1ADrl6MyuuDJ/0/rYdoM72YazCbH
	I7CKla8c3+EZ+F/zrJctpBZLkbEWBAEwMxtJNtmtEo+hVRDvB9p9yz4f
X-Gm-Gg: AY/fxX7qnKG1Gd/PGfIAhZqgCSTC85/xI4OsexFps4dLwpNrXgVnBHZWYNC5scwK013
	9o2zN9F9lPnI/SWhJHOGJ1ZF80SYK/4gotUUqMqx9vq/9huTnQzZTTGH75GHxNPvYPJe9HcXqeb
	+jZdX1hOHrO65Rr19iK7bMlZryX+VyTLPq8ve/Lx1hex36yvaryKTMKxpKtxP//Z6W4PC9+csPo
	WlodeaaluukvN2ilH3rvc+XndwcKFSnKGPJlynlGS8vs6nDl1qL/yWr9k5vW2qKKRewEedKaPm7
	yTAQjPtB+T7DwUCV8wuVh9pFwia70wTz4MR/ZKT/9aI8D1VSEKwoVWy/uhkD7UDSdJJloQ6KIqy
	pbL9y8zfLoAz3ULiP6ij0KW26ccgPwvy4N1UBTCQNkg/gyDRAzG137TzNq2x1PWFYH2wlxMkpjn
	M68LeUAw==
X-Google-Smtp-Source: AGHT+IE4CMDSS5cSbzuaSozssRSJqfXk2nhl7d8TyTbYaGC9KoYy2AAvf/LJ/XGngtuMXA7g4/QdSQ==
X-Received: by 2002:a05:690e:16a1:b0:644:5bb4:7b05 with SMTP id 956f58d0204a3-6455566b32bmr8594370d50.83.1765844290324;
        Mon, 15 Dec 2025 16:18:10 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748cf8b7sm33659807b3.3.2025.12.15.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:18:10 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] iio: adc: ad7606_spi: use bitmap_full() in ad7606_spi_update_scan_mode()
Date: Mon, 15 Dec 2025 19:18:06 -0500
Message-ID: <20251216001808.333053-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_empty() is more verbose and efficient, as it stops traversing
scan_mask as soon as the 1st set bit found.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index f28e4ca37707..7e17ccbcedd0 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -345,7 +345,7 @@ static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
 		 * has no way of demuxing the data to filter out unwanted
 		 * channels.
 		 */
-		if (bitmap_weight(scan_mask, num_adc_ch) != num_adc_ch)
+		if (!bitmap_full(scan_mask, num_adc_ch))
 			return -EINVAL;
 	}
 
-- 
2.43.0


