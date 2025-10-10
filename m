Return-Path: <linux-iio+bounces-24927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E6BCE51E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E57C4FA3C2
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511E3016E0;
	Fri, 10 Oct 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FiZAYKdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF151DFD8F;
	Fri, 10 Oct 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122737; cv=none; b=nUPBGgwtziGZ0LSUqWq5BJTLh1x0amJlcWbztfjE8JauOe2l6bpfezCUqa28skKIMeQdvnqa+GOZgquzaGmw7Wht8R8rRhs/6nr8IBnnfrbl7C/u++DvedaRO4Ru8WWNSkzVEHibzM4tEpDh+hxPIxreENLQIC1h+Xw5lFQpPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122737; c=relaxed/simple;
	bh=Q/9X8eDjLNsGnCFUP0D1zZBftDpTDm4iPEUON+dm/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtCuRLM/k5rmCHF3xfWMA7SeCdatRwPkB2H63b9PKWuLwVwR7KZydj5eF0t7iy3SL0DxFe1rHiLWXuWUDAMu7F0rr2gpRn6tD5l9HG1nyVU3IOZy2kjkUSWkI8jxaKIIs8TtX+kGYTFJ9xiHYnmjBRi/2bdROfEb/+jE/m2y5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FiZAYKdK; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 7IKJvBbLKn3LW7IKJvlKz9; Fri, 10 Oct 2025 20:58:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760122733;
	bh=NAjcAUUGbCXwbNJ/vJc6N1P0xBbcp7/30iqfViOPjj0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FiZAYKdKCbSCjlulrQedrfPPd/caNT13ihSSJ7oWNiY3nCBauRbDpIDElP+fndOgq
	 L5hM+HN4phtas3A4pyBxFwDnlQEo6umpvRdMF7ND7EypLYwFGZnXcAOykmBwhG26Wc
	 ZgxJYXXuaqNHFB1rOh50Qkw4TohaAm5/HnLjItq5Z7ovi0ax3Vj453DcadxRTKSi2M
	 NyYOu/94FVdjEYUCFvQUkWhWdGh6n+WZjDsvM60niy0koS69SDThCfIatPmlUWeiSZ
	 6i/vLEBuIVMqHIhRUf+XzqDye8IoPJ9Vt2hYB/f7E+umG7eLRIhIUWcQ1IRTPr9/b2
	 V7v3enLO+HWHg==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 10 Oct 2025 20:58:53 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <k.wrona@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio:common:ssp_sensors: Fix an error handling path ssp_probe()
Date: Fri, 10 Oct 2025 20:58:48 +0200
Message-ID: <6fdd39e3763a6e0e700982ac6ed63a5748a4ce67.1760122717.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful mfd_add_devices() call, it should be
undone by a corresponding mfd_remove_devices() call, as already done in the
remove function.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1e167dc673ca..da09c9f3ceb6 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to setup spi\n");
-		return ret;
+		goto err_setup_spi;
 	}
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
@@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
 err_setup_irq:
 	mutex_destroy(&data->pending_lock);
 	mutex_destroy(&data->comm_lock);
+err_setup_spi:
+	mfd_remove_devices(&spi->dev);
 
 	dev_err(&spi->dev, "Probe failed!\n");
 
-- 
2.51.0


