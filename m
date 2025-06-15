Return-Path: <linux-iio+bounces-20691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2261ADA45F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6C3B015F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C0283FEF;
	Sun, 15 Jun 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwlDKOFn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BC283141;
	Sun, 15 Jun 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026195; cv=none; b=DKBF4K5Ji7bIQjFC4LNLICyb1fM5PdAIdl7IKTBEZ41vVsvjddJHeB9EGPGwhEJCYzz5QTD+xlIebk4Rrd3JIHReHgtVg/tlWwnuNRPoQgTJFC3suvoVBGg+zRhNa/4RPwVrl8o95XDApBompZxRgx1TvvioYft75ju94E63Nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026195; c=relaxed/simple;
	bh=IL6WIr/r7jeZg+QTWPfJIlpuxYVavKG6r0rAqIAG6GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igxDedsuJE64RpNHQk9JQojXbwSiaLkd0sOoRzaF9G3JkeK775PCyLV6Ru8m/Ysj8v6lIniX9MwLyZpKtWvWiUc0Udn8fvt+P4LEWMnsxHsFfZTxgUXp3fXecz4wJeG+mqDU5KIhDZV4iijt7ec7tCmGyRfZwwkV57wTDukA97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwlDKOFn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606b39b19b6so714731a12.1;
        Sun, 15 Jun 2025 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026192; x=1750630992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+SUvETOXPqWlMOnYdfvPk8HDZj5mET+aHB1oxq4dN8=;
        b=KwlDKOFnWv3azrei4/7DKe6cjj0lE/PeCW5am0b88I8AWPGL3LLRIaEpDQwgnvrEmo
         vtcn/9s89UjtX2Ak0ImKIxzVXgTsSfjOzy/RuIGZ9YhxSjwh2vX134x+u8rKgvfYecQs
         1uwTbFY64sdM+dQaijBEHew9n+WA5tx6UjLxuuJupYw5Y+/LPS4Y9PT1eVnIbmpeufQe
         W9Lw7xm18gRykvoOsOZh/yyhSyZ6mP6gcyTaNIveynloSk1Lem+LEg/dPtKF0Dvo6a9P
         xs9pYUCiqlx8MjXeoLmHihHGujJL2kKRO7Fz5aeDWBzAJXnrMW3OGoHwEDxPe/ZalRdz
         /IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026192; x=1750630992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+SUvETOXPqWlMOnYdfvPk8HDZj5mET+aHB1oxq4dN8=;
        b=VfNFxL7UhcIbGmPcOfvPG/8OOwD7EYcV6ZYfj/s7rrm8JJHtSulw5uZFaBfSNOr8Dk
         /FN8S4Q4V+CkdHbJXniMhpLrKqysqb+ubMuL7Gd4DNfqTw136yWL/eXfCoDGxy7hLzg8
         Jc1jAJFPqkCNel/kQ2kOio9OyXT/RY3qcIi/Fuh5WrnVJ4T/UuFkLqwNJ+pDoq8LINUs
         OfmpCmeTcqfeJi9SeL6D2ovn4h6UQ/9PicJK5qxJbm3hVSkYZQ2KWNXexMEOo4Lp4wq9
         yAJ8xD7sBkBxlOffcyGVXczrAc7XFgBSFujv+OrDz68SFtlheTWdNudW93MiYppxxFwJ
         c1/g==
X-Forwarded-Encrypted: i=1; AJvYcCVCu05qislSQEBl2TTWOIk62f21oYJWwtnxut7CeAo3MYEjcDPbxLCfALAw1RJK1r5mmEzgPpJaU4OjMY0/@vger.kernel.org, AJvYcCVzfG1y8bjZ54VTWsuB+u2GDkx+KlQQ4KXvTe9JGtMvJZrXj+Yduq24f6M1OfDivhpPo4Y2FmVXgl2T@vger.kernel.org, AJvYcCX/zdNLTdy5/W6RRWXegMNC8cwU9MSuB8nvWnZDuGL9q0pUq4walwoFynDuBEB0VmWEIdXeoHDFAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhuwczUcA3P7xg9oKmt8WqNMJL96C4nWZ658tJdCFAnfDjOdYo
	SHq55rAQdrbrTf4pMUVf4IGrMTFPjRlsjwtQrKVr3blIOuZXSiuJVKEf
