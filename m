Return-Path: <linux-iio+bounces-19079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCBAA8D77
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D70188A1FC
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C11DF972;
	Mon,  5 May 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa60GQzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF01D5CD1;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431588; cv=none; b=UjtxXYWw7XNVHErJLXP4PHXI0IqbbsnimbMVWEM8Hu92s4+Ojr00hN2lXsdrzH3PBrrpl/iTflkRSThmiW2pZUNgPuJOsS8a180A9AfEVUXbpkPyQO/3gbTL8LvTd7yN4Hp5WAZaYJ2NgNiLCTxPOPmpRgpzaufPto/khs9OXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431588; c=relaxed/simple;
	bh=1v1/rio6XCqOmkruQ3uZOyPmUNsBY2ySnofdSs8eHtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aw1Dd49ZU543n84OIxzJGxl+5bJhECog5fxLZrJlnVrvaa1QM6Ees8Eo+hh8JDZ0ENc307e05XPKyriw03QYD4pcGN0PHTjW5zw+h92eVpyfIWwP3t1OhHMT1DWY5rbPOHaVGMCB+xPXLLAcSgZUaC6rKhnjmkh5D+PeVsQXDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa60GQzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC5CC4CEEF;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746431587;
	bh=1v1/rio6XCqOmkruQ3uZOyPmUNsBY2ySnofdSs8eHtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qa60GQzpw/wAXqtDhfmgaTgx5xgsrgze4xOFuh1zVt9gIWt/EzlUTc4JtCQiSbxew
	 ibuf1mCXuKs9GqFgoDX4i2Pke6YRVNWvLduBSbr51tXjIG4c8tJmEmOxLjRsJXq+1c
	 83EyM4If7EElP0eCFbLdP0OdKyVX1IN8Pc8r6v+uQRvnMp4BHVE9Bh9o20xOV46GYa
	 K3kmkOAgXlqSIKbXKriKpuUpZ6b40eKieFYDfMzGTe2ymMrxsiEAoBJF//QBAVx5HC
	 7UBoz0q1vtjvhzl1w8M0sO0viwxHuMcMDk+I4IgI7NJF4Z6crJzMLonH0FOhUxJg/q
	 W0LL3DKvzZw1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2BAC3ABB6;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Mon, 05 May 2025 09:52:58 +0200
Subject: [PATCH v2 1/2] dt-bindings: trivial-devices: Document SEN0322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-iio-chemical-sen0322-v2-1-217473983b42@gmail.com>
References: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
In-Reply-To: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746431586; l=910;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=1Mfxr5j12EbsEQWdQ2AY6ErLyezlks+9xDkOv+/nbsM=;
 b=kXQ6usTnCkZCv9d+dDS63qVsNQQKiFnQ8HkGcdC1VNXiaCoHf+pk17QrpX1IWEgIK0Usw2W/p
 OIvrkfPYZrTAu6I4g6MXLaDFdxwqtQ2AulBIOxE9E1azy83JaR8s3Xt
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

Add documentation for the DFRobot SEN0322 oxygen sensor.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55..a25bf2135649 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -85,6 +85,8 @@ properties:
           - devantech,srf08
             # Devantech SRF10 ultrasonic ranger
           - devantech,srf10
+            # DFRobot SEN0322 oxygen sensor
+          - dfrobot,sen0322
             # DH electronics GmbH on-board CPLD trivial SPI device
           - dh,dhcom-board
             # DA9053: flexible system level PMIC with multicore support

-- 
2.34.1



