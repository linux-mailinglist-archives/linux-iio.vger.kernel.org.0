Return-Path: <linux-iio+bounces-10016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10998EA7D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 09:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D601F22C91
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1761272A6;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYFXlSjQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD354BD4;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941075; cv=none; b=TzGYtlK+4gClIeQkiDjh7Vh3WhJ7iKmrnGuMpe0I5BaNbUzkEJnFrW+4r22RE2nP7TaN9JWbqnjZqY+Z58cf3Ipt3wdPRXXxJ2sQ4cfFyr+fpsTXAqZ12966GCvJ2B1ovUDbDBHTkv47zLR4l2p4+EtbuRLFXIEo2esXMEpqUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941075; c=relaxed/simple;
	bh=C/jua4TD52euzP3GejZALVtTUHREpT6iga/ADyHMakI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9jiLofNO6xl3BWnggUTLQF7Eek9b64Q75/jMigC1s5zi9ARqI8UsNGZPb65Jc1nAgr7ugEnmD8zhP/q6s++OYk71ljTKoMf6pNrDMyLPImo2UHve300HhKhm2Be+mujMgJ+gj2VCnDmafTm7EDoJf3IuGJ5NYzFiZAlKX5S54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYFXlSjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01B13C4CED3;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941075;
	bh=C/jua4TD52euzP3GejZALVtTUHREpT6iga/ADyHMakI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sYFXlSjQjPhD+pLTLWB7Odrc4r4RmgzD577rneej8niX16f5VwL35egzGbER3E7/6
	 IquODsVB+hFnBuidkaXFicuPcsY2MBKd/mvSTvoWXUK3vXG7W/BcH84O08YCG+OXC5
	 M9qqvJZNvoYglmp5sN3f1eEt163yNn3O15lXEiPOp3HMlFCCZoUgd4m0w6EYiJ9qLY
	 B6uLLUN3LQ41fwJ+Ap+BQSTI/ZiH8EZykk3RZA9sOXge50oXL9MGkENN6WNhG6olbG
	 9HLlkA4B1mm4t+DK6KTub25wj+MzCA48lOe84J+2ntFKgiGS+asfYBNX6n65qxYqvD
	 OFx8pj47TaAqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8BCF8560;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 09:37:47 +0200
Subject: [PATCH 3/3] MAINAINERS: iio: imu: add entry for InvenSense
 MPU-6050 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v1-3-7e4062ad68cf@tdk.com>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
In-Reply-To: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727941073; l=880;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=FPt7EcUZXhPizT6dYgXIa8fkCzyGqvv1//+R8PUl5hI=;
 b=zhopDH4uki864JdnXdglGMv8Z14ALLQ5SUsfqRU/nSMllLqWEd7VJDUSXJg9nEH1lWOMSFNQN
 G10JTUKZvQTDgUF0XdCNJHuR+rLmHe9FNduHwcQ4f3SGnm1v5rGBVLU
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add entry for inv_mpu6050 iio driver supporting InvenSense MPU-6xxx
and ICM-206xxx devices.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6b252b991a514e225df309485c708c2af547f57..fba699e27612997ed1465ae080632dbeb0639be5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11913,6 +11913,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
 F:	drivers/iio/gyro/mpu3050*
 
+INVENSENSE MPU-6050 IMU DRIVER
+M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://invensense.tdk.com/
+F:	Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+F:	drivers/iio/imu/inv_mpu6050/
+
 IOC3 ETHERNET DRIVER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org

-- 
2.34.1



