Return-Path: <linux-iio+bounces-5192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381108CC95A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 01:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667BD1C21C27
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E70149C66;
	Wed, 22 May 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jd50RRlo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909CA145B14;
	Wed, 22 May 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419110; cv=none; b=mrvZKeP+QBq+b1/yvOgbPFPog8bTMP8KOZsUWXr7WXK8YRB1y3k2ivmJuQlOst4yc8YPi6gEnbhz8VwHiE12qPfjT54yVkkdkHF6NOhvoSXl8lGAIBgisnepXdtDb3UWNz0Q5udK/y/9HkyQOkKA8U9VPZelkm4tBSyb1qbDlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419110; c=relaxed/simple;
	bh=IZSQW4GuzdTVV0wRqC/Dl9Mli6Jmli2ntbkxW3IaW04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHa3p3H86qEI2GXHwiVWiJWcWGpaoaFRNztSAM5q5D/pPQ2N/wpkYKxYlB+6aiyWSWoQxpLJtQwuG67Dqbo8LfEVEySl5nDs94Jka5DP5ja70If4qFAW/Sr6z0bwZxKBqCqkC2G67B7TYQKKMw4iBLhetY+VBVQ4/PqMtsBaeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jd50RRlo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/KqgiF6JyOVGu5gdJ/j9Ln5H0DOWGdPUlVZSPNo6r34=; b=jd50RRlojAR0yE9d
	8c4kZAGmLLfF/Ya5sfb1XDnKdk614E238D/z+l+RPhr53cpK3faRm9bJqCJt6eVDAThmjWFH3KDYZ
	mQ/K/NiOBQfw7ZptmNRpIJLHl6Zm0wecGoRBE3JVrdbVZuoaHc7VYfPvTzdCFHP7ELrhutIzhhm5M
	urqIYGwTcSqeVlBu7ubTI8VGUYt1a/KPtyl+ItXGMYhh47wRugFAb/9XNP5rGWGo/ySfVSWqUHxQd
	92xbP2c4cRGK67fcpAxgGR+dN7hGtQMuaOlOZ+lXl8M54T9peTOfBoB0oFk6tjhLjaZWBW1QFfWov
	mRhiZGzhCPJTGDAYLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9v14-0027Vk-02;
	Wed, 22 May 2024 23:05:02 +0000
From: linux@treblig.org
To: jic23@kernel.org,
	lars@metafoo.de,
	marius.cristea@microchip.com,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] iio: adc: pac1934: remove unused struct 'samp_rate_mapping'
Date: Thu, 23 May 2024 00:04:56 +0100
Message-ID: <20240522230457.478156-3-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522230457.478156-1-linux@treblig.org>
References: <20240522230457.478156-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'samp_rate_mapping' has been unused since the original
commit 0fb528c8255b ("iio: adc: adding support for PAC193x").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/iio/adc/pac1934.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 456f12faa348..ae24a27805ab 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -227,11 +227,6 @@ struct pac1934_features {
 	const char	*name;
 };
 
-struct samp_rate_mapping {
-	u16 samp_rate;
-	u8 shift2value;
-};
-
 static const unsigned int samp_rate_map_tbl[] = {
 	[PAC1934_SAMP_1024SPS] = 1024,
 	[PAC1934_SAMP_256SPS] = 256,
-- 
2.45.1


