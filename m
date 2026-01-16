Return-Path: <linux-iio+bounces-27854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B352D32B89
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD69314554B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24691393404;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3UXvXOd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504E392C36;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573958; cv=none; b=LnzKLFm4ZMQpHyaookJ+Sacmb3BL1O94DD2QrdmjzcXlAt9FXH/GLf8tquR+ZYmIj9Q4CDw/l40P0ynuC7eE92f130vZ8bfho8mFY3n1cHCaGFj6xfk41re35OHJfHkYf6XQFwUTA8rqnJ+wNpg4RKnpRzZtzcT4cBdCN+9MoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573958; c=relaxed/simple;
	bh=5Pdprx/T4/7tgWTyw//g5Cy5x8rBkNMkRXoxWA6N5fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ab1Dsd2HfkxouBZWhNrPXoUZ2UV0o+yO+lrzKgRnSCOI0aeLJtLQFBe6I/SYAUbA9st0yaHeoFW75WwPFkM897MG6qzzdzJ8YqaVHfEn8/7ZpVQojhis6+dIm2LAa8n81DxYQDzJZ+n/cooAoAvb+A+b5ZTZvaFwyKhqIstMLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3UXvXOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C3A7C2BC86;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573958;
	bh=5Pdprx/T4/7tgWTyw//g5Cy5x8rBkNMkRXoxWA6N5fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h3UXvXOdj10azg2+EXgBPaVspIla7kh3fmN4kn/yX0ofLr0EbVuTyJjRXwhq/dJD+
	 wEIkyymsoro6GSEslRpby2bkOMs1npo6mw12yXgq3yWZC1d7fm8VWbaTG8Iibu1V68
	 9FoOVAKt9UhPp+LP0/1thg86+9ftIIuw+TdQG3Psu1ijChNYUZ4ZBiRb2RqJ7yirUb
	 /QWwmwml9gPthzV5xXSlsf5DEYn9K3UJhqr3HmOGPnhh2Y9MqVKEOcDLe+zrYsZqH/
	 X6vSXaT3Gp9EOf+IZTl/a4+airJ9tBtrEv6NekeXkdVHZTMzriE6fkJX8VNzp3uJ7V
	 +oQpCiSIK1+UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA2C982C4;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 16 Jan 2026 14:32:21 +0000
Subject: [PATCH v4 2/7] units: Add HZ_PER_GHZ definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-adf41513-iio-driver-v4-2-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
In-Reply-To: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=642;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Mv2pAN6X4qTIrdTXsQmD4zyISKh5GA9YF7QZeduEWxY=;
 b=eoiVCNbs0HMipw6thyXDkCSXRU2xNbJSDigo82wNn4gzbYFvLGN9+ouOf6BCegC5ITI7OL99m
 EjTsOcYh4InAB0Fwo/0n9j3semAfRo+ZRVFHgJ4xrjtQVVloIWmc7QI
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

New PLL IIO driver supports output frequency of several GHz.
The new define helps to constraint DT properties and frequency
calculation parameters.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 include/linux/units.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca..06870e9e90b8 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -27,6 +27,7 @@
 
 #define HZ_PER_KHZ		1000UL
 #define HZ_PER_MHZ		1000000UL
+#define HZ_PER_GHZ		1000000000UL
 
 #define KHZ_PER_MHZ		1000UL
 #define KHZ_PER_GHZ		1000000UL

-- 
2.43.0



