Return-Path: <linux-iio+bounces-13104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4806B9E4961
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B0316AE30
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CEF215F5E;
	Wed,  4 Dec 2024 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzU/5uok"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B920D51F;
	Wed,  4 Dec 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354940; cv=none; b=fNQfvu5Mavme22KJ+dFXPudvn/f+SqqNwdPrv3hIerVxBOhk7flSXukZpkMuEFnVLS79RNEIKl4X5IAOt9yhczMyNaRHd/Mdr/0sh6ZjbZ3wcdsWAIRB+FThFBP21mxBy7hftTc5Y9xlcQtOaPXStCmaOI7Wxd56XffOp6N0mKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354940; c=relaxed/simple;
	bh=QxhMXdqUrydnTcdF41z9OWpFa5LfRVKONm0hMTL99Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4YRMMViIoYQmwobtMouCW7ZZ/SQitSDaWAVL8aO8sT8b/U9Rnf6XZzV4z/R6DWYlw+oyvSa3xbZuFhZvpRAWXheXM8WjjIVE/Y1L3W7xKrfMCEWPP2Rj7puHJAGiZ135nuR26Pq5QIZm3zyTh18ikw/CX8cRpvmxYT5uQTywEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzU/5uok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ACDC4CECD;
	Wed,  4 Dec 2024 23:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354939;
	bh=QxhMXdqUrydnTcdF41z9OWpFa5LfRVKONm0hMTL99Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzU/5uokw3XLkO4V1D8AHMb0JggQrs33K9PmGndJ1poAmjvC4uNr0x606lsnCFLsE
	 kceNjxrLThNEOiiLjCx1KgdSXZ0vmpUNBgnQ9tfXgiHQA9DZBkaR3D98sxDNcqabF2
	 SPuss9o6l1Z1h7wcb8gb6xhQfzuk5O+Gq67tvGburPmFG54TQO8WW4jwFJ8FCqEqSn
	 mIPObNQuiumQsYXm4qQam3mZ+AlEC/RmRUD1v72WH5FNEA5P1arS/GhYlsES34H9Tv
	 1fbsgtB2UoUVFrbJaLfFIcrT7i9hTacJheAxa3NEU/IQDfb6tGtif/5Dl/uqVQ6MHp
	 bn1rCvMW6pcsw==
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
Subject: [PATCH AUTOSEL 6.11 07/15] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Wed,  4 Dec 2024 17:17:01 -0500
Message-ID: <20241204221726.2247988-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 8c516ede91161..640a5d3aa2c6e 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1613,6 +1613,8 @@ static const struct acpi_device_id ltr_acpi_match[] = {
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


