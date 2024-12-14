Return-Path: <linux-iio+bounces-13477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFB9F2094
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90897A0FEF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE671B0F37;
	Sat, 14 Dec 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSWiCVYS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F61ACDE8;
	Sat, 14 Dec 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203671; cv=none; b=dbG89Q6YK8D5hfgonKxTtPBhaLroCjYCLX+dsjFMHG7qVGczOm0iltccoM81nvktXAML5LHMzIiIbzUNYbpTGhx4SarQ1TTzAiSNdzf3M+JTJ6o9cFMYAgeEmC50lKrXYXaLbDMrUa7+ElWfyfE0d9ppyUR1B8VNoCwoofHKUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203671; c=relaxed/simple;
	bh=56UqBDrnbwwhqvj/0lN8ie1YNa66Hu6CK0aHQK/FB3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC5r1o43AD1JQxaaD+lU0oI3gvPqIzPall5eu8j1iVqzrcVyaghQNgq+0zS6nvn7n+16Ptzn1uWWSK/c82rfKb7nbW7UOx05LHez8TuMYTz+xWtzdHTYqDEtvXZIZr7BVrqaTIyYZyWbd7qJVC909mvCdTarB1YtaJJVMfYdlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSWiCVYS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so416245766b.1;
        Sat, 14 Dec 2024 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203668; x=1734808468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaAb2acuLXVgIg0u7IBl7VlwH62YP9kYmoP/9Ij8jM0=;
        b=SSWiCVYSB1VfMTcFbtRvtoIBXrbQx6Lq4JSWtP01iD2z13Hev+oPlFBlNGwqwi674Q
         2LbycRqiH/ayhAUNDH+dnysTfPSpqes0wHzzfqtPRmGy+tdEji6WatJ9JiYrv6SqgoEw
         I2+Akn5Cg3M5Kl/Fpquv3rs4ill0wId965/LmlQN0pe3IpIS5cYrbCsZqwcahgdCp/FN
         0M0TmHblDHCiVF8LnOXxpDqMIbXmy0N7ekWyPNTVjTwM5ehX7gKQ7UJQ7aJ6+9IFVsm0
         sdSFPhPgTx1Kt7QRXmwXGCc5dfhf9ZuwLJe73xMA6GrbkdeEkkmR1SD8izLggHa7aj0R
         dgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203668; x=1734808468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaAb2acuLXVgIg0u7IBl7VlwH62YP9kYmoP/9Ij8jM0=;
        b=Go5+L5csiSRi6Z5TBsZHti+lqeGLfTEbVclVelfSfbm0rKs0SCv5zkwk9U3VQfSQU0
         Pe8Th9lUOYcHQ5lz5XEqqBwpFWP9jVDFmPOr1rmW2/I6Rw0QIX20plqb5Q0HBdCsj9ZR
         WVqZq4KuwnOUM938YJZ8NPKhefBeAybuKwoegHIj1n4foTVSqyeTNEcrkebHapndzbH8
         Gvn/2Cvdc2vP42q2ebbmv6KCkqasMwVUsQypsxQM6Mz2k1xpI6X5Z9SV38HE9KFB2qTF
         Isu0jUkAUnYcERZwBk55V0TIZP+KWoOVEkbeumwqdFrncwtAhaLC6wT22t1wnnVeM+lT
         Y2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV35T0KzB6Iw1OXwBA8LcXNf8AHBbeabD4JaV3TQTYVNGaTiSTQPbYBbOE2NTHgRkiGLEMEFFi1fFk=@vger.kernel.org, AJvYcCXmlvblVTgmsYFUSiaIbXrBePjpp0WYks4JuWcAlDUJ/9RCsMuNqDKNl9ED7EI62wYozfFS5oF2XLbAMJ5D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg54g/13rVsReYkRjpjqpXRF9D1Uy4AOQYpirj+4JPq59gY4Xy
	/gGGEpt0g25BjeK9CiO/iQoczymWD14BO6vz8T69kFrVyqQD/bh3
