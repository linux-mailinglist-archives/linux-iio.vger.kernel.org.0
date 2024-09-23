Return-Path: <linux-iio+bounces-9744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C402097ED69
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD15281BC8
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E119ABAB;
	Mon, 23 Sep 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSqtbZOL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F124126BFE;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103211; cv=none; b=PDNm81OyhDvpjqwDx5APYKDCOLZwwQVTi9jZV5v7XW0GR2PX/8REH+4kVSfqKAAaizfzx7rXYbJNcTAFjTT1Dg8JQJcM/KuQxIbJC56FHQdd8N575l0E8tEs7vWntFCmyMprWCehSgjZzmNoS9tx4oVCerzLEpcZY+YHJuWuYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103211; c=relaxed/simple;
	bh=nKwqZC0rEOeleKnqcEnAwn2FC3PO/cMvKnG1Hs4oV0k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rq3FEuxynKqwjHgCZ0gT/JtiWpjQ7diELI8Y3tWEtrFrUtVERJEECK7tvm7xfFPZNO5n0gqz06RW2u6p+lhNgDdPrPxRtwxzKT98lXqW0h8TswwFzr4eRcLW0H1n0Fdxlf+3eTJX2usBrURqlMXyUwC20qUJUkS6EmvhHAuaXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSqtbZOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8C0EC4CEC4;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727103210;
	bh=nKwqZC0rEOeleKnqcEnAwn2FC3PO/cMvKnG1Hs4oV0k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FSqtbZOLQe7WZ6y4IYs8FUyiAm8Z2GUVTPZI4BMxHpB+3b/ED8izMku9uNHyeUwT5
	 49hC3cFMqVVC6QCJHvCFAlrZ3eW9XWy/tXj/fFGGEL9IUwTRrqQrx9xiGCKwnZk95n
	 Zq0pyiBgUZxTDF/f2F8fyAXN654fXrMEkhiQjXBKO1tB7YvsvrIgAP/9s8jA5SV5wd
	 9APdYJm5ntKKLDg1l2mpDP9zfokBN7hxH1VD7WGcteIOVSKY8rlQKvHHHbepgJOO6M
	 516tQp39L+m3n9MDr1aPSfd7ga8hoR+gqvh/3dtAXoSwdjhiAJZsQ272z5BchRY15S
	 j3vX4Dek6LioA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0ECF9C6F;
	Mon, 23 Sep 2024 14:53:30 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/2] Add support of IAM-20680 HP & HT
Date: Mon, 23 Sep 2024 16:53:20 +0200
Message-Id: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCA8WYC/x3NwQrCMAyA4VcZORsI6VasryIeMpvZHFZLq0MYe
 /cVj9/l/3doWk0b3IYdqm7W7J07+DLAM0l+KVrsBiYeKbBDyxuu5etpIpQY0WRl8lfC9MFUcJl
 kZAk+ODdDj5Sqi/3+g/vjOE4Vr5wRcAAAAA==
X-Change-ID: 20240923-inv-mpu6050-add-iam20680-ht-hp-f5a42a96933b
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727103209; l=1076;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=nKwqZC0rEOeleKnqcEnAwn2FC3PO/cMvKnG1Hs4oV0k=;
 b=+fg/gqi4YuYK/P3eSCPIUczNFoHJgDxTpEbozIsYbMS2ZVEdzJv34mt4OWjCG4ILzbcwn6yOl
 n0r6nREKFjiC/Roz6feDjXRkBS/PTLDmWG++uhSXLC6XbDkd33uH/Uq
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

Add support of IAM-20680 HP & HT variants. These chips have better
hardware specs and a bigger FIFO while retaining full compatibility with
IAM-20680.

Changes for v2:
* Send patches to the correct list (devicetree was missing)

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Jean-Baptiste Maneyrol (2):
      dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
      iio: imu: inv_mpu6050: add support for IAM-20680HT/HP

 .../bindings/iio/imu/invensense,mpu6050.yaml         |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c           | 20 ++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c            | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h            |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c            | 10 ++++++++++
 5 files changed, 49 insertions(+)
---
base-commit: 1504ee03b6e48187348d20f6efc74e7d93855728
change-id: 20240923-inv-mpu6050-add-iam20680-ht-hp-f5a42a96933b

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



