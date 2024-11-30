Return-Path: <linux-iio+bounces-12845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98689DEDD5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD88162C51
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD413C695;
	Sat, 30 Nov 2024 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhHkhm1/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713E139579;
	Sat, 30 Nov 2024 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926458; cv=none; b=FdS8uFlY3W4TbH2+W80100JdiBS6Dzx8j5Wr9+LoI6yRjyM08FLV2vX6lUZcEPcYwWzg40liMsh51XamUfATRonG4TOpBZgKTff8WFSkUg/n2z2v7wxKnOb6V9MQK6xgxVt2VkicYuwhRBfsfoAgCPep93yl2FuqMHilYEsY6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926458; c=relaxed/simple;
	bh=z0HMc5U1PTtA2Nr14+pdfS1vr/bqIZLGz5vkPjd7Sjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5ZQoptYWBvsbZKu08eUUC3P9jCtn6aRKnNlapN6DHzrql0EY4xS4A58Xfjx0N3zrxC4XJGO9Q2mEeBxNb7Zdn9UdFrhNzg7HHX5ZvZZ16X9ac3aFJjsn3lPdxVn5G0k7aUZpSujNK9DMuh8iFdjFtVqzMUa/fnE7CbDuJLBxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhHkhm1/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e1f12c82so394323f8f.2;
        Fri, 29 Nov 2024 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926455; x=1733531255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFnwIg1SlNfk7YCu4Dnn+679o1iR81Pc1C9n26emMmQ=;
        b=MhHkhm1/eHSBtSAe/A3As4SHqbKSRNUaFfMd2Fi0WTnVYrerSN1axYl5V3IkzFgNpe
         foBzryf+jWi4KZJ7YJmiEomi3KUvOR0i7hW/fBzP0O5mD73M+Nk+pf9WNZ+Ix5+tCYA4
         ALW33Npf8n96LoND4oVH7fUkO4xeVNMZkmS02wiLfa674MziKzg+gfUg4HaupcrE0spT
         yIxY2+L/c13Ks38emHQfggYLYaerSsheBkxAUgXOJFWCZZetZOUoix1O2zNwD/no3g3y
         wpwS3di0OFcIqNeBwMnSrrx0Hr4V7E/p2XLCrus35NvqPmKuO444ZmZn34eeoshrYDl0
         Y+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926455; x=1733531255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFnwIg1SlNfk7YCu4Dnn+679o1iR81Pc1C9n26emMmQ=;
        b=jGdlr8p1vE25Da6WPYd049OvkuMcDDIG4SPZGjLj2E7h0HiLjjFFSPzoNJuwlUFA8v
         hxisiCCCE3TsTdNP6Yw4bCQANtgaSR9jKu8Z+2iyFH++awEmgNh9ZY4mFx0cm85OgjiT
         XuwrOOLlIagmOsNlMgHHgAkmbvgi6lCzz4tO5RppBbC3jKlxdHkiwavhrVQAyvoPpoRl
         xp/IPqX+FbhWNsTs7RTmksIgsXxG7Q6q7G3I5nbaKtKIojHRoh8aL1fBiiLMQRP7ssmo
         CfFh4xE3N7NQxX1/800np6UK9BMUzIX7ntVpMspGrpNxMynLVq0gzkrFtAgunoWOGzzW
         wvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQI7keuRZbwMn73pdrONHd1OWUEU/D1aIL/p4vzINoxyd6RtEM0m1scxzFUfRoAJkRM+yupLoCb0I=@vger.kernel.org, AJvYcCUxZyGlw++3CpP+FuuqIxl8QFX9tYa//KkC5r/Qo3ik81yKSQGmS1zaPWniHGwr/hQivtWv0gIIoDz0bKiB@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKB4fQ+GfIDhYvsVplLx9vbrA5wfhaTIM2FEfC0mgBbjwhNot
	9Z36I+PeSt6hBuDbXiKLg7VHm/tUjPLO/uR+HMIbdAvDPuP3DPHjwhpLeJt5
X-Gm-Gg: ASbGnctCsze2uo2UaEfYPZfgMNOa0Bg9HxkfutpCi5mwPjNQXzcTtOY8sCYU7QTesbR
	vXCeqZPSZmwB7p4UU6HLh0xQsQaFZs1xBGhorrOgMOEmoG+n0mkzD6S21Vif1YrHVgZrK36G0+P
	wIMs4ttpFy5fH6IFz0CSd62vx8ieJh6/JMVxxugcnTw+wOVNv/1+nnaY8Icl4S9XGiC4Lyomif8
	NkuTPF4j1C9B9Ehpb+NFYmCjmtzEyajNaQQl+jgtWvz73qtR0gGClRPLbK9eA==
X-Google-Smtp-Source: AGHT+IHQWr+IrxUNAk7zs1/xyAUn/MmlBN/UG2b3dr0rFp6iNWLgDNFXIcOKOxYIaKs4jXlkU/8F4g==
X-Received: by 2002:a5d:59ac:0:b0:382:450c:25e9 with SMTP id ffacd0b85a97d-385c6ebb925mr15211897f8f.35.1732926454963;
        Fri, 29 Nov 2024 16:27:34 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:34 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH RFC 6/6] iio: core: mark scan_timestamp as __private
Date: Sat, 30 Nov 2024 01:27:10 +0100
Message-ID: <20241130002710.18615-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241130002710.18615-1-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are no more direct accesses to the indio_dev->scan_timestamp
value, it can be marked as __private and use the macro ACCESS_PRIVATE()
in order to access it. Like this, static checkers will be able to inform
in case someone tries to either write to the value, or read its value
directly.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 include/linux/iio/iio.h           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 8104696cd475..c332741f3cf4 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1137,7 +1137,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	int ret;
 
 	indio_dev->active_scan_mask = config->scan_mask;
-	indio_dev->scan_timestamp = config->scan_timestamp;
+	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
 	iio_dev_opaque->currentmode = config->mode;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 5661794d1127..669b4ef1280d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -611,7 +611,7 @@ struct iio_dev {
 	const unsigned long		*available_scan_masks;
 	unsigned int			__private masklength;
 	const unsigned long		*active_scan_mask;
-	bool				scan_timestamp;
+	bool				__private scan_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
@@ -908,7 +908,7 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
  */
 static inline bool iio_is_soft_ts_enabled(const struct iio_dev *indio_dev)
 {
-	return indio_dev->scan_timestamp;
+	return ACCESS_PRIVATE(indio_dev, scan_timestamp);
 }
 
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
-- 
2.43.0


