Return-Path: <linux-iio+bounces-5851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D3B8FD4C4
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2273286ED8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7314EC5B;
	Wed,  5 Jun 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U52V+hRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C715FA74
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610421; cv=none; b=LiBJzwrWjqkKKnTKKRj8YtnH7PwBUosFxa6ryFEivobffpAAcxHDplmk4T0X0S8MK/m4cnpNRe2Qz1WD0fiubTrWMY7l6U8kbWzth6NrQ2usiN2iX26QoktixjjIdmGY8tHj4Bkk6BXkTLUx4Bu2qOZI8eaCCjGVMrqPc2CrG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610421; c=relaxed/simple;
	bh=DtpDZyHe3eugG9lKYAyC1ondYmKEiXhRbdfT84tszLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rUQlNx2v2HsY6NnkOeMRuWz6PMQuqLkka2w9WKrkRBR2HBqcdh7ICFEBgAFORE9TZy7H89VD4rgbJ/5Cusx5fAH2c3aGXX3wFl13WNcCEs65mpo5A2RpcZmw+4zWIk0VWCcO718XIwVT+AxeJBblAZTZTYP4h5e/064FKQYyFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U52V+hRs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df78ea30f83so1550765276.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2024 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717610418; x=1718215218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwIs39A3C8kh3vVRuRyRYkps3QbjGarBaeH82L3DU0g=;
        b=U52V+hRsiJQjSRnjvYDtZ8nO3ttKXkTxiHrLjNmADwfjQ8plad8HEMYMkkxmvtoFIs
         QEZHHMmsbHs8oE4DsgfG7xV73VdpniuxJWGD1uX+sexyHuIPqMEjjQbpiFRleB333mzK
         cskQ8g8ioMRy6iE5yXCZP8fi72tXA3aLXSn2e//1mmOhKE3l2iZpjrsErUj6Nw8rXBT/
         Ls5L9CJrzLx+rKGRzdTKorUXDwYGdNhd3A3/5vELUbwt6as3QITS3EdKaGbEVRNWJanK
         trjloEE6aIqij88o+jESh2lYoT7HqoWLxLTSIiCFGrQSEuGXKrYAGwKb/WUU8YLm9SV8
         ouoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610418; x=1718215218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwIs39A3C8kh3vVRuRyRYkps3QbjGarBaeH82L3DU0g=;
        b=Vskcsp/vE50B/EJOqpgTr66BsjgPGtiXX1rfG+xLdB7cZPo+dsYjRLm3AMy8rCTe6T
         MpHptQ6XDVB8a0zQY1oxg5tmKuwIa3HV6UBXRMUi4WZdpP3L25LsURajZaGR2sFrJsV2
         q00aMCVqh+eOHrbJmjMAJ9D3Y13l8m7bni1rdP+5qs/rchWxGE6DQOkXvd1PPXwuETYJ
         /lCe+aDzce8nUEV8julhzbg02MdSsMH0/KKeWYOvryz4w5jjhzgaKBkZT50DgAdGOP1y
         9vNc2iIb7MDFbaBebsmQwNU+rb33oFRlrCUVQD9BS7T99JNJUOS3kFUta75SOr074dqy
         mHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsncbk5tEuXvNsmpHP1FEu2x6u9nZUborMQww20RIHSSddPN19lghGltTDH/Cbd4aGoMPBK3nVE7oGFMxSSttSf51hcstxTP4B
X-Gm-Message-State: AOJu0YwtawVwNIGEt5ZKlkVlCM307JKamst3iPP4wkmKxc+K2kB6d5HR
	XkJmryFOmDiEQZcEdrjeLB/HTH9IyR9eW3mLiKZYlk7eA/KrpPMLiKtt/Di4ihLzECNMzyO+Hr4
	aZyqH3hQttA==
X-Google-Smtp-Source: AGHT+IF67RE9Tjmuj/kq/k/X6dA78e699FHOj3MI1LHmpXg9uh50LZwtSgAXRWUPUOYrgrIfYkhy+wDlS5BIsw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:9004:0:b0:de5:a44c:25af with SMTP id
 3f1490d57ef6-dfadec0b255mr68711276.5.1717610418012; Wed, 05 Jun 2024 11:00:18
 -0700 (PDT)
Date: Wed,  5 Jun 2024 17:59:48 +0000
In-Reply-To: <20240605175953.2613260-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605175953.2613260-1-joychakr@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605175953.2613260-5-joychakr@google.com>
Subject: [PATCH v1 04/17] iio: pressure: bmp280: Change nvmem reg_read/write
 return type
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change nvmem read/write function definition return type to ssize_t.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f53d987c7d..8d5aeabfa297 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1465,10 +1465,11 @@ static const int bmp580_odr_table[][2] = {
 
 static const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
 
-static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
-			     size_t bytes)
+static ssize_t bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
+				 size_t bytes)
 {
 	struct bmp280_data *data = priv;
+	size_t bytes_read = bytes;
 	u16 *dst = val;
 	int ret, addr;
 
@@ -1518,13 +1519,14 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 	mutex_unlock(&data->lock);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
-	return ret;
+	return ret < 0 ? ret : bytes_read;
 }
 
-static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
-			      size_t bytes)
+static ssize_t bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
+				  size_t bytes)
 {
 	struct bmp280_data *data = priv;
+	size_t bytes_written = bytes;
 	u16 *buf = val;
 	int ret, addr;
 
@@ -1582,7 +1584,7 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	mutex_unlock(&data->lock);
 	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
-	return ret;
+	return ret < 0 ? ret : bytes_written;
 }
 
 static int bmp580_preinit(struct bmp280_data *data)
-- 
2.45.1.467.gbab1589fc0-goog


