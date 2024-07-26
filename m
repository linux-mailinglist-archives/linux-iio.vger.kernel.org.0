Return-Path: <linux-iio+bounces-7929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC493CF94
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F358EB22D6B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3117839D;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuHaNQrC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB05178388;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=nSui+KbkuRGqPztjazn5Miz/J3tOJEcVNM2KJhTU1ihwEa194fAFHVQHtLpH+Tj8TglGtFJMOb7uRwc1QWgoWy+Kte7P4NbI3jq1Cjcw5oiNCwTnWeKNzQojtzjHgHXd5l93vknJUtFLpBoXg46sEeC4rwDuqUYiO7pFi/NWEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=KrQFhJf8FJDPGFqDrIHncRfLunmp581qO6wFP16R3JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acD6OxTnKEiaOZ4FqPfc+y8ZVTGUrY1WAZ2pOsWnzTG5FW77UxKhh9nxgFlOd1TaawF6YbhCKZD8Mq/rRLsY5w4GnLXz6gmXlE+Ixg3RAeheL8ykLbwhkiZNgT1uwAv2Kg65eSQPTR0eDgEXSQETs8Hh9gzuIxStd8agnVcnAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuHaNQrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B105C4AF1D;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=KrQFhJf8FJDPGFqDrIHncRfLunmp581qO6wFP16R3JY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PuHaNQrCNsmECy4xAHjFIzgKYFpcWU8bSSJLeoqCWD1RpOhVTD8wAEo/Vy9kI3cho
	 mE/2Q3GJci70m2mM0LMSY0hbKIE5L/S+RxVehvPtgs+KnVdV6wq132ISQu4o1BMwjZ
	 7uRocN3i2xps6GfA1T9RgH/l2TBrJoNQNXZiQ+BE4y7NxQ7vY7ea5ymNLiAMmBWndq
	 /K3zXbKhx3J8N/zsmS5TNyy8HKfTPwyjRkfKWyDTpYbS1qLi6xlsBwFhrRErXha2mZ
	 eYLh66ZFqDTTb+UFwWawgQbFQMDTP0xpD1wqOXO2kc11bSnjSqv+wNrzVHNtBtLj4F
	 2is6kOyIs3kdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B1C3DA49;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:13 +0200
Subject: [PATCH 21/23] iio: common: cros_ec_sensors_core: use new
 '.masklength' accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-21-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=1662;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=S8zIGb8Q4J9OHT5HsG9OinrLXTwNMakjT8op5GXXE1Q=;
 b=NK1YNz2usGK6ZYEbW1KxXqE/y+5B8S9jPIFusiFf8GoS2xQqvs/foDTlHzqAb+wzExuDIJ4Cd
 Jf4LQ7byffkCFvUqaIcW+M4XkU2ITSkc9AVnPhiLqqd9hXJVqAXKYgU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of iio_get_masklength) and iio_for_each_active_channel() to
access '.masklength' so it can be annotated as __private when there
are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 6bfe5d6847e75..9fc71a73caa12 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -198,9 +198,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 		return 0;
 
 	out = (s16 *)st->samples;
-	for_each_set_bit(i,
-			 indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		*out = data[i];
 		out++;
 	}
@@ -587,7 +585,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
 	int ret;
 
 	/* Read all sensors enabled in scan_mask. Each value is 2 bytes. */
-	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+	for_each_set_bit(i, &scan_mask, iio_get_masklength(indio_dev)) {
 		ret = cros_ec_sensors_cmd_read_u16(ec,
 					     cros_ec_sensors_idx_to_reg(st, i),
 					     data);
@@ -683,7 +681,7 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+	for_each_set_bit(i, &scan_mask, iio_get_masklength(indio_dev)) {
 		*data = st->resp->data.data[i];
 		data++;
 	}

-- 
2.45.2



