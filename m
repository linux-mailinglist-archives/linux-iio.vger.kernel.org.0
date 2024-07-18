Return-Path: <linux-iio+bounces-7685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849B934E54
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97CD1C22847
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5913EFEF;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAKiUB+f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DE13DDC7
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=c5qAd+kvRBttMGwvnPJgv+8de1d+PsoradDr3AY8rgPdYOJsEA8Ls1lZFjlIswppaVehE4uc0D54Kwa7GEcv+0qF9MSLvBSnukql8cXoQqSllbYTkh1YjWc6HhDd+eTf1qKAsauimcq3jE/Qoa1WmPPonnNcJhvOhykGijVYPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=Tuwpk/aqmBQEqJUdyzDzw6ui/akzpLbe+aopsBoMIJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tn5LXfxvGMboP/JGK4VtMus+5S5im1xr/+DRvsRDxnC738TMYyd7kiYruo7IpRotwVzUYT8WwBEARUf2krcrcVHDIp3XKG1tWeD3F5W/BZOPJqWP/eJS4mQxePy+gV3VeW4km/Q7EH0Lp5joptiC8Ylhq1ngvLvZ6Tua0LKLXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAKiUB+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78497C4AF14;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=Tuwpk/aqmBQEqJUdyzDzw6ui/akzpLbe+aopsBoMIJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZAKiUB+fejEl+d2cCORpN/bCZKETn8YdqcOrgwSXkWVRJTbam2YPpdKUR//LHUktb
	 sXtnWiV+VOYP3ajAsFtmIMYXJfQmG4JNiml4o/e/oe+oiLRvJvv9Sgy/AazPTHoaXG
	 hkgNPD7ak9NIPASvdkbqRNamwLFsNyhkGil60eU5CIf63pAqzdl63VEQf3ipKNHQmM
	 1KctJHnS6WMgUe6TLXYSDqPwuIvzyEdFWlZUO5tmultpByj7Rgqm200JfIimJnAUCg
	 c0fCO02P3AB+Z67TtF6XrjY2J6IZcPpR2AUDAkQKcFd0E5zwDfKeBMJd9eR8wJh1Rn
	 WgLIM3+QQU1Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A0C3DA63;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:51 +0200
Subject: [PATCH 05/22] iio: health: afe4403: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-5-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=875;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6tp4obCLiDRZ8R0W142pAzIZiL2MQwENy2R1UHKy5HY=;
 b=yuLejtozZFgSU4xKAxP2iidJUylcr49KdPtdA4shuLIIzE6LFDLJrQykH89vmClPIqhhVwgyl
 G6fgUkk8OVmDryS06iCSehJDrTeowtp9Z2ehJ5BLtQti0Xvj8MLH1xT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/health/afe4403.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 52326dc521ac..85637e8ac45f 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -321,8 +321,7 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	if (ret)
 		goto err;
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = spi_write_then_read(afe->spi,
 					  &afe4403_channel_values[bit], 1,
 					  rx, sizeof(rx));

-- 
2.45.2



