Return-Path: <linux-iio+bounces-2714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23122859121
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF80F1F21E72
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624377D3FE;
	Sat, 17 Feb 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHr0COqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F57D3E6;
	Sat, 17 Feb 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188270; cv=none; b=qWW+6j0qvtdE9ByabmXNGRjOqLwBLyd55Lh0srH7WgPdq6aOyUODZnsYYHqTObIaPCIHsN/q+dDjzQ9jT0j+/tjQq1+iDP5ROzXQy+gg8gTIlugZOFdH/Vo73RvpqchRQUW/3+AqUeENUyeBjvdflhpXgaLBeCyQ1QpI9Jjf4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188270; c=relaxed/simple;
	bh=35QYOXLq4zAytbJTMQEpTX7uMMdXMhvlvDV0Wbcyp70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4ggNH1myAhkFpaS7rB4ZPaWwYD2z0CjULhmZ6mBJZg6myfkJIeTfqwjn7xocwbeVQe1ewrRvPuymaGYjXAdDL09IsiguETPHdsXIdkXTbxmrcwiV9sXkKf38QUlUuLsZ7KnhsnDQ8OEt814oLReaAzuMoRiH5aleD8YBMrudt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHr0COqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C158C433C7;
	Sat, 17 Feb 2024 16:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188269;
	bh=35QYOXLq4zAytbJTMQEpTX7uMMdXMhvlvDV0Wbcyp70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHr0COqgDkW/q5zxC2BrNG1FpCAovCsy1jBkU/FiZnXcJ5THp1Z/cVWvbU5BvWYYI
	 ME4o98hmsNy884IUh0ihFLVqMXHauOeumaDJQiHSVgIzvGW9sDQnQi/W95Wru8ENvz
	 /UKqm5QGmI+nXgU0Ck1V8bTc/PDespxCBGSgWwFgIwdinOeB6UpfsSKHNc6qqT0aP4
	 2LaJlPAI5ReVAKYXjZ6nwHJ49PumRnKO7FMBGnWs41GWdZXju9axKCJejB+QT2ZU0f
	 kPAcPUwjnRd32DzEPECLbSACIexARkIrRClo3wVyrq2MTwdjsaNfunmKSBE5eX2Wtc
	 oUlMOrejgcTJw==
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
Subject: [PATCH v4 14/15] iio: dac: ad5770r: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:48 +0000
Message-ID: <20240217164249.921878-15-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
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


