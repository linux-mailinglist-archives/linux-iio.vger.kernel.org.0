Return-Path: <linux-iio+bounces-3951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28078892CB3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E0B282F8E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED793FBBF;
	Sat, 30 Mar 2024 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmCL69k6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34EB200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825747; cv=none; b=m5IYNZkGY/fq4lQxaxUMxMrcqJFgQ5GgmqkVYo/OKCxIjgjQLflonMrIZxgJEdDEaSxcCBFlLAo2iePvdO76EPxkg9wyq0oydbSZJmsUpE1ztJ3PtXwaxm79Zazbzm0ZWgQ64+8eZC4Gg6oUu9bxj0JcgBsi0UXXfhO2j6voBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825747; c=relaxed/simple;
	bh=pBrBX8N/AVh05V+rxL7ttckidHUEbDcbAnCAdcL7fis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjZRbq7hUNAVAHjJzZAOYTRHE9tpd8/L2RwO7yPj1VUMT0YOBDSN+1tcz0WSqvhKktR603M/yS0YfXNif9rJ/S7UoCC6FAETUpV8fv7kP9IE09oeznaAL8hXnoXJFqQIhd84zfsZVG/oZrktGOnJ6daSQPXxBKVfA/ZvXrGF15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmCL69k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9BFC43390;
	Sat, 30 Mar 2024 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825746;
	bh=pBrBX8N/AVh05V+rxL7ttckidHUEbDcbAnCAdcL7fis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmCL69k6i01OsnPW64Ekkb5PtcHhP2jBDY+DBEEHeOzgrBpJxld2AT4lGUTWR7FVW
	 R4jxB38RZKdGvjsjfqaHGbXSuuhQJeeH+yKpDFV7x0z0TCGJjxsIAcSWq7C13QbT4y
	 KN5PFvcTUuFtHpckR4EcL40c6MAi+v5EXYfkaZXn/chHAA2DNPRL/tl9ZCURcMfi3y
	 k9bU3iUEkL5Bfk4uB90QD69D3RhfZVobcxeN4uh2NAx1CHckC/LSCr9ztvPJddu+Wl
	 Gip6Wvv2jHhIQ8peSznvbMuLDo4zdXYXzqOxEMBIsIypm+MR0/dDQpUvyTGiDTReFD
	 vNTpKSBmQqGRw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
Date: Sat, 30 Mar 2024 19:08:42 +0000
Message-ID: <20240330190849.1321065-2-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The dependencies on various ab8500 components prevent this driver
being useful but they don't seem to prevent it being built.
Improve build coverage by allowing COMPILE_TEST.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..e648198b0a0a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -8,7 +8,7 @@ menu "Analog to digital converters"
 
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
-	depends on AB8500_CORE && REGULATOR_AB8500
+	depends on (AB8500_CORE && REGULATOR_AB8500) || COMPILE_TEST
 	default y
 	help
 	  AB8500 Analog Baseband, mixed signal integrated circuit GPADC
-- 
2.44.0


