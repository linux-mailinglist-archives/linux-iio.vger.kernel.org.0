Return-Path: <linux-iio+bounces-2435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B146B850B35
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A261C225D3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE19F5D904;
	Sun, 11 Feb 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WApqwAEY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F633CD2;
	Sun, 11 Feb 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679668; cv=none; b=I7D4kdzzBIafDmZuEASvjkt+SHVyQR6+xuWmhmTTzaGnALCx8SgldV7Ho+IaJTtdz6DSazbWt1bm8ZB8uE6t2aACRZqHbCxHC/CY1kWKlqpa2CXLyIwmM2T/deea2FS9JX0pe1ct3mrOloRHrhE6qFl+6jT61fW/IbdGi40AXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679668; c=relaxed/simple;
	bh=5i+ESD60B1IvKZDplIYAwXVD5VdjSlxZ809eXXhRSAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctkG1kJhd/0+DCBWFw2b9Y8emquO37Rr738VLV7EaF+FGWLZXJh9yMKuv93+3DJCKtOnvO81+FqqpP4wF2BwuWfYpBxlpeYdttLzM+3kEARCo59HxcqvLlOI96F5HnkKHB8YkKSYMohyx8FgNhyODiJylVAdsh+3gOV6/MGNmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WApqwAEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B9FC433C7;
	Sun, 11 Feb 2024 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679668;
	bh=5i+ESD60B1IvKZDplIYAwXVD5VdjSlxZ809eXXhRSAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WApqwAEYnM26DY24LMhRg71rCxYeAZi+dAeSPGc6+WsJlGGFpjTCOy8N9SP0iZgEv
	 LOTunF402eD/YrrpTRRAnV15YbX3Kn4sszV7ImGhb4LzTB794B6BzyBA95poQIczQ5
	 1kN3kqzj/Vj0cot6NIxyqUjUnZYlMSWMPiuOJOcSMXY4x+WG6s6hl3d8FzDtpZJC5w
	 gWyd8vCf7dxKHvWuL0QJpX+3y3hz3RJalR68zLmwESyk+CqRdarGokrkgCJghfk1LH
	 jXGVIC9t49DlSxPISpYfHmB1/bfW0DTKH2LOsY7VsKBz5T4IVP3DIxalET5eIQl9R1
	 aVmS3D3d9kvtw==
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
Subject: [PATCH v2 13/14] iio: dac: ad5770r: Use device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:39 +0000
Message-ID: <20240211192540.340682-14-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
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
2.43.1