X-Gm-Gg: ASbGncuPuVOENnUerw/gt7fhAHzePyynuNNqhpj9IUhV9GNV4es4UEBPi64TMnSTVqA
	M1QYFgD5vOtapglO/2o6pSJSipf+qo8Vg1mWVvxkVSMCSvJxlg/839EiIWq56U63UyE+m1vKPPZ
	FYTiFU0YXssY5hUd7axyL5k8l9+F8nErLqqLdcWoYpAiSQYctH587J3aV0peIUgYoUP2ZdOSi/7
	ueWnQJ1aNRD2BPB+tjahzeYTi7DjGsI7Sk853HH62uU+JP+38mX1svKV0hdTjFt6NGiBg==
X-Google-Smtp-Source: AGHT+IGdWo3YszxT9i4wIoPQuSKR7JwpZibXSfO0wJrT+fKRu05+eFcMZeLFgFP+Rse5WUDAwc2+QQ==
X-Received: by 2002:a17:907:7741:b0:aa9:1b4b:489e with SMTP id a640c23a62f3a-aab7798905bmr545493266b.24.1734203668154;
        Sat, 14 Dec 2024 11:14:28 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:abde:dd08:a767:d63c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm122818766b.190.2024.12.14.11.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:14:27 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	jackoalan@gmail.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 2/4] iio: adc: max1363: make use of iio_is_soft_ts_enabled()
Date: Sat, 14 Dec 2024 20:14:19 +0100
Message-ID: <20241214191421.94172-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214191421.94172-1-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the recurrent allocation of the data buffer from the trigger
handler and put it in the iio_priv(). This way, the maximum amount of
channels is always allocated in favor of simpler code and drop
of usage of the internal private variable "scan_timestamp" of the
struct iio_dev.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/adc/max1363.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9a0baea08ab6..e8d731bc34e0 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -161,6 +161,7 @@ struct max1363_chip_info {
  * @vref_uv:		Actual (external or internal) reference voltage
  * @send:		function used to send data to the chip
  * @recv:		function used to receive data from the chip
+ * @data:		buffer to store channel data and timestamp
  */
 struct max1363_state {
 	struct i2c_client		*client;
@@ -186,6 +187,10 @@ struct max1363_state {
 						const char *buf, int count);
 	int				(*recv)(const struct i2c_client *client,
 						char *buf, int count);
+	struct {
+		u8 buf[MAX1363_MAX_CHANNELS * 2];
+		aligned_s64 ts;
+	} data;
 };
 
 #define MAX1363_MODE_SINGLE(_num, _mask) {				\
@@ -1462,22 +1467,10 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max1363_state *st = iio_priv(indio_dev);
-	__u8 *rxbuf;
 	int b_sent;
-	size_t d_size;
 	unsigned long numvals = bitmap_weight(st->current_mode->modemask,
 					      MAX1363_MAX_CHANNELS);
 
-	/* Ensure the timestamp is 8 byte aligned */
-	if (st->chip_info->bits != 8)
-		d_size = numvals*2;
-	else
-		d_size = numvals;
-	if (indio_dev->scan_timestamp) {
-		d_size += sizeof(s64);
-		if (d_size % sizeof(s64))
-			d_size += sizeof(s64) - (d_size % sizeof(s64));
-	}
 	/* Monitor mode prevents reading. Whilst not currently implemented
 	 * might as well have this test in here in the meantime as it does
 	 * no harm.
@@ -1485,21 +1478,16 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	if (numvals == 0)
 		goto done;
 
-	rxbuf = kmalloc(d_size,	GFP_KERNEL);
-	if (rxbuf == NULL)
-		goto done;
 	if (st->chip_info->bits != 8)
-		b_sent = st->recv(st->client, rxbuf, numvals * 2);
+		b_sent = st->recv(st->client, st->data.buf, numvals * 2);
 	else
-		b_sent = st->recv(st->client, rxbuf, numvals);
+		b_sent = st->recv(st->client, st->data.buf, numvals);
 	if (b_sent < 0)
-		goto done_free;
+		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
 					   iio_get_time_ns(indio_dev));
 
-done_free:
-	kfree(rxbuf);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0


