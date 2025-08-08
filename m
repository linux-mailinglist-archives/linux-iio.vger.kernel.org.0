Return-Path: <linux-iio+bounces-22428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31499B1E3B1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4716B7255B6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24622541F;
	Fri,  8 Aug 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUp5q7py"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35601EE019;
	Fri,  8 Aug 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638812; cv=none; b=ULSoGDDEVzFe1E437P1IxigdXqHL/TGZToE56I/nA3uL/f+b+C/BsThjwjqHPwvYrKxcXD5h+ndT/tRXFXAXtpScVHsen/1X8LWfHevoJ7bIgjvtLOTA3I3Eo7znK3++9ZovK9/lAaqTizRRnS0sUvrpRZBHhSGRGAKnHC47TkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638812; c=relaxed/simple;
	bh=VmEZ34d/BfDqCjXVktgRfwADPDnoWkyW/gk7BmB/x1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZVn5mcMTqBFX1JYbiPE+DbrxOIdQnJiC+aRbszEfhK/a96GKTs0woSBchQSMOsOdh+Mt20qykMr4Q5bF06AKsUWuWjKo1i0CNq5Y0NcEHoU22R9UybhkjKCe7+weC4iOU9XhzQPIFFJeTO37veQBdjqfsYGQz/EwlZZHiMD/bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUp5q7py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 826D2C4CEED;
	Fri,  8 Aug 2025 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754638811;
	bh=VmEZ34d/BfDqCjXVktgRfwADPDnoWkyW/gk7BmB/x1Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AUp5q7pyx4AIAF0bU9xw33qIiIyBXHwnIwWWqSK3s45ov3ocuVjXtRn4hNcndLdCc
	 dKloqpHmHosGnYJlxxmVurdEb/9wpxvVOfuzxYuc/vb3nzv5TfSO4UY5IbjwPZeUzg
	 ozAKqudPtXMOKa4eQubk+b7FicDw/8f8W1p2rLawjkNHZ86kD24umsJ4oSg/qs+mtQ
	 OTUa15y/FOxttaJGHIxYMr3wR3j5cx8zuqkmbFKDA3ddhxUUBlcwoWuphHDk0impX/
	 Z7s/Jno02zTLZKe/KbV8zcZbPwMJHNcO6w4x3piMTIyPr7v+NdRzSjGw+NtrpTd3hM
	 Jy2DFNbsLBBog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7850BC87FD2;
	Fri,  8 Aug 2025 07:40:11 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 08 Aug 2025 09:40:10 +0200
Subject: [PATCH] iio: imu: inv_icm42600: change invalid data error to EBUSY
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
X-B4-Tracking: v=1; b=H4sIANmplWgC/y2NwQqDMBAFf0X23IUkaGr7K6WHkLy2ezCRjUpB/
 HdD6XFgmNmpQgWV7t1Oik2qlNzAXjqKn5DfYEmNyRk3mNFcWfLGEqfeeWP4ryyYZmhYVgVDtSj
 HksB+SNaH2xg9LLXgrHjJ9zd7PI/jBD+8oqZ8AAAA
X-Change-ID: 20250807-inv-icm42600-change-temperature-error-code-65d16a98c6e1
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754638810; l=1568;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=NpeRL441DPZ1rC1rEkgDPmcWmaZUMbzkqnfYNLrMji8=;
 b=EPMyM5pzy8BkOiqIAuGm4MBI6sE8S7x+CcXBqShuVr25CsSsqrrzPnoiR5Nq0tEH5xd4Ivn8B
 M1Bjef2/BL/C2SkgfYqYreeV0aECEBlblVdSc4X409EmjW8Sx3FSa/g
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Temperature sensor returns the temperature of the mechanical parts
of the chip. If both accel and gyro are off, temperature sensor is
also automatically turned off and return invalid data.

In this case, returning EBUSY error code is better then EINVAL and
indicates userspace that it needs to retry reading temperature in
another context.

Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 8b15afca498cb5dfa7e056a60d3c78e419f11b29..1756f3d07049a26038776a35d9242f3dd1320354 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 		goto exit;
 
 	*temp = (s16)be16_to_cpup(raw);
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return EBUSY in this case.
+	 */
 	if (*temp == INV_ICM42600_DATA_INVALID)
-		ret = -EINVAL;
+		ret = -EBUSY;
 
 exit:
 	mutex_unlock(&st->lock);

---
base-commit: 6408dba154079656d069a6a25fb3a8954959474c
change-id: 20250807-inv-icm42600-change-temperature-error-code-65d16a98c6e1

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



