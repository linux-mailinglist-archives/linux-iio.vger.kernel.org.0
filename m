Return-Path: <linux-iio+bounces-4367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B068AB213
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12B91C21865
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6E134CED;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBSpE6pf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09913049F;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=dDl6U2AlwbajMAjsLTtR5aOOQkciSV5wOKF2gT/KatOPjvGSJk7LZ3i4DAZN6rGI69ICUvJlXUAh0Y0Sbsjf7jyfuevmdvAmtekfk2Mc8AH14pbjOUA6DAam/+cFETzXZ82TilNENPJAvn7/lhnLJOV78EzVQQvPRwA201CzDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=M63do2rsHrBol9Y21pmkGXyr8SUKXE1yQfuo4S+xsMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1at0h7vz7XjvjKtqeIrKfSa9WHacUxn6ietdeaOXzMlr7pJMzI0rXeccWV3njWeF/1v78TeW6P0ohNSqBJkTw+ieSnN8l++Fqq6cGQeBV7FNuSnCstlw8BCf1QaoUI9Iz7LOCMYZ4nKIYTvH6R/wsDr6AYDZgAQ+MnD2SyDaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBSpE6pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13563C32781;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=M63do2rsHrBol9Y21pmkGXyr8SUKXE1yQfuo4S+xsMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gBSpE6pfBPwdSyba8Jqysn8yJ1aw2s6fzeTykhH4nrZ1Yz6CQf0dyUZ80FqATt+mJ
	 RIgBXC46MO3xABapu4G6TvJAAsA9+lEWBJ1XV33z8iTot4G1PjZ8ttOn9bODCnFTIq
	 XV0Rw1pfpETZ5IYwhCj1YJ6GZGlQ7CfFVp1jqiYNsEPQTfveClcsUMvkqw5F9E+GUx
	 lo6pT4wI+N9eZ2Ry+ICWCPcb6vC2A8AauGYgzX7FYVaES+3DGY1DDf+8eQAnQCvKiQ
	 Zd2aj/tfFm4veoR2Rdm+v0SGTHEELJ7ELA3BmvVo6TtjVohwwfiik7sRRjYRn+UQ+F
	 0bo7FZxL0rBrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED59C071DB;
	Fri, 19 Apr 2024 15:36:51 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:45 +0200
Subject: [PATCH 2/8] iio: adc: adi-axi-adc: only error out in major version
 mismatch
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-2-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=1320;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=PKeKv+/FjVf4CBXkS3IXNv+HfrXrDFDeJP+4Q7Z6xTk=;
 b=BFlPAe3M5OBgFWkkaWq/O6gsfGa0Vd1GEBUfwRCXcvzaGJ+FegFvmtfP1dTDZkZfHI3pR2ABp
 MTCRXzhpKF3AveS9Ijc58ZBmReShPeIV05HubsvboArxiYkuHx3A0nA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

The IP core only has breaking changes when there major version changes.
Hence, only match the major number. This is also in line with the other
core ADI has upstream. The current check for erroring out
'expected_version > current_version"' is then wrong as we could just
increase the core major with breaking changes and that would go
unnoticed.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4156639b3c8bd..a543b91124b07 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -207,9 +207,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (*expected_ver > ver) {
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
 		dev_err(&pdev->dev,
-			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
 			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
 			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
 			ADI_AXI_PCORE_VER_PATCH(*expected_ver),

-- 
2.44.0



