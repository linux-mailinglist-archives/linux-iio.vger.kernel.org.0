Return-Path: <linux-iio+bounces-8140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCF945F60
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677E1282A1E
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A2F200109;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9ndI65f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A00200101
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=q5+OpdhdC42+wiInAsOJfeSLGkDc4jCDHZOSpmEO3xfXNc/wTHrWXuHSF1JVowyH4U+76zm6fefHXZ93SRPIb3KIsPM1lM/hJLZjLMJl4Wy6a+6KVQ8vO1fMlCw12TdaB8G5HQC5GAjeejPxub8uz5iFdwkmeBOcwzp/XAj7ZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=hs7Izb2iLc9r5wbQ4KWVZkkGEkQM0G7T7G/q1XG+w+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwkGIH9i6zxdS6O+f3pXg2Rp7JjjQ48pb41DePRERgI99FYLJciNqkykkvxSpw2C9ErioojNj5Mz1KFJ2J9TczZIwv52J7zN7m8jTqAYdr34mD5K9lD6DsMOV64DrW64t/+qa/5BzygsZ9GkbZHTKeocRXISuF/dE+16SF1kO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9ndI65f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E969C4AF0A;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=hs7Izb2iLc9r5wbQ4KWVZkkGEkQM0G7T7G/q1XG+w+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E9ndI65ffmQxBb+qS9F4lp2BR9FLvRkyuRUImOytd0H4utiwQEgMJKBHbGbe7rEd1
	 96ENPNo9vviCBfIvK8TS4vGYRTdHTu4ABa1UCr6hcRvZD2mZnEW30Ss97/JHFFua0F
	 wKkmHOSzj5xf0VYqMCR0QKXS3bZ+wASORupkr+uemsLD788YIfc8abDRPka6j2zf/p
	 zrwfNhhPuvlZuHPkrc4w7eAZattSkCDd7S0F471gw4qaWgTemYtUfvrVQMaeTxj+EM
	 VN1mGT/fLYykn3/y81Ko/yBHwf/zvgn1stc3k321d2kkh/GIJBlDXiKZIOfXftp4ro
	 c2kUH0NOvQWRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786DCC3DA4A;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:26:59 +0200
Subject: [PATCH v2 1/8] iio: backend: introduce struct iio_backend_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-1-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=4840;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZXTwWK2rEEm8hHyS9XYhmR8ZiAipT7oHi6CInXjd0c4=;
 b=GaB0z2pomHke/mGWZXVUpzBZ1FvS+McBCHUj2RLTXqWSkgQYFjb7E7m1OheFmiqK6mzNgWBqX
 xHJL1VaQAxHABK2u2W4AslYqOUA0ju2xU5un/iF/LUUdI9V18ud5oyc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Instead of only passing the backend ops when calling
devm_iio_backend_register(), pass an info like structure that will
contains the ops and additional information. Fow now, the backend name
is being added as that will be used by the debugFS interface introduced
in a later patch.

It also opens the door for further customizations passed by backends.

All users of devm_iio_backend_register() were updated accordingly.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c      |  7 ++++++-
 drivers/iio/dac/adi-axi-dac.c      |  7 ++++++-
 drivers/iio/industrialio-backend.c | 10 +++++-----
 include/linux/iio/backend.h        | 12 +++++++++++-
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 21ce7564e83db..0a9d7433da304 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -273,7 +273,7 @@ static const struct regmap_config axi_adc_regmap_config = {
 	.reg_stride = 4,
 };
 
-static const struct iio_backend_ops adi_axi_adc_generic = {
+static const struct iio_backend_ops adi_axi_adc_ops = {
 	.enable = axi_adc_enable,
 	.disable = axi_adc_disable,
 	.data_format_set = axi_adc_data_format_set,
@@ -287,6 +287,11 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
 	.chan_status = axi_adc_chan_status,
 };
 
+static const struct iio_backend_info adi_axi_adc_generic = {
+	.name = "axi-adc",
+	.ops = &adi_axi_adc_ops,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	const unsigned int *expected_ver;
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index e44463f48bf5d..9655705b158be 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -507,7 +507,7 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 	return 0;
 }
 
-static const struct iio_backend_ops axi_dac_generic = {
+static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
 	.request_buffer = axi_dac_request_buffer,
@@ -519,6 +519,11 @@ static const struct iio_backend_ops axi_dac_generic = {
 	.set_sample_rate = axi_dac_set_sample_rate,
 };
 
+static const struct iio_backend_info axi_dac_generic = {
+	.name = "axi-dac",
+	.ops = &axi_dac_generic_ops,
+};
+
 static const struct regmap_config axi_dac_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index f9da635cdfeaf..0cf80ffd2e612 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -641,20 +641,20 @@ static void iio_backend_unregister(void *arg)
 /**
  * devm_iio_backend_register - Device managed backend device register
  * @dev: Backend device being registered
- * @ops: Backend ops
+ * @info: Backend info
  * @priv: Device private data
  *
- * @ops is mandatory. Not providing it results in -EINVAL.
+ * @info is mandatory. Not providing it results in -EINVAL.
  *
  * RETURNS:
  * 0 on success, negative error number on failure.
  */
 int devm_iio_backend_register(struct device *dev,
-			      const struct iio_backend_ops *ops, void *priv)
+			      const struct iio_backend_info *info, void *priv)
 {
 	struct iio_backend *back;
 
-	if (!ops)
+	if (!info || !info->ops)
 		return dev_err_probe(dev, -EINVAL, "No backend ops given\n");
 
 	/*
@@ -667,7 +667,7 @@ int devm_iio_backend_register(struct device *dev,
 	if (!back)
 		return -ENOMEM;
 
-	back->ops = ops;
+	back->ops = info->ops;
 	back->owner = dev->driver->owner;
 	back->dev = dev;
 	back->priv = priv;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 29c4cf0bd761f..f120fa2e0a434 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -115,6 +115,16 @@ struct iio_backend_ops {
 			    const struct iio_chan_spec *chan, char *buf);
 };
 
+/**
+ * struct iio_backend_info - info structure for an iio_backend
+ * @name: Backend name.
+ * @ops: Backend operations.
+ */
+struct iio_backend_info {
+	const char *name;
+	const struct iio_backend_ops *ops;
+};
+
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
 int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
 int devm_iio_backend_enable(struct device *dev, struct iio_backend *back);
@@ -151,6 +161,6 @@ __devm_iio_backend_get_from_fwnode_lookup(struct device *dev,
 					  struct fwnode_handle *fwnode);
 
 int devm_iio_backend_register(struct device *dev,
-			      const struct iio_backend_ops *ops, void *priv);
+			      const struct iio_backend_info *info, void *priv);
 
 #endif

-- 
2.45.2



