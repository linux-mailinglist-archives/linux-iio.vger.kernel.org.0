Return-Path: <linux-iio+bounces-11405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217839B1F60
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 18:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E271C20C34
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68EB17C7A3;
	Sun, 27 Oct 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="k5Aw02Lf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWrkwj4Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C917B506;
	Sun, 27 Oct 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049713; cv=none; b=Ak38FxaAYvJXBGoH15GM6YKPCBMAPUYy8H/NFQNcVUm139mt60ewdN/QjlNp6iK7mb/dV9C0yQEHEDC5DxYYITDBV5/3R1bXARp1oOB2yMaDKTRyT0fN6+MrwBDhQD6QAdIQb3R9oS4zuMk3X3CNgJTM5xpCW4pF7K36QJaNJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049713; c=relaxed/simple;
	bh=zNLifCw53RuEU9K56iB2kiI1QFNOASqO/+9c0/UVaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBKZYo6DrK0n3sd5UlkqAOcF8I/Xu6n9vdVfmHjmmw4PxNxCxXtOe1XJz7GDEWUiEf+hFgz5umYz8mALrNkIY4SPZMHubK1iTWPfVmPKFStD+jhhfTGVwlga7EOv4AEQi/3QaSjkEd6tnq744bBODKuFPZ1hUNiygIVqp6Kx/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=k5Aw02Lf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWrkwj4Z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 30F6D11400CE;
	Sun, 27 Oct 2024 13:21:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 27 Oct 2024 13:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730049710; x=
	1730136110; bh=b3yx3pByZgnY+Ay2QUJg1Z3X5UQekehxLlhS8VzCxk4=; b=k
	5Aw02LfPEWGwR3MNc2DUIjT3UT/cgdeVGidAYPR1vmAFjP2USyIYqJ1EtC0drpZa
	rHK1MsXIidf3zHEBAToYNiTUnnCq5HK5ou73fVHYDkmkTSytuF9I0loqaMedWYBn
	A+SMi6yvkljw94VPmzFCQsWxl0yXR/bunlwD9fw1O0LEKPCTof0BgTCG4U0bUztj
	m25VXxBnn/TPSq6inkjUsUClVeV43/NfwRp5AQOuKt9l/XXo9+Lsr0PmQ+VDFwer
	B8Kl01bIjcH0V7+SwTne+0GgeFA4Sg75SRy4wLdabkcMZLxwCD0Lw3Jad5UOUZAV
	c5XwxvTI0EDYfv16NHphQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730049710; x=
	1730136110; bh=b3yx3pByZgnY+Ay2QUJg1Z3X5UQekehxLlhS8VzCxk4=; b=V
	Wrkwj4ZqkCXQ2y3gi6B1XVGl5DmYgQDmnCrpCvQfU7mzODq0wtt8h76Wq6eeWbwv
	ymoaQbcWvwY6kQPC5bI4Kvikf4UJmbuY9lgWDA7SaKh/IUCOJxJOX3neZu/Sn1E5
	f31d4ywKKyi4chntoKhYLQGHIDQhzFilFaSBCxQA49P6VFdwTRjJhFvC/77p49QR
	Iq455z2HXXVivvknJfNo7jK6HIJlcgdNCf3WcEJLd+wORaNk5xOLt23oj928XuCD
	DaHLlw9AzC9RmqdnT64/q0qLRwfn8Emx8U6TusMIB+4D1jfVYwqRfLjNgziH9us0
	+vFrazwwWAOJM2JwPs5fw==
X-ME-Sender: <xms:rXYeZ4Jap3Wr71uls0oISj61QFlNqTAIw2CL5UPT291i5Rfu-KV0HQ>
    <xme:rXYeZ4JxYOcumKPWBMK07owUJ7xFt3M5EnpkTjRUPQL6tVYxs37EL9wMGQB32B833
    bYleH7WOrlpeLhb2w>
X-ME-Received: <xmr:rXYeZ4t4Q4HIpelk7yVDXYcEQdOqg8SLwWN_05-IbavHZvVHTCtQrHxwfz8yb37Qz8qsf-rNeS2rBsPFWv9nfrWePBRjWAm0D10UuFniMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepiefftddvgfdtvdeiteffudfhjedt
    feetleekgfetkeeggeffudeihfduieevjeeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhushhtihhnsehjuhhsthhinhifvghishhsrdgt
    ohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhgrnhiirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdv
    feeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
    dprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihk
    odgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhushhtihhnsehjuhhsthhinhifvg
    hishhsrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhiohesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:rXYeZ1ahDpdnMOBm8c5LjR5gP-h2r_ou3Q1dUbbYY4hlIMelquaMEQ>
    <xmx:rXYeZ_a5uQHrSkE5seaKeG1AHqleUYDzgjXKsZ8pbbVxzIUd5yaiZg>
    <xmx:rXYeZxDO1dz8DgBs36lZlVdR03b330B9qlK7eQoHlW-i_rw3cLIe3A>
    <xmx:rXYeZ1auiGclKU0O5HQY-dxrr9G0VM7WTe4ydlTKrEGzz4A0P_5IVA>
    <xmx:rnYeZ7p5Kg8Qpp7F8CxJ8My86_vx69O-zSJgYx7wxj15CpLCGAcdNn8j>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 13:21:48 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH v4 3/4] dt-bindings: iio: imu: bmi270: Add Bosch BMI260
Date: Sun, 27 Oct 2024 10:20:24 -0700
Message-ID: <20241027172029.160134-4-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027172029.160134-1-justin@justinweiss.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BMI260's register map, configuration, and capabilities are nearly
identical to the BMI270, but the devices have different chip IDs and
require different initialization firmware.

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


