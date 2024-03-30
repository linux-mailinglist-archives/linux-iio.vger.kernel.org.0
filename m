Return-Path: <linux-iio+bounces-3949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE43892CAD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E79C1C20EA9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65CC3EA8C;
	Sat, 30 Mar 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dea63eox"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD613D0D2
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824843; cv=none; b=izErZUV7dM0jNxR/lXBbcYkhpLiCc9yeU9M0kZzfWplKuYoyNwgKVgek/Pm3wQ8OZQdyCaHzldeSQgVlaiejmWIdlQTU5mgPSR3M4raPlCztRq0qc0TXEUfRsZtEJMdUJgsGsDz002rcFXR1lRTQxrnxBiUWS9VYb+qML6E5XSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824843; c=relaxed/simple;
	bh=bG+TeFde3DyITfgrg0EFAq3aPgezHodRADkhJV7nv3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VezzQaEci+2VXHgl2JG5KwmTIGfgW+NPLrD+UTPGtGbcp5kq94l2uKPDi6C1wWtmHplBeMEh/KZc2rzVRHT19QlZl+LhsvaWsfm60Hf8MSWOr2CwYtQLd1DrOEJhvbx7c8YsNdqZgrWkCGrHFDdsnspTUMmq3kTgvsAQ+/XMx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dea63eox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C62C433F1;
	Sat, 30 Mar 2024 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824843;
	bh=bG+TeFde3DyITfgrg0EFAq3aPgezHodRADkhJV7nv3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dea63eoxYo5tNDPyNC0FXIEzYu0ETvTcYUQLfIt4XtAhTqB4+fZ2/Rozkr3baquyO
	 9XOHkOEYuC2v6dULvKQWuKAN7w5ipLRZsyg1Kmgn8hyPt0GSf9VHj5nuuzDkqX0BUW
	 CHmbh23DqqyLPSYWDVumYPER3u2YDLUbzkW+gDO/l8I+Wofei6Mswh7P4MvReO69ZJ
	 +TSqYbbnxJ0MgTJwG1+Q9UAEAVOI7xaAUttEsdg7+4k1tfHayLpBbIHV3amn/MQKhn
	 Dx0KNecQHpOEAAw3AQPOwDQdoeMPdH0+pjujnEODfqekcGuZpkclRKW6IZU+vK7Eyd
	 EGdsEkJbuXbQA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 8/8] iio: dac: ad5770r: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:53:05 +0000
Message-ID: <20240330185305.1319844-9-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5770r.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index f66d67402e43..c360ebf5297a 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -515,39 +515,32 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 {
 	int ret, tmp[2], min, max;
 	unsigned int num;
-	struct fwnode_handle *child;
 
 	num = device_get_child_node_count(&st->spi->dev);
 	if (num != AD5770R_MAX_CHANNELS)
 		return -EINVAL;
 
-	device_for_each_child_node(&st->spi->dev, child) {
+	device_for_each_child_node_scoped(&st->spi->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &num);
 		if (ret)
-			goto err_child_out;
-		if (num >= AD5770R_MAX_CHANNELS) {
-			ret = -EINVAL;
-			goto err_child_out;
-		}
+			return ret;
+		if (num >= AD5770R_MAX_CHANNELS)
+			return -EINVAL;
 
 		ret = fwnode_property_read_u32_array(child,
 						     "adi,range-microamp",
 						     tmp, 2);
 		if (ret)
-			goto err_child_out;
+			return ret;
 
 		min = tmp[0] / 1000;
 		max = tmp[1] / 1000;
 		ret = ad5770r_store_output_range(st, min, max, num);
 		if (ret)
-			goto err_child_out;
+			return ret;
 	}
 
 	return 0;
-
-err_child_out:
-	fwnode_handle_put(child);
-	return ret;
 }
 
 static int ad5770r_init(struct ad5770r_state *st)
-- 
2.44.0


