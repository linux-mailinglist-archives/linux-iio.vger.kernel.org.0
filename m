Return-Path: <linux-iio+bounces-486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCD7FD778
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC468B21704
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FF1E4A6;
	Wed, 29 Nov 2023 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAp9NM4S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75911DFE3;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D20FC433C7;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701263128;
	bh=2fXjKgx+cwQmwgAWiD+DYamk2BKPOuBQkUSd8ryi6mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UAp9NM4S9RaYkwoMjdrQDPjpwMSPo2ua7xiTFa1BUDE70dfkxnlnyNSh1eTW6vekV
	 XXoK5y4ZacoOMenKGlPdyf8rt4t8aMzMfl70DJ53lbZ4gm42Pcfyu3ZGHpe/te8O0d
	 mmxEwih+OhO12zQEKFZrj5dch4U+dO/8si2VLTTSPFmBGbOWnjDnKUlzkJpaNrpFo1
	 RLD1T3+7p9RSi6v2dMpaoIFZ0TEqPRl74AVPgCpKMp0jzQdCYEfyItG5wIRS8SRrMx
	 fWtFXypUqwWXqIFuXvqLAUZA7WW7Nt4KxLiWaME0jWU4zHS1Os3Qu1QwGMS8H2VPrd
	 eyQd3kde7D2JA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA9C46CA0;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 29 Nov 2023 14:03:52 +0100
Subject: [PATCH v3 1/2] dt-bindings: adi,ad5791: Add support for
 controlling RBUF
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-ad5791-michael-stuff-v3-1-48e192b00909@analog.com>
References: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
In-Reply-To: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701263126; l=983;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xoXVRs0OAnHTU0WyGMMl6hEXK64stnYpgoFfdOqlHJw=;
 b=qmFebdZsji+q4JvfvSlkNQHeaFKqyHlbeViqGM+by6bC6j5niob3957ji9TtRlWYgeeKcLeQb
 UIFzwKTRvyNCBb1JWYugLHQQHA9yltqekI3kRe71Mv7xhrReYC7yRba
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Added new property to support an external amplifier to be connected in a
gain of two configuration.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
index 3a84739736f6..c81285d84db7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -26,6 +26,11 @@ properties:
   vdd-supply: true
   vss-supply: true
 
+  adi,rbuf-gain2-en:
+    description: Specify to allow an external amplifier to be connected in a
+      gain of two configuration.
+    type: boolean
+
 required:
   - compatible
   - reg

-- 
2.43.0


