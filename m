Return-Path: <linux-iio+bounces-14963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85604A270A2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D56116545D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD520C47E;
	Tue,  4 Feb 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t1ScWaHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD820B1EC
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669837; cv=none; b=jqNQ3XPPY6xXw13Ss9AyKQ03YkPWOwVprH7iMKmKfujNY5cEtNkvsibwcj25/7e8K5VE5PKP27mLo6bUOsOhaBZDkfCZvBOLMOd3TLDTcF85o1e1cM0NEgQAm6iYyqRESuI+7hB8Wa+ov6EBMpW1pDlWmlzc4LeWKWoeD/AnRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669837; c=relaxed/simple;
	bh=tQ1K1FUEH9Prrzkvqp1E5aMOd7QRsMSiOy67GBtJxOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7qBAvQkPItMM7MqipOnQE1/WMpo4+7+Ym4CZwjc+/TcqPPWdJQNp0I9A5EviP+O24/BJ4LB945e5QDBl0uV/KLJ1JvtRfYHkYKO4rpZKuGIJjIW/VZTL5sGJYWw5h+1EH2o2HR9t9p/pmGkuUV41wR2GpEMqeCTndWB0qj8H3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t1ScWaHS; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so7701323a12.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 03:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738669832; x=1739274632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8Z2b75njmPnz2OfBJEcJJjid7zHz8pgd99qOfTvtzs=;
        b=t1ScWaHSUxy65wlHkbrD3ueL4qLwI9nFVaAUDvtLnRahby+6pe3zayx9T9sZc9i2F7
         SRA8IweOGiO/3gQempcLF3Bwfalciw+/Tk8l7yp/f2ngiBx78be8cMu14/08F14Z5Q94
         hz7ssPAQZUWtcjvCrdu3ZbU9XT2n95+0izh/cwFYWUTd0+17gWjOHN5xtzXv92MdR5qw
         +mTE4KeVdU6bRNAo7S2Cyss/3ZrR0ZwogZt+wiGgF5vfMN9C1u9fD8Qao0LjlKId24HO
         Phtip+8dtk8b20sez8XoxLFVfDeBsLDrO6hdm52k26Ka1o3KDiw6jENHBCP770K4m+b1
         vtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738669832; x=1739274632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8Z2b75njmPnz2OfBJEcJJjid7zHz8pgd99qOfTvtzs=;
        b=fNpW7XLdvT2tgBSvSSsdO01ycRRk8q0kF6DLMZTKOLN01zJj2CkrONCY4a2MxOhOGu
         //p5vqPVWcLvC3m7Ib1q6QM/dSiq9EWn/RnUrYZIasabfofacf2dHZGx3FbFa6WAr3tt
         nNKLcx/IEuP0E3SH7JMMXL6SKGNSREcGJ36oFX1r9NplLyT3AX736f/T+cu90Oc2IhmJ
         ttYNaP4/NdLQAmbqZxjVKR3u1zhE88dvQ8tpgTNMEPedXIwf+yAG2MgXx8e7gkpq7HSW
         ePwY/MqrU7EL/uSav6/l3qdwaFi9mlhX7Npi3o0QtHcyeTImfC93Ocj6bRnwnI7yW3Ga
         fxPw==
X-Gm-Message-State: AOJu0Yx81LVY9miuORsXAO64kQRI2IToWVJ+U/ESdyTrO42kv+7h6X8v
	wNCDY2JEqGq4nVW6WABsUnzMKY1+/tenjiL2B9rCJmWitnLuFfzJE75lZcmouQs=
X-Gm-Gg: ASbGncvEpst61Ue/8LQvRqRcv67ZuX/Zi3ALiyWlmiINuvpRHhznkxChoo/yUMLQAHi
	pX0nT4rMZOjmlC8sKzYQeQ/aWM4KlBGIKnh/8y9zOqtL0PQRqz2jSmSMd63VicicrZDkQVvJy7R
	X+k/l9bbD9fbNrT0YYrrhYJWKx5hDYibE10gnGx+/+rfXfgutWBZjVN18OdgQ5amg7Zm/DONXHq
	yNPVeaf1Q6fW7Ju1z6KbkScWN3baTFUTWMZYlEqtm7HkwTH82zM+lah7bSAQxIgQI5EsTzZNaKg
	UR6K95ZLqxUkL7k0nNZJKICc5bQmsHySrrK9iPLf2HA/22uqk6+iwlvcXg==
