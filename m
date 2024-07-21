Return-Path: <linux-iio+bounces-7768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A193844A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F831C20A8B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF3156F27;
	Sun, 21 Jul 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EbJmTAhm"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A226156885;
	Sun, 21 Jul 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721556966; cv=none; b=UMQc0EHgmx5bEOiYIrP6NMOaZcTLVW0yLe3NsiKkPhaGWYLH+zw40iYpZp845v8Ab3KYy1Yvvm2jtJ5SQ/cAqcCf4mCcxhY1m/p/zL7GCOyQjSm7MNmHAKvqbPf0YFWvpPUxPCfDjJ/UNS6zLFiIfWr7jwmYfv/ZHWoPRVqjYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721556966; c=relaxed/simple;
	bh=QsPikQLZceYAGuxVlGoupF72mEFVrVlCn8xSmyVaK5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USwFW06mabR4Qu25apsbfj0SfGSf82Pt0c2qofDfNAr9hj/xcuowsOumT8openy3wLT8oWVojBDiwt4AfoqDZBddxWYNkxWSL5qYGaQAlD4U91qHeMALYuD7dBOp9GJlSfy3p150SyXGCtOF8OW/2KhKjQcYmsSMPbOhz9syFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EbJmTAhm; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A183D41377;
	Sun, 21 Jul 2024 12:15:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOf0iVq06uQf; Sun, 21 Jul 2024 12:15:56 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721556955; bh=QsPikQLZceYAGuxVlGoupF72mEFVrVlCn8xSmyVaK5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EbJmTAhm4mcSCitcrRpWJVSju4wRl34OjzfxYrD2WdqEsm235BcVwdkh140CRFe2l
	 tr0tt5CpzkiPSYKgpr6SN8zZ+DxIXziwBMOCo1pDFF0nLyCkq2GUOGgh1dBbYv0DVV
	 QigD5Tlw4IC8x5m8HPeONgrYVyhkhCUoVoCyUQ/MiJFT7sUMMEUyqgSHxSUYjgIm4I
	 lBxt+G/zNvUyJ66w0lpiU6oFgs14YWQ8y+0lOfwDQznBWrba310ApqVXmfoqpQN8/R
	 4jowoum1A3ULavg5GXW0c9BM4leFeDdBWFdBljMoWYpB8rxtl2Hbr0d3uNBMHKQJUg
	 bq1fnr5iIT0yg==
Date: Sun, 21 Jul 2024 15:44:29 +0530
Subject: [PATCH v3 1/3] iio: light: stk3310: relax chipid check warning
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240721-stk3310-v3-1-98fcb6f551a1@disroot.org>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
In-Reply-To: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

In order to allow newer devices which are compatible with existing
sensors, issuing a warning for an unknown chipid indicates that
something has gone wrong with the init process, which isn't ideal.
Swap it with a friendlier info message to get things right.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e3470d6743ef..48a971de6a04 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -496,7 +496,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = stk3310_check_chip_id(chipid);
 	if (ret < 0)
-		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
+		dev_info(&client->dev, "new unknown chip id: 0x%x\n", chipid);
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);

-- 
2.45.2


