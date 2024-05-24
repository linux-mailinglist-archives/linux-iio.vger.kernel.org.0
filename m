Return-Path: <linux-iio+bounces-5255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF868CE2C9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B00D28193B
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FB12B17B;
	Fri, 24 May 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpv2llq7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1212AAD8;
	Fri, 24 May 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541248; cv=none; b=c5PmrQsStN1h3pK8T2pY3qbCl08jOB7z+Y5oQsBGBFCIhopB1LvMtQ7AzD8bNZCSk9G0pbW7avd6R2JqgQoQXVnxMxMLwCZ+wLY6hJTB0MGmfREWHxQYxm+3Eyw98kaV2CtFI8OiceUWExRY2x6BwhJ7KMgBWDY4JUgBTbZKHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541248; c=relaxed/simple;
	bh=AD2QxnTXCiZqcUtATuF6XFe0uJztAf8DKE1lBJHaRWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qs6zMNzyIcTYN9vwvTxHxK82GJui9z5Q3sKa72ToeejmbTFoELy2EFYEvCm5E5t5xRHW879cidGJhh9cymC+O+uxJU/WktqXrIEWFdgvtMdvdN3uNqfbKOc2ldQzSVkbDb6Hzqw6EhPgzewKpOCuxBj/OjU51TAQf18gnNun5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpv2llq7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d3c488so76217366b.0;
        Fri, 24 May 2024 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541245; x=1717146045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yzuk+Lzt+HE/E31U6ntE49TPiuNsnk7yodO4bVtrkg=;
        b=fpv2llq7Th27hfRp3/FJ727bUK8QjRiQ8uYLSqfyhM0LKdT2iW7A0Cg4OuD3Urwpx/
         iC5+dWNYm4ld8YU4WyZA5zQ+ARjEF1T1TNN8DergPm5eecOpOfxm1/4VSVWsHCE2stW8
         qaONC1urm51zESW4zrG+3J7ZX6KpD1L2bUENF3VZ3RZSRX9/j+Wn9fV3j4/P6hhQOE6w
         7cVx2s6Kmewue/s9Ux+6be7FdFJk07MKNJpXD+lcThYy4OFWDle6FVEK3f/Uez5cNgfz
         O1xUbDtZyYJxUG5x6NtZE/gmKfpel45WrL6qbPHF6JgB7Nu0ep9+hykqWAmfWKiruWBd
         UIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541245; x=1717146045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yzuk+Lzt+HE/E31U6ntE49TPiuNsnk7yodO4bVtrkg=;
        b=ULmngUtnpR3Hg5NfFObWvcokYaeQKi2RVXdEgTmhSA2F1kyKMzEfh0aA29QgWrvsbL
         zxxlKsvaRLCrtNO8nt43ufjYxiRph+6TklEbLK7P1bmmY+eJb3S3J3LZVcr6XIqU677k
         sTY3U83zsZo7FEat0qND6ezMAMwn6XvN8w+YaFL0n+iDRsZaXoCsCbI06BKsFDUsgZY5
         kCb1NaHdkfAJuAaFYJPjM+v0jrlRVXD1Ir+5g7yGFNBVOSduJhTCYQwTJ4o85upD3Q3j
         F+AReHZdONSh5i1RIB32ZL05xiBKS9C5R2MnTOf9Pg3Z0LUNOn7H9E8fgB9VuJUctNX4
         H4vA==
X-Forwarded-Encrypted: i=1; AJvYcCV1F1K1Z/uFnyuFZECsyG0Gci8VZxJTFdSdSoBY0CbMPr77gC7MATXzgpqcZoL56A22GzbpepFyq3gKG6jhSpQuPxC14KJSQDPxP61RTdB9DCAdnKzpTOq5juRCXXVGz+K1fMmSow==
X-Gm-Message-State: AOJu0YzMgWS432/8pBRv/bMZ3Kcw8gUnn+hDPMf5Moh/YRi7tyWL3Ulf
	vBPdgbRjhRhYgPeEDC/y15oREVVvoxF1BVeMicWLYqhyrVI2zPb1L2IuXLMzMm4=
X-Google-Smtp-Source: AGHT+IFH9X50N+NMXP7KqrSHQUKeQafNDP2mWb7rGxfEDkI5KsOnjQFC7YBzMvOy0uQNNxuc8md/BA==
X-Received: by 2002:a17:906:eb14:b0:a59:d5e4:1487 with SMTP id a640c23a62f3a-a62646d583fmr174530866b.42.1716541244603;
        Fri, 24 May 2024 02:00:44 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:43 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v4 05/10] iio: imu: adis16475: Create push single sample API
Date: Fri, 24 May 2024 12:00:26 +0300
Message-Id: <20240524090030.336427-6-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create push single sample API reposnsible for pushing a single
sample into the buffer.
This is a preparation patch for FIFO support where more than
one sample has to be pushed in the trigger handler.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v4
 drivers/iio/imu/adis16475.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index f9455ecb348c..ab955efdad92 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1249,9 +1249,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }

-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16475_push_single_sample(struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
@@ -1340,6 +1339,15 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	 * array.
 	 */
 	adis16475_burst32_check(st);
+	return ret;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	adis16475_push_single_sample(pf);
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
--
2.34.1


