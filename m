Return-Path: <linux-iio+bounces-10831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC569A5727
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 00:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35959B223A9
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E7199246;
	Sun, 20 Oct 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="OvNeu+IR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELxUaHRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAED1991B4;
	Sun, 20 Oct 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461687; cv=none; b=EWa9Xhx0kCNNPlJ0prJ+UbBERmfvhp6PU92TRjVQn3P07OD7sp0XhWYjuLiqxYW/p+utvsTnxVi7KZ65XrLDP8YmjvOrK5l0nbu5FUscmXDVoaW/X3oHxiRrw06llwBuFvs8JZzdkEshQ9UrPLk/7c1qtlWxEd443erMQnE3iwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461687; c=relaxed/simple;
	bh=D/mLWFaivoTEaaqHLS6D9+BJQdYAQkXFI5nP6YYK7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUEAQksAi4dMVNypZ5wVAO0nRt/89faXq2sJwI/ct2bMVA801V7MPwyahTf5E4tQtePrWK5u1hbvdgQBv2EpXYBkbukJqxR17589lLxoJnTzJXC3j0Q+GXHowmzuutWfGCRc4SZ4Od4Zh9FsRMBKcwoRx9vJEhhWdVKWziDkWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=OvNeu+IR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELxUaHRI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DB60C1140095;
	Sun, 20 Oct 2024 18:01:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 20 Oct 2024 18:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729461683; x=
	1729548083; bh=YMbbini+gX5z84v+iufpqhX1D/K7N7C3mTtmdziwyzw=; b=O
	vNeu+IR89ep0l/rR/wIg+gFluXmBjEkPiK4KTCEGXG7IpnJeMZ5fMx25lmFUGjLY
	RrVBaQEmHqKWBAAsUHD6Q6LdHG9wG3bbKj/bDVoLNOqpW9ZhuGySTRCk8CIbFvhm
	+ZqVR8m7a2TEdK5BhT/MsoGLjaMBt/gRevi32ynE6OIisCwFRov4B56uixqCQ6pK
	4lMeT9IEbDFbnTY6QdUs5hOIcO/ImLahING/v1TyeciqbbdYj9XYj26R2gDZxtZI
	HfE8cBsTURAouV9bKlWh0GrnPP7ckR8SjAZEc16lg1cpQ+Aqo/QvFsJqu1Eh/TKg
	Gwq5rgdVSFbua1wRxGTXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729461683; x=
	1729548083; bh=YMbbini+gX5z84v+iufpqhX1D/K7N7C3mTtmdziwyzw=; b=E
	LxUaHRISayj9Lu9iHQoD8XwJTjrdfS1IgrmK+l3Xmykdh3c+9p6tZQ4wPgEnyooX
	c2DV4XuibUB1L1ilicyHak4jeecVk3KnZ8sUb9zcFfE9Pf43B6hZ4JWu8o+IaSHl
	/aK2BRQ/c35zfwRnOdAVi5XThDdMr7HWKioqE0gdr/Z5+3afp/JyK6I7B47nQ1DV
	foftmOJFfAz8pazUZKR6CNa/5nS71bigFYK3BaHg9lR6sxX/K90/lszT+CZOtw5A
	7ciOtStW3CoYTfur8tXn9licRaOrqd6Mb5Ovnyb+jFKqtFkfYNGgZF7oohyb/6HT
	dRL7IEEBDrL29tz5s4xZQ==
X-ME-Sender: <xms:s30VZ1rICq2UfQCUkTqcGWMI2BqyVTZrjZ-_8qzvMGOAbMMbwGWnnQ>
    <xme:s30VZ3pGhmRwCg0pYuxw-RAJ6Qz4rSdfnYPRgnIrNBuMN4vj8-LBwCDz-3Rrul40t
    8NB0t_lwLVUjyEnzg>
X-ME-Received: <xmr:s30VZyP2VSyS3oZx7Pofrc2rqDByHNqkqPrX3StmotgvgCsQwCL9H3RVZEmWAM1UKCo8kKeq0TgZgnS5SJssPXQtsi-acCeraKpLVfAkVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiffdtvdfgtddvieetffduhfejtdef
    teelkefgteekgeegffduiefhudeiveejkeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtgho
    mhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hlrghniigrnhhordgrlhgvgiesghhmrghilhdrtghomhdprhgtphhtthhopehjihgtvdef
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghrshesmhgvthgrfhhoohdruggvpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s30VZw6r5KLC2-4nKsIhMv0WDBGwtoSbS17lftsAZWeK8UP8Piu38w>
    <xmx:s30VZ04tN94SKVYxG7Zf6qXb5KkPFF_LcElyjjvolDiTWidBXV-5rQ>
    <xmx:s30VZ4j6ABkH64hfj8L38vdzHCed3MDe-UWWwedPRhMVlB7gDJ02Qw>
    <xmx:s30VZ25tft5w9DtPaGGsnuDXxJC62fbMjqgZVJtCJA_e_l0BbtmMww>
    <xmx:s30VZ0ylePeyL2vYBdkp_YI3L5YJWvdU82_IwdpxKWk-zvpZ74MmvvVT>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:01:22 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v3 3/6] dt-bindings: iio: imu: bmi270: Add Bosch BMI260
Date: Sun, 20 Oct 2024 15:00:07 -0700
Message-ID: <20241020220011.212395-4-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020220011.212395-1-justin@justinweiss.com>
References: <20241020220011.212395-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible ID for Bosch BMI260 to BMI270 documentation.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
index 792d1483af3c..7b0cde1c9b0a 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: bosch,bmi270
+    enum:
+      - bosch,bmi260
+      - bosch,bmi270
 
   reg:
     maxItems: 1
-- 
2.47.0


