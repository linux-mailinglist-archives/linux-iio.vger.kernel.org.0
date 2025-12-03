Return-Path: <linux-iio+bounces-26691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA48CA0EDF
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 19:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF43342ACF2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF2333445;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4d58lu3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD1332EC1
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777177; cv=none; b=M8iZNLqu/LRQ+s8EOvpFbtuw0V43kovvY5oNSIZ4Ggg/vcRpzc5cOVolzC7tNZPyiTsMaWb7FmrtQYTgNkfXOIi2k3H09y/UVqO6osHdVPnsfznchqfBL2aqDQZjulyUPI8TvehOXVD9yqI9//wUSXd6Rmpi00fnyA8qSGWbWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777177; c=relaxed/simple;
	bh=fGSf8E3JveGiTE8pVaaHQYXfROcHHbPjoi7b3BAjRQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCMGlXnW7mJ/1mnINiN2ABrVeE7butqSpcjPupR82XFZrKWeii8vKi/0aLELgzViQ823Gux60bb07R26laUUOU+jr9eu11wgceuFmxkUCXYi1sXSvwBUpSTwym/GkqsP3rs3PgpISP4KtqpLE9c7/nLZ8tHNCiKSRrfaX7p6z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4d58lu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F688C19425;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777177;
	bh=fGSf8E3JveGiTE8pVaaHQYXfROcHHbPjoi7b3BAjRQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q4d58lu3N2EgCrULO8h7WsbB3KtByhWJhzj0+q+5VGotaEASfV2PfM7h0wCciWt++
	 ew5talNSqUOD4W1vxE/3MhkhxQbfu31ZpmFjO7A6w0TqiSUmlVkJydMyGlEk/lzeZv
	 Z4WnwzXVyXy/aM+In2Q+wNKI7Bwf9EB0vZXdyPgbt5y8qQJIZl728hwlM7sslpWiXn
	 jw9afzIP3/k7tDIcFI7UFBxC667n37C3gy/Wxcd/PfrCR1Qfzs7I92jI1mC2dxW6Yz
	 mcQM13DpVjsNnXz4URogn13I7eNfdQ0Y7e/vubF0k+jTiZnDaY9d52g2hBle1nXN/H
	 EZiBjs5ukgWsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B31D15DAB;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:53:37 +0000
Subject: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into dev_dbg()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
References: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
In-Reply-To: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764777217; l=1060;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1mI9GzMK+TpvyOBmx5lCXv0qeg/FjUA9vszGxDZhgKY=;
 b=9tDz+tZ9RJa0R8s70CoAHiXLhVcI7X6TDG5p3DQYZG3bJerInFLz9b/0HNsvp9tHAaPnwsuDc
 jXNn1iSza1hBrMJ+29drVFyFlq8Ir60hiuSQwkPNyyBhzXA7xxwFtTv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

We should not abuse logging and logging a successful probe is clearly
abuse. Turn it into dev_dbg().

If it turns out the IP version is that relevant we can make it easy to
get through a new debugfs interface later on.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0c7b62f5357d..f536158beb4c 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -1000,10 +1000,10 @@ static int axi_dac_probe(struct platform_device *pdev)
 						"cannot create device.");
 	}
 
-	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
-		 ADI_AXI_PCORE_VER_MAJOR(ver),
-		 ADI_AXI_PCORE_VER_MINOR(ver),
-		 ADI_AXI_PCORE_VER_PATCH(ver));
+	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
+		ADI_AXI_PCORE_VER_MAJOR(ver),
+		ADI_AXI_PCORE_VER_MINOR(ver),
+		ADI_AXI_PCORE_VER_PATCH(ver));
 
 	return 0;
 }

-- 
2.52.0



