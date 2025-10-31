Return-Path: <linux-iio+bounces-25744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF80C25037
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8714224C8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8E34A3A4;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stN/Zkj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D843491DD
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=Af0+yRMOVyQMtrLN6A33X1goD76vsZIY2mvKV8+etu04VsdlhvgBDeqhxPAnFGu6v/G1HHne8jQ5v6PQfzLBoYDXIjwfgpOUivZMT8hTselUQA/SaFkTJC1OttX9RjXkccYhUYHPXuts8dBWfPZ3NbP6JlpRnCUZLfCD12NtUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=Rw8Z4+XEi+wyBDkcnVQV93WN7A8hmTXpTZAoSjx7aBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UN6ue1gNAluwmq4zH9A+uNeGd5jqFNyTLXlIlliWVAMAe45oYyV9VEdhI6rBqiqkNXSxOZkXwrZqrKtGzbBO9jE4DCza2RQRxlbsjhuV6tjsDBMjM+9+Q3/nozMBW1ptIyOtXTZdefhvupjCtaT7Qkek8QTGIBo+HamZ2YpGnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stN/Zkj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15902C4CEF8;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913862;
	bh=Rw8Z4+XEi+wyBDkcnVQV93WN7A8hmTXpTZAoSjx7aBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=stN/Zkj40u4XrJNyvUWNGRxbzRqCVxXVZci9fRd5mKy17qtiVWJ/1R8/77QmzbPhR
	 ybr7l1feQlK8NM75gBrw+sBNCMbaEZsNiBMF08m8208/U1p6oOOVtrDXr4ibo/WWW3
	 Cl3l4ZzE7ES9V5nOqkuiyGgB0wK5BjzEwzohlDbCFT/BfPQqgjn2IpZH3FxmfiehmB
	 FbS1E4rjSrv8eriAvzaCMZRKtNj9hWvQmguR0ke8CPhtRePnJutcs5dJLnP9jPdE65
	 8oTwqyfNeBmcKZQ6YGGPX1F1VmLw+qDfrzeBAZRLcYbujBbE2k89PBaepEPzpScA8p
	 MhpHI2LLJ6nnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56ACCF9FE;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:28 +0000
Subject: [PATCH v3 07/10] iio: dac: ad5446: Make use of devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-7-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=695;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TcScp9YMNX1T1uCOCkW6UV53t32jVxdLnSxBaxEQVpg=;
 b=fqW9yst1QG5QptxYiIou7zHVZGbfsEuqlacQaljawvXKwU+PJjZmJ9mq4LYXZPo7W3DQY4EJZ
 OKJkNLl3Io/BDkzRZwYSOGFakyp1znpF3QQH65TsOJQH5W3Aexrsp7G
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use devm_mutex_init() which is helpful with CONFIG_DEBUG_MUTEXES.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 790e24770062..d9fc69e1039f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -184,7 +184,9 @@ int ad5446_probe(struct device *dev, const char *name,
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->pwr_down_mode = MODE_PWRDWN_1k;
 

-- 
2.51.0



