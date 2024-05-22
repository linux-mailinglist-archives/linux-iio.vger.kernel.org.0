Return-Path: <linux-iio+bounces-5194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A98CC95F
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 01:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98ED2813AB
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9C14A08F;
	Wed, 22 May 2024 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="APVKum7G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC9149C6B;
	Wed, 22 May 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419112; cv=none; b=G09jDbgj2scC1uUDzFkiP+ICD+wOT+XGXfAu7Y194P7I50vCZVCLy+yffrPqm8Ihqf3HO8ZyT5pAIYn17Ul5RgN9/n7p/sAXP6GFJAsfFFyt1PK5+H6pylq0SAthtS+WropmAPgzMK+c6bPNIw1ITQvsY53s4ARjbA8sxA7ft3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419112; c=relaxed/simple;
	bh=GC91rZEjwWdn9kP5813pBtcRlW2ZP9h8kGBpnB8dAz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN5XmRAfi6FBkK/TN7thY4v5JBfvq+x68lQFh35b+bV/W7KFzQkSfrtMPweFtYNF2E/qRtBTphqkj+Eni/j6/c1vhlWFsA6izpFjA8N1sVapYL2UbtOmCdEOFYYcacyIS6dT1u8pJMPfSmxV3Yei5tutNVOWy+KbKEP9WunBpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=APVKum7G; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=o/dCa/2pvSYcJSKo2ek9COMY2kqbIjQug7Y5IygVtL0=; b=APVKum7G5V7S6kgB
	5oZG0BICn9jweeOewJUfQIf2V4BIZlWwnySjoeQVSJuSH0rmTdFpuUNpYckmb/FMAqsXmAqbzbu5A
	nlM94UTUovgov/ndILVZMJO3ou6L7uN0uwJELS1enJorr2lcCxOM3ZCxeg/3iDUv30ZICu14E3g6e
	LXLWYBC4WWfuV7m3nNu1TTcby7J6bz3IMR1786MwBSKoCQturmPSfMcxJGSFvCe822rFgfqw089tO
	X64zAy89pB7EFdSbrvo8gmv65nA9DibF7VL/mF5tUTPXidQ2tDktZUfi4vqgJhwK/W4ipYsQyIe/P
	s9Xodr+ajXWFbx5/5g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9v15-0027Vk-2v;
	Wed, 22 May 2024 23:05:04 +0000
From: linux@treblig.org
To: jic23@kernel.org,
	lars@metafoo.de,
	marius.cristea@microchip.com,
	mazziesaccount@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] iio: light: rohm-bu27034: remove unused struct 'bu27034_result'
Date: Thu, 23 May 2024 00:04:57 +0100
Message-ID: <20240522230457.478156-4-linux@treblig.org>
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

'bu27034_result' is unused since the original
commit e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/iio/light/rohm-bu27034.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index bf3de853a811..4937bf6fa046 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -223,12 +223,6 @@ struct bu27034_data {
 	} scan;
 };
 
-struct bu27034_result {
-	u16 ch0;
-	u16 ch1;
-	u16 ch2;
-};
-
 static const struct regmap_range bu27034_volatile_ranges[] = {
 	{
 		.range_min = BU27034_REG_SYSTEM_CONTROL,
-- 
2.45.1


