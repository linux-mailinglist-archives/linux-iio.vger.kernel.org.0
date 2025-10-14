Return-Path: <linux-iio+bounces-25057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84095BDAAEF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AE23AECA6
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B988302CCD;
	Tue, 14 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="kjq+v7fP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97C2FFFB8;
	Tue, 14 Oct 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460206; cv=none; b=m4Xv19KWkDG5hryADWu1Az6Pp1PQbGwLX8zxMsDQVWYfir68p2YekOWUsKj8cM7A2LyyjMx4Z3OiYwbLNeE1kuK8bNpk9Dszj24sCL4Fu6Z7hBG1bon0i8kJBlGlPO3PS8YbfjU1TB4ZtscRHPcZShhT5qIjM4NPnNaJhW7/G/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460206; c=relaxed/simple;
	bh=03uCSFPXdr35r1DtOgioZ1NTzrTky7VlQoTuY/lbPdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1G8clS7cBuOuPosjY1r2iQ5LN1cCM/tHtUhDIEjMTBVn6tHRw5hZ/lP/4FX9bc1tOfI3ZR02fXrh84O20DyiVWeNm2fFNhymBisZVnPgVi7Qte1e0CHtutC/awvW8fz53mwh01fEVbC1LEXXZuW0hWhhC2e4L9jRsnwjtDwgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=kjq+v7fP; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6D155173BEA;
	Tue, 14 Oct 2025 19:43:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCQJRY01GWTfyP8ODMBovSvJ81tgq5xJoHifNgHWcyg=;
	b=kjq+v7fPI5lVDfz7fkQuIocyzksStoR8huNt5+d0txfMyeO96CMZcc7gRFkXhJ9/zM1QfF
	E7YAHaNysrLN9/W2Uv+D6hYQGXECgRSSz4gM1PUwVYdv4RF5QoKfFXoyj54eQF69Je6xMb
	0rI3LTSE8YHtfEy2/e0BizDYQcAtsxIKcaUBlENNrKRLW+7sNctvO/DqJbw2Cg7H49qShw
	Ry9L1w+Onwpw2a1uyN20g8ikAlxiRMxNfmUZgqBI22q8WoRe4LgKRaP3iXEarRXReW82ZS
	r/4wglpi03IAimb3vJkxk+weqBBQjXYjHhjBAK4/B/ZQYIQWFVVF8Ka+PVf3hg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:42:57 +0300
Subject: [PATCH 1/6] iio: accel: bma220: white space cleanup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-1-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=03uCSFPXdr35r1DtOgioZ1NTzrTky7VlQoTuY/lbPdM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1Zlpna2VwT1V0MlhLRWFIaG5CM3FVUGtpClBaY0pzTHB4Mm5SZElOd0h3
 YU5Wb29rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMll
 BQW9KRUhRcko2ZGpPa2xqbndjUCt3YzFuTkRwZG5SdWNTRkhMNDdHbDNsSWxRM1BRajNnM1BzYQ
 ppbGg5bFllcXd5SFU4TWpDMnJtTHowS2MyK2NnY3F6N0NHQ0RHdWlvdjE1UkxBS1lCbnl3UzBmb
 FRoQkNaQUxMClhEOTJ2QWttU2l6bksxek9mY3E2cmZOdjFpMXJWQU5hSVdHUDhrWk01a3NOLzZx
 dStkM1FVRWNDbStYMW5lMXQKU2FQbXoxSUZkRVlqQW0xbHRibzlQZEZGMkdVUVMxQXFlVnNlN0x
 ka3o5N2VYcmRBa1d6UXVJL3lLU2tQSUVaVQpuRlg4emZNd1NXTkdMR096ZGU5dzhYTDJ6U08rcG
 N3dWI0TXd3S1BrM1dQQXZuVVN4Z3QzL3p2ODFTVk14QVF6CndUV3pFODZoVkd6QkRaZ0F0LzYzT
 EpDMStlNXNHUnV6YUx0OE1EU0lUTy9WZlljTzlhdDd3L2k2Tm1JTHBXU24KcFQ4c09lbjBDb2hE
 TXd1bHpVbU9aYzlYTGxDQ1ZJV0JQODVzYU1kSUFmTnk0dnhlTmYrTTA0aGJTUTlBOUtTMAo5TnE
 xbVJqMHhncUJTREJLWGRZUkJkWXZBVVhTdkhjTWpWc1ArTHI2TmtZbzYwWkUva0xBQnUxNUsvTC
 8xR25VClA3V0lpVTJ4MUVJQVhuNG95ZVhDYU1UMDllRE05czFNMkdXamlrK08xbGN3anNXaXE5b
 2djMEpCOFk0VDlyWEoKTXBnMEpsRzh6dFRLRWkwUUtpd0g1RlpJVmZNRnFhRjZJcUt3bWVWSkpa
 MkxraHdoR05IL3hxaDVMNHVGTk1vZgpOd21YRVFUMis5Tnk0clpoNXl0bkwrRXVwelBlQVpQcXl
 DV1pGNjRRcUQrZDUyY0JHYU9YcENqWWs3U0RoN2orClhTbU5rbk1jcEFZblhnPT0KPXg1ZUIKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Clean up white space inconsistencies from the last patch series as
requested by Jonathan.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 2 +-
 drivers/iio/accel/bma220_spi.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 2531d6a54ff0..871342d21456 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -128,7 +128,7 @@ enum bma220_axis {
 };
 
 static const int bma220_scale_table[][2] = {
-	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
+	{ 0, 623000 }, { 1, 248000 }, { 2, 491000 }, { 4, 983000 },
 };
 
 struct bma220_data {
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 7aced4017373..383ee8a135ee 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -26,12 +26,12 @@ static int bma220_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bma220_spi_id[] = {
-	{"bma220", 0},
+	{ "bma220", 0 },
 	{ }
 };
 
 static const struct acpi_device_id bma220_acpi_id[] = {
-	{"BMA0220", 0},
+	{ "BMA0220", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);

-- 
2.49.1


