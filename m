Return-Path: <linux-iio+bounces-25461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACAAC0DAF5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7904F6B41
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3F2E2EEE;
	Mon, 27 Oct 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAJwR5FR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211E3BB4A;
	Mon, 27 Oct 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568935; cv=none; b=aZKCwyCWzJ4Fqf42/J5v5FCvCbc/lgfN4toUKNe2W5YCgIW1ap3+dAqC52KtMj/+DC9SZGnyj+tfVyi1d1OT2wNTgOqLOpJXdlV/pUbWnu0yo3fCO7t7FfmpHrwpSUZHAZTNcPGOCQNUAP9x16w5OX5vfTPihMlacXuKKiR4pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568935; c=relaxed/simple;
	bh=KD75sUwvrRjHB7yDYrRRvxYAC7F4QHY5w4Dp1x6bWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hr8lmbLHp0+MQxCE5YXlBVpunUk7f0PH3wGwaNvU9mbS1cYxYgniG6dBkpfA3hacdbg4zILUcKrDILK3yRJvj2QpfXjkBgLTSJve78AvPfNr2JvY0vuNVM3s5H3x673VUyzF9pSCounhV4BaBUvX2EyeVJoJ7T4XG7xZusQmbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAJwR5FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55351C113D0;
	Mon, 27 Oct 2025 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568934;
	bh=KD75sUwvrRjHB7yDYrRRvxYAC7F4QHY5w4Dp1x6bWpw=;
	h=From:To:Cc:Subject:Date:From;
	b=MAJwR5FR2GxEvc6wgl3NRlJZ6XmeIqi8sDxoYnjDBhT6Bjs0DV+lODAnR3CMjg5Zt
	 NZgBl/5yo7YFALBrMh/25buLi/4XkeojAXdntX0+PGbeBTGBmnMXiYVSpXBrmpVUm6
	 WvT+NJWHaw1YOMvdz109zdWVl6DFf6CbwntuaLhdboFsz0XoGNKrMt4npHini41Q/C
	 e5Np7VMnh4nrh0L9dSN8wTOYCNN17/r8BlfjjDl6FP+NOew7hk2GH7MumFJ18XXG/4
	 GMVgO+rjKaWIfaoLgO51VlN9Wm27YDoacjIx/SUmjuu4bncXrFi2JZGauoIbMiFW2j
	 5S/wV3Oa7mw2A==
Received: by wens.tw (Postfix, from userid 1000)
	id 82B5A5FE2C; Mon, 27 Oct 2025 20:42:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: Use datasheet name as fallback for label
Date: Mon, 27 Oct 2025 20:42:09 +0800
Message-ID: <20251027124210.788962-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some IIO drivers do not provide labels or extended names for their
channels. However they may provide datasheet names. axp20x-adc is
one such example.

Use the datasheet name as a fallback for the channel label. This mainly
benefits iio-hwmon by letting the produced hwmon sensors have more
meaningful names rather than in_voltageX.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/iio/industrialio-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 88c3d585a1bd..d410ea2e7963 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -749,6 +749,9 @@ ssize_t do_iio_read_channel_label(struct iio_dev *indio_dev,
 	if (c->extend_name)
 		return sysfs_emit(buf, "%s\n", c->extend_name);
 
+	if (c->datasheet_name)
+		return sysfs_emit(buf, "%s\n", c->datasheet_name);
+
 	return -EINVAL;
 }
 
-- 
2.47.3


