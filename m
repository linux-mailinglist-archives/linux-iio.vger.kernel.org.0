Return-Path: <linux-iio+bounces-8577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C868955FE6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7451F2172A
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913D156C72;
	Sun, 18 Aug 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ezNBobdb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A25154C0D;
	Sun, 18 Aug 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020192; cv=none; b=U/4DeqjB87Vr/HCGHABjdNQznJ/2gxPt9U7F0SH6OZZy38clzZaEfTkQoekuI9rLzawv04IXZUKn5dptKEbNAymOE8elwb0iGdWZhbF0/LdYWpUEMvyTRSdVHmkwIzYQCFWzfyyILMZQffuhCxcvKFbZmKi2kxhMt0Aiprc1Oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020192; c=relaxed/simple;
	bh=grpKM7vcKAHOVjMHZqV2M96zyxR+uXG/mzxlGax8yAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjyhsKzZxNUczG9wJFxOv1/DFpBR947aZ7h1F9lbWKz4OhPVEchl6z5i2ouvVeVD1HcgOamPwpkBM8myu9AWlLgNV3pSizh1G+1ujfBQ55A8iY222icXX6uEgDI6qUTrRJD10sxwEQTlO6NXpKsIZtJ9vKKlNF8v/UZfTm9HEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ezNBobdb; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC24970D.unconfigured.pool.telekom.hu [188.36.151.13])
	by mail.mainlining.org (Postfix) with ESMTPSA id 631AAE44F8;
	Sun, 18 Aug 2024 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1724020182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aKokqTt+o76OlgVHlya5SlvemTXVqFqL3g/BEhLoa8=;
	b=ezNBobdbDk91wMneutgP22WizHytUnAfeWZqs1h63nLuN9YETiPOKySRAocHI53Yhfm/xq
	mSqZ67U42vWzVHePvLTZiN4mu7Xb7IIcCR8HvsJ9CH476P3nr4FOTISNYx56q81tqFN/2l
	5uncVGF0llxsIKz+rjWIKq66XPPabqJvgpSExqVOv5lkRkuuoMIOrYG2VuaNJ3h8Y+MEWR
	gTTQRIQOMyixDhV0+mzwqY88lMeXXlyoYdmphjFWfv8Hj6u+mE/YQCzoOUPrO66n0CL+DE
	b7IEs7J/8amlNJQNcVnzZfeQGDtdpRe+nfIO0cCmCXwlZrRNyYmT1E9dv9Tx9Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 19 Aug 2024 00:29:41 +0200
Subject: [PATCH v4 3/4] dt-bindings: iio: magnetometer: Add ak09118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240819-ak09918-v4-3-f0734d14cfb9@mainlining.org>
References: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
In-Reply-To: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Gwendal Grignou <gwendal@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724020180; l=1094;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=4z8Qw4TnpjyDIAB9abQf+nU919vvZWUxTVxcAw+kBu4=;
 b=ihojHA/YzhWQNwBhPgNpncMe1EgkFV9Jrg3y7PE0YrCrzC1N0jNWtCrf4HxHtQqHQGq+ajHqL
 JChwDOQ0QJfBNXkcABkyTC+gbfcWpahByhIEoHAB+KimGOnM9yidhuE
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Danila Tikhonov <danila@jiaxyga.com>

Document asahi-kasei,ak09918 compatible as a fallback compatible,
ak09918 is register compatible with ak09912.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index fe5145d3b73c..e8ca9a234027 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -18,6 +18,10 @@ properties:
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
           - asahi-kasei,ak09916
+      - items:
+          # ak09918 is register compatible with ak09912.
+          - const: asahi-kasei,ak09918
+          - const: asahi-kasei,ak09912
       - enum:
           - ak8975
           - ak8963

-- 
2.46.0


