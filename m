Return-Path: <linux-iio+bounces-10043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD798F093
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DCD1C20FEB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81FC19CCFA;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNuc8ByM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1519B3F9;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962713; cv=none; b=eWf1EHyG3qC/eTQ+iJbAiZJcnreCgskS26ZtqDIAkCJEhjmY7UBSZt9ESjDFj79CxwXTld3JV1uPQeZ5pV/rWYDdHdjgmygp9oHDWiadkqZj2YwMWCsPszZh3VwUjyd+XOBe4EaYcT/hfIxyoRUDKNg6j72oJx+Bodh7+pIhQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962713; c=relaxed/simple;
	bh=qCk7a/dUr5axlHi54k4hn+N7hqMMBrQTxORi8yOc0KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpuVjrgYiXes5unqO40nHaDu4ftDSB5D/qUkfW6ZoO17MF/CmRwrSxYknDo5EQsA3uMGuLIR/QHmilMgwUbZ+zzW9bnjcHPnP7SKKOmTcbr79JEzbkCXmueSkTmYEiB5brLBaXIDeM1mYahtFTV5oVxOLVmRQ8Rj6kmJ4ZMYZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNuc8ByM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29940C4CED1;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962713;
	bh=qCk7a/dUr5axlHi54k4hn+N7hqMMBrQTxORi8yOc0KU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oNuc8ByMgmDPEnktrMDFyBPJk/giXGDhyu+Uf7hmbg91dEFOHiM2E0bRlDeAPt0xb
	 6QDGZzB0/PvNNBhQIg7sIbsGKOejjjt+VaWjYpObQp5LeghgGC0v/9JEgy3d1YPfP8
	 1906BvitsWQ71eC2qoesm1UhXnAJ7xmawIMqnNtN8kJcgurWSp+AcJqcCb1CQmlzbk
	 p9WwLiyUEaqr8AZ9lZ+EZ0vIjWc21raNKx1ZGL3QEjLNvuBqsgI49x4MUyjN4Uc8yw
	 06g06awalONVr49UodIiVtZ8J6acmAwH4FN/t8KVT4wdiU/XWhbFn9HGTka65YCK5h
	 tYoTTu0dvqwRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D480CF34AE;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 15:38:24 +0200
Subject: [PATCH v2 3/3] MAINTAINERS: iio: imu: add entry for InvenSense
 MPU-6050 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v2-3-ca5a4928eb22@tdk.com>
References: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
In-Reply-To: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727962711; l=954;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=w9mTW2Po/F6sYjTvjGIGExFNOUZEA5q45EE+lyY0DjA=;
 b=od162YpKu2Rq+3r0ZvuWNQ3hUOc6rbjejNcZnWJQmHhrDIlFv2UHxUKd3DQAPqZ+88jeZDrB1
 VrgMXXZbqvOAFCHEpLF5Ws8Q+24kJMSWeyfc1nj+SMIgknJmFWnGwLE
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add entry for inv_mpu6050 iio driver supporting InvenSense MPU-6xxx
and ICM-206xxx devices.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
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
2.46.2



