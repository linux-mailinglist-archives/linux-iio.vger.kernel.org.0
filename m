Return-Path: <linux-iio+bounces-11981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F29C04CE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B19FB239DF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06211212D02;
	Thu,  7 Nov 2024 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vLcp2aRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25390212183;
	Thu,  7 Nov 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980082; cv=none; b=q3XssHq1EVxWlWeVXlKhbef3ylE5oPIr9wkh47Ez7u1F7zcFVhZGmKFIKqkSqcZXDAudqOyFUwqkFb8gjmxL41K/zsK2qlkTg9GnpQtSuUxd05Bekq+2rBrZY1isGR/eDvez8q1R48IRbnuKuCd6Nn81uP2MKp2vRFGVdUToes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980082; c=relaxed/simple;
	bh=PRAw6ugHPrefOkrLvhBR5eOG83D/eQhFr4FdkSMhwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8fyCTGuDH7HMnJOK5UIBvoMmceN2+JcdLUbb7mE4hW/tg6eqLTS7iiW3/7fld9yqZBgmr2OhuOrShyNWIcmLjKHq8KhdI6WkgPg8BWfreZ5tq9aPbxPOdKRu9aaj7MvB233eyv7JN6VVTMmGroqafWEN0c3m3qCw7A3e1/f+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vLcp2aRD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z4S7eFAqOKlyh0GLmEWkpvO9ikI1XkubVMydYt9t5D8=; b=vLcp2aRDwCSVwAoqK7+/n31gD/
	7pj/YV9z9UmFqiQb3zgVSjTeWqcggKAbbNcrqXf3t72o6Wrjw/h5ZiHDFJA7nVq11AH28hvkXbprD
	/zJuGZh4FTBtFkBVnM89jFuT5pNS63bOEDXe3tBNTXAvygkHDrcRsk648E5IIui0zzX66a+77F9e9
	013SZvC1FrBEZyrN+PaPiFq02VcrH7HdcW9/ORKUALAtjZHU9VPIFIhaUNXLjZlsBvzBtWunwi8tt
	RDZH5xF/SdTjmNRrRg944sfttUsdBXa6vkOyufCKv2JtY02Ma5k7i8U9Qie4LrXgOFLG23IFUE62w
	0UE1gw0A==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90yz-0005lF-IE; Thu, 07 Nov 2024 12:47:25 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v9 2/9] mfd: core: make platform_data pointer const in struct mfd_cell
Date: Thu,  7 Nov 2024 12:47:05 +0100
Message-ID: <20241107114712.538976-3-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The content of the platform_data of a struct mfd_cell is simply passed on
to the platform_device_add_data() call in mfd_add_device() .

platform_device_add_data() already handles the data behind that pointer
as const and also uses kmemdup to create a copy of the data before
handing that copy over to the newly created platform-device,
so there is no reason to not extend this to struct mfd_cell, as the old
copy in the mfd_cell will be stale anyway.

This allows to pass structs gathered from of_device_get_match_data()
as platform-data to sub-devices - which is retrieved as const already.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index e8bcad641d8c..faeea7abd688 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -72,7 +72,7 @@ struct mfd_cell {
 	int			(*resume)(struct platform_device *dev);
 
 	/* platform data passed to the sub devices drivers */
-	void			*platform_data;
+	const void		*platform_data;
 	size_t			pdata_size;
 
 	/* Matches ACPI */
-- 
2.45.2


