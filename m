Return-Path: <linux-iio+bounces-14666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C97A20A1A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44243A4DBB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83C1A83EE;
	Tue, 28 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Ug9L4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAF1A3042;
	Tue, 28 Jan 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065700; cv=none; b=R47fldp+qafMm/IPe85VrL/eAbZ54xORzi8TdMEcpad9pvbE1fLtHGZRjuNYIYuVLotdqv+2syrpyVurX2XAN7iPxRSyD+SUoyPArOS1PoyjWn6665MT+HeBGXeJe1D1utksw/vBg7IxjdpRBFXzUhWXPncWFNFHMYOK8yAHgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065700; c=relaxed/simple;
	bh=dBVzk9hpS+UwdX5RwEmeSkQwWEzS04gHxTdHrRzaNPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epk5YmsiTUpfxnfOnDIIfyvJmeC+FRjQu6KVyN80GcY5cP28AN5NnmGeB+zrm3ngVPY4aflQmSaTAYsfGoP2X1sli6Xti7UQ5lchvSZPO+5/XvmncLCf/ujSYrfyWThHFwgSukpX9F1DdLmuZVifZJL5w7tlVKbv96aNGc9nKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0Ug9L4E; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so82411966b.3;
        Tue, 28 Jan 2025 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065696; x=1738670496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXjpe3fdaVYUZIdxmPyTXbc7YGYYpIRM9KhUQttLI4Q=;
        b=e0Ug9L4Es8SOxy5L1VJT/IcpQj6d4Vzmi4IKcGCrdXwZBN01WMVkRjEXr6J0kU1eOh
         7bHtMfdlPckoWOfn4+2Zqtent6GWBFV+ZPCe5IOOSuVDER2lCQkB2joCwsg3AyjUNq55
         O7o5UXknRRF8d5TzTr76P4j6FyjBbVqw9VJzrZXeyxTcm821YqzQzJQubf2EVwCx+iHO
         mslbXIWh0m+YpJdLylbwIECWg/Ytm1U92tE90mLcBWOKlmva4X645BWhqnMtD/HAf9Wd
         E6eJLLJjK6VTJAmp9OFcATvyTSYRtoin7CDMxfdVUm5v6ZFko4bRSg8GZs8AQZt/I6+j
         /5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065696; x=1738670496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXjpe3fdaVYUZIdxmPyTXbc7YGYYpIRM9KhUQttLI4Q=;
        b=dpE6j7r6O+lSEUDlA2uh1cgsWWiKyrpfufDacw0gvLyIk6D4nY2hM74lpILl//kHZP
         jkISiAXVak2+n3yQBM3sI0a/eRkmmygKnYmVbnJpsEbiSJ2Cp+XU1hdesdcKzhgutImn
         4Gkn8BCugkSpZrNarW8fL1WHVfHuQ9bv01VBoLncHPnMHu76yDsYA4vy6KXEQTHGb1/m
         bt6cEzhHeyC3vG7wePJgIXdaXGWGcALNeQiloqrkuaDHn+G+EZpkMPJmpEzrzvLd8YMP
         giXqgg3kF/q9Dv2Lj4O/iZVEWEj78xZVx9l2hvqI0L37N8tyjEUTUP9Yu5eubDn2NMQC
         CKAg==
X-Forwarded-Encrypted: i=1; AJvYcCXKV0AoJcZItSXlvqodMNWtPmFWe3EL948yr6GZ9mi+iTfUrwEZF8cKQkiQ/MT9GS+PR5fQNtrF0OTcUKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuaawak96wlS/Y4IQVb9UXEJ2KmK/mzndBnTLTRTCbAc2dDmZW
	jk7t98CYPHjS2n4KHW+5ZLlSHWEZGfgLUhOFcEzq0t5u1nioD27O
X-Gm-Gg: ASbGncsJ3bRMvebxyL92N1sUO+iJ49PPDbvGLmno/AXgyYgB2cF2AX7y6yI1QjbD5qI
	Mmx0k+Nhhq8kdJs+YijtfeNfPTtbdrLfJ1r6iSwMB4t3KPsgt/gO9mX1kh1Pm7qDhDpPlIjefuj
	cqmlxCaSEaa2S5SZ2qOV17JM6v4nUyFUn424upJDwjcamZcR3R83QY8Yt2i32AA+odce2p9ntsq
	9/EsnQg5SasgWKFf02ODcAnNZXLY0QB6ESbsLVqqCUAevtS1855PeSe/s7sjhPb7+KXMk128/Fi
	2nNVyQ/KeqgKSN57m2Iq1hwCT7qPE7No95wY25IOkNNgOHb16yeQxsgiUBVIzQmqVFB95A==
X-Google-Smtp-Source: AGHT+IEsGujAU1z3cAxFE6HXz7YLuwMRuX3pcGJLWuJuW1BwVE4LJW7difJXbk1tWpgFp1WSBWNyew==
X-Received: by 2002:a17:907:969f:b0:ab3:2719:ca30 with SMTP id a640c23a62f3a-ab38b35c602mr1760114366b.10.1738065694527;
        Tue, 28 Jan 2025 04:01:34 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:34 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 03/12] iio: accel: adxl345: add debug register access
Date: Tue, 28 Jan 2025 12:00:51 +0000
Message-Id: <20250128120100.205523-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to verify the content of the configuration
registers of the sensor in preparation for upcomming feature
implementations.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 142f12117627..8fbf0a43746f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -296,6 +296,16 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -554,6 +564,7 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.debugfs_reg_access = &adxl345_reg_access,
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
-- 
2.39.5


