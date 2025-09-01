Return-Path: <linux-iio+bounces-23612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C7B3EED1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBBA1A853AC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E9C32A811;
	Mon,  1 Sep 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="eXhQ/AvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9526CE05;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756086; cv=none; b=E1pHC14Lh8L4ANODoTNwoiwZ+Fjeuaal517FBFwd/5RptLc3aGrhxwC5v9nYUtKuUPm9ZnEJ87NMwpgcgmSmmBgrkWPK6CSdjk+H01jqVIE1SBd4X0KzVl46DPxiHgwRC5mQTooMNF3whPMX6z4IcwtJXoG6m4dM8iCRYrA6Mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756086; c=relaxed/simple;
	bh=cF3EvrApDf/cPk/HLyqyyg0xZlk+DVt3hkQn2VTPGa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBd1v/7fyKf6zDRSxfOU2koyjRFiCQ+IjXjh3eVrma8hZ2RyHVYop2f9E0Oh0g4ODsAO1qQNAObREWS45Aio5IiWbofDCWybDyCW6SOURv4z16Cb+iyf3gqw/WHs+PZe9/4jT+9FaR2b5S8a8U8yc98ouRwg/NoepRFhXkVorvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=eXhQ/AvZ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id E39E8173BEF;
	Mon, 01 Sep 2025 22:47:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ij4A38b6zGkOy+qUs09MDVVi9NjmgAjHdfoHDOqfCg=;
	b=eXhQ/AvZ6C8807FuuNscwNKQYTB+BVOVqQd/LxCmk6ASKDkDb+3rFLRT948d3EtuwMRG3k
	ZDdUYPLSerCvcvpVVn+gZcYtB452J1m1YbmYZ89p+l2XwNug+Ht6ukGM5MbLhCPKe5fyRl
	PWWOYWCSoeVVVxRbkk716ucUFGUhfIjkY+q4FRYucegEQj8aTQBktqsqSfZoR6JjJankbt
	ak8zhK1zg+MlrThdVLd5p7RPooqhSFN9eQARKvOytoAdjxFu2TseT7R35/DjcNT9jpOm1L
	Uo76f3KWe4r9tl9qHeHq8w+zoEdgHZZTVfxiMnYtTXmoPMnmJwJo/PnYbpruRQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 07/10] iio: accel: BMA220 add debugfs reg access
Date: Mon,  1 Sep 2025 22:47:33 +0300
Message-ID: <20250901194742.11599-8-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow read/write access to sensor registers for use in unit-tests.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index e60acd62cf96..41889cdcef76 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -433,10 +433,21 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }

+static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.debugfs_reg_access	= &bma220_reg_access,
 };

 static int bma220_reset(struct bma220_data *data, bool up)
--
2.49.1


