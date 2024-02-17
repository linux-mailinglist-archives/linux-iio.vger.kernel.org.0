Return-Path: <linux-iio+bounces-2707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAB859113
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999441F21E93
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683977D3E7;
	Sat, 17 Feb 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn7z+Gsm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F597CF3F;
	Sat, 17 Feb 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188228; cv=none; b=f/Q22ys9utaXm5VbqDntNFxog/M/m+ymS5O/4LeGtLqmfEDboqSeXDN1cGuJYkJVL1GTf3qicv13uccyj7xRzljF7+qlgkJJ5ePnRmiXbGptqDF5Bte2iBAEXSvOBsmB3oeWovbCN7RYm6Wiq2taMrGkXk05jJXORcydZooXX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188228; c=relaxed/simple;
	bh=2mqddr2vk1tIUyCyEYFgQRTgvjJnligNLqFwI5ekcbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNtZ3pAQ+rXUAwDM8mU5SLCc2CEzCnZsAJrkwtDndI5N3XxhH1slgPsPleKG9uN+5dRFgmE0EUlz2qTXUx2JROirK6t0d9yoqB1sGnwjQWFSnNg8lFAH3kIQ3PQylq4l3c2tBY4+kKEBLVf0qTJbLNQS/upmJerjgJTdx7EAXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn7z+Gsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77295C43390;
	Sat, 17 Feb 2024 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188228;
	bh=2mqddr2vk1tIUyCyEYFgQRTgvjJnligNLqFwI5ekcbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn7z+Gsm26wo1s4HpGolYGv8RCewXgYaxaMT7EGxngx3lm7UfGI0XuqS7SNrYpSBO
	 9p7jKMWuU2HCuILA2V+9/YNkSZFqhdC6zZnVwaUOK6ebLafFiRqDLVsWc7+ufAVUjk
	 Nb/PfduUU2jpBF70DDr5ilPZiPxWc+WrpbFOHUN8Sk8CwLSKhaJ1NoMbiIsT2dMLB8
	 wOnWGSM4+rfTY6WIlrzYDPZAsyvXxixu5ERccC10YRO5wub/ZTEho1GyT1We5Ihxhd
	 glldlNEVV5Pl4SVlE1/moFmMy/vpcSmbG2orFX2d6vRu4YWWMN/ExpBzo5+7Q6gKNg
	 ucM8dXZYozp8Q==
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
Subject: [PATCH v4 07/15] iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:41 +0000
Message-ID: <20240217164249.921878-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
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
2.43.2


