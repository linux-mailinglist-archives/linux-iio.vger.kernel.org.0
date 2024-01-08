Return-Path: <linux-iio+bounces-1499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA78278F3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 21:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534321F23813
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21455793;
	Mon,  8 Jan 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fSgBxzVA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6155C2B
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204a16df055so1809445fac.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jan 2024 12:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704744429; x=1705349229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0ZAlEBjGplq0TA4rGOIY+Fm8QMufuog3/zNcBtCWCI=;
        b=fSgBxzVA4vq96FX+88exQkx5hJryrSG7uFche4O7prAgEzLQHz+GlgM4U+N2iJj2U+
         rMf9pnDqszKcv8dq2s6uWLV9QyjUiwQCyyymOr8bnS7YHmO7U62GPju18wVy5m0ZJbE/
         0uVmKzoHBfKDIhPOJnDEgx7azjsAxAZmqi+5w+IZ+MbCfC/2pvqwa3povvcd/Z5oWykA
         R7dW2Z1VSN3e8fyB15RBZF5OV1GR4ERaoP+znBdChCDSva3npLKENZbw/dXVGQDsnpGa
         p+IoeWP7uVRNiLpWamFivdi3j9rnPD73GUlmteZ6/qEbfJArj+rIYVIH6UO1Q1AFnmr8
         2f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744429; x=1705349229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0ZAlEBjGplq0TA4rGOIY+Fm8QMufuog3/zNcBtCWCI=;
        b=WSpzhzyeeVi4lJ2OmoHQvTkl3ZQWuA+XmTBKvHS5GoRoFoa1erRIiDaIOchq1Zs6XU
         7/nwVjBUJSTfNVxGuqJRAU2rD0FUFnO5x0gMcNfhI4fSKPQX7t8KsmNoSiCyG0H9DwnD
         bcCwuAG5FFGBoCWzhgUUunKMVeENYOLGimsKqvzROnyc8WJ4KCFThcM4J6KpFcPGCk48
         vr395BpU8DQqvqtMNikPgoL49oFEdQ+MCaIIh9WYHM8efgd5H6VyKYECy2rUdfkNgyoH
         MiXNJuWZqu85mRi8jhsEJSw1R4r2GsVXo3riRLgA9qhauwwimZkBb4Lfy1hYV8XGQoR3
         FG0g==
X-Gm-Message-State: AOJu0YxHrNVEM6VHW5fuJ+2PodmsqfoSeMwhjn/zpQ0P2p0NcflG7amy
	Oc6U3MwB005JidFpNH0ZET96QnZDot534Q==
X-Google-Smtp-Source: AGHT+IFRf9wPQBcL+YChPl9qGlJTPQwrSBs87PEmn2B68yZaTNOlcnjG9lNRoF4WnjWBlFf7r1Vf1g==
X-Received: by 2002:a05:6870:ac8f:b0:204:44a9:a342 with SMTP id ns15-20020a056870ac8f00b0020444a9a342mr5712141oab.32.1704744429373;
        Mon, 08 Jan 2024 12:07:09 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id d14-20020a056830138e00b006dc0f1f0b34sm101468otq.18.2024.01.08.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:07:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: use INDIO_ALL_BUFFER_MODES in iio_buffer_enabled()
Date: Mon,  8 Jan 2024 14:06:44 -0600
Message-ID: <20240108200647.3916681-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces use of individual buffer mode flags with
INDIO_ALL_BUFFER_MODES in the iio_buffer_enabled() function.

This simplifies the code and makes it robust in case of the addition of
new buffer modes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..8855d377d710 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -210,9 +210,7 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
-	return iio_dev_opaque->currentmode &
-	       (INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE |
-		INDIO_BUFFER_TRIGGERED);
+	return iio_dev_opaque->currentmode & INDIO_ALL_BUFFER_MODES;
 }
 EXPORT_SYMBOL_GPL(iio_buffer_enabled);
 
-- 
2.43.0