X-Gm-Gg: ASbGncuCvKqGD1qiBpEPlfsLA6VSX3fTp3k0DPYSptvp9Pl6uvhS+kp5XwEjfB5gqjS
	yrgPpHCUNtd7FOAW8RDo3SJnq/vNpJDVh4PqIFIQ4UcHORhhipSobQx+0IRbe89BmxjF2SwcIZ9
	oQxl2ccLFPQo1KNW6QmKJgU9Cd450NZcIqtqS6z1/Vk9QiqTWipGYxagc05eoHXAbQuWvnC9cTm
	6qJ+9N4EGioNU8d7C2FeABlTkd/ZSMQ6k9gqmh3ZHr6etcvp+fHEd26vW5mTr/umBXxd/M+zJ9g
	sqSn7/HDZN1L7axw3e9pVk+Rei2e02QVcLCZhJf25w1rA/JwxlqZpkaESbWG7muk3Mtqlqt9L9N
	cmVX2Xj2lBeO6Rxthqaj3spnoGbJDyZRA
X-Google-Smtp-Source: AGHT+IEy3L4/XFdDbLFlohkIV5DuAV8vLjy2DIONEp2lUnN/oMZnh01EvZyQN6PCkyjGeCzqhVPy1Q==
X-Received: by 2002:a17:906:c154:b0:ad8:a2d0:8f8a with SMTP id a640c23a62f3a-adfad5b5198mr214070266b.16.1750026192167;
        Sun, 15 Jun 2025 15:23:12 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:11 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] iio: accel: adxl313: implement power-save on inactivity
Date: Sun, 15 Jun 2025 22:22:56 +0000
Message-Id: <20250615222258.117771-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configure the link bit to associate activity and inactivity sensing,
allowing the sensor to reflect its internal power-saving state.
Additionally, enable the auto-sleep bit to transition the sensor into
auto-sleep mode during periods of inactivity, as outlined in the
datasheet.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +++
 drivers/iio/accel/adxl313_core.c | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index d7e8cb44855b..75ef54b60f75 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -41,6 +41,9 @@
 #define ADXL313_RATE_BASE		6
 
 #define ADXL313_POWER_CTL_MSK		BIT(3)
+#define ADXL313_POWER_CTL_INACT_MSK	GENMASK(5, 4)
+#define ADXL313_POWER_CTL_LINK		BIT(5)
+#define ADXL313_POWER_CTL_AUTO_SLEEP	BIT(4)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 95f52c95682a..d8a263b2a6f6 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -396,6 +396,25 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	return adxl313_act_int_reg[type] & regval;
 }
 
+static int adxl313_set_act_inact_linkbit(struct adxl313_data *data, bool en)
+{
+	int act_en, inact_en;
+
+	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	en = en && act_en && inact_en;
+
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK),
+				  en);
+}
+
 static int adxl313_set_act_inact_en(struct adxl313_data *data,
 				    enum adxl313_activity_type type,
 				    bool cmd_en)
@@ -426,6 +445,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 		}
 	}
 
+	/* Start modifying configuration registers */
 	ret = adxl313_set_measure_en(data, false);
 	if (ret)
 		return ret;
@@ -452,6 +472,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	/* Set link-bit and auto-sleep only when ACT and INACT are enabled */
+	ret = adxl313_set_act_inact_linkbit(data, cmd_en);
+	if (ret)
+		return ret;
+
 	return adxl313_set_measure_en(data, true);
 }
 
-- 
2.39.5


