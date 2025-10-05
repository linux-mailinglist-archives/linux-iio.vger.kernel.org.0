Return-Path: <linux-iio+bounces-24756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B4ABB9743
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F82B3A363D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4992882A8;
	Sun,  5 Oct 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="vwiDgmR9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61414A4F9;
	Sun,  5 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759670415; cv=none; b=txwPaq9GUAJvbfFUD57j29i2AC/F3W69DfROiFsxjxbBxNI0alLNMkaCUBni/7oFACvXtr4Q0Vy80KkF5YYbjNszmJ5EWsRxcUAKYaVGHINw7mZrWUNiUo5CXiHunS64RsY15792F/kMxhLX8wqmXHzGWLJGipWNST8KX5OcyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759670415; c=relaxed/simple;
	bh=OMns8uwPd30PiioGzxoymRaskS8waCyzQdNMCb4kWtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5BaLcYtQx7RMgV2ZZdaNipJTCI5todi75SLhPUiwtbetDYGu0DeCGgccGUCkgO4RBqpHwCD+8+MULuUHO4CupqOhI5CYZqwkI1895JrwAtn5eXPme2MNKHdq3AKZJMVHU80eDK0015V8mhFzzMyWvQgSqFBj0A3ZMwhn+dU+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=vwiDgmR9; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 080A0173BE9;
	Sun, 05 Oct 2025 16:13:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba9SmFFFThBt2H7cUfDPWfYs13rpomHUEj5ezt6iOfY=;
	b=vwiDgmR9HjItH8IYsqFoRvqrjZPFu5X7teeiR9V2r6CWpaQMDvSSAe49H95tkH9G3e01mO
	+9DCM00Qa7y1ZR3/Wp7yHsqJVomR6yv/zTmauxzAMyDEfmBu8nmWqbE1SEADKMnAgXrZIh
	Nd2Tjoxh7NOCjm4RLdPn8cz0f89lpGjkEEP+gfLRJCv2EU5cPKvX45iKDry2TQAqCmFQzz
	Qu5a1tVIgScqABciPfi/ai8fMJluOOGffcnVd4d9aoCMCjlw0+NUcE3gyieMEcYV7d8Mdh
	PQFUmy+P27zic+bBfMvORAFZy04L/xSJ5fANaBYI6Qn/K59/vJx7FZuEDMB7SQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:10 +0300
Subject: [PATCH v4 01/19] iio: accel: bma220: remove incorrect kernel-doc
 marking
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-1-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=814;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=OMns8uwPd30PiioGzxoymRaskS8waCyzQdNMCb4kWtE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQmRDc25wMk02U1dNQnl5WmlBR
 2ppYnE2aitBaXlMZGZpbnhBRC9haWZib251VlFhbDYyYkdCaHlWClBtYWg5ZGRNY29rQ013UUFB
 UW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGpCUUpvNG02dUFBb0oKRUhRcko2ZGp
 Pa2xqT2xFUUFLZnBaN1g0di9aY3N5UVpCNTJ0dmRFWTlNelhJRWZDWEhmWVlOWk1lRzJqZ2g2YQ
 phRm9RRGZqTS9GNWlMZjMxRlFUc3AxWWpPZWdaMC9ibENiLzJiRUM4WUhKcW02WGd3bWhGK3ZhO
 XlJQzI2WkltCkFycnhRd0I3UWM1Nzk1NEsyMjVjVXRnSTFuU3RwcEt1ZXVjV3MzSGVIRDQyRWpF
 N0x2bTZmTkV5a0tpQXZPWEsKcmpxeXprWXJhK0dWYlZ6RVRSWGZBUmZ3bDc3UmIxTkVzS3hZeDE
 2Nmo5TkNuZE1taFFoQkZtWEFoNkVkd29jNApERkJROW9EcHN2YjFrdWpGQkxpUTAyM29jc0tQUm
 IxRk9FVWJvN0lyY1lvVWxZVFAyYVc4SjBhSDJ6dE40Q0Q0CjJHMlRVa1ZpQ1RtM1l0ZEVDaHExW
 nJtME5CT29YeER1UFhaQmN5VnhYRjhKRnZlWXczclFjbzgzdTJ6cHdlUnUKWXBvR2I5UkN2VDly
 Sk0wcjJTM1lkc0dTcm96bk40citKUHcvaHh6bmw0U2xhYXYrUlBpYWdQZlhIS0MwN1JvZAoyUG1
 FRTFuVFdDNmZjS3VqSlRXM2JjOGhnTDNqR2JRRkFaKzR4blhHdTk2VjRxMkRwSGs3cEIzSjBDVz
 l2Snh6CkJEcFFCVExvQzMrd0kwdGhqT0VwVHdDaHoxUmxzWUhocHcxdmpVbE96ZE9mc1hZR0Zob
 jgxTjJKUUtWVU9zd3YKMGNwWDJWMlZLb3poUGRpMCtQUzJDRnZWeFo4OHZYdWRwQndIaHhHQmRu
 OVVBU2dScVduTmZIQWZpT2NucUZhQgovTnFjTUlJc1R0TWZGMndkVzl6QVc0UFpYekRGckNuK1l
 zWDlyU3Q2bXRNT21TcllVZzhKeUMycFJyd3IKPWJtZHQKLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS
 0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Remove incorrect use of kernel-doc marking.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 - split from bigger patch (Andy)
---
 drivers/iio/accel/bma220_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 01592eebf05bb6b002d44c41cca1d2dd5f28350c..505ad70912571ba629f91e56a92898d8320e976f 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -223,7 +223,7 @@ static int bma220_power(struct spi_device *spi, bool up)
 {
 	int i, ret;
 
-	/**
+	/*
 	 * The chip can be suspended/woken up by a simple register read.
 	 * So, we need up to 2 register reads of the suspend register
 	 * to make sure that the device is in the desired state.

-- 
2.49.1


