Return-Path: <linux-iio+bounces-10040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C698F091
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C9B2858CC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B619CC2F;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knYYATc6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5E86277;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962713; cv=none; b=SF4ebKd5HnDd6+LgVC7PxXTomzOeJVvApL7q4GEy+El01MEH6kt9SGf/BNbCzg27mz+rBDy9Ql8JuuRh9qGu7CF3vzsHcbAJK0eg8eSxuqCmLtLJBMmSx8hEGlErpXM0Eos1WuPLSjnJ90B6uGdh8Ncl1lV9XLbsuYX21hN6Css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962713; c=relaxed/simple;
	bh=AgRauzS1Basq10C8Dgv9VKqIvHPNmH7ID65/6oRc7nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4UBeaqamkyW617fmSz1X4E+vcmWrryBAYMMYCfMBQX5Ec6QgRGOj0PMWDsgY08sYSm0XzmCBzwl9QeC9+Qcx/U6C0+i1iqfqPkM76yspr5AGjH0dAzitBj2FQvzxX+z0fvlnHgQOBpOvQYsCvhYo0EmrkGU0e5iDPifPb7EIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knYYATc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1382FC4CECE;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962713;
	bh=AgRauzS1Basq10C8Dgv9VKqIvHPNmH7ID65/6oRc7nk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=knYYATc6pDgZd7dKgW7md/E/W20yXxI5OxCP/I6uNRHmIgOD5zzYGe7wZjCZu6k32
	 BCm8WPdn0KdyqB85c2oGildhBGTgOnDLdkozudxljcTCW/I2N6Z5KkhnFmI2yY5iYN
	 7l4wG+xDoXGi2qHt+wIJ25MPoriT2nwcJ0vDlZGeH2jNrg2nxLpxwHuTt+2Yc9gjVj
	 zLPENX4nEz05skXJdcs5ertRcQ+xZtk44nWOxUr/ijzIJBgUrtHBkraBR/v+FoA+kC
	 5kRdH7MR0jBlsOM09xP9Q5rxOmzcJpRkwhMGdI3XPdCLAaKSL8yOGpOdkuoc8PyCem
	 x3Prp2WoKAp1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EAFCF34A9;
	Thu,  3 Oct 2024 13:38:32 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 15:38:22 +0200
Subject: [PATCH v2 1/3] MAINTAINERS: iio: migrate invensense email address
 to tdk domain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v2-1-ca5a4928eb22@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727962711; l=777;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=ijoFTmmkNW8P16NGl76tKyJtKzPzqes0lHYpjdQZKIk=;
 b=r534PF7HP2e6DfhgrBieLkacgWutAm0Miz14Iw25HR0aEssVw9MGicFlAsYaGM2s8wg9ZTavH
 b8KtdVsM6pmCQ1/P7myCun9E/Ka8Frj54/rdpX3jZJNcDBiQYRNYGGD
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

InvenSense is part of TDK group. Update email address to use the
TDK domain.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcdf43f37660403f3adb11884f1c58f64bc32840..b6b252b991a514e225df309485c708c2af547f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11898,7 +11898,7 @@ F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
 INVENSENSE ICM-426xx IMU DRIVER
-M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://invensense.tdk.com/

-- 
2.46.2



