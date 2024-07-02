Return-Path: <linux-iio+bounces-7137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76A92419D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E828208D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40161BB680;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRnxmyJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC51DFE3;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932378; cv=none; b=irTuSQvStKOSgq67nC9AYFTnr7CwAZ4PyAaWugWG9mYi2i2BaC+MBoRU4iUemNqEnricdfgvG963/Hp3LQy7uOOmpYvUbFpsIIV3wihlYaQnOEGvrxFVOEMqKkvfULLGHMlsI0JfSLk4rFiwVdFngW7mGE/3mw5ypYJ6Ao+s/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932378; c=relaxed/simple;
	bh=fHanAlQ1ds3bzkFzGm19phfLkfN24UYAsJwf9d7Tc0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQafiyGfjcPFUbiBzL9ifkDDgyqA2cwNJtRERzsoyZ0zCwBUh9ZUFfc34K88ofXkV82zgpunj4yYQQRI9uEWZKLStvjgaIo52YyNc1tp5odk3YSssCJfU+FG8ocKX/+N9+rKFCGdtP2EzAuSo88uqpG7spK+ZpIZUt7On3zl+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRnxmyJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13696C4AF12;
	Tue,  2 Jul 2024 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932378;
	bh=fHanAlQ1ds3bzkFzGm19phfLkfN24UYAsJwf9d7Tc0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TRnxmyJigBl42EE34ctQu1w6kd6pCyUPELSvR5o46l9x4ZT2d/+OLeBYY372vQDtl
	 mt/955g6sn+shTL01yZgPj9QsK+C6xa4EtXZUpz3HMjfkfj92H/5E9M5bDioF8zuxm
	 BZefSrrScI4DgnQwUzBegbbs+SY4tpEG/PEcTGR1Uj+C4/3zeBZyvasrOcnRRCPRnq
	 8iXn4YgaP/ajyvzj7rMlLay7EOTRuDo8+GH9fu3pqhmY8ZNFv6Zwt296U4TkxF4JjX
	 hqIGe/1vyAlcQMcCh4KwHgF2T7YK0xxXGd7rvmO2B/fksXI9C4JOsrAxwes3Eljb/C
	 ev7i8lkXfJzQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DDDC3065E;
	Tue,  2 Jul 2024 14:59:37 +0000 (UTC)
From: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Date: Tue, 02 Jul 2024 16:59:10 +0200
Subject: [PATCH v3 3/3] MAINTAINERS: Add Sensirion SDP500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
In-Reply-To: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petar Stoykov <pd.pstoykov@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719932376; l=804;
 i=pd.pstoykov@gmail.com; s=20240702; h=from:subject:message-id;
 bh=++KMBJJdkAu/mRC0gJaUp/zFLhaTtFAt27IBrDli1ZM=;
 b=NSO1Rjq0Zm5akuTrH+ez/GsVoiUzK0DPfANPoSj2ZB/R4e8LZWMF3Wnrtd35y6onxYIxR+E30
 7QnG0lpDk6tAz9weSIbDYuYHtZs6RF2fFk8C9bKWg8CyRr8WCf4wAUW
X-Developer-Key: i=pd.pstoykov@gmail.com; a=ed25519;
 pk=oxcGqcVV5O6wqlTh+39SbOwfbpD763i5x4TavUAHiCg=
X-Endpoint-Received: by B4 Relay for pd.pstoykov@gmail.com/20240702 with
 auth_id=179
X-Original-From: Petar Stoykov <pd.pstoykov@gmail.com>
Reply-To: pd.pstoykov@gmail.com

From: Petar Stoykov <pd.pstoykov@gmail.com>

Add myself as a maintainer for Sensirion SDP500 pressure sensor driver

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40c754b4c39c..65f9479ac343 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19533,6 +19533,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
 F:	drivers/iio/chemical/scd4x.c
 
+SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
+M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
+F:	drivers/iio/pressure/sdp500.c
+
 SENSIRION SGP40 GAS SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained

-- 
2.39.2



