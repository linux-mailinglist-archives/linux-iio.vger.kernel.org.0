Return-Path: <linux-iio+bounces-24080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A727B56208
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B953AE3CB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E72FA0D4;
	Sat, 13 Sep 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="UqbOVKLg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D82F28F7;
	Sat, 13 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778021; cv=none; b=i+zpoyO7MHrpWBP3oMYGAVpf05jPGXmD9QyBqjyrnGJUyLIJbk4YyVIChwdqrdVrn00oBq6zwb5BKdiSH5ZpP9NrXDvCW+4QfkPo3XnvckpB10aW1VHAMI9kHOuhisUH/t497G0dp/hn4GrBEr+1deVr+Jl+b5WtKdK991em1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778021; c=relaxed/simple;
	bh=lzWx+a0dmfGLNa9KQBKgDX9o3geWkCG4XafSD5c/jTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYQm3n5nMp/55hhbf2PX3aVXfXfP9kwAukuew4v02h2AY7KFCczASjFM8XYmzkClNlgRhszGga4eYYz+9wcbrb05vFEH/aq/AJGUNfT12iGYOIjELRKOswQk/tRtJHUVsd2yXcbGFOouiJWKIWvMB90gr4qtHRgVQFfjTwniyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=UqbOVKLg; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 411D4173BFA;
	Sat, 13 Sep 2025 18:40:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pA18o8EFs3MpHFqQmZXCGHKpMhUvAZNuJ+WPTR54bo=;
	b=UqbOVKLgbgAZnJocHtRz6T9SsiHgXuhkgFirmNKwm8T1/YujV2wxDttgJi5JqVcT039gMG
	8NrW7F2NvDTzHwlBBGhiFpa1bLwfOgQoGc1X8/cAO8ZEXyWLLEesj6850P/y6ggH9PwVDn
	7TISS2IFJwAeOBXLiKOljADivLeGFLKmzPv+RdnGzti6GHKuGastxgq/+uNm0q/w0zmdLr
	L2cBzZET8rWwUsAcOXU9nHpDV9JVnqXR1rkW0cwXTpHtwh2Z2n2E3a8pWhkubEyj+SHqMu
	ipjmeQXnLd4aQ3vAWD3HvBiA7os3I0+VhdHIOcvWAtjiOPUC7O4sfDQbxN0VWg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:39 +0300
Subject: [PATCH v3 18/18] iio: accel: bma220: add maintainer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-18-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=lzWx+a0dmfGLNa9KQBKgDX9o3geWkCG4XafSD5c/jTM=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSrGtrBf8q/IsJC++D6a5b2R7PFtHZHTaXl
 ay/eev1idGJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MHQWEADLbgtArbU+DB0vNAvwlBchBF8G1CvOpCoR6vsS70AuHWyQbRrtUubeviw2LDcrtcthXgg
 NElCUcsUqhPU+edphgInTyoeVTG08B4Yt1gjhNwdzdrZ4STHR6Rye3qqnuiS1UDmLhZ+r+e3oHj
 B6DZFQttWSlKGoTv5BiO3xJ+17skOjxVBcDR2sjWKRvkpNMAUF8nTYR7bhaQZkAyZMrqDKmnCZf
 WrngtqElx1W+IE3WVeKPYhVK+Dr7geoyEamRb/iKvJHkb5Fmut3GO0CrV0biqB0DbcsCdXhmFRi
 BfKb6aXPs3OMmjhIGdkhuAnir1kp2y9Ax+/r8FvCrzl2vfN2lXjTRBoeVedPOHm1t3tNEOvoty5
 OnWxWfyL4y5kYCYu3cLDmVOcAoGdEvPpIUaoIVsmO738Q+s6Oz5ruZJHgD29VS62mimcZgI69bp
 317OvRylYp8NpPKSOXnLmKgFZYWNuN7Fd/QKdjuWLkwOHkyyHx71T44PslR8ONGPZTaodV+PczZ
 dwJcgfPbYdbXsJF7FPhOeXmLMLehVaUC0s1lL1XN/A9WOlNUIY1jMigKNcIJtnaixqtlJ166Bgi
 cWUKxf7guvxOYoHEifzhOq424cJwTbGODihDiRSFV72pjwIja/OqI7KgSPlvotXPwKMb3Tjzl+T
 ut/x28udsWYGj4A==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add maintainer for this driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v3 no change
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75615d82593e173a9e07fd269163fecdc4711e8b..eb985bd06b7d960bbc25941a8ea7b420d83483b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4402,6 +4402,13 @@ F:	include/net/bond*
 F:	include/uapi/linux/if_bonding.h
 F:	tools/testing/selftests/drivers/net/bonding/
 
+BOSCH SENSORTEC BMA220 ACCELEROMETER IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+F:	drivers/iio/accel/bma220*
+
 BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
 M:	Dan Robertson <dan@dlrobertson.com>
 L:	linux-iio@vger.kernel.org

-- 
2.49.1


