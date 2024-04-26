Return-Path: <linux-iio+bounces-4551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24478B409E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36D8B23395
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF81CFBC;
	Fri, 26 Apr 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jtzksphb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625528DC1
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161735; cv=none; b=VRMnB41ff9UfurYAjT6u+Wd6U+u/LQ/PWTD/TQxk2qHr9oT8wWwS+OK2gvKg2qv/P8AwQiTekLXg3d2PguBe7PS74azzzn2drovCZ/2AHWNqv0eArlRCJptCAe0SRadE55na+cJ0OK7ISOKBdNzXK5Fo6LWwpLI/JwUcosLx+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161735; c=relaxed/simple;
	bh=f1n9LZ8BoducsIpsAgn8GteNDhfL0VIydA9D2geNncY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti0Fnnuc9Ahdn8mo1VtzN81P0H+bJD9+TQ0fmy/1gUaLXZ/xMTB1F035v9d16aRezAwab2Z3vDaXVrp2QaKg1ha6X9mTgWo0OQwIL3bS1iwMpMXNavIreM14YuOVpqCpbyGRo3UM+VYh8EZXepyD/UcsolX9QxojdP9NskocLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jtzksphb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so2448274b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714161731; x=1714766531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFTcTT6Trice6IHk19ZJPOUnwehgODIkqaj1Y0k+YOM=;
        b=jtzksphbwJf2580vtGln2qILZnF1k0iwWFDAuzt56XWCaX7Zz2HTqgOCp5ofLzq7qn
         WcnSezUal/wpjH5ptNKoDnfRx1aJRQb9iH9Ya0K4jTYlwWARQpfuQtJviUI7TMC2Qy0S
         VMfjc6797SB1JJlV0m5/gLiRqH8SlSHB31t9A6KP8ptxox+3iUy5hESy35d9AcPdhDQD
         zAusGK/ap1zIi4fYeJ+xQ61Y328sMrcpJ5o5KWq/xWTwOrpOqJD2Iz5K0d7LKa/mcA/B
         KN1aeqxSk/9XArVLumA/nvmCxIaTBRCuujq+zPD4+OYVgAjVG7v4tfoIl65aa17JVL7L
         7B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161731; x=1714766531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFTcTT6Trice6IHk19ZJPOUnwehgODIkqaj1Y0k+YOM=;
        b=QPEqQaHGUPiDOl/H++tXkTaUpivF+0h8FxbGk5aoOa5nZhFA10DgsH5EvGO7atc5It
         VivCknEAdNLa8Q7RRNx4nv0isLZ0i2LtDs4nOxdWCsomUTxqTT3RkLfZ5n/6ZqgL93AX
         AkFM+H7hKVpFx9fsPutoFcBPO8SlHRXP0wnO9yNNd6I4ZfNNJrLM1V0FWs8TIm820z2e
         SCNSOZyZmQi/MO47lHjcTIKKuVwa+ga1kY9PC1GFUdYRWU2M4EcBSrEXF1RtTSlk5ZOS
         MpOL5AVJCxq3V/270zfrpRaVcagIw1d+jNY+x5diwLm0c1NfNNIuS+0qrGurBeooQNd6
         lUVw==
X-Forwarded-Encrypted: i=1; AJvYcCXo78Wz/g8t3gnJ8TplKAleIodYeIvDQwrn3cuzRNqB4kty4DppYidyNFv4ETyWQAxZq22ZGAMEt/mFIfkLpwBUIgIwNP0DvkhQ
X-Gm-Message-State: AOJu0YyDrn3uXKcl00K8JB9RpNCT0hXcp8OSGSm0VZjE1AEYhQnL1IIG
	PvdIoEKfUgYG5zXujUnj1wYLUOli7NBvRW5Hwp3nNzcy9drMsolmexm1es3r+OjRhPg99KURuhy
	/ncLTCw==
X-Google-Smtp-Source: AGHT+IE/NmkRfiU932fW9JsnWa/mc7hz22e6Ba8OKGO5O3lwCPU8/lWM+LK7aLiQHwgsgDbz9Kr6Qg==
X-Received: by 2002:a05:6a20:de13:b0:1aa:41e4:f1b4 with SMTP id kz19-20020a056a20de1300b001aa41e4f1b4mr3618459pzb.44.1714161731510;
        Fri, 26 Apr 2024 13:02:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bc40:efcb:b1a7:466e:d0e9:635f])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090ac88e00b002abb4500e97sm15026699pjt.41.2024.04.26.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:02:11 -0700 (PDT)
From: Gabriel Schwartz <gschwartz@usp.br>
To: jic23@kernel.org
Cc: Gabriel Schwartz <gschwartz@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: rtq6056: Use automated cleanup for mode handling in write_raw
Date: Fri, 26 Apr 2024 17:01:14 -0300
Message-ID: <20240426200118.20900-1-gschwartz@usp.br>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using iio_device_claim_direct_scoped() to automate mode claim and release
simplifies code flow and allows for straight-forward error handling with
direct returns on errors.

Signed-off-by: Gabriel Schwartz <gschwartz@usp.br>
---
 drivers/iio/adc/rtq6056.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index a5464737e..bcb129840 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -520,32 +520,20 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
 {
 	struct rtq6056_priv *priv = iio_priv(indio_dev);
 	const struct richtek_dev_data *devdata = priv->devdata;
-	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (devdata->fixed_samp_freq) {
-			ret = -EINVAL;
-			break;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		switch (mask) {
+		case IIO_CHAN_INFO_SAMP_FREQ:
+			if (devdata->fixed_samp_freq)
+				return -EINVAL;
+			return rtq6056_adc_set_samp_freq(priv, chan, val);
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			return devdata->set_average(priv, val);
+		default:
+			return -EINVAL;
 		}
-
-		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
-		break;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = devdata->set_average(priv, val);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
 	}
-
-	iio_device_release_direct_mode(indio_dev);
-
-	return ret;
+	unreachable();
 }
 
 static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
-- 
2.44.0


