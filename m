Return-Path: <linux-iio+bounces-2992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186D8624F8
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E319B1C20F19
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F332C8B;
	Sat, 24 Feb 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaY6ydiz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BD18021
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777968; cv=none; b=Y9BF4Qj891dCuJ4xmCwGzkS7eNvFIa6ldDu4aaERM29YX3KJLHvLYN2XZZYv9nz2QyEn4x9JcdFDLXAI0p+Zwqe5G/kVSVj853d6+JQTybYM0ZNCdCXukQu/cPWEPP36gcE8PFqAUvrda7N5G4X1pth5w3+gkmlXnJ+8ZIX8ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777968; c=relaxed/simple;
	bh=6GckLYsNuC3zH2eXzNl8m+O6ErjjCU39FK09wLysA60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjg20o5YgDMoQROZRteNKjECkaHmK3/fhaReW3CvSzh3iLa+r+maizd/8RIsFxbKCcVr8JuG6SKJUB//G5dy/xh/M5FGv2KBokuTJDrHy0ywLuUb4o7QKvPAKqhvvJ66w+Z6S7b+wOv8JpZk4jEqCynrkJ1xq9kZMlu312/ZVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaY6ydiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A4EC433C7;
	Sat, 24 Feb 2024 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777968;
	bh=6GckLYsNuC3zH2eXzNl8m+O6ErjjCU39FK09wLysA60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaY6ydizNTADS0yVPv9BK8paMTjO1yjvPZ6mdg+FAsS2ul7toHILUnuZphBH4SXyP
	 3MO3uqhbCU43ajciYMinwq7nAiGo7vDR8aaFlrR5QeXjXw1wIdcx6NOoFdPFx02ick
	 GFT5rNZE+KEfrohGg12n9p5DOc2cTkQJPaanmpoXQsA2jxOHoQv79GItCxPmbh414A
	 Ds26lYYALhybK6f+/MGGneAgn9eJmQtxoeNT3iJN3c1oH04bmhsUrYxcso3w4dXxG+
	 ZQY0KzRWuoPqCRYvAhcA+pUVDVN9shemmfR1jUIKbDfg7fOu9F/RLzBEvPIFAOZGMk
	 zDJR3LcJjOmhQ==
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
Subject: [PATCH v5 3/9] iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
Date: Sat, 24 Feb 2024 12:32:09 +0000
Message-ID: <20240224123215.161469-4-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

A slightly less convincing usecase than many as all the failure paths
are wrapped up in a call to a per fwnode_handle utility function.
The complexity in that function is sufficient that it makes sense to
factor it out even if it this new auto cleanup would enable simpler
returns if the code was inline at the call site. Hence I've left it alone.

Cc: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index b6b612d733ff..9b69f40beed8 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -825,7 +825,6 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 	const struct adc5_channels *adc_chan;
 	struct iio_chan_spec *iio_chan;
 	struct adc5_channel_prop prop, *chan_props;
-	struct fwnode_handle *child;
 	unsigned int index = 0;
 	int ret;
 
@@ -849,12 +848,10 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 	if (!adc->data)
 		adc->data = &adc5_data_pmic;
 
-	device_for_each_child_node(adc->dev, child) {
+	device_for_each_child_node_scoped(adc->dev, child) {
 		ret = adc5_get_fw_channel_data(adc, &prop, child, adc->data);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
 		prop.scale_fn_type =
 			adc->data->adc_chans[prop.channel].scale_fn_type;
-- 
2.44.0


