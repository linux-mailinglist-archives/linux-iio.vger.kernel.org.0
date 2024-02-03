Return-Path: <linux-iio+bounces-2116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9D848570
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 13:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB501F2334A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282515D903;
	Sat,  3 Feb 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knE8k120"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410715D911;
	Sat,  3 Feb 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961740; cv=none; b=FPF5yxxGsiEu3qTPImP60MPzPEqBIaYlzEKkQLWLeM8w3fVUgFQqIFwIJ1+lErlV/Pb0uTDDKBD7RtEacwh2KHm+g6DfV0vm36q+4BAz/9IC1yejFQM4pO56ZefjO1Ep03BmgQOIoh5Lmr7tGlkL6gzHDhBe/X5JhcktR4K1NVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961740; c=relaxed/simple;
	bh=amSLVYPBB36yYTqYB7NEfH9Md+g6aY8Bhknq0DhdMic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPYA+BZq29BX72+QDxDpDH2Hsy4YdEV8ClcaaBNv2zUy9uCe5YlhRkZssFlHjd3Csk/+fmGQ5qF1BMe/d5SqgQHXO0wzsDGehJqLl+gIJmeb8cZIn8FXE6OAbHMoqdNmBW14K3umnsrQGMTpZwR/nBISQDgaroS+G6SdCrzEkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knE8k120; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E99C433F1;
	Sat,  3 Feb 2024 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706961739;
	bh=amSLVYPBB36yYTqYB7NEfH9Md+g6aY8Bhknq0DhdMic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knE8k120hdqARPGoQToKPU+0f39qvGGdQLSVOtl/sMuy2VCpwyHi56bPit+TRk4Fe
	 VMBxwzIT0TEHr+nwjgar0oWeb4iIpNVLAbDcoORq5xY8IYI9HV2gOtcxylJqe1DuqB
	 q4uxDuosXx7PIClbUSF3ME+vBc9c9/nTniD89c1C+FdWiXXMzFPNZez1fenIJglOl1
	 M53KIxssjn5q+zSIVrwaAdhd2zxTcptBCFjInoobGN/7+5NqEYvTDMBG1G4lldG9EF
	 XQwcT5eA+1HfhG0y7oCE91A4g94Bxlh+8ZS1AjRRJDo+HeHtWPB7cXlYwBLcrR0t0C
	 wwfgWdYT6cWVg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Subject: [PATCH v4 3/3] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Date: Sat,  3 Feb 2024 13:01:38 +0100
Message-ID: <942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706961432.git.lorenzo@kernel.org>
References: <cover.1706961432.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device bindings for asm330lhhxg1 IMU sensor.
The lsm6dsr supports the features and functionality provided by
the asm330lhhxg1 via identical interfaces and so is a suitable
fallback compatible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 28b667a9cb76..c48a96d17f51 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -35,7 +35,9 @@ properties:
           - st,lsm6dsv
           - st,lsm6dso16is
       - items:
-          - const: st,asm330lhhx
+          - enum:
+              - st,asm330lhhx
+              - st,asm330lhhxg1
           - const: st,lsm6dsr
       - items:
           - const: st,lsm6dstx
-- 
2.43.0


