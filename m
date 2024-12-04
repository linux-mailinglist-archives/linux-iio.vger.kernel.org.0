Return-Path: <linux-iio+bounces-13105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C965D9E496A
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85380286AC9
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799321772F;
	Wed,  4 Dec 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXbJPgsw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D0217710;
	Wed,  4 Dec 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354985; cv=none; b=Is8pARMhn+xR58i8H00fJiuMQcG5P1KFolij8VzDCdz5y1rDwuKzLDPNtXDG2M/wWUQOwq7Fp9b18430eqy+KKTlYZdHJSFBNW0ASUeVWdRw0la6XGxjnh0rnxK5Ucby93CIAp/LrV6XAY6b/t5oejg/UQH1pX5HhJ6lrEGir/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354985; c=relaxed/simple;
	bh=u/C6fKFwjAgCE8hNwHlsP4jgYFds8gs1i7+nI3P+N14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/M/+D0l24pM3AZaNmP2pL0SM5XhJrtslje4R7bYnGGPPYXsvJCRBvQaPXSEz0ZjTr6h7JkgeWiFcn67pAKQb6TYHArsCRbJTdymXPx3s+dpe6RZ/61njnr7zO8TjRBwm5nlliGsOz5SDY0rY1JNVOsj+EibCf7BNhKuaY9uQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXbJPgsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E68C4CED2;
	Wed,  4 Dec 2024 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354984;
	bh=u/C6fKFwjAgCE8hNwHlsP4jgYFds8gs1i7+nI3P+N14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXbJPgswRMcWyVG12GliSFWJDgPU//dqxZVeSsR8c7hyoNhfco5IO7iHRKzRuSwgp
	 yB50yUUsGhLrpw2qZxxzHW6q70GqKda3IH73FXpHGB3SaNE678ml1TNzv5HL6yBnrS
	 3ncvmPJe0UbLc7yg02B6K0llajIvIqGJD4F5lQN0v5P5bmQ9dO6cZnsZn4iXlYAL+l
	 7+5iEji9SgXj5Z+WxqbQBncRrSvkpj1uwnrOmQHYL+pcyytT5u8FQRrirR+6y9Yz5s
	 N/O9DX6jQBhzuGssg2/R8dVZrmbINEeQM1qctmMjvIY/fpkWqeRV47CJ0VzX8vLU2Q
	 ZwLzqBr/YsOlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/10] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Wed,  4 Dec 2024 17:18:01 -0500
Message-ID: <20241204221820.2248367-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c26acb09ccbef47d1fddaf0783c1392d0462122c ]

It has been found that the (non-vendor issued) ACPI ID for Lite-On
LTR303 is present in Microsoft catalog. Add it to the list of the
supported devices.

Link: https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
Closes: https://lore.kernel.org/r/9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20241024191200.229894-24-andriy.shevchenko@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 061c122fdc5e7..498cff9327132 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1612,6 +1612,8 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0501", ltr501 },
 	{ "LTER0559", ltr559 },
 	{ "LTER0301", ltr301 },
+	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
+	{ "LTER0303", ltr303 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
-- 
2.43.0


