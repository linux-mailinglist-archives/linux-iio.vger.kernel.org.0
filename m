Return-Path: <linux-iio+bounces-12840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 571109DEDCB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 01:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EA1B21F57
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB639FCE;
	Sat, 30 Nov 2024 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4oDmp7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB417BD3;
	Sat, 30 Nov 2024 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926448; cv=none; b=RTbAmIuxx6njKnyGjY8ILAVL/9Tlo6WoMjBd9qjC+iEzgW6cttte7kDPck2A8IITbxu3YkKWYbb/lJN22HnSVfK9LB8aSs/hkmM94fZ5WUw4W7ddGl272Is8PMMUaz3b6IHv5TvSqsdebTd/Wz0BsEil9hyKXsxtoA5MhXkGMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926448; c=relaxed/simple;
	bh=XiVGJVTbEUb40AQjcPLkdyA2iAGvpAfEWBgeZJmdZPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI2JhhaslEuZjJ6RPm8+ZwySG/HWE/g2oWXa68NjczSaCuhtzjzK3YWauyPHmtSdKW/Zg+cVMQp+gWNtNm4pFjVH/2uB7lFpeIu8unOtHjkbHGoTDrQSwIaGaD2zhwNp03jFY1CQ3Y05osM2PFv+2wrIsaV5HERcTjLflDiF2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4oDmp7E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so238946f8f.2;
        Fri, 29 Nov 2024 16:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732926445; x=1733531245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BuxdRBifStPjxxiawLv0rBImUatNjkAWFJkyPMMHhw=;
        b=m4oDmp7E7bK6Rfz6n+LGj3DdJo3Oi3rk0hIfdPRmAQHgxoKoJdOlP6Z0LZxMhuevcr
         z2GwGOKejgbNSzjppJRg98/0L7gWWdcZ5pY5JrjP2moKun3NfvWtI3jenUCjSnZk0oBC
         m5Nzk31ISEa7MXG6P/wOCnSlw6ZaXYjgdTWBdFuvOg7XOlPgdPku+MPUnVL1pcNQ1yAb
         8iPgH65OaoIbBJq9bX70mYcQ+P9xntrjHVJKJAUUBFUE37CBITXTSv9AVSqS1c0WaLcy
         sz6L5pd0IkyswwK7VtiVcQT7nswYx4Bm/6vlrjI1t0kNKeoo4eHEhrqNVZIFPpm27JoT
         OQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926445; x=1733531245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BuxdRBifStPjxxiawLv0rBImUatNjkAWFJkyPMMHhw=;
        b=oMxFijn565agmoYBDYcyNoZamzZz4OHTYRYC19IRCpoaVwygCc3Lxd5eafna2LTm7A
         dA72fsN/hnglho21CBIIpXfwJCBH3cSgr0hwfuLRUmUHZKtDFB16vAaPgT3NTwyww3fi
         hPcP4m7DDUhnECwJXIDQ0kxBWXimXyGbwfLqgBGxR/tSVWyOBEDNGd4CRbB6BtTNBZ4M
         3RUcTul0/akL60NI5LB9kTpbkkGDkfs9tqIeE1DvgKrh+EgVEi0b946xqDsyJWxWWwpL
         X8L0vk4fEZQ1UfD3sL1tXePr6VnzgR4ftrMgIJ/5H+sv3nIHqszYaFjpuRG0AZumRNej
         MC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw6fwth3vMVaCEGoMB2cpc1PvkrChBb4bAalKPzHhQgDwi+XcKm2oS4c2zolOzntnlt5eKj+Qfsc1enYUJ@vger.kernel.org, AJvYcCVRpHgOG0+a73a5SAbJopVk77tXmBzsGMWIZC5+O8x8hrRM8r6FQzZrYxhEBCk5jo/Deau3LaV3ZYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYNRj0yvtjEouTyQqsqqqY0V6l8JeXfRlN2/7ERNWI63VuDJb
	x/yhWXj7HaTG69RzItES8i01vpNfUyLV1i3UrwePg1W/shyrbian
X-Gm-Gg: ASbGnctTaM+xsClFz9tpXv/KEPOve4t4DPuuTXewI2R83Q4NWIUXdQtKioX2uytOUIo
	YuJuj1AWgIB34pI1odmMkHtUn+ECCl2OzABOo/So3KIlWAmNA+SE4IFePFKeUncIyPmpKR/Zopo
	PedDil9j3ROyQEUDecK8LjEeanboI6H531fJIJUU2c/rpEYSFSVOFu8Cy/LZ29uPb7y7ugH5DSz
	GW86ytqXvjKFa6R/1oTkFW5N98+0W8A4SMJhca+ryIqzzfqSmaN/yjE+qrvMA==
X-Google-Smtp-Source: AGHT+IEs+5VvLSlKe0whACEqkhTWDMbXqlWWWZ7XNd+k2564ZKw0tU4PVAWWdqNVX9MmQ3cJHgbYMw==
X-Received: by 2002:a05:6000:144c:b0:385:e303:8dc6 with SMTP id ffacd0b85a97d-385e3038ec8mr728270f8f.26.1732926444669;
        Fri, 29 Nov 2024 16:27:24 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd2db43sm5873345f8f.7.2024.11.29.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 16:27:23 -0800 (PST)
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
Subject: [PATCH RFC 1/6] iio: create accessor for iio_dev->scan_timestamp
Date: Sat, 30 Nov 2024 01:27:05 +0100
Message-ID: <20241130002710.18615-2-vassilisamir@gmail.com>
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

"scan_timestamp" is supposed to be an internal member of the iio device
structure. However, there are some drivers that are using it directly.

For that reason, the following accessor is created:

	iio_is_soft_ts_enabled()

The goal of this accessor, is to ultimately mark "scan_timestamp" as
a __private member of the struct iio_dev.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 include/linux/iio/iio.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ae65890d4567..5661794d1127 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -902,6 +902,15 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
 	for_each_set_bit((chan), (indio_dev)->active_scan_mask, \
 			 iio_get_masklength(indio_dev))
 
+/**
+ * iio_is_soft_ts_enabled - Check if the software timestamp is enabled
+ * @indio_dev: the IIO device
+ */
+static inline bool iio_is_soft_ts_enabled(const struct iio_dev *indio_dev)
+{
+	return indio_dev->scan_timestamp;
+}
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
2.43.0


