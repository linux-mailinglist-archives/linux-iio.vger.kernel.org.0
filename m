Return-Path: <linux-iio+bounces-10018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349F98EA80
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD42C1C215AC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914BD12D1EA;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8UQuLHy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40D73451;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941075; cv=none; b=ukyYJOI57CCqohtp2Uq+LzrSn83KTVOwIOLKQ64HPOUrwqBT1SIF08/nLSX3+41fWTZ7SGp2WhBPHU2kbh6wMbuQPXhWj5EAGoVcl4w4Ia253ZiQ0D8+LcHnGeUPL041ihHXNJFG00I1OZ30Wizcj0wVaj4OvLksfj5wiS6pSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941075; c=relaxed/simple;
	bh=BdE1cUEHTRfW5mhi7z6nY05lVHtnvVutEdzIPVEuryo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnpstdLEncuzy+ZgYPK09uOiTxgVT9xcmNKX4Mu5+UqJBNYpClrsTWF9Q3NM4cql14o6YjCR254gQd4Td7sHswJQpUtxS5kKudLrRWoON8yzh7YeiL4VGNMvrYy9bJGnrALEsImLZBGKB2vUTjf6fuWXqArEAlPoR07CKI26L+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8UQuLHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA3A7C4CECD;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941074;
	bh=BdE1cUEHTRfW5mhi7z6nY05lVHtnvVutEdzIPVEuryo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m8UQuLHyYcxUBfFkyxuVnxzw/6JnoBPzOVQR8RiKyd/UiL0zgwAmQWPY5vODNWAne
	 Ks2WEbA0L81CLu4BYlNT5aR/GhbnD0/hLa5mNScOWM6Hvd6CgYgX4cbIzAf35Lgefy
	 jWQAzrya8kBuqw7CuJ1ooFozls1xw8Z154l5uRtl+ZrH5+5YkUhjWevxavxxD9OePa
	 Hnj8tktz8u8xhUgspC8cyw6/ciiLgeP0b+BP1YF/TgQd8KmYu6qGo2+2lEBpUGELse
	 eJ9Clkou2j+UWDau5JIWzhBOIcydYUcLvVlxSLWYZeiAFYaHKBdY0v4abea+1c/tCL
	 HmcDgXbM/VmCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7423CF855A;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 03 Oct 2024 09:37:45 +0200
Subject: [PATCH 1/3] MAINTAINERS: iio: migrate invensense email address to
 tdk domain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-invn-maintainers-email-update-v1-1-7e4062ad68cf@tdk.com>
References: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
In-Reply-To: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727941073; l=703;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=bnLpFpdGSdAAgRlcBRyqc8VlLbTmu7ekBGszqaJYuJI=;
 b=6THKOwF3SO7EIqHKot5HNqh+342ZX40WpOOahQnVngw76Lmjabv6QaRApqY+o5lO/JQfOKmM/
 2IEKKHjOe81CKN+0/r2Nx8A3nzbdN8kAYGwecFAtH83yZhkoGHPmxLi
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

InvenSense is part of TDK group. Update email address to use the
TDK domain.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcdf43f37660403f3adb11884f1c58f64bc32840..b6b252b991a514e225df309485c708c2af547f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11898,7 +11898,7 @@ F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
 F:	drivers/media/i2c/isl7998x.c
 
 INVENSENSE ICM-426xx IMU DRIVER
-M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
+M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://invensense.tdk.com/

-- 
2.34.1



