Return-Path: <linux-iio+bounces-9428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7A972C4A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FBF2875B3
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC61862BD;
	Tue, 10 Sep 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="bx+/lKtW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0A185B4F;
	Tue, 10 Sep 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957474; cv=none; b=NNt9D4Tl313cEAXaLocxXJV846qJLNdAtQcfELOHQ634Uuj4yvea6738lr/gyptVUOgs+u12WQFZa5HVRzd6y05Jc8EUaLxyJyidBl4Cgzu3Lbz569sMUps3pOvOVRR15e/Hc6y8ZZjpdTs85+zF+jpRXadFxmcS7upYBJCc1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957474; c=relaxed/simple;
	bh=VgY33WKq4M7AZoWAoxDf6aHPRTan11anSQWyyjX2yTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bsa60I97OJ4Wo9gdxdp95o7lCtmLzIG2CK4sUNjwB+opZE0UxEGAxQNGR5N7ZDa2IKE4QUUwFdoPB2xDpU94pUKfZJfI3z86u8C+Xrgz3RloDJwgsyJGPpHYGJNsgjO+LN+8FnxiI/j6MleFtMHu0e0MbuyVzFWENSsJgBEUQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=bx+/lKtW; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 62F0717EB76CF;
	Tue, 10 Sep 2024 11:37:42 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RMIl3gRd53L2; Tue, 10 Sep 2024 11:37:42 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 378DC17EF89EB;
	Tue, 10 Sep 2024 11:37:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 378DC17EF89EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1725957462;
	bh=hPSAedrUXh+YSHdaoVA6PILMGeS+TlCtpwfGwxJwoW8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=bx+/lKtWvUqQATZfHdZ9AmLMxh7lEu75ofVHfvBH9q5nxgMmYPrldGanuKsk5a78j
	 hVv286+CwyhTGgHLsHGoYObqJvGdjRMXceBqZyZs61RuUB6qkV0n5r1rcad07pzHTe
	 cEpo2HkMGdA3Ut+2u8bUGOOCXkELuyYW9GYSAbmTiqNBOGxMJjPnLXcdXSvE1pdvgz
	 MeYp426WefZk6px6AUdPiSgQjkFTW91fEyab9LPYBSm0C21AZpBevw+8vEwo0md9kV
	 k4f/bmQbEAw1nTeN9wbUYFq3eQkTE0gvHpLv+3SvWqKDmi7JIVT43QmYnD1X1MdcUt
	 4uqz0hAOWg6eg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VvMrvAcM9zgg; Tue, 10 Sep 2024 11:37:42 +0300 (MSK)
Received: from localhost.localdomain (unknown [89.169.48.235])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id D99B517EB76CF;
	Tue, 10 Sep 2024 11:37:41 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Dan Robertson <dan@dlrobertson.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iio: accel: bma400: Fix uninitialized variable field_value in tap event handling.
Date: Tue, 10 Sep 2024 04:36:20 -0400
Message-ID: <20240910083624.27224-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the current implementation, the local variable field_value is used
without prior initialization, which may lead to reading uninitialized
memory. Specifically, in the macro set_mask_bits, the initial
(potentially uninitialized) value of the buffer is copied into old__,
and a mask is applied to calculate new__. A similar issue was resolved in
commit 6ee2a7058fea ("iio: accel: bma400: Fix smatch warning based on use
of unintialized value.").

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and doub=
le tap events")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/iio/accel/bma400_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_c=
ore.c
index e90e2f01550a..04083b7395ab 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1219,7 +1219,8 @@ static int bma400_activity_event_en(struct bma400_d=
ata *data,
 static int bma400_tap_event_en(struct bma400_data *data,
 			       enum iio_event_direction dir, int state)
 {
-	unsigned int mask, field_value;
+	unsigned int mask;
+	unsigned int field_value =3D 0;
 	int ret;
=20
 	/*
--=20
2.43.0


