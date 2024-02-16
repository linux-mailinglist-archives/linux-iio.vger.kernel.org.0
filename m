Return-Path: <linux-iio+bounces-2664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B7858493
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963C21F2202E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC9133298;
	Fri, 16 Feb 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Yhg0nq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA6132C0F;
	Fri, 16 Feb 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106002; cv=none; b=gqJnB8bQMzTm/AgKRkyhdppWnqMuO/XIwmfVfKTD4+DjBSj1r54DgcACkgKFMdwqyFKAJC0I+XwwB9nJ+zW7aGr5SNhRqcx3D/GUUKajZPdUL5lOFBaOHzg+rGeBaPNNdskhY5B9NvHIxPqaT0TjlPeVDtPwyfpcmXwN/v4Y9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106002; c=relaxed/simple;
	bh=2mqddr2vk1tIUyCyEYFgQRTgvjJnligNLqFwI5ekcbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyxfOsEEEToj1Uh9oREUSq2Gs5IFw0PfJZPMKM3T4RVydYdxKbOE7SolhSsrNXioyBPI+wXLsmqpmEP/32C/xI2RaA5/pspR/s45cL05qQe2JBJZkN1SS93Id4jTENvYhcYS2Mwxm7lm5Xcszj1/yX0MHvoP1P1+8HirymgRpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Yhg0nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E178C43394;
	Fri, 16 Feb 2024 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106002;
	bh=2mqddr2vk1tIUyCyEYFgQRTgvjJnligNLqFwI5ekcbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5Yhg0nqNKjYX21fB8wUKnj4CFIpeWMDoChM0ATV7ueCTwVQw91ilucEvE9ftDnZc
	 UXeVEL1/X7jFH7TdFopddAC9YXaMF15vNCVxiXev1Qv5cy3oLsOq75tBRzjrxHLFTA
	 zd1jASjqeHWTYwlOhUrThqJgf6y+fmiGIp+Joau6KR1VC6uwyl4Yd47f2p9Zk2aCt9
	 CWEfoOsmxALatGJ7qbmrSHDi0p3/O2DU+u12DKUqVDihfJGKt3DHc5sYN+05Lgio5f
	 KK+MTo6VKK6mQ4F527cSb+lwGE2ED8iG5GXQ///Z0n6N43UbF7bLSpLR0fV8Auphgt
	 Co8sJ83DYfhHA==
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
Subject: [PATCH v3 07/15] iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:13 +0000
Message-ID: <20240216175221.900565-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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


