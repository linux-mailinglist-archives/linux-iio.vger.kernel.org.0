Return-Path: <linux-iio+bounces-10082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343F98F661
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFD4283AFB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE61ABECF;
	Thu,  3 Oct 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cDwQ7MvV"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-218.smtpout.orange.fr [193.252.23.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD001A3A9B;
	Thu,  3 Oct 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980962; cv=none; b=U+ipPL6wsryTRV5oXrfo4hakTWizhYv2chmoQh+L+7exC5oAsNqkd7YzxmY95tzZ/wSve6JKRsY3O7B9RRpVHXZOTkS+Uycagq07n3joP9rwGi0DrpWiQJAkpAbGO29YcJfRxGGQYib9BHBNxJAQqISV5Xd26uWZR11TIyWzVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980962; c=relaxed/simple;
	bh=jPlFr60vvz4tkUSvParCwXFMiMSbMRyjC1djUuBi7KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfT+8RQdgZSrbUN5V3fUZNsh3wceFqoGfuwgoUKZrbIXWzLDKdSTTkJ2kt/jR61BU9kWs6hN9EhbP8De3w5ezBW9QlH9on/lqiMkUJOKlOf4ex7K5EZtjJ/qWmhiDDHovSD7hhAbuObEa+8S5wY9Q+jxblmN7AMPcIlThbsK1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cDwQ7MvV; arc=none smtp.client-ip=193.252.23.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wQlJsJxvseuCGwQlJs5sQ7; Thu, 03 Oct 2024 20:41:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727980879;
	bh=jxInce6aIOgiZ5gkFsGJfLR2xEJFih2LCJj57qSdMt8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cDwQ7MvVj6N5dLkfQWRGsy+I28xdVx+y7ZPDTRjZT6yH7c+IcM9cR7kS65MiCc9Ec
	 5BGpvrDvrufWL0p1+wmHvsQMyRGGC+CCS8LBd1IZPZNvZ+lb+WQK3Ai5Ns+/+HH9tN
	 mddJ5ieYQMIppe/5CWJjYJzLCHup5OMyxMBExWAIJ9Yc4ra34+6y7Dx6qZzNrpC9tU
	 D/igqn9keMfRHuHp8P8pj6hDUPucpVffN057Y7dzZtIQQRpJQePaL343HzWrqwzref
	 i82Te1pz/dgsXJdphCWe/tabhVgX1ed4ZJHV/6t7Y757zXv4a2W/3WM/N3quc4eBlo
	 Op0jZLr74pciQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 03 Oct 2024 20:41:19 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()
Date: Thu,  3 Oct 2024 20:41:12 +0200
Message-ID: <c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hid_sensor_set_report_latency() fails, the error code should be returned
instead of a value likely to be interpreted as 'success'.

Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.

The code just *looks* wrong to me. No strong opinion, if it is done on
purpose or not.
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ad8910e6ad59..abb09fefc792 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -32,7 +32,7 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
 	latency = integer * 1000 + fract / 1000;
 	ret = hid_sensor_set_report_latency(attrb, latency);
 	if (ret < 0)
-		return len;
+		return ret;
 
 	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
 
-- 
2.46.2