X-Google-Smtp-Source: AGHT+IGgXgC4wk9xkBuVUSWP8c22FsU5qnsVpArvfz5yBEUrkJSvFPDarJdqAYn0+ivmHCFRw0e8nw==
X-Received: by 2002:a05:6402:510f:b0:5dc:5ada:e0c7 with SMTP id 4fb4d7f45d1cf-5dc5efec13emr72192583a12.26.1738669831428;
        Tue, 04 Feb 2025 03:50:31 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7008b2c04sm704834066b.33.2025.02.04.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:50:31 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] iio: adc: ad7124: Really disable all channels at probe time
Date: Tue,  4 Feb 2025 12:50:23 +0100
Message-ID: <20250204115023.265813-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=tQ1K1FUEH9Prrzkvqp1E5aMOd7QRsMSiOy67GBtJxOk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnof7/vKlINUZclvoGk7g8N22KTPD2vfs3AUynn 7r7MJPmkuGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6H+/wAKCRCPgPtYfRL+ TiaBB/9gFSNG5KTdkMDNrnZVOkWwwA+h+xH3qBlLMRDFaq4ifY+gZp/VTMNvhvp5MZmoCHPG5bU k0P2tp5mXerKmZrlvSqI6laEwpc1QYLtKULWUmlown5jjtdFpAdeRwLPS6zPJEwOL1g9Ac+nzBE 1eK7/ob7o8Z5HHrv7SfbzrN2o3wMMlZTjzdrYhBQfuWPqUkuAl4/mrAuNVxV/uTGYs0PN6aPOio Hvb0wRqEvMMNYD5SZudQGJruq57TdNhYWEiSOcnrdKLzfGdwkSkZ9UNFCtn6B8cD13uFcO84bNo fcsW3ApI2uPhbxhc/2wD7/09l5vq6SpPB9OeQsPABzCG4q7q
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If one or more of the 16 channels are enabled and the driver is not
aware of that, unexpected things happen because different channels are
used than intended. To prevent that, all channels should be disabled at
probe time. In Commit 4be339af334c ("iio: adc: ad7124: Disable all
channels at probe time") I intended do that, however only the channels
that are potentially used by the driver and not all channels are
disabled since then. So disable all 16 channels and not only the used
ones.

Also fix the same issue in the .disable_all() callback.

Fixes: 4be339af334c ("iio: adc: ad7124: Disable all channels at probe time")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is based on v6.14-rc1 + the patch "iio: adc: ad7124: Micro-optimize
channel disabling"
(https://lore.kernel.org/linux-iio/20250120140708.1093655-2-u.kleine-koenig@baylibre.com)
that Jonathan claimed to have taken already.

Best regards
Uwe

 drivers/iio/adc/ad7124.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 2fdeb3247952..6bc418d38820 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -550,11 +550,10 @@ static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 
 static int ad7124_disable_all(struct ad_sigma_delta *sd)
 {
-	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 	int ret;
 	int i;
 
-	for (i = 0; i < st->num_channels; i++) {
+	for (i = 0; i < 16; i++) {
 		ret = ad7124_disable_one(sd, i);
 		if (ret < 0)
 			return ret;
@@ -1017,11 +1016,10 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * set all channels to this default value.
 		 */
 		ad7124_set_channel_odr(st, i, 10);
-
-		/* Disable all channels to prevent unintended conversions. */
-		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
 	}
 
+	ad7124_disable_all(&st->sd);
+
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to setup CONTROL register\n");

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
prerequisite-patch-id: c8d3727852b9c3bb4dcd2f16508bebbd093a3768
-- 
2.47.1


