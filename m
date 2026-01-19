Return-Path: <linux-iio+bounces-27965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED62D3AD07
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367EE306262D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8837F75F;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAd/aon/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A2329E50;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=O+rUXUc4CfYcddG83b6MWjZqCyohS0GyoOSgY54EEut8mPNgW+u0VuskzXp28nPCRhPgjrZ59dqtp3dudPNLPzQ2euFMVp5JtMxC2XV3WnzPgEl4RwvGhTj0HCY3J/W3WoxewIkseiY3ApCx+5sFd9EW68zCXt1GFv9ox+7B0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=UyScQ2ACRZSy/lz8cbYQAzpkus17hqeQlMYDqY0q6pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdbv+imzNDfE9rUP7c/ukeQbUbLqKhXAmaqQxZl3W7oNnJXyAPOsDi+R52z+famcxavSlW0hfDsGz2cqXcgQaoPp/22FDOMQiEDNfU+/NA3+15UfJolo7bU42QH8sHSqPEyrK5+BETbGpUGeVxwWwXumE5k2hUm5THebtGSPUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAd/aon/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2168C19425;
	Mon, 19 Jan 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=UyScQ2ACRZSy/lz8cbYQAzpkus17hqeQlMYDqY0q6pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TAd/aon/ysL1iXYiHwSlRLNBkjyuEyhdx+a/QupGtTU3xmA8ccRtCn1mgzFdPNh18
	 DjC4cRRQOf1uM/h9a0IhTDHsJVjny3uJCESBSbQW92XbZ6M+WpINqUlPsJQJ4Rn/Md
	 lkNnZCGj2+BfJodt1Wp+pb7TVrwcVQihsSxagJ9XEOrX3QPP1JYYTuZN0ZpTzo/DpC
	 bB8Urn7qnbBzCuTcg2D/vbK+IhfftKFiFdfqjajApuk+Mv7WQ+YK9innVsTNL56Qi9
	 PFqZBKjNkrb9apnadaa6l7gJfiJubab4CEXM6UMLRoZXyJlxx8Kk3C9PqmWPGzd0T1
	 9recPb0VwAIKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3962D29C31;
	Mon, 19 Jan 2026 14:37:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:36:55 +0000
Subject: [PATCH 1/7] MAINTAINERS: Add missing maintainer entry for AD8366
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-1-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=890;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rob+NAZkHfCiMJf8OmO/3rqHiaqTB4rC3m2DW61I/hw=;
 b=6hPObne3IZwi5e5qhPoH2SIEVRDnrUBNyf3hrhYjWzrS+d76rkW3+SJ6J67va/4rz/A4OkX+4
 T2Vqevb6abRBwDg1690Dxrw5HmSeU6FpjqSfmY5/Jf2fCA8hJJrv6/Q
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add maintainers entry for drivers/iio/amplifiers/ad8366.c

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dd9f758a871..9c8e83470464 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1583,6 +1583,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
+ANALOG DEVICES INC AD8366 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/iio/amplifiers/ad8366.c
+
 ANALOG DEVICES INC AD9467 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sa <nuno.sa@analog.com>

-- 
2.43.0



