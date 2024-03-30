Return-Path: <linux-iio+bounces-3943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEA892CA7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D62F1C212A1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB5374C3;
	Sat, 30 Mar 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcr2f2kF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189372E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824811; cv=none; b=YxmNF+krvXbiyVNVE35pYYgCU4MHDbAWc1CSk6xsfYLlO5wgK7G/BapLwFHdFA5BzFO9kWOvUnpRzL5Rue9AGvU39OiQK1jMzNE63Qlzs99b9yGbosN5qGSHHJJ1X+1OXNAgC3C80DXIzUUmN4unMG8AHxt+zdj/yQCA2UuYhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824811; c=relaxed/simple;
	bh=6GckLYsNuC3zH2eXzNl8m+O6ErjjCU39FK09wLysA60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0xd1jmROWwMhfagkXOJ+ps/EdEBTFo5Yc4yJAMeQk0IjBSZkiorOyYpWVJkGtJPtbFvcvasasGM0pCVtOIBe5junv/eadmCj9qaNZeOEliVI+UvnCT/Zf0QYqMBecrGhg5rOzqYfODBG16zz3LXGJ7dWUYwF/9fD3BMrwlSeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcr2f2kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA70EC433C7;
	Sat, 30 Mar 2024 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824810;
	bh=6GckLYsNuC3zH2eXzNl8m+O6ErjjCU39FK09wLysA60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcr2f2kF52THMLloiyJj4FzmpfmsPfEKfMzrgDXGtBxIlLQXsCfYIIspKBLH+bn++
	 CqFxPusnD9Ax1KrS6gf7sXlcX78gWzQhwIjCZjpOzP6MlDYJH4UqqFdATiEK/Po0zs
	 3WGJB+H6K7bZzyTxB05zM4SZhX8uUxlJkzWXxzlCHSPlFNN87kgdlKT2tZzLbkxKfP
	 bueXiFtVBq+nPqhRgpadNLgZVodc3guoePARQMMbdzYb8//QYXJwR74Y0RxPAISrus
	 MLCVQK4dBcH+wq2W4d2xPqzmm3QRYKGbMMr6DSH5eWTZxtvO4G9DMNdBvVhX0oTc63
	 oo5URrnozD7lQ==
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
Subject: [PATCH v6 2/8] iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:52:59 +0000
Message-ID: <20240330185305.1319844-3-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
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


