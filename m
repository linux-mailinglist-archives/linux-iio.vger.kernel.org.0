Return-Path: <linux-iio+bounces-24752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC54BB96DC
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B68F345F09
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888E8296BB8;
	Sun,  5 Oct 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="4qluBTJP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAEB28B7DB;
	Sun,  5 Oct 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669996; cv=none; b=M8VWzvQti/pYkgEtDLUZJtE97HXjwfnAuOGkg93IcZaOBbgNxmsa4EBoKmsyLhu92It2QVfQ5BwvpWcl7FelgIcrFwp8qInDxkTP+dOYPiXUAg9va2BnmieubMpp2il6lCafUzhtpSQgkLwgbkBGpypD/tmDL9blDkr+xjp7jPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669996; c=relaxed/simple;
	bh=xT46Cce4/dW01Wkd6hR7JdNM2ioVp7UZkscnuhppnKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hfw24jWZTv/RnIRBVeu/zO82ddfappC8Wz5tMUEUq/21/rTYNZFAMGWeFOyW2S4hBJC0+HNEX/kr/aM/+rYJ+iQ14HXiVKXpSX68FgrEFIC+2xyllQQuH+gX9oc9w/B1tuUsGs+TgnJfmSJrA9LZLMxHcuLETlmgQGoew6VCPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=4qluBTJP; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3C94C173BFB;
	Sun, 05 Oct 2025 16:13:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfU83ZAAwmHQCQ6ye4cqw1fNFt2YVAaZF6JclQgw5IE=;
	b=4qluBTJPb5KKneOnDG8SzbGXn9ihMRLTzUNwwc+4D9TM582OesJuHf9OqE1Pp9Q03TwfOy
	U3Pnrs/4hJk70/KweAYhfP6RpSCMGab4DBEoRg072iTXqczZHdJzquu7TSSZkyekeOUQB/
	J6FmSe+XDK42YbCzugy1hnNERHqpgw7DXZPJ68o5uxP5dJEFO+vmBiQ+dPqcFC1deyGdFa
	hDDGkShhkVjRsUNW6givlt/QF5ngcw+TyB4iVLbaBa1QNISFxdJl1UZ49/xOqMg6uJRfPj
	Hy3+AIk17VEhh0O8u6hyxAk9GZ3MTrt3evOWWBARJK3s/q75PCJ2tx6KMcxjcA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:28 +0300
Subject: [PATCH v4 19/19] iio: accel: bma220: add maintainer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-19-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=xT46Cce4/dW01Wkd6hR7JdNM2ioVp7UZkscnuhppnKs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnRtQ3hKam81ZUpwV2lvTldOdFJRUHNvClg5Q05BNVpkSk44NUhpZi9j
 dk8wZ0lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1p
 BQW9KRUhRcko2ZGpPa2xqTWxRUUFLU2lkUHVwUVM4RHdMbmhDRW9iMW53K0lSMWtwcVVsVm9Cdw
 piOUg5emhnazIrMEdEZkN3RmMySnd6WkU2QlNuSGRTcm9LRjZjTTg3Qlh1WGJGSlB0cTMyMUVGW
 UM5NU9lSmZVCmJHOEliMDkycFJxY01QOVpWdnFmRG1BSGo1NHgyNTg3djQ5TEdGaTI3bnB4aTRM
 d1Mvdk1pektBQUpzV3NhSFoKUE0xb2xNVHkxV1h6VitMakhZM3dDVTIwbTFabVpTc3IyeFN2c3d
 Ram45MU9Ra2cxRXM2S2JGWG50L2pYVW5xUgo0dDdhcXhWVHpvckVVUUlyYVVVeStxeFA3V1Mwc1
 cyV0NIZkZxWkprWEVCWDJPZFhvYllLTkNiRVYxY1hzb0dTCi9SZVJsZ2RKcHhtNTFXRldQV3lTb
 mFBTXNSNmRSWG1sSmsrNHVIdDFsODhXclU4bUxGbG9TT2s2aVYxT1dUa2cKRFAzU2JjQnpPK2pr
 TWNhT1FEUjNoUmZIM3U3WjlXaFFIQjFTUVhnU0NWeFJIUXpIeG53R1V1cmJTWmwvbXNKYgpxMU9
 Ra283Z2V1V1F0VTV4NEI5Vk9nMGF5ZFpEZitaM1gxa3N4UjFnZlVjdEl2TVk4QTFrZkdpZTJMZ0
 MyR0NBCmJiNWZVNzdSeUIrS0s3S0VEU2R3K08vMnhHeHJNcDdnNEpOMERrMENyRTRraDlmOUcwT
 UdJTnJ0RjcyR2JRdTUKcDlFbjkzbEtYZ0pFSDZSTWFMbnpiMGd2TWs3cHRGeFNBcXMvalhLOXh0
 LytNNDhzdjErMXorYXJPTGV2SFFWcgo4YjI5MWFYTTBqaTR0czFNNkdoNG9tbjZCUStxbkNzWEZ
 5ckM3RDZ1Z0UzTDJNZm5meHBMYWJ1Z1ZJUTQ2dVI0CjlUT1lkTUtCOGR3aGNRPT0KPStkWFIKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add maintainer for this driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v4 no change
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f090c2f6e63a0d255a025885cc4573f5802ef159..aaeb4ae6fd2282264da7e61b6fc32c00fc90a5ae 100644
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


