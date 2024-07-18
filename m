Return-Path: <linux-iio+bounces-7691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6638934E5B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99E21C2290B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A1140360;
	Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmznzegh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA313E41D
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309906; cv=none; b=l+ZCbytK2deVkGDoSPuoxtIcWYpGe/z0Dv0wwDQC4ieOL5eYnUgYdftHYnbUg3YdIQ+QajNQw+Qzo1uzGisc7uqMQu4ZcVSBy/XLLODNd0C0Cpkx99YD4CrtWwMZHfYAaRnM+IajRBnRK34t/gfEjWcomivJWK20LUy/KNVjLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309906; c=relaxed/simple;
	bh=NNjQN7J2L7xaT3aQ9I7ub3B8qixiSexMMl+KIPF+d+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hquUbnLmqOXE96dYleuQYkAbFcCYK9lapbyZ5bc3hFOB0Sqhkl+J8JqURhA9RMVTpz40KjtZ0KYIN57GSlXEQDJ344anP/CacEMKOjYIFkntNSV5O8iJizro8q6l3WyZXRXWiKGR/m2mlFGxF4szWn+lwbRXxsEj/VvXMHJMY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmznzegh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFFD5C4AF50;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309906;
	bh=NNjQN7J2L7xaT3aQ9I7ub3B8qixiSexMMl+KIPF+d+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rmznzeghNiHLKRwYj+aK9aOAUbOCLHLvhpykOIS9qFXqAnLjmp3olduOP8nQ9x+h4
	 0/0kxQ+EPlE32gmDYiBnt4q0LzD3HNNe7SqAEYp+LDeotQJzngnS6pFCILxw3clnar
	 t8/bsFqR9WGiolJRih/GIt93E3SAj1IQEjyauMpwYE629pD2idT+8txhJLIYBprNgj
	 grzjC/jSiEaOyKWjV3otp/s14Dn3KdRHmqp9M/wo/trzOHgfQ52C2IQo1FHyA6k6nG
	 RG3aH8+xRsDs+Jx7Zuz4+zB1aluN0QwQIWwhoZ/vo4uwia1EUsrcsym+yPTU+o3c2F
	 PJSw1RYY4FoEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A75C3DA49;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:59 +0200
Subject: [PATCH 13/22] iio: light: gp2ap020a00f: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-13-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=1716;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=iVAdgQB+Z4IwxRK4KcX4smk+miW5axW1/Zjw6uLW21E=;
 b=7K8V1J0806sMudf1VLaWcWBtMWSwCfjZ1Mly0z4YAGqDqP/2zcvrxhbjm8eAGWGeBRexmZ29P
 /i01BwZhG1VBTPVO4Oc6bvSC29pJ6D9t7jE78bSzDlT27WA+/yhKddQ
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
 drivers/iio/light/gp2ap020a00f.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 757383456da6..b3f87dded040 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -965,8 +965,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	size_t d_size = 0;
 	int i, out_val, ret;
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(priv->regmap,
 				GP2AP020A00F_DATA_REG(i),
 				&priv->buffer[d_size], 2);
@@ -1397,8 +1396,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
 	 * two separate IIO channels they are treated in the driver logic
 	 * as if they were controlled independently.
 	 */
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		switch (i) {
 		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
 			err = gp2ap020a00f_exec_cmd(data,
@@ -1435,8 +1433,7 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		switch (i) {
 		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
 			err = gp2ap020a00f_exec_cmd(data,

-- 
2.45.2



