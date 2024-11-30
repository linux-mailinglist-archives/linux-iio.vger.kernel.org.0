Return-Path: <linux-iio+bounces-12841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F559DEDCD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42B6B21DCB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78A5FEED;
	Sat, 30 Nov 2024 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuv6s9mY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34714436E;
	Sat, 30 Nov 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926450; cv=none; b=d9qH1yfQ7kLgcUBoHslTyXnkwAQA5s7WRifuEIKTwiuTwxJcrNvV5w+2QuoiCgaMCRnkKqA2xdMkFrybRnW7+N6P2FYUJfFF/olb3lpU2hHKA/AsPwjN+Rzamea5hCv0MGX1TiFFHB8n6L2iA2Zyyr1/kCr/YoxHmIiVJGig6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926450; c=relaxed/simple;
	bh=tjujbQpCbJPcxDHKJYeSPCo/U5kToNbx8fRpEVEuUnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csJPEnuZtNziE4sTGTth/Tg2s3aWCmm2X7FVB5/pyJlxUAT8KaMo8kBV85nOjoIBw8t/G61KGnQfqutiZ/9kFuurKMnP9o53H3q+FxPvnm9kg9+su4+5hNS9UlgrKUoh6mXdjogNL3/a7qSKOX8Ef0kE8Z5W7K/XlJWzpv1p2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuv6s9mY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38248b810ffso1917371f8f.0;
        Fri, 29 Nov 2024 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926447; x=1733531247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZtWMAM69Cv8U75a6tG/pnUEnTJCw8ZU0QYHAr0vXnY=;
        b=kuv6s9mYSX+EJsElqF8FMbNdpKc3VErOez06WzTZYgXgSrke58NSTxU5YSWJAhgg8A
         Eru8iJyTzGNGC2Dg1b0Mss/W/RP0M8LlvgOq2fjUnZO+PkJkJxIbc94fiEoiGbmy5MVz
         JDUFwxTdw73sO/V7R6ZUXS4cEhHId4kdMRPw9j4vDjjj3Rv2LjdnY00NM2M/IcEyMNlb
         6ZFC/3m/z3NoXo3C+aYN7EYjQDqE2H5VHCJrDGcQQdEoTs/W2+wBQ4W9K/JmJqLzCgwv
         WrygxlKtJnQhY6nsL7CnY+8nv8+ILTbVFbPcWZ+QotsjZHZc5NFmMk02OqDGYeaNPYln
         BGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926447; x=1733531247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZtWMAM69Cv8U75a6tG/pnUEnTJCw8ZU0QYHAr0vXnY=;
        b=LqyD6CSL/8uO2CbtbA2wsVtYos+w0yXFRHb3fYvfQzFT+c/1nanM/2yntS5dI426q3
         SABqTNb77FxpO9KuMwVbkG/VwtPcMs5q2Z8F7ItIEqIgYdHc7u9SMAuOgwbx3wk0q8FX
         RPkEocCuy2U/4pX/9Dq51t01V0J95z0s4o8PKpT9XLGrQqIN6MEjRwGKeveAjgSd+AJt
         oSs3caJjEoDUTxINUCnGXcJNLUmABG0mHFTSRtxzRMi6L8LJUPwk+MIrJz19RZuNLTi6
         7hU0VAgUM1L2nLhPE9QagQH8NOGRu261edX62PjQ765KtMgG5e0gFCEuOCxm4OzyHcsI
         e3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUq7pt6Wz9B0/gr3ROtGsWUSfvqCc7rnliqjdlbgS5090TXzq8Up0frU6ZAGI2WL7wksE8xbnVpk6s=@vger.kernel.org, AJvYcCVm8/YnTH9iiMKDnnvnl74xL0vnpe06fd+MsuZDm8xEBg/NOwn1pIu//ywuxFg8EVNJuFeRRJime0S0Jqlf@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuC3HTvhiuSJmlG1aY4EmnDHa7qMywkoqH1Ftj7fAjFWH/3Wf
	TlwQnRQeO2xKuV4L3s3p9JdpG9VTP68z9JxpXEepaPab0Kv/nDap
X-Gm-Gg: ASbGnctGDOHRMz+2RbvTgydJyVeayXQCDp8HTVbXe2YVXFuU10nxWpgh8eK25fODcte
	/cC5XkJ7PQ1nP6fbbzDXjXveSrnuXMO2scSnXraOt0wYVUAGGTx78+SxYCtM9IIL3T/AV6OUfPZ
	jO/LBXx4tdfB/GriRscRe3J3t3thhy7J4ftUcRb8Xqu6r97IGmZihAZQ9YkljpotsmZNJPvUdmW
	SNFoEhJ0u/6dxeOMKBRbxaYpvgNzNxwrEgjJqH6/IlJ38IjNwuPgM+kOm+STA==
X-Google-Smtp-Source: AGHT+IFWIDJxjusB8DewTXn48qqKRrlMIdOt0Q36io7WT1cPyKupKKrWJQ3GDNb+7/4avEv+e36I0A==
X-Received: by 2002:a05:6000:20c8:b0:382:3d04:964b with SMTP id ffacd0b85a97d-385c6ee26b1mr8079340f8f.57.1732926446969;
        Fri, 29 Nov 2024 16:27:26 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:25 -0800 (PST)
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
Subject: [PATCH RFC 2/6] iio: make use of iio_is_soft_ts_enabled()
Date: Sat, 30 Nov 2024 01:27:06 +0100
Message-ID: <20241130002710.18615-3-vassilisamir@gmail.com>
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

Use the iio_is_soft_ts_enabled() accessor to access the value of the
scan_timestamp. This way, it can be marked as __private when there
are no direct accessors of it.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 include/linux/iio/buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..3d82b110a8b9 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -37,7 +37,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
 static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	void *data, int64_t timestamp)
 {
-	if (indio_dev->scan_timestamp) {
+	if (iio_is_soft_ts_enabled(indio_dev)) {
 		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
 		((int64_t *)data)[ts_offset] = timestamp;
 	}
-- 
2.43.0


