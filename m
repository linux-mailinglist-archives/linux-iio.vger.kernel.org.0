Return-Path: <linux-iio+bounces-13102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D89E492F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3818216A989
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744B211491;
	Wed,  4 Dec 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYegcuWB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDD20B213;
	Wed,  4 Dec 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354880; cv=none; b=IRmHgmnL7mg99etax2UEJ11e+9gc5SJ7SMRnhnxxytsg3JK8VUUoCstDNI9b2Ec1NhOUNsIJUtVZ8XfC/KRJaksBQpwFx7gJy7bE3OJBxAN/gZTbp+S7JQASM8vrUh2n21/5j4Nbp0Nz1MV6ZofY3iXREzE5bQGTlwjZvGZPcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354880; c=relaxed/simple;
	bh=QxhMXdqUrydnTcdF41z9OWpFa5LfRVKONm0hMTL99Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJokdkmPmhiuhOI/4f17KyhL6IWyK8G8ujjCkTD1Y13N0CXMhgLst12G2wBxnbONX3/VeWcGfw/5R5EemScwLDL1leKJHgAynXvb1mDKZSYz84M9YFQwVo4cDXPIrfe2K+5NGRqVoLYaRj5cG7zHuMfnUe0p6crzR/JxDS+nQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYegcuWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096FAC4CED2;
	Wed,  4 Dec 2024 23:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354880;
	bh=QxhMXdqUrydnTcdF41z9OWpFa5LfRVKONm0hMTL99Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYegcuWBDNTexcUQOOTcnPmAP3fSqjpDfJ7jYFcvGMP2AAse8xW1At3iuL3HX836d
	 yBapi8f1MP0KQAizDPjR5Cs6kErIBsD4/1mkgXrXeZ3lcA2RwHpWKZpou6lFcuigC2
	 iG9DIIoYefdKGYA0GpnPO7mJ+57HOx52cri5+LZBGAxtyiUOrIPByt8FTZbNeCi8yl
	 N8qVtOi8ZZtEaXpJrt7mGoFwmrShxksz/LVwLowEDn6CeQYf+PEaLBkKFgJwgefwFu
	 JjnEuxmqi8/lbGO4GbPlGFNSHEVzMmHar/2yG32Kj8naIh0kMFfVUsA92cXh6LjvdN
	 Ia3NSZEn7bzPw==
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
Subject: [PATCH AUTOSEL 6.12 07/15] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Wed,  4 Dec 2024 17:16:01 -0500
Message-ID: <20241204221627.2247598-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


