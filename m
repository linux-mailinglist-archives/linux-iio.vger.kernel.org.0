Return-Path: <linux-iio+bounces-7548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39192FD78
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CF51C239C4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54010440C;
	Fri, 12 Jul 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ue0QRp+W"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4580171075;
	Fri, 12 Jul 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797918; cv=none; b=AxZQX40cNf9iM0Vql4vwj4axPUbEFGDBRwhpvHfF6DtQSGxagDxusOyH1tl9XZtQq8UmGEbWr9ArTCkdTX51XUKNOttxCsGM5Sq4TbNNR2WZeMskf3iD6y4XzoN/GEEKT9/sQkvNtY6xsseJyUNh+gg9bWrlrRlT/InVl9XuO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797918; c=relaxed/simple;
	bh=Nf3c5cFPQqH6NjdQ5t3abQSsHaZokZU2IJwpFQAzxTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyPXCDiaVgVAtC4AopwkfZ0NkY8UyWey/VEsZvKWv8RbQoV/9SNCMJAByZZ+XQwV88heFe67v49AqAq6GrphgjZo0ypXazNy95IBddit34KmAnsp5lVcU3QozoJrwBn5deHdN3KUIGGueV8YM7j8yszexoOgYYFVZdQ5UkV8HsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ue0QRp+W; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E3D1441A24;
	Fri, 12 Jul 2024 17:25:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WHmxWArao7F8; Fri, 12 Jul 2024 17:25:05 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720797905; bh=Nf3c5cFPQqH6NjdQ5t3abQSsHaZokZU2IJwpFQAzxTs=;
	h=From:To:Cc:Subject:Date;
	b=Ue0QRp+WNS90FLcaHVnbZMvBVre3++HUBVGu2tCdVppyhZdzfohN1ffXUnIbBwpcb
	 Fn52/3gZwYJSA9Wt//tdwhoheXW/wDl4s5WZvLucFwkWLrdRMD8DNe4/fv4pDyCo0p
	 Y5K/oOvL3CH78vV0+SN0ocXzAOaV87TAJ8IppVNDeFpHPlHn1Fn1T+iyn7BoU8AYzf
	 RquPp4Q0pcWS7+W3DAHyeM2VnZ4QLM6mHLym88IjeylLyoNcWQ768hrhVK8ybwOkWZ
	 icpqg6FTSaJrzAivTO5VfzG5yJKviAzkAoqwF+0C0S0VbMMVQiOt5LZD+4e0gE+lWo
	 MWRUxgtD9/v4g==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH 1/3] iio: light: stk3310: relax chipid check warning
Date: Fri, 12 Jul 2024 20:54:00 +0530
Message-ID: <20240712152417.97726-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


