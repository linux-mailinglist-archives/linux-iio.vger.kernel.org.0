Return-Path: <linux-iio+bounces-19616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F51ABAFB8
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF1F3AA788
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC7218E92;
	Sun, 18 May 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV92btBC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494DC2C6;
	Sun, 18 May 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566819; cv=none; b=dwBTKH0mujns0m5VS9sXi5QqadhZZ4x9ivDm1QS3W/6Q+G7ATa48KnY4j1TlvPVVxnalAjmJc571sbS7clpz1Lu3C5rKqFS/tEPa/2ehPCt3VTDf8NZMgvpSf89trYx12GDtPSAQ/BBlAdCw6gERV3z0sXpdb/UOl6sx+QwIGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566819; c=relaxed/simple;
	bh=cKE0WSkFCIF9Brh/SnNokfm5fFpy6Et8C8/qKo9CJEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFZXvkkSxiGQ9W2SdvPYDUzSGPDuGhmXkkcjJ+7jPil7MSk8hGdyDadtkZg9LuhIber+bFWSXreTsYC20CtTTb1FUjXN1YUjvSq7waLGbcRXSdpclplxowKRuNIvUuRicgj6qKSguSI7EVpr1uB8WxOvMXGjcxZX7q4rPD7u5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV92btBC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a36561d25cso200619f8f.1;
        Sun, 18 May 2025 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566816; x=1748171616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=QV92btBCXKrref5VC8gWHiVdTSZjZ8OPx4rZc7GgsmOcvCn6i4OoBVmIMezUTEPs8b
         B97d7vjyP4oz6OQ0v0QQkEpx+RAalLKhRjZ2rjj3sm4HpOJ9rVioFspYrJoXkEQGqCXw
         7f+Ufo9TuXeGL6LKayMJeAQqB+pTIPa67AtlFgikbTDeF3w2nChBrKkZtlCR/6ktBtdR
         vO3YbIasFwhH/mtoJLr0+1xpicMDyjOhTOsHuzxqI6PxP475zuRA7bFZAMhI7Nr+PfUO
         i5J5Cw+df3yhFl/gdHtApDHFhDa4s/B2KLsUnm0SzX75RdWbb+Luv3g8wta8xpw9dxKv
         zJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566816; x=1748171616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=EUE97H1L7cvDNGpVCYXb6zZpi/0lAxvGsRxu92LNni1Q51gD/Jp9tFR4wXhw29f1uh
         MlJ5D8EEb+JEoxyoD3hDT+MwfE8k1memJQ014oEV/BVJ+LFkWUs+YJO7J6tPbCbtcPgs
         u7HLsQSg0u6sk6I9h+gNoIgXVIo88bHywaK54AxqlS5lmJNFBmRoOV8WayWduyBqbfPr
         upkjStBG2Er+1MFbzzBZAIwnzbl+//HKR9xuaUKJH/Jkt/OP+1Eo/6dlzTEAt6B+IRzE
         8niRfDzk21Tz09I5meCSTUitBKSExivlEKmbwSlGxQddnQunE7+29oZ9lD77QdmTX1RX
         6NXA==
X-Forwarded-Encrypted: i=1; AJvYcCU5H5QALP4SWKLK8fjTk0ktkuAuCjPkdTI+ahgG5S8td+EI1rUNFxuSBFLxdLqhe/W+WLN8f1yRhHW6uD2i@vger.kernel.org, AJvYcCWQCXzbEpGgMUA7aNvMJOHQnPfT4S2jEvaJug1zO82oVNn2FuDm2kuGYwMIMoawFbb7XnWDzO+0/TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkG79LVUBKw/Luir2U/XDMY0nMgAfrat2it0ODvGqvprpjNVt
	lg4qeqiYrvM0SZ+TwGDytkEHN5s42HQCJeOeQJYtr1XfOPoJEzFB5A1WJApVM9YK
X-Gm-Gg: ASbGncsahFv/MYqKtTlE9q91SlK7zLm8iLKmbOTif5jkc57wsbL1nikHDBpyHxsuwXO
	eGzjCVJd64aUnzjCsmhPAyvXHBFamV1GCASn2Osr5JHzSYzvY64LIFltuAh6qVyLYS+6wva0no8
	PH68bbgI9uUjk0xUkj0Z9j8hzMFlGqeUp3ZgvNm2oqRomSz8eqb+oV33BYA9JMIdXzh4M8vJWxl
	0QqrF64OG5Bco5CJDthTHQ9AVaVUfqivhf29PIbXnYtSqg3rbOtzcThi+Cm/nzeKxYWiVgmbF4d
	NbD1YCXxjHqFUWUvzmlHIzmAeu/H5afxuRPfanf7lHJI9NVG90f7A49y2ZcAHPCoLTMoKGPLlsC
	KZbcP8xSwlaDRPy1JRYsm2g==
X-Google-Smtp-Source: AGHT+IEe++ciSrBK/lHi/sjGR19Tth6ojbaWHC03R9Yh/QiEdXU7MFcyzc/TKCaEv6SikPguVgXD5w==
X-Received: by 2002:a05:6000:184d:b0:3a0:9538:8579 with SMTP id ffacd0b85a97d-3a35c834cfemr2947334f8f.2.1747566815821;
        Sun, 18 May 2025 04:13:35 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:35 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 01/12] iio: accel: adxl313: add debug register
Date: Sun, 18 May 2025 11:13:10 +0000
Message-Id: <20250518111321.75226-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iio debug register for general sensor debugging.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 4de0a41bd679..2f26da5857d4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -321,10 +321,21 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.debugfs_reg_access = &adxl313_reg_access,
 };
 
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
-- 
2.39.5


