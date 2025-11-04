Return-Path: <linux-iio+bounces-25876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B856CC31E06
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80B4D4E6CD4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E827A324B2D;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAf1eOPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12C2C15B7;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=d0II7WvfF72gCdwChk/Wb78sqIHGhHkIBSkXXlYSapF9H4F5//G8nGb06L1SPHoVB3MwSHpji3sR41BGEkoF6jE01rGW8mTf8dzWmVN7c1JjbxsYTKylWQRz2IYTTh9MH4BuqX4BIqUvN7nuOVhT+LDJsgZY9T7AraclhaYvEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=O1KbXXqkKIoOS9eEnR9SxyXF0BQ7aFH1gzcBIpITaNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNHAHI3DGsbLwFs+ClenSRTQz31r/YH5hYse4wDaSGbNYwEXHxw4C3NnXTpd+BJFgtXI8AFiiBRvBbpIAr2ZTZggRa7ftIURz0v/zUntRs2jGdOofv4o3I5Io0HsQXm31mcAXQLKrVk7tcyLJiJmushMOFf7NbtQIra3muQaXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAf1eOPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53B06C2BC86;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=O1KbXXqkKIoOS9eEnR9SxyXF0BQ7aFH1gzcBIpITaNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CAf1eOPc+2d33X9rtcsWUu1JNKBRSpzE9SqwbKBOg9zCqq/lCMCQbonEhE0YcfSas
	 g5IlzF6QUWzg2OhvGXk/4d4ClvkR8PKyrD+dQ9BQsjTWNdZpaf/+OLCe6WUabBrhs5
	 Mu1GxSW8Fha+HuMCe/C7evbT+81kJODxQ6gYxG6Y6SDwOXdGywaGCq+k7oxhQlwUnX
	 wm9Z+5iEd5Qf/emkWFIoRVo3QUOGs1aBaCjuS9mMDyfwK0DFVGKvXXkqI/JQ3ua3o3
	 EUirjeaeHxw+QZQ4isqhYIpaAvrsnBYmXfvBxe6P4wMPPl0l99QqtzQhW9GnmboIWW
	 W0O1Sk1M+7rOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E011CCFA12;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:13 +0000
Subject: [PATCH v4 08/12] iio: dac: ad5446: Make use of devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-8-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=695;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8mzFmEgM7w3rsBt6qaEgYIGpFV7hcIrmz0viJjwtS/E=;
 b=VJ1oPWo5GnEBNCS/uv3iMubDjIzksi7J6sC/d9MjDYWmWd3VwizdiSYyKNsYBzruQaMnMQEWG
 EnzvVDy+gQZCw+T1JQfDFYNm8aQXFZidxZY5OvxhefxFMqkEG/9+zmt
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
index c7876217c7ec..59e1f67ef334 100644
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



