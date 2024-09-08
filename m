Return-Path: <linux-iio+bounces-9353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD0970A0C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF02A1C21C2A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F8187860;
	Sun,  8 Sep 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YBbXd5wG"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52E181328;
	Sun,  8 Sep 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725829802; cv=none; b=VnwR+ia6aJo6xPCDlWo/ERCCcSRkp7xNisbYY7BGIlc11WwTKklD+6ldJNwNn2L+2B5Bifg8QkI1ep1H0tDkdOeux5i+xmh2lbuAbyn+OdFCL8z95gb9GLMn7OCmxfStSlVqFL6zQuk0Wf4WO6MjzeAZgLwztpEynpCD0mRJPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725829802; c=relaxed/simple;
	bh=hr5V3SKs+5sSdOcCMLObBljUvchYcD8eBaaOFqtYTr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8Wh3ZAhqzbPYfvdy2nkDO0YLB+OwuA/VdbeOhosixPDHLZe3xgI8qql1S97NOfjwNzL6ayioBUvSobngQIVMRBpXSOUJobHJT/g3lVYi6R+hS5eKXITWv+atdp5OkDXNBh0N+g0/4MExVHsBpq0WZsLltRoBqJCPrr1touijSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YBbXd5wG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AODWEsE73iZy3ftOFUVpepawKaVLM9NWi8usTPEPRhw=; b=YBbXd5wGMQvFJ78L7z+1sRxDbj
	lj8ky7GrcW/R8EGhM6SOQe+1YOUnnfUSAemNtm4Hq1xsa15A816rSSH0kk/qWszTu5rJCXhwRSOkO
	NeHevL5NpBoay96RCGWudg1Z45AkXFxkZ+WZPRNH+IzXC3VqoHPB+3H1BCQN4n/2q2QyBCBZYKEGa
	gdLwY99LziS6ERU8zhOh7g4vDNAJTHDCZwgUuibqdeTh6iRxkm10SSJfK8j+ni7wiQLPVC82cg8C+
	KIm2ieNa2Ju72daIBrPau+b7ZDvr8JaInc4p9gEzB0ZiSxJAyLKF9/iH1B5E6xJX8dam384YJTFn3
	05713NZg==;
Received: from i5e8616cc.versanet.de ([94.134.22.204] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1snPA1-0003s9-W8; Sun, 08 Sep 2024 23:09:30 +0200
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
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 2/9] mfd: core: make platform_data pointer const in struct mfd_cell
Date: Sun,  8 Sep 2024 23:07:56 +0200
Message-ID: <20240908210803.3339919-3-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908210803.3339919-1-heiko@sntech.de>
References: <20240908210803.3339919-1-heiko@sntech.de>
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
2.43.0


