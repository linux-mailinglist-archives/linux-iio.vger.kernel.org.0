Return-Path: <linux-iio+bounces-24677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB9FBB514C
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 22:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65EE481762
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640DD28C85C;
	Thu,  2 Oct 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KESQnFLB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BA2848B1
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435373; cv=none; b=o+zThWE6XeVxmayVFF8wixm0yCIvgg/Qbxe5CzaqH+GjuvnFB44Yv4r3w3R6XX7qmMVlrdrogDql0UJxwmeMaKgxLhVm8PGrEIkO+Bd0NoPAK47nuhpXTF0C5//WjWFk2Or/ARb01yDNyOJcVMFxuKoZyPMBKyoJGVxrJ0+fZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435373; c=relaxed/simple;
	bh=xqA4WfL7S6BHVcS+M//q/p+VfDFq76/O5OymsIWiwqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkPmdcijFaDjT4WPwdrD7h1W9M8c8zlmX5wcARyAh2+SeAf6ZLz82lSD1XH6lXDGblTmmMArNWEMbcadGzAJbGW2zUrcV0NoEhoD9N8ywmuaDQSYH6QafYgz3vPxKow7j2ui7x/KZVX5E/oevs0QFPEn7ZL6eJN49ESIO8mSgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KESQnFLB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso264739066b.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435370; x=1760040170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTj76Kc5BTuQhN8FqnbvXwRLBgS3SMtN0BmmDUIv/k4=;
        b=KESQnFLBlMfbq+a1bsjHmWLrwW2dirpjFdLAp8Hv9qA5hlQJ/LUm6BI+w5Qh7KVJaE
         A3qjOYsZKUb9teywpoT0pWXeswOFVJ5q4mfMOTfUm5wAAAgtbXgfhiz7rgt8btrOfNCc
         QIAQDLLt/wJCxPG9EoRdz5qK5VAdtEQsjI34f75Fkknx8Uj0keblqdqJt4sYkR6JbnEq
         bG1/SD9yPDD3uM2DTtledgw1k/veFCRzXZscCjlrsJc5D3MpwGavsNUBxNf6H27/Npy4
         eYFSnej8e8eOsuU+3HkeBoS4vXkGgEVRueQvKct8tlUionGmX6+CQPzhBuctjYSBDf7+
         CZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435370; x=1760040170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTj76Kc5BTuQhN8FqnbvXwRLBgS3SMtN0BmmDUIv/k4=;
        b=RVeTPXQhfI4w/DxIMntpmT6Eojr+Jv+Bxa3Gx7W34ylHuG3z8V9J8I5Yo6OzeGW5HV
         v7b3uwpvdKNG2Jsq6SsPWXHatt6BhKAHt2pHSsgfT81uDDzdcwjBd6MMPnkxPm5Q6N8G
         xj/UruHyjnPCqhfgLGj61RUqdj97oNfwmt5Gxt2M7sW8sqpj0/tKxgtzesgip1VPtdqZ
         4sDBHqDq4qc/H9O+cl+Z0CZeesaVR/8jInjo3Zdj55eIMv1uEJFD13s6g/06EET5/Gzc
         SlKD8hOrX0yNq3PFeHzpO1fkIh/zreLbe4XdQZi86kxrxgpqV1Fls2CAoFK8YH8LMEXT
         SbMg==
X-Forwarded-Encrypted: i=1; AJvYcCU2yHOFv/85zEsZnce67ajoG/pfZCtBYxB0GJ/GdBwaSC8vW5HrgRGGkV3Uwnk+deUtLlzGPGevUBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuWP/JeJIs1fXqBnTEvIXdHQPld4vEzQEr0X7NswP8zoOSRLi
	50XgJAFhOkpbdwLgUlxc/nnkbniBOZnpp/89wvRw0yUUmw39SCDjugBO
X-Gm-Gg: ASbGnctFiCWl5IGX7G3L7b7iAFEy8EufUT0NH9S5884PTv6knWEblmx0lGHc5dHKDwH
	N2cqhu2cv5fT5QISbdaDQJ0SBjB8JpAkhaNbQjxmGnwEA+GVmFzl1kVxGVOiOZqG4qy9XTvsVTG
	+mfOJlVdYi+DV+Wfgg0lb6uYPKExxSiRmXhlOakbsLHT15lOcu5l5WU0twxt+R2vmVcdhe14gPN
	Td7HWL8cZwTkriFXwIG5V01gRfwG+wa4gTpvUJbVdhWIUo6SYU+ofsJIZ+B8xfuY/OyJlLL5kRM
	g5zxtbIvD/uxX6Pn3R47GZrR66Ca690CmSlN+5RZUXlpua0YkG+a/qEyR6x8uG4GTNbE6M5Q146
	m99vd7/oURBMUpjinNkjPNU7FnSglQXLqpfYF+O/ON/SK
X-Google-Smtp-Source: AGHT+IHirNV8dhsgxR2JvSGmnkIh+1Ct4YXCMozn1CUIlPWZh3N8EYqS2S96FuJZnf+B79k/VIzObA==
X-Received: by 2002:a17:907:608c:b0:b45:e8e2:ade3 with SMTP id a640c23a62f3a-b49c439483amr76122266b.64.1759435369591;
        Thu, 02 Oct 2025 13:02:49 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:49 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 2/5] iio: mpl3115: add separate function for triggered buffer data collection
Date: Thu,  2 Oct 2025 22:02:03 +0200
Message-Id: <20251002200206.59824-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the code responsible for collecting data for the triggered
buffer from the trigger handler into a separate function.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 54 +++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 579da60ef441..1da78081ca7e 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -148,47 +148,53 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
+static int mpl3115_fill_trig_buffer(struct iio_dev *indio_dev, u8 *buffer)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	/*
-	 * 32-bit channel + 16-bit channel + padding + ts
-	 * Note that it is possible for only one of the first 2
-	 * channels to be enabled. If that happens, the first element
-	 * of the buffer may be either 16 or 32-bits.  As such we cannot
-	 * use a simple structure definition to express this data layout.
-	 */
-	u8 buffer[16] __aligned(8) = { };
 	int ret, pos = 0;
 
-	mutex_lock(&data->lock);
 	ret = mpl3115_request(data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		goto done;
-	}
+	if (ret < 0)
+		return ret;
 
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 			MPL3115_OUT_PRESS, 3, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto done;
-		}
+		if (ret < 0)
+			return ret;
 		pos += 4;
 	}
 
 	if (test_bit(1, indio_dev->active_scan_mask)) {
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 			MPL3115_OUT_TEMP, 2, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto done;
-		}
+		if (ret < 0)
+			return ret;
 	}
+
+	return 0;
+}
+
+static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	/*
+	 * 32-bit channel + 16-bit channel + padding + ts
+	 * Note that it is possible for only one of the first 2
+	 * channels to be enabled. If that happens, the first element
+	 * of the buffer may be either 16 or 32-bits.  As such we cannot
+	 * use a simple structure definition to express this data layout.
+	 */
+	u8 buffer[16] __aligned(8) = { };
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = mpl3115_fill_trig_buffer(indio_dev, buffer);
 	mutex_unlock(&data->lock);
+	if (ret)
+		goto done;
 
 	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
-- 
2.25.1


