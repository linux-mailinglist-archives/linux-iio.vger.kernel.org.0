Return-Path: <linux-iio+bounces-22478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE0B1ECDB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660BC567B21
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACB286418;
	Fri,  8 Aug 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLCsCI9C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18727BF84
	for <linux-iio@vger.kernel.org>; Fri,  8 Aug 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669548; cv=none; b=V98fnErdblhxq8hhBbnzZr0Ii+5fptXRXo1bpiPSxIXnxWQxze6C/imZNz6n1HMW5aryZrAGvDQ0DYJjDjFDuVrCcZsTSYtDg3urCOXs7lCpFW9yXF76dKDknwCGlH22ChdVFQIArijtAuH9MvjlrGdA3gfS3aYZkTWxZCc3Mes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669548; c=relaxed/simple;
	bh=iDCLx8+D2vtjx70DIk0za8K/wYOwxzy9DG65a9st3TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SFnyC9m2DzEH/UTNbfEiN+GUnnj+9qGG+J7L5lBYnh2W5vsg/9Lu71e8tzygk7A7ZjAN0O8ItFEAXBQW38ycBTUiaSCVTMQXxiSxgpNEkT7iYv4DcyP3YtChEfhowCN/0aPqYcnkLOtKK0G7BXuch36MivOsijIKzUoxCiVdNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLCsCI9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20BFCC4CEF6;
	Fri,  8 Aug 2025 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754669548;
	bh=iDCLx8+D2vtjx70DIk0za8K/wYOwxzy9DG65a9st3TU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BLCsCI9C+BJA8FOjMiA7SzDI6qe0ukGQOUZeuPWZyHmhv5UQ0T0hn+bQ6pvfMJ65C
	 h13wRmILVbJDaM+vpJLWFtCQgwVgEJnNSLMnQ4JUD203Mu+aXUzJzSuS0s4JSoX1jc
	 6+yHGvfOJX/1jxXbU2hNEL1O6rNQzjV8L037bjNPrcUg29ZkbiQs0tyy/edubIzkSn
	 f0uMLP1IbdAoih2WfyoMqED2eEDPXMKAHYxfKMHwwIt/EFrZDYZ+uh9iKXa8ibDVyU
	 EEt4rtocDHnA2aJWxNlRtN4/ZVz+TipqUQqG6VxqzS0cJaFP1uaYoD1MhcY3ts0EJN
	 HMKJMhs7Y+zgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10952C87FDA;
	Fri,  8 Aug 2025 16:12:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Aug 2025 17:12:33 +0100
Subject: [PATCH] iio: imu: adis16475: remove extra line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-adis15475-extraline-v1-1-e3259a466e95@analog.com>
X-B4-Tracking: v=1; b=H4sIAPAhlmgC/x3MQQqAIBBA0avIrBswa8q6SrSQmmogLDRCiO6et
 HyL/x+IHIQj9OqBwLdEOXxGWSiYNudXRpmzwWhD2mqLbpZYUt0ScrqC28UzUlUzNZ1dKtdCLs/
 Ai6T/Oozv+wGh5rU3ZQAAAA==
X-Change-ID: 20250808-adis15475-extraline-534e5698f3a7
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754669566; l=741;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=npUHJTmNVT2sPd9SnTgs4zrg1w76PUt3kTdlnAH1txE=;
 b=aGLHxdtRM+AYQt22tLWAfpXa4q/wiaOMtOjW0rDVpMVJ1RNJNsukV2VJweOFZTTPTQ8jDjXul
 +12ypwOeitsDdEKxVCkQFkpkEByPvAtxDXYko52+TtQagUz4WifmFfq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Remove extra line before adis16475_probe().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 924395b7e3b45dd3a6459d6eb788fa2ec86c4a29..ab39bea1e729ea8abb56dbbca3d5305dc1973083 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1930,7 +1930,6 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
 	return 0;
 }
 
-
 static int adis16475_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;

---
base-commit: 6408dba154079656d069a6a25fb3a8954959474c
change-id: 20250808-adis15475-extraline-534e5698f3a7
--

Thanks!
- Nuno Sá



