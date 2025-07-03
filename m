Return-Path: <linux-iio+bounces-21321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9EAF826F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC83F16A1AF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99ED2BE643;
	Thu,  3 Jul 2025 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VBa/ee7G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7528B4E1
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576878; cv=none; b=GDjzkhu2AX3qhlNAbxbOC85rK6U/0TTCSvRtjOQGlAiUWkgQOH/HtVihgTlbTI3zZjs+yMcVsOeJ1K1z8bvXOBR+bw9f7/fXl4zHzBG+Kxg+82VwXMgbB6oya3LvsLlWho3/HM2GBU4SQwY2QBQQ0aTWLijRv/RnCIRGuMvbvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576878; c=relaxed/simple;
	bh=kqPXioKOoQz945FL/ykJkjIoFVXZSuZyL+bCmVjutc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z+8tlZ2c+rXNMMovTnjhsAzYM512iM4qu/FCyOjubQZFdKM46G9EZWIIE3Kt3i5gXJT91DTvRALyAhpxPrHsoeUc3TUhV/nj7mn5e9P2xU8s0rSmsuYi4eMhqHfY3QTUqWR4uzfq4Y46Wo5BY5REY3lqjlm/9dHmC7Cr4PNmlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VBa/ee7G; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-40b71debe9aso147165b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Jul 2025 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751576875; x=1752181675; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4oYDZ5sK08jy+FMU7Girvf+ZLAM5OGZtPNURJiwJ+8=;
        b=VBa/ee7GAy9zTfPePYvdzVhESliiimZT8C0uKAKao2bt4MyXkgnTTLIeYVQ7otu8ev
         aoCSPpg7HqQ7zqrBiSOr8bleubgbgv7IPUqsDB3mBYpivz03Ltbu0BoRsqla5rLcvO3d
         ND/e6dZcu4WAeBor5mdhcMED7FQ5kVm0bwysmvNC5mVmsrLn+oWjWEgJuHFKwUe5pj1B
         wda9YG1yZ8oZ1DJoIDwXoUiURcCX3Tz0Uo3DryWFkP4m1bd8FjGq+zv9b6RFw2Na69t1
         1iMjJx7PAk/5cUjtKzbuHNkM8PZJVThYBpHsYR0w20yvwDVS2m19Ph+mJiTFajE2eKZi
         WWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751576875; x=1752181675;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4oYDZ5sK08jy+FMU7Girvf+ZLAM5OGZtPNURJiwJ+8=;
        b=DIwWVqU5YtLbxMM5dmTJpyILuGLJwUVdiC7kRNZEM0+0KIjbgudARPvkbOUOWCmM93
         ITrurNFRbe9qU0QY4WiniDJ1k6KPkUkAqUAaLTPBf2OUkm2qftZV2qbToE4RZEXXAFu8
         +3IutC0hi4xJc3mycsij7S8dNTGUhUp3UDgX8N9Gwb2p2knsmuD4rLj/3KqmNm5xWRmQ
         3b+GtNBc75B9C0G2XNrJgYnt2PnAcCC/pZDMsMCAnMXugzVuSLgihffS07b3j16Bs6Sn
         i/hBLILZZ9UKdIrf6fHlHcyuYdTTeAnkcA2hkq+ARHwTUUzm2n290XhStHuyYNt2LvUR
         TD/g==
X-Gm-Message-State: AOJu0YyCOmoPW1Tod/4cG6X2ggZT3xrge2WxuidU7yOduuxrD36O7eoT
	WxuP414iS9wJX6t69sStaWqGI0B48JFtqHvQtju3OcF/F3ldG7nAe5ommLV/IT72pS89x1z+cQK
	UcQrrSMc=
X-Gm-Gg: ASbGncuDyQN5vW2NrdOWwCJegauAl7v2JF+NeAlHV9YbUJtMkf9XahsQoq09kv33eO5
	7sRme1AiREh4bvNR8FE3JosUNnf/6lGhq6m7K+iIXcF2LIadgBtBIIiMbSECuzqJPWTjWRIOAc+
	5//IBKatHSgI2FZj77b/yGM1f1qFHGxj/VPePxTN6Bp1nmQkpZqi2x7yiRHRDD8prCTFLuY9b3x
	FdEqHjoNSMWPFqkZnCkL3+Iibzh9i1CTQM27Q28Ql/0gbbxEaWq78tVFsWsZIUTAOHTxnrTFgOW
	rzJORFLG3XMPv6yEA0jmWZwhmO8lM6jCQT39h5EoQfE57gYJQ7RKavct/2/9Eb5md1boxXgkJXN
	Z9o0=
X-Google-Smtp-Source: AGHT+IFJGly+blzpD/C7mjwzVxH0NIWp3w9oJLoNQ1NEhhl+S5i5wl4mzsiArlB5jChHIduux7h2xg==
X-Received: by 2002:a05:6808:1206:b0:408:fbed:c3ab with SMTP id 5614622812f47-40d04b9aa50mr130033b6e.38.1751576874719;
        Thu, 03 Jul 2025 14:07:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4f2b:5167:10f4:c985])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02a45af3sm78900b6e.14.2025.07.03.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:07:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Jul 2025 16:07:44 -0500
Subject: [PATCH] iio: adc: ad_sigma_delta: change to buffer predisable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB/xZmgC/x2NQQrCQAxFr1KyNpCZKlKvIlKmk0wN1FYmVQqld
 ze4eIvHg/93MKkqBrdmhypfNV1ml3BqID/TPAoqu0OkeKErtai6YOLs9KbjK/Us05pw+JQiFd9
 VWC0NkyAHKjl04UxdBJ/zVHT7X90fx/ED7K5KYHoAAAA=
X-Change-ID: 20250703-iio-adc-ad_sigma_delta-buffer-predisable-d10fc1914092
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kqPXioKOoQz945FL/ykJkjIoFVXZSuZyL+bCmVjutc4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZvEjEZHxabT02pj40v/6ZNFWUsqVg+fSmoMRj
 B+fIXSQ2c2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGbxIwAKCRDCzCAB/wGP
 wA+8B/9/Q8mZS5Tj0FbKJ1W2M/CxVZjR5wAoPdzdKscHRZzVxezqPM0c6E4JN26+fbYGS9yWeyv
 Ld7bi4feF+CP8QfPMGD5U5kq+BlKVmQE8JZqEuIi5xZW+Jh1HXxKun6mWDUOa9G2XP0DwrbDZIL
 yDSl1MEl6nQCHhdRQYA2gA1MZFVFVWMffH0aK7uJJ68x5Gmq4L7M+HdwzJ+qItFtYiq4xQI84ja
 gNFTtKmeeDcXFU/p/zOmD6guFcImqV2Rz9yv7cliCkGQI/iynovEYiRkSycywSjAveHac0Kqe4z
 Oag/geYS/vWDWtjZBeNBVX4Pgnf+J9oj2NDh2/OFSb3mmUfI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the buffer disable callback from postdisable to predisable.
This balances the existing posteanble callback. Using postdisable
with posteanble can be problematic, for example, if update_scan_mode
fails, it would call postdisable without ever having called posteanble,
so the drivers using this would be in an unexpected state when
postdisable was called.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 4c5f8d29a559fea7226b84141bcb148fb801f62c..1a2ee7c7f65afc60677af9f3138e59f6476f74c7 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -520,7 +520,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -644,7 +644,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250703-iio-adc-ad_sigma_delta-buffer-predisable-d10fc1914092

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


