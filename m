Return-Path: <linux-iio+bounces-1974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D509F83F52B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 12:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6DD1F217A7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0A1F19A;
	Sun, 28 Jan 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQuRMk5B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A331DA44;
	Sun, 28 Jan 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441192; cv=none; b=RTg4fj+qq6noCx1E25qlg/cOqnpWgRQBxe+4Ak07EbOA+c/4hrllMRO6f1u8XrAJKhBKVRKCFwyJdP6+72VmVz2Ez1uVokUgVN9nkRLMevUuPGcOROZL2lxkoLiQgjqYDJsC5Ybtx+87ggGp6dlEB/vn9Rb98j+W6enTJ0lMZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441192; c=relaxed/simple;
	bh=fvEweWhj7gZResBcZ8QEpA2Pjcf4E+Ob16+YGLRIds4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DocAvMEHv+Suf4PmhoMRQ/oBBGLumlL4/ypOWSmAKmUZIytfWsclNstQ8E1PmWgF9phvS8NLpbB533puDfc6RDeyAmL3+TDG0bcP8uMzgswwNltlwR/kfvYPH/vYT4dvunKP+8ZCB3hfRSpQcQaxL0XfyLF+DcnKHcGCYz78UjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQuRMk5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6FBC433C7;
	Sun, 28 Jan 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706441191;
	bh=fvEweWhj7gZResBcZ8QEpA2Pjcf4E+Ob16+YGLRIds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQuRMk5BmqT0GdfMvTGgZZX3FweqbkQKfJBRIrVWlPoyjwDyfuPz4Qp1xa+dZ77m6
	 zHLY6k3x9ROdVcllpvGhggEIUrfXzNI6L2JltdeiykPcsbewQ9vUQ3rOpCsrr+o4p7
	 +wGep9YIxfGtOvMXUIGs+ECGZrRUgbp2KlOtRYlrMoeF4vEktFDlGEcByanQdmT2AH
	 Yhgx2rkWnYwawKeMg24R0yM5Ebik2ntjhr/BRtJ0xm+MfDxEj+9swaYVlFzAHSwEUL
	 nkPQjqNpBf4JjqJgnsaLRMNWx9BQVsYq5/YJrhqsEJLHsxeCuKBH/XvrOnwa+YQAPm
	 dDOzn6Bgrh8Ng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Date: Sun, 28 Jan 2024 12:25:45 +0100
Message-ID: <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706441008.git.lorenzo@kernel.org>
References: <cover.1706441008.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device bindings for asm330lhhxg1 IMU sensor.
Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
all the features currently supported by asm330lhhxg1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 28b667a9cb76..7ba3de66a2e1 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -49,6 +49,9 @@ properties:
       - items:
           - const: st,asm330lhb
           - const: st,asm330lhh
+      - items:
+          - const: st,asm330lhhxg1
+          - const: st,asm330lhhx
 
   reg:
     maxItems: 1
-- 
2.43.0


