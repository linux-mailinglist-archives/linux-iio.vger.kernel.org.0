Return-Path: <linux-iio+bounces-24678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976FABB5158
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B34483424
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5EE29D266;
	Thu,  2 Oct 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHf2aNm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AE2980A8
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435377; cv=none; b=pDYx9aI3yRgPJOksXXPQd3EqP4JkKkDXAu63KEhZkejtXwPiqBz8JdVLiFbzgJt1lhcPQIn1L9pBMha3ZjKCEab3X7NglX+lGC5Oow0bpUxRDNHP8UxrVTuafShKML74GUCjIcwWHV29KeY9ePZel09k9D8a95FMf9mMhztgUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435377; c=relaxed/simple;
	bh=REDD5MKT+T6fE11WtgKxnSCfTx1waCKVI6IWJJQuEiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GO3WktHDusA8SzIn0d+UcQwCFaGG+uFhjxXaD/auXvl/+CxVIy5MC14nCjv45Tffi5o53FrR4KK4c4lNCgkJE0aZk4gP8O67q5KU8DboT5WbwuJqT4Vjr/mF2+ioGH4KLEbqiGq5tJcdz9agoSxdqZm23RnGo1od8fiz7d1lT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHf2aNm/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso264752366b.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435374; x=1760040174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5B+iY1CVYEWEXhFVr0arn1MWUauujSFMSYkHP0zG1o=;
        b=lHf2aNm/HR0E1L8j+2OMz5cHcVL8uyDCe9WYS6Q/U1i6WB6ObwzglCKTQ+NWWA7H08
         yZGYi1j+BTjn6IdHumi/76nclBQ2fhwxC9Zq7Rd2muJpgAphvqJMJ8WPwjJWykDOm8dU
         u5pFa+kEnTtLi2P4SCY87KZo+TqwSkeVAwCUSlRh0rm0rj3EHJOqd3Yz8YEBNxR7iZ1Q
         ctIWa+AzzIUuP/GkI+MGhNiuQG+Zskr80pg8FnrkGvZO4z14QANmYNR0KQlGsNB4NrmA
         jbSoERbHa/eQQcCuR7hv1i/jS3RWkb8+gwAyYsRxyq+2Af8uAg5BE0c5yfhYBcoTuZxL
         F8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435374; x=1760040174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5B+iY1CVYEWEXhFVr0arn1MWUauujSFMSYkHP0zG1o=;
        b=ZNG/SzyJiVbV4DOR/6Ng0x4pFqBU2egT3RIOZ6W2U4cY6IIGHkL2en603qEbaBWKM7
         zH2q0wnaAa9MqW3KrwuUHZniMEN1puu94oBDqxgZtnOs8EPRl0Sl4DkJns9c1TP/TueG
         anMBf2Bo20IuefFQg4DDerf9mQrtvjNkLQ4DzF+5jKKHWA5lyPI4N9e4u+vlK0xmj7rx
         WXR39TyOsXnty6zLRAc13zRDN2XPBlG6+4jHOB6BSOToNJWug+ixUiGzxLL+7NgJAjvA
         vr6R4QvR+n3BHgS7FbW8bwazwM2XEb3rRIgCwGzVDdjqDHzn2C96M0AnPtAy8wP9w+Ox
         erSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCuzNdvcgXaaLAgWY2lr8LzVNZYf8AtKMMYCVLLNxVMcFTaTNUdKkg3wF1/bpg2gxSCrcpW1fIiyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZDQqa6fWD3J/ORS0Y3lJZskMo3AL4VPJ9ZJcUBVYXaRhD4lY
	EdIdY18vxM4g0h1Kk7G5hAIZFanwqsFJWILtZO3UZ/5pVJ/bW2zepg5C
X-Gm-Gg: ASbGncuCzOIZzy8q3hbTOT/bBcX4BT64Cg/T9VTQVHaWQFDbGGFCIhjsMJTs80wm9Hu
	jeK8Yuts0lAzVRrldh5CqW/L8Rf9McKqcjfzzhctNfY7LQCoj9uikIoJRPY2EiYAQzzwCmgjlSf
	Zj7RFuyAUum4DZy4o0LE0C+OLGetIJBJcHNFhUQfdu4bTAKARA67jjo0W60lMJ464HqjmL/hq3M
	5II4IiJlYpxkghTHHOsTYLEfKM8+F8jnkjcQlO8WxfvcSKGWfKuMY//lQjZzGZhEZc0Xfqofgnb
	loAKPLuiNvv+JkyiUymTqt3R+W2KWuMiDq11cdZXIF04sFhMbABHo4DnBhR3q09j6OPreb04DnC
	V9/6aukSt77NwGHJuLK3eJ+SbhGX+wdQSfICCjNaQZ4mP2WjeJkCyqtI=
X-Google-Smtp-Source: AGHT+IHLLuSxZSfWj6JmA7gazFVSXaP5F8QLszT1jN6eLNAVZ7qyjvjL4BW50x/00CvbU9ELpFQ4Hg==
X-Received: by 2002:a17:907:6eab:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b49c12809ddmr83263966b.4.1759435373813;
        Thu, 02 Oct 2025 13:02:53 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:53 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 3/5] iio: mpl3115: rename CTRL_REG1 field macros
Date: Thu,  2 Oct 2025 22:02:04 +0200
Message-Id: <20251002200206.59824-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the bitfield macros of CTRL_REG1, so that their names clearly
indicate their relation to CTRL_REG1.

This is a preparation for introducing the support for the DRDY interrupt
which requires the usage of other control registers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 1da78081ca7e..61830edd959b 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -30,10 +30,10 @@
 #define MPL3115_STATUS_PRESS_RDY BIT(2)
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
-#define MPL3115_CTRL_RESET BIT(2) /* software reset */
-#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
-#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
-#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
+#define MPL3115_CTRL1_RESET BIT(2) /* software reset */
+#define MPL3115_CTRL1_OST BIT(1) /* initiate measurement */
+#define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
+#define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
 struct mpl3115_data {
 	struct i2c_client *client;
@@ -47,7 +47,7 @@ static int mpl3115_request(struct mpl3115_data *data)
 
 	/* trigger measurement */
 	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 | MPL3115_CTRL_OST);
+		data->ctrl_reg1 | MPL3115_CTRL1_OST);
 	if (ret < 0)
 		return ret;
 
@@ -56,7 +56,7 @@ static int mpl3115_request(struct mpl3115_data *data)
 		if (ret < 0)
 			return ret;
 		/* wait for data ready, i.e. OST cleared */
-		if (!(ret & MPL3115_CTRL_OST))
+		if (!(ret & MPL3115_CTRL1_OST))
 			break;
 		msleep(20);
 	}
@@ -268,10 +268,10 @@ static int mpl3115_probe(struct i2c_client *client)
 
 	/* software reset, I2C transfer is aborted (fails) */
 	i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
-		MPL3115_CTRL_RESET);
+		MPL3115_CTRL1_RESET);
 	msleep(50);
 
-	data->ctrl_reg1 = MPL3115_CTRL_OS_258MS;
+	data->ctrl_reg1 = MPL3115_CTRL1_OS_258MS;
 	ret = i2c_smbus_write_byte_data(client, MPL3115_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
@@ -295,7 +295,7 @@ static int mpl3115_probe(struct i2c_client *client)
 static int mpl3115_standby(struct mpl3115_data *data)
 {
 	return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
-		data->ctrl_reg1 & ~MPL3115_CTRL_ACTIVE);
+		data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
 }
 
 static void mpl3115_remove(struct i2c_client *client)
-- 
2.25.1


