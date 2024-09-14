Return-Path: <linux-iio+bounces-9591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACD9792E3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B7D283FC6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A61D2784;
	Sat, 14 Sep 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5S1dfzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C91D12FF;
	Sat, 14 Sep 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337622; cv=none; b=mysh2Du3ILmQc9Cw8Y3KDSnpYYSm9eJgtbktzIietXjI085v98rgdb9JfBd99x3zVf5bIVtcWKMTp8qsiZjfjatXz/tJMCvbUBXJ8e1zsXc49n5mjWwXw8p/HaU/KEeu5TG+NMkY06mdCHiimIx2hyDu39nXneXw+o01yJNGzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337622; c=relaxed/simple;
	bh=s/LoBMZv5gHJkDYqSlQPWXy35bnh/xfj+rbEh52Ptfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PopYM0lfAxcP1JAtJokDs8AWRq+cuQXur5f4+N7h0TUPUSHL3FSKsfVJG0e1YBVQdGHnh2OAHkeOuOv8gSb1Fm1dlGVBfY6HaqC/Wkb6VztGTZkDs+fRLIaUwrpWyZUoeYaw9tGlyaDugI4GdfUO6NDzTMcauOGay9uDBN30anA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5S1dfzP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2053f6b8201so29966175ad.2;
        Sat, 14 Sep 2024 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337619; x=1726942419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOs1UIlM5LJYEJGNmyVNKJGScq5MVA7FTKWexwbjRs8=;
        b=V5S1dfzPoyNVous0+hvEz6FPo4u7KgMxtkA1uuw2N4cOpmtC5pZ7R2LZD2oiim6i8G
         fJc0G8/fXWXPtiAN4zTBAXdryoeuh3hh1MCaLTmqR33ZW5K47tsnLJkj2O0jn6uk6gUt
         LPUGOa73y5VCGW9fU8UFrfose9QqVxUQdtMkjqGWWMIZ33Joc82X/sco6W72m6AuwoSE
         PsvVuAQ74MDP/9ymXSL0qw+9dIxeSrSPyQg9Jeclv3rjSOithgMaRUihKZryBByq/TQV
         PorBVocK5tKIwdFdSwlSFd5HhkFzPE9JmZtjEeeU2cI9udlZjhSyoWANGxuzDl95bptv
         /G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337619; x=1726942419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOs1UIlM5LJYEJGNmyVNKJGScq5MVA7FTKWexwbjRs8=;
        b=C53ArbTyttrBTGUcMb9I2w8Uyz1o/va4oqy0kNPV5bezvrnz2sphY/BAuyLcMw90ck
         NW3+M2kFFI/xS35Wx+TJgGRjD7MU86CI75c7VL5Ct/lvw6EAp6LYTv2m9bISYurmt/mP
         SdNF1d7t21kVdw1TqgK7efg03sKY4gOaFgoprl24Qe26EeecGv8ewbdHob9bTbSt+epP
         EtYZhBndWnT+bRZcUvl1LyyQGOUAhQLP931ebt7JBJY4uyUb+qdis9XHwweVpu58ig/C
         iWTk0JPGlGCzIVNDtRfWj/iuEolIbyuuCQ/FKE45Bdac7q9BoajReiq/NMtiSwYZmsSr
         t+hA==
X-Forwarded-Encrypted: i=1; AJvYcCVCvljLac7QrVdpSFckZ+7iVo5yKbyV6XlnjbGTymlmabf5pueTqpzP/Bd8YHUJQaGiXX866y2q6dlbSuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYs4YxCiXWEwUiYB+mnSxFJZpTpp9Xa5iBulClMQoPIG1/sYs
	G2VHQb4Ou9etMuSvTUlRAlnjBApypxnR7V2UH8/pJNqYi977wP+uKGFmPUrKEIc=
X-Google-Smtp-Source: AGHT+IHw2Nfj8ssbvnePhgO0iXjdhze1JIm25qEsE1YQBbKcOq4E5OjDf2F82RtFlFyLZYL+5+n1mA==
X-Received: by 2002:a17:903:41cc:b0:206:d6ac:85e1 with SMTP id d9443c01a7336-2076e308699mr151995085ad.2.1726337619052;
        Sat, 14 Sep 2024 11:13:39 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm1830870a91.31.2024.09.14.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:13:38 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 2/4] iio: light: ltr390: Suspend and Resume support
Date: Sat, 14 Sep 2024 23:42:44 +0530
Message-ID: <20240914181246.504450-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for suspend and resume PM ops.
We suspend the sensor by clearing the ALS_UVS_EN bit in the MAIN CONTROL
register. And we resume it by setting that bit.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index c50ea31e2..e152009b5 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
+#include <linux/device.h>
 
 #include <linux/iio/iio.h>
 
@@ -430,6 +431,26 @@ static int ltr390_probe(struct i2c_client *client)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int ltr390_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
+				LTR390_SENSOR_ENABLE);
+}
+
+static int ltr390_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
+				LTR390_SENSOR_ENABLE);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
 	{ /* Sentinel */ }
@@ -446,6 +467,7 @@ static struct i2c_driver ltr390_driver = {
 	.driver = {
 		.name = "ltr390",
 		.of_match_table = ltr390_of_table,
+		.pm	= pm_sleep_ptr(&ltr390_pm_ops),
 	},
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
-- 
2.43.0


