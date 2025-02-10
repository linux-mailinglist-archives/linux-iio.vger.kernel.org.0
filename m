Return-Path: <linux-iio+bounces-15235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDDA2E49A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0853A4FB0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BD1C3F02;
	Mon, 10 Feb 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfXbxFnh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7A1C3C12;
	Mon, 10 Feb 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170233; cv=none; b=eiqTkMsGBA8qF/Si3yxHawCIQ44tPKjeLUEZKU62wUFRb0xM7UkrV/h/cvvrfwl5J42507xDRXAShhM5AQIqaGg6fkVME2ZfS11YkeITseiFNQ99cDakNBNk6+cae/TpkXOASd8bvY/KoqQ1cJP3E4Z7rWD/t7ybLlYxLBmn1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170233; c=relaxed/simple;
	bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hh4H5Tsn1LJ9Ug9bdoW7CYQkWRzVhgtn8s7/6qhTVNBywG9biSVgaoaY8FEIHh13HQTN/F25BGR2jPpOUvwNnFAI5UhiagsD2AdwoYQ1Id8P6filnNpQy+sQs75DnUfjNk1yCZgDlGD7n7sBjurWtxuNEY9/PdWESEKLPDqoOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfXbxFnh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170233; x=1770706233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
  b=dfXbxFnh8sq0dlNhLKUfIJsn6Nl22ExcRjbmTFYz/9hO4SMpCsKJZ1ct
   aGbxCC/ZVHoF7iVYYK0nFIk0wT8VoNMSvvC1yhxy4m+Eb9o6TJk4dXCf4
   k4c4rrN3rrlOdpPh+mAoniLJA0dyY1Mxw47C5pT6ITiQ2QYDHN/yY7nN1
   e34DrU3W+PFITX8z+7n2Tq8wOd44IkwVG4dYzS1Vea5gyyHg0P66yJiUU
   9NPphBPAVYEX2RlOEaC6QAVgKIQwvl/KYdD0kivjlAfs4rpa8hJx7EIXs
   jG4TsK58lQE1jXJdC0rVJm1+odwZoZkxbuLhWdhvLkVbLRmv84UnQU27S
   A==;
X-CSE-ConnectionGUID: LNUhDXP/SNOaFuGhRGyH5w==
X-CSE-MsgGUID: XAx1tMNRQY+IWfl4Yzsg8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499416"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499416"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:32 -0800
X-CSE-ConnectionGUID: 7cqpstVVQ4i+LnWUtkNRqQ==
X-CSE-MsgGUID: 6iWeD21WQVe5eDI02Un6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122621"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:27 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 13/20] power: supply: sc27xx: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:59 +0530
Message-Id: <20250210064906.2181867-14-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210064906.2181867-1-raag.jadav@intel.com>
References: <20250210064906.2181867-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f36edc2ba708..573838ca8ed8 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1014,9 +1014,8 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!table)
 		return -EINVAL;
 
-	data->cap_table = devm_kmemdup(data->dev, table,
-				       data->table_len * sizeof(*table),
-				       GFP_KERNEL);
+	data->cap_table = devm_kmemdup_array(data->dev, table, data->table_len,
+					     sizeof(*table), GFP_KERNEL);
 	if (!data->cap_table) {
 		power_supply_put_battery_info(data->battery, info);
 		return -ENOMEM;
-- 
2.34.1


