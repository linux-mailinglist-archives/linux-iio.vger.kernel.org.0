Return-Path: <linux-iio+bounces-6875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA5916125
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1811F22AF2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B291482E8;
	Tue, 25 Jun 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MD3X8VsX"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEA147C98
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304106; cv=none; b=tMrGh1rFW8IJrsU3taik7v4kB/cc7kRzyD+gkws1v+LI/BxIIlXPJkwL2ulfF4i+wbTDXv2YlQV0RJshLxF83vbn3G33rbRqT9TsscUrMZQjtoHkxImP+qZabIYrw+14PAzkyMth7UtIhYZgpLqbfKaCxYwwOF5fMg/RdbXVfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304106; c=relaxed/simple;
	bh=iBP7ZlMwHaIAZkwib78zmh5FwjsdAw8CIHlvgSbJY8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtCS8ndFK8EX73W3L2c7g0phVjkeg6+4rPWSjuzrYZZBP7HHnoFOYVNWj4uC/lLC6uBQJrlTmybyB1eh3RRPcqlqX1WVYETS75mDtLtC9RyF/TlThLh6Y0grioLtlYSGCBUdnxKIhTAcVv/uTuPszCvkhJQ1+Q1ldKe6totJ8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MD3X8VsX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719304094; bh=iBP7ZlMwHaIAZkwib78zmh5FwjsdAw8CIHlvgSbJY8A=;
	h=From:To:Cc:Subject:Date;
	b=MD3X8VsXcvH3Esj1TBeJK8KPziI35NEuSzNssImJqEjZszdgYxmR4AH0vlnj+MevX
	 Wugah7Onw6bcCAwhp7ZyKOjo7ijRpOlNt3kgdGk8rVjsihKeItQtvom3VFDD/S5CwX
	 emPfKsdv5sT9FmksqF9AcJagegq4qM6YbtFR8QLxTu7Z4ZnQ4kgsdbElQsImWs4/D3
	 xpPDsezYkoaEBictJ3mhB9XFHzcL18m4b9E+X2LCpcHb+VfANUsHnFZZUVFruqYleN
	 vTIStJhxN9eMFMcw982V28Vcifdq2Ceb1464poF0FNDW7HT9gKqwXyz0gPC7gfMjLh
	 NGjLDPyzTpd6A==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: kauschluss@disroot.org
Subject: [PATCH] iio: st_sensors: relax WhoAmI check in st_sensors_verify_id()
Date: Tue, 25 Jun 2024 13:57:55 +0530
Message-ID: <20240625082800.62305-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hard matching against the WhoAmI values isn't ideal for using devices
which are compatible with existing ones. Instead of raising an error,
issue a warning instead, thus allowing the driver to continue probing.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index c77d7bdcc121..c69399ac6657 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -606,10 +606,9 @@ int st_sensors_verify_id(struct iio_dev *indio_dev)
 		}
 
 		if (sdata->sensor_settings->wai != wai) {
-			dev_err(&indio_dev->dev,
+			dev_warn(&indio_dev->dev,
 				"%s: WhoAmI mismatch (0x%x).\n",
 				indio_dev->name, wai);
-			return -EINVAL;
 		}
 	}
 
-- 
2.45.2


