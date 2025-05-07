Return-Path: <linux-iio+bounces-19249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9BDAAE852
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF45521418
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F991EA7DD;
	Wed,  7 May 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA6uMXic"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16881EBFE3
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640855; cv=none; b=NrNh31szhA/dFsKPkprb0rkjCpIFM73sucAs337E+iTbgLhaHBkip8qNqRWEAVBf5/wgneZ24zVB5v++Skv38korPLr19Rj24JZDHEEm+grClODx3WWSNMZyACC7fZHFbXlK4wmsvwxyUQTQNrFRxdht/KNQGEXY1AY+DKU65ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640855; c=relaxed/simple;
	bh=LrPeY4iWoJ/G9LcXZN0VHoCDVuXwRa6qAUlI4HkkgCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lf2reQnD/anhtA5o3nU+RG0RXxldmiK9rYXRoHKxiIZj7ACAWIQHJceAzfCr9PeM5WML/pV4bt/jL15tIoY5dq5/XJUeBrid2zY97UVIHdw9F8qM2ghmJLfLAl4Zh4gIlgST1jO3KSPsTXI7CB4sbOLLIlVAPaD5bPVpzchqDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA6uMXic; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6064207317eso121934eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746640853; x=1747245653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqMB5eINxTkjm5fdfjOe7QohJQbGHMbiLuz5DU4W2Zk=;
        b=ZA6uMXiclGScV4ZiLnWcn1jBCLZQOzFUbaeW2nA9/XQ1mXHDuqQ8/LUOI0+rYHQ6Pj
         xcv+2VldFC7IB5XCGuyNkfTkDVYYb9QzgGpDZtXOCnFxaMMbZvUQyT7v94K5BJcU/sAq
         SN7qZ4/vYm7qR+6QxKCYMy+63xtMv0/9OK2pEDTQPFE9zertTxnN5+/ONGmbPesaZlWM
         chh3elbsCKknn0+UyZNPsC4CQkyS7vM6Vqex+fH6q4fQYU5ca4zLS5e7y1dM3vzckGKv
         yj80VVJdEX+j3t2KjWqY10a5w7iiEtQdaMBtGG+HZTQ/9waEv/P1ky0rh+zccr3nrC4Y
         l+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640853; x=1747245653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqMB5eINxTkjm5fdfjOe7QohJQbGHMbiLuz5DU4W2Zk=;
        b=U6JMIwMnXQqtgzwl5pEOY/0CUUNRGpu1BHuP0CxaFpZxaPQbpN+6ouadQyG4oPDC2l
         S5IDxEix38vn6THMfSkBF/CEhhEvZvb3KcnXkKtOWtjD3MMlXahX0joCuw/PdqBpgl0I
         KpstHaV1ZoXZaLJkR/QNXzf2V5mufSTO+Ebn8Cfv0taH5ragGRRWKqYRl4jDEa2rnWZX
         UNpHUrS//ZLeT/kx/Zon9fT0Eein7RTxPuxLcHv9xUDIL51gll//OoByGzrRzK1/eqi/
         eO6RRVSyfEluOt8R550472Mn1+e7fdWZfdk/eKFitsu019RxTQh+kRv4MjAuDxjLptpf
         2L4w==
X-Forwarded-Encrypted: i=1; AJvYcCWuNuYMSnzaGHvdLjybGSmIsMs0hpbmV6gjhWwb+0GMiyPXCdH8/V58dHyG72toGXxkHOjrH96t6HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mHZLco8w90F8YeACp2FyzwK29jmMq7PcbPOFrlKeLDGhd7hX
	rBe87I2L2XhV+bF1bSy6TEU8sDxiA7GQianDf/WMfsXmLG2L6kyd
X-Gm-Gg: ASbGnctCzB/pRZzXedGAjy/gbSO1sIa9EaRkwHd1Gg3Dv0+jdsBJJHjWMtuYTHNqyFt
	GVp2/zphjk83vajMacOTTBNlkLOsuwHUTItrwIFBfnWiqoHLafx+bLNnTdiB3ZGstt93uCk16qK
	evsv3HW2ORNQZ6IWxgpDkwcoonMy3Cos3Mt4eJ5oJG/HfchSgo6CJ50IM1FUVKtrpco4KD91eGJ
	JdKoY4FjWoos1/21XOm8GbfJn329bZOjzy2wenNQcPabhVw36V6qqFEDLdPNurr9YexycMWN9su
	8z1gelfUUrMn2zzXVEEaPkpSXzbRSmJEu9LVBteWA7xFRDacDJpMXRE=
X-Google-Smtp-Source: AGHT+IEHwjaV3s+3LsKxQ9YDGUhCqs5kca11s4W4i57w8HyqRASZ4OqCbNgUdwdWCnqmvrwP0JROmw==
X-Received: by 2002:a05:6820:4b0d:b0:607:ae77:59ee with SMTP id 006d021491bc7-608338ce587mr271721eaf.2.1746640852656;
        Wed, 07 May 2025 11:00:52 -0700 (PDT)
Received: from octavuiPC.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fb6fbbsm2908544eaf.32.2025.05.07.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 11:00:51 -0700 (PDT)
From: =?UTF-8?q?Oct=C3=A1vio=20Carneiro?= <ocarneiro1@gmail.com>
To: marcelo.schmitt@analog.com,
	linux-iio@vger.kernel.org
Cc: ocarneiro1@gmail.com,
	fernandolimabusiness@gmail.com,
	eijiuchyama@usp.br
Subject: [PATCH] iio: adc: ad4000: Add iio_device_claim_direct() to protect buffered captures
Date: Wed,  7 May 2025 15:00:46 -0300
Message-Id: <20250507180046.8515-1-ocarneiro1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add iio_device_claim_direct() to protect buffered captures. In
ad4000_write_raw_get_fmt, data reads are protected by the
function call to avoid possible errors caused by concurrent
access.

Signed-off-by: Fernando Lima <fernandolimabusiness@gmail.com>
Co-developed-by: Octávio Carneiro <ocarneiro1@gmail.com>
Signed-off-by: Octávio Carneiro <ocarneiro1@gmail.com>
Co-developed-by: Lucas Eiji <eijiuchyama@usp.br>
Signed-off-by: Lucas Eiji <eijiuchyama@usp.br>
---
 drivers/iio/adc/ad4000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 4fe8dee48..55ceee6e9 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -583,6 +583,9 @@ static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		iio_device_release_direct(indio_dev);
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return IIO_VAL_INT_PLUS_MICRO;
-- 
2.34.1


