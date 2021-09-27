Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE88E419546
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhI0No2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 09:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbhI0No2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 09:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF41460F39;
        Mon, 27 Sep 2021 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750170;
        bh=VIAUZjMWRivhGaTtfn1+Dr0oD5zXALI5OhD1Lfs0UgQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mLfDgnemA1BZGINgwBYZXG/Bp+AXqs3EW2Ny4x6tBOvZBo5VdChyZlCCgtjNh4CdZ
         JX3DHLOol75UcfZ+w3NNBjbdGf/uSJ4kAC1DEbJJ244uke9EceLw1eNisXbfB0LlgP
         teqLI2jnEP0PYyMVD8dponhyqsGxYdC7UWjd3Mmi80BP7DokJYS55AMUNjv/MFWRoS
         Q796o48eOFJWeGDAq4xP17AL9gdTmbd05n7Yo0A15A4nE1Zj9PEfsJh85l5dB04afQ
         P7fCvUwzywn5FcZaehkt2lZCHi8FhUfAMgmRL8fFqB9jtIaHd9KSEqqZjj9lbbN1vR
         ZOFu6h79xm3dg==
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device ID table
Date:   Mon, 27 Sep 2021 14:41:53 +0100
Message-Id: <20210927134153.12739-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; h=from:subject; bh=VIAUZjMWRivhGaTtfn1+Dr0oD5zXALI5OhD1Lfs0UgQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhUcoMMreEvtIsPKEKbcFOHk9KzERQMOiruiHsHDEQ DlR9g5KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVHKDAAKCRAk1otyXVSH0B2cB/ 9X5iwylLajfPmDFsA+tB39Qiep5cLVqHM9oFcNOfw1WGVxyXlQlz7N0mWZUNRAsGaYWokzfYm25hN8 tA6HPA+QPz2FUPSWX8feiPzn0Q4a5gLN8D1GusXO+guukfTVWH8wub44lPgZBXeDjTDzlDKPVvP1IP EOAXG8dkIoKbVAqNYg4Zp35Pwehg9C3XNGHOTeRZx/fKj16SNuEQKHfpu1FChYYzwUDgMjP2vInSjl +jZ/S4gP69s5qcbakekeIEONcJBZRse2ALvVjLyuJJNKUjsamqE7CmbeZPGmpIJ84zP52Rrff1k0hy CO5UMXXGIssmWJe09eC7y2+dx3o1xg
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding SPI IDs for parts that
only have a compatible listed.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/pressure/st_pressure_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 9b2523c5bc94..d6fc954e28f8 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -97,6 +97,10 @@ static const struct spi_device_id st_press_id_table[] = {
 	{ LPS33HW_PRESS_DEV_NAME },
 	{ LPS35HW_PRESS_DEV_NAME },
 	{ LPS22HH_PRESS_DEV_NAME },
+	{ "lps001wp-press" },
+	{ "lps25h-press", },
+	{ "lps331ap-press" },
+	{ "lps22hb-press" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
-- 
2.20.1

