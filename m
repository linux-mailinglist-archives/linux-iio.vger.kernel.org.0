Return-Path: <linux-iio+bounces-2066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E8843A92
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 10:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086B0B2D420
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67FC64CD0;
	Wed, 31 Jan 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3sTgE5R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705536340C;
	Wed, 31 Jan 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692328; cv=none; b=fxbXu42In4r6Qh/TcybtFTCQ5QEPmGDag8O8VrKBFRQP7aaMX8iYSmq5NudUXDo1sImsgN88tv4Js4FaEMJJyTEtzly3myeIvlXLTGXNvQWMe79kUieh6S0WGb47rlip2rIdw7rWlZybdnR0VFGpaI7ObCVMxFPHlYaFjv5aFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692328; c=relaxed/simple;
	bh=6j/gTw4kZ6KgjYYpxtBcqBlrc4J6FZDT+nOpz3DsXYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTzYblWfDB+TfVEIZNySlnxtB4JXkXtWOHcNpkXYvi6nqEJlCPbpFafQ51mOfoqgbjvMTwEbN3Df+q3Pfiatw5xSzEhHo7FgmVa8KRW1eOpwuJnDg4uo2VeTIkknhPXFHkvj1rYmQ8CuiUCAdQVhLM8uzBNUJSRf9j3wgbKwZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3sTgE5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50D0C433C7;
	Wed, 31 Jan 2024 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692328;
	bh=6j/gTw4kZ6KgjYYpxtBcqBlrc4J6FZDT+nOpz3DsXYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3sTgE5RidABATDKXKRPY/bfblqQp4XuW7Qmd1HAXH4591IPX0Edowt8e/Ubblstu
	 kUhGxxQ1UVqQQZAcopQLUuKnl7Kl0OC+RnmHrTFrs0is5sOIWDaPmi46szZvm0NfnC
	 8xOx1i4HXVbfGPTBMsPiBnYber8yvaCxpei416ru7CuFXeUXcLfmI21UGrhprKWeuw
	 +z84UCvBPCOUv66ekFrgzkqVd2QTxApnqURzLjdPibV5v/YXaET5+xTcVypA6AYOOw
	 WYcQolzLvUrRPg9oMA+txgy4nwejpiUMLXYJSJD8kCL6VcDNQGfR7mgPzv/rRCm5/v
	 E1Uev5Ht246AQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 3/3] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Date: Wed, 31 Jan 2024 10:11:31 +0100
Message-ID: <93160585e69e4531a981064817ccbb143a6a1f70.1706692153.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706692153.git.lorenzo@kernel.org>
References: <cover.1706692153.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device bindings for asm330lhhxg1 IMU sensor.
The asm330lhhx supports a subset of the features and functionality
provided by the lsm6dsr via identical interfaces and so is a
suitable fallback compatible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 28b667a9cb76..316601b2da7a 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -49,6 +49,9 @@ properties:
       - items:
           - const: st,asm330lhb
           - const: st,asm330lhh
+      - items:
+          - const: st,asm330lhhxg1
+          - const: st,lsm6dsr
 
   reg:
     maxItems: 1
-- 
2.43.0


