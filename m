Return-Path: <linux-iio+bounces-1339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBF820C83
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC5A1C20982
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C341946F;
	Sun, 31 Dec 2023 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH8vLqph"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47E944D
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1002CC433C8;
	Sun, 31 Dec 2023 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047725;
	bh=XssyMWi+Rf4taKkSYeRbmsKuH49r35AwXsSxnagho28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aH8vLqph0wXWLvuyxY32+HNUBDBg++hFE9YAgG0k+32ZRXAfzxsAsV78FqXZXP+Ip
	 6K17bQNbHss9v4/EUUadnrzbFKI70Q9QT7lyEd+Ou/GHIdESfMAMivGDYPJ6MnKTyu
	 F4IDdlJdLfvT8Cs+BLNEemRDnTar+hRkKePComUS2qTnnl/M14JVsG1leHOf+78blL
	 xYUNLrJu5HeJ/OHHgHO2rl2tQFRrN7RZ2vVFi/TLtgkNxY13wKS7Lultsx/Ti+mWrM
	 Jk3B8c98S4N+DTNtn1KTnbvz57AZk32rd8gkIPZzHjXO2op7Gmjwy0mRh+5S3jjkID
	 UVn2Rpc5frwuw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/24] iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef CONFIG_ACPI
Date: Sun, 31 Dec 2023 18:34:52 +0000
Message-ID: <20231231183514.566609-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This avoids a build warning due to the use of ACPI_PTR().
Given the driver already has APCI specific code under CONFIG_ACPI move
the table rather than removing the ACPI_PTR() call as we already
have the complexity of CONFIG_ACPI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 894709286b0c..7f084f73da84 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -422,6 +422,23 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
 	ACPI_FREE(obj);
 	return 0;
 }
+
+static const struct acpi_device_id kx_acpi_match[] = {
+	{"KXCJ1013", KXCJK1013},
+	{"KXCJ1008", KXCJ91008},
+	{"KXCJ9000", KXCJ91008},
+	{"KIOX0008", KXCJ91008},
+	{"KIOX0009", KXTJ21009},
+	{"KIOX000A", KXCJ91008},
+	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
+	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
+	{"KXTJ1009", KXTJ21009},
+	{"KXJ2109",  KXTJ21009},
+	{"SMO8500",  KXCJ91008},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
+
 #endif
 
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
@@ -1687,22 +1704,6 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
 			   kxcjk1013_runtime_resume, NULL)
 };
 
-static const struct acpi_device_id kx_acpi_match[] = {
-	{"KXCJ1013", KXCJK1013},
-	{"KXCJ1008", KXCJ91008},
-	{"KXCJ9000", KXCJ91008},
-	{"KIOX0008", KXCJ91008},
-	{"KIOX0009", KXTJ21009},
-	{"KIOX000A", KXCJ91008},
-	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
-	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
-	{"KXTJ1009", KXTJ21009},
-	{"KXJ2109",  KXTJ21009},
-	{"SMO8500",  KXCJ91008},
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
-
 static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcjk1013", KXCJK1013},
 	{"kxcj91008", KXCJ91008},
-- 
2.43.0


