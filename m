Return-Path: <linux-iio+bounces-21080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA7AEC98E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399217A6DAB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB2279DA5;
	Sat, 28 Jun 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UucuOKbR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFA242938
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751133289; cv=none; b=FodPH14E59I8ZTBE0dB80J2CRxSf1sU3PBdC8NenynvBOjpfBOiSjnxlsN/nM32PZmpPhbWaGl6Y8mKleHFZBQI9ESpybxBTRnq4uGDjkMhqPYU5G8tMAOzhlZuuxqCpIGnodkFgVMWbj1+HaYJoSMUeZCzwlzmy/s2xorsSFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751133289; c=relaxed/simple;
	bh=0zjpL1V/eJ6Fk7Ky0EnmVtOPa6ROb70muI0oDeGQCVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V6hnZIg9enLhD8Hos7g5OEuLpnMJPS1cu1gkUYgR6GeOnXkXATiiaK7DYNPC9sI8OFdoF9Vnf+/NvhN2C+JZIQUcedKjPoApPIxOlGQW6pw/wlpdC6xELDPUNf7ckdCpOseipnB2enjY1Lq4MrpR3SSahuFFwBkWCnxdhnqWsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UucuOKbR; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6065251725bso737783eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751133286; x=1751738086; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuadP0vU3o+WrGjNBSJmYh89lN4dUuZOSzW5j10vazc=;
        b=UucuOKbR4In8krSovpmyoFfn/hQYmeyxJwdjdaNa1m3WRh5UcuEX3uupXb3w+okp9/
         Kd+7X0DK9y28mE8skJsoM/QGPRJx4xASPxQXZQpOdbC/hSx0G4C0fIaBY99e9JU5XlXa
         QKCpLWwaP0xt5uvypoUfIihjL1rL2A0PYP1JNP9r1TrFszVUXv9xSdwy8fBuvDOv9blN
         IkZnxa2q/nxE6YjvXYxaMCT7Dgh7KjuW56BviE852RrlTSXKGtQ4Kaoa7cx8bveNdVHu
         Rs2Qh3aJezHiQuYaOXo2yhjFM625lCmFTKBC0Q3oOQFd3huPc4DBkfDTwL1BM4qye0Ei
         cSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751133286; x=1751738086;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuadP0vU3o+WrGjNBSJmYh89lN4dUuZOSzW5j10vazc=;
        b=JHSWobZKC+TioEYc7UXJ/BR+UF3Y56LhBzfUlW/5q01zFXa9nvCpWpukWW+oOXjgxJ
         IBVhWxwPYM5Da6N2h1KbiwYiBUrKPInSO51smVZ+dKoY4MzpuXYFdHQV4erYI9ZLfWIr
         I2rcZWiy23qUYquDbxaeSmeXuaCP8LaaI/4FnIkGvzOtqOy1L+OSv+QVuWEmygWiQe3F
         1F30buPog3clSSbMwb88tb1M5P+9lzvW8LWi43KfNGbIIzFpR1qx2OusXOOdFSNnaKu8
         PeOo8csbMzbnay/cHJYxXfDyI9yPn9h17wAvluYl/8WGxmFVd5ZLMkMmjLRrhXGQMOCU
         LoHQ==
X-Gm-Message-State: AOJu0Yxc8TVsvnAh+rQ4/nAqpJonu6w74PREmU8ql/G+g32i4hjUMNTB
	bnyQG1Nt/aTQlBpyo+t+KN1xF1Ub6c7u56QP++rTmL5pf/jfa6TuxIiDaa0iVNhwDqQ=
X-Gm-Gg: ASbGnct1NABb9k+FPF2mr44b3Ij7BTwM2mbOm3FK+jXHJRen3tmcviOKkvhU07LcPDk
	WjwOZXb7PCBtgoZtTSf/TWAbENd9F7IP/jli34HNIfrzYQBl1aF3lmoE1l77d4R+LXVX0zYWTrK
	NCfYbqDM8FiegRA2cErdRZ9rlefmEQuzJBf3TjZFkY5Zo+qCExT7CN6CFmzX076QCdwhUAMmXlD
	9+QfZqNSLB59iniEmv0jG4b7+YssBf6+L6MRgMCYYL+12pAPjxsu896DbSx2cfZgrwqLdOZcCa5
	1iuxMQ/F7IbvZ+Vkb93r1h1l5Mev9zV0o5gJnJkMtvvgzi1rXVAV6fNXn8yv/smSU5JP
X-Google-Smtp-Source: AGHT+IHrB0pdunMc9fQjAjXZzqXA8yuazcinONbrUvSnwTUgrMdSyYbq9j+vgzfJeJt53j63+ahGAg==
X-Received: by 2002:a05:6870:1d10:b0:2e9:e9b9:fd7c with SMTP id 586e51a60fabf-2efed6ea82dmr5465090fac.26.1751133285986;
        Sat, 28 Jun 2025 10:54:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b1b2fsm1617110fac.32.2025.06.28.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:54:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:54:37 -0500
Subject: [PATCH] iio: light: isl76682: make isl76682_range_table const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-21-v1-1-2597d8eda30f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFwsYGgC/x3MPQqAMAxA4atIZgNt/MWriEOxUbO00hQRxLtbH
 L/hvQeUk7DCVD2Q+BKVGApsXcF6uLAzii8GMtSZnkYUibjGoBm9yw7JIrWN7zduzdgMULoz8Sb
 3/5yX9/0ASbyA2mMAAAA=
X-Change-ID: 20250628-iio-const-data-21-243d6fe40837
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0zjpL1V/eJ6Fk7Ky0EnmVtOPa6ROb70muI0oDeGQCVo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCxe8mG1dB3KX8VH9TtlPSbtPY4aaIAvyNl8f
 YfiUtDCWp+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAsXgAKCRDCzCAB/wGP
 wJzwB/oCR33fg84rLDsf2jM9C9lzn+AtZ6ipw6ddyGaUe2i3cibB+qZlJ/jv++SQy2FMM9S6UPl
 FKREClsZ1LWQAAI6d5ua1UsAUcky1DwSUaJxRiGgggqM5886SNus3oEh1PUWbNVojIW7ufKM1yR
 7jfERJ/cJJ6tkwEkXvd6/iTHpN3b07w/dzHODjSi4KMxmCN4uhpQtnCTZL6OX7tOwqfj5ttlGvo
 PmI20NcEs+duJTeUcS/KyMmGaGTABCt9+hhkyU5X70RyeWzOCFchE/t8m6UzEL+FCiF9HmaFtqG
 RwwHd9k7xCD6BbAZ5P3zvojAVKHcmCG7EhMYg2fnT4jVRIXp
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct isl76682_range isl76682_range_table[].
This is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/light/isl76682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
index cf6ddee44ffc3f8010de912d36d16d474dbdcc66..b6f2fc9978f620afc69750d21eba7a3aa5032e2d 100644
--- a/drivers/iio/light/isl76682.c
+++ b/drivers/iio/light/isl76682.c
@@ -59,7 +59,7 @@ struct isl76682_range {
 	u32				ir;
 };
 
-static struct isl76682_range isl76682_range_table[] = {
+static const struct isl76682_range isl76682_range_table[] = {
 	{ ISL76682_COMMAND_RANGE_LUX_1K, 15000, 10500 },
 	{ ISL76682_COMMAND_RANGE_LUX_4K, 60000, 42000 },
 	{ ISL76682_COMMAND_RANGE_LUX_16K, 240000, 168000 },

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-21-243d6fe40837

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


