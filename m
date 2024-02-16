Return-Path: <linux-iio+bounces-2671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA78584A3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4C81C21EAF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED2133401;
	Fri, 16 Feb 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpQ894DB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3791332A7;
	Fri, 16 Feb 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106044; cv=none; b=hCt8XBvmk4sxvEPNWBCiCRShf7qP5zNyAy4jkxe9lrc4lyPYDasESKy723cnGJN59NWq/VxJuET8Mov8MWBCboZTWsdXeEQVrcuudCtbrnQvhNGL4dWo+U3QhKkvtAjYPMVjJcBmSvJQIrn6Uy13y7ob7bSWaLPKck01mYAcjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106044; c=relaxed/simple;
	bh=35QYOXLq4zAytbJTMQEpTX7uMMdXMhvlvDV0Wbcyp70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8ugUr/8APjhkCxL78vo+e5T0tXmnvj+RzKC+/+cjMbHwqbrKd2xdrXU9ff7Z+y028VCZ/2x1oDKGC25A/ajrDHoV8FkcemTrQQdgOWUp+r4swJ2iZjszOhCE3g177FTwfHOCZdUn7B4LeC8t09J5EEjAgw0Ych+zfluRYJp8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpQ894DB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FDEC43390;
	Fri, 16 Feb 2024 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106044;
	bh=35QYOXLq4zAytbJTMQEpTX7uMMdXMhvlvDV0Wbcyp70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpQ894DBsCMf1HDHgK5xNKJBsFAMRZOJOBNORGN8qFG/ubPmHA0yd+zZIEhrzF/HQ
	 o3R6FhDwPsI11fc+fiFkmRs5saZ0nsZNCpPxhjKYbJTrSYIA1eRJgh7AKzqkXVO8zY
	 Wklq18PgYNkBofJZERy9sHbz2Lv94Y2PHp2b40nV3rAcs64bxDFcRZ5E5ukXNplUYv
	 YcCiPylOMuM45uzv9Z4SNNANsUYWjNo9V6pyXaaLhIEWWt7vDAln0j0Mbw0ya0lw6j
	 r0ic3dbd+pCMl++zmiBco2wog1T8MzVvbyoDFQLGtoTzU1GV09JhkUhJdOHroQJDOX
	 +os8eRz2mFptg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 14/15] iio: dac: ad5770r: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:20 +0000
Message-ID: <20240216175221.900565-15-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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
2.43.2


