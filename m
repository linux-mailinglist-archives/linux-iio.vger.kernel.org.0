Return-Path: <linux-iio+bounces-1361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3098820C99
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C921F21968
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7BCB65C;
	Sun, 31 Dec 2023 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COiWfw7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CA9449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8ECC433C8;
	Sun, 31 Dec 2023 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047763;
	bh=T83QePi6HC6U/3scuy9n7Zok2bayZEqRBHyr/AL1fio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COiWfw7+ks+L+c8jZW9Sk6t6gs8qMeRfvRTESfXFHNN18I4kN1P6CFU2O7H43tFHm
	 rWkbM8uxH2ELOIPc61yib2aItioqd7gGWDzr/Rfec9zHmIFLjXl+gqrZTBC1mnJoGO
	 ellHj6Eh9llhNJDpYUGGQuA6GvQQgo5vJEcgHstb7m5NyHkkVoQiM8t4OyBemplwcz
	 nxx55of5Neq+clziJ3zp3swHZuBcYYinURC+VKBadV2EYUGDSSmN1vjGHNp61JV6ez
	 Q1zDJb8pePN5TMX71BNy/8qIJHTaWA7V9k2u1YKSE2q+cV1MtOZIKOaA48b3IkVfs3
	 wE/iut0o/oTkA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 24/24] iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Sun, 31 Dec 2023 18:35:14 +0000
Message-ID: <20231231183514.566609-25-jic23@kernel.org>
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

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. This example was doing it correctly
but I am proposing dropping this so as to reduce chance of cut and paste
where it is done wrong.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc108s102.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index c82a161630e1..69fcbbc7e418 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -293,13 +293,11 @@ static const struct of_device_id adc108s102_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, adc108s102_of_match);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id adc108s102_acpi_ids[] = {
 	{ "INT3495", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc108s102_acpi_ids);
-#endif
 
 static const struct spi_device_id adc108s102_id[] = {
 	{ "adc108s102", 0 },
@@ -311,7 +309,7 @@ static struct spi_driver adc108s102_driver = {
 	.driver = {
 		.name   = "adc108s102",
 		.of_match_table = adc108s102_of_match,
-		.acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
+		.acpi_match_table = adc108s102_acpi_ids,
 	},
 	.probe		= adc108s102_probe,
 	.id_table	= adc108s102_id,
-- 
2.43.0


