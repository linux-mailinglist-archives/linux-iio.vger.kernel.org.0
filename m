Return-Path: <linux-iio+bounces-16607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FEBA585FB
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345093ABC98
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA491DE8B8;
	Sun,  9 Mar 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti60d1PA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CD1DEFD0
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540010; cv=none; b=ZIrJkEYnBCLIzsGfq+EuwoAGtmRwXNT0w5upgOSTft6DgNvo9R1QLTgLEmrsF2ugBC67iVP4+5lw0Uja7Djf8UQj4tnSIuN3kyT0+kiYEMGVxd8aHz5omecwkr8LpE+bPMK63pe44+9a0zk3z8ekh4oMcQEhCNmWnIEvQ+0GLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540010; c=relaxed/simple;
	bh=k0SxrHoPHzJr884c6rJdiNWgZyDmS6FFwYIu/xA6y1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4PChyN5eMI5yGUzVq7zesvA8/JIEm/xKJLnFGaXrS52IpW3cecwVbHoyjR6Rjm03Fr40pSa4Xbu2yF3XybQXBTXzvSQTD+v/PstrzWiUHYtNeRBBjj8y7DlqMmeKEoqmsjmyD6yyl3u6ScSDkL4EUarS/2lLqrDyM0pGH8U9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti60d1PA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37E8C4CEE5;
	Sun,  9 Mar 2025 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540010;
	bh=k0SxrHoPHzJr884c6rJdiNWgZyDmS6FFwYIu/xA6y1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ti60d1PANl0GU8IvzQEjDLfWr39H/nSChM8Yq06ay6u4Dy9JKWj2AvAarfAaf7BRo
	 Z2LjX2SEcfmkOXA7k2KcjBYRzHlbb+3Wr5D3JeFUIlB3doLyqq5tJPztSImlUneqXr
	 KRu+8+zPo+7i1dnaAdgz5FTwdMQqgN8ZWdIS/BOyAJlgS+FDGt64hI2AqV3dTA9txS
	 ipPmBQyP/hcFW4vQccj23Q2K0tVJa/Q1IoccJ6OSf9yGlrm412H1OmaMTj1TTEO4sn
	 dlOXeEUo4coIVVSdmV7oM/lk44J8xkLCisU3rLBX4mkMUNzeXGgni2qt1tRX+BZhBu
	 QpJhxSfVwl5pA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/18] iio: light: apds9306: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:16 +0000
Message-ID: <20250309170633.1347476-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 drivers/iio/light/apds9306.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 69a0d609cffc..fca7e73a905c 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -831,11 +831,10 @@ static int apds9306_read_raw(struct iio_dev *indio_dev,
 		 * Changing device parameters during adc operation, resets
 		 * the ADC which has to avoided.
 		 */
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = apds9306_read_data(data, val, reg);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 
-- 
2.48.1


