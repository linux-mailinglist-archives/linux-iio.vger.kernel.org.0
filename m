Return-Path: <linux-iio+bounces-18374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B44A94898
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DB93A4146
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461020D4E7;
	Sun, 20 Apr 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHzWFPQB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDD20C477;
	Sun, 20 Apr 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171252; cv=none; b=XDR0pg3yfLYtJRT7Jn0EWMrRfv8eWTWpE0htdagiQHMt1tnS39Fj5C4mRsul7Iz3ditfOGrJaRzWkopGGrboELGShOrJVQmO8hwMOOI7ORNJmz1IbwlU/Ubvwd9vazElfrwm0F/SNO11I0HQOuh1bWeGANSx7mBVJrkduqsT5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171252; c=relaxed/simple;
	bh=2Vf/9v9oV3MQq5OTBU53RUwRdOhIL5//2e1Ab5etr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQNkFcNaBgrxn6al5p1Z3PsE/ulAAGxZzVEVNYY4IiFNBZDDZT4sT9I3yCOTHzlFry0DyzVOC9NR3QycBwymv61DfXqzwHn/XNvRvjminmkjL2JDuQO0ui7HARqZuvgaJGtSN748j1+O9itptillJmMITgPE38YCtj7BykAivUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHzWFPQB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso39304586d6.2;
        Sun, 20 Apr 2025 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171249; x=1745776049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24RgFyCcH7lzHlvjgR3evkgjumfAagNsNMPftg8pkw=;
        b=fHzWFPQBsHVTJRCFbWAyg5hUr4P9X6CR2Tfnq0j/M7m9lUwCqBQIeL6JoMhrBQCbga
         pir/BLU9YH7kvwQYFb2XQpdCIkU/0rB4xuJbgpJemsqJgSDgbjAKvYFD6XqbmqKMniXt
         l1NT8ew38YHrRr8gc7zk+Ea1CzPP7MJwHTPk2e3B3WCKpQ+5Jj+sJk2BZ9SjAasdpl/S
         1Wu1x+97si08tMRMAHJmb1NIMTN2EGzk5RCRRPgJWZE5tF3HQkZTmXzcM2W+3IorD5by
         JQg5gZ2ESSUCW1vwGxz9ihLPNmRAN2V57bu1tR2pr9dG/Na0jBqJY076pgXcgdwMNj8D
         jBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171249; x=1745776049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h24RgFyCcH7lzHlvjgR3evkgjumfAagNsNMPftg8pkw=;
        b=TChW73eDqeiOI4A1cYTlwecJuFvNYHjHYXCnjHzCvB7tmjWNhJGeUaXyYKT3TsRZ0A
         vJmzWUa8brxpPkpM3egjrvW6ewEaUJ0OgXHCvvH0NOtgPH8IxHLBc0k7AaiXCY9/jsq3
         khjTLoHN+ggtbvq+sVq1ornaC/RwRW8RWgQTLSUM+lEcwXPwxygHULEV4LdttWh97Osp
         rAcvNm2CikVMjTmWcF/0lvKpN0VxkX7IIM2Ghp6XbLMQpi/mA1jvr3oJ9A0yAOlVD+d/
         BIRckRisNwQ/h4HruU8sT8d5N+/zsRE/AyWhysejFcUTtwb4mNwPmemeNlGMJVKdr+CC
         hKuA==
X-Forwarded-Encrypted: i=1; AJvYcCVz24bLU+5GamC1UIvlDtjdlZKpj2ttJfhFGIG2xZwRHIgu6umSmGwrhf3cSygh8L9SPpDm+TI1SBC3hcvA@vger.kernel.org, AJvYcCXhDO3dnjiaacRebwJb841Qv+YBmv0c15XTDAu3luYm+qEXc83QFViWmZvVSLei2qUFkK3TAan+6gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAI+b5N5MFS34YLlKSEjjfu2mq3CMDKfTYYFYf/+JQuZR1cE6l
	r0Hz3Ed/O+pYL1w4KadEeUMwjlNgIgIelCxQBpnVzY35tH32jQtm
X-Gm-Gg: ASbGncsCYjcW5UzRLVYwVItWGcbPitbo0Q57+BmrfSetNyMyHos5gLX6OV/JmxAPrtm
	DayXRnKQqfQMUu76iQJb9cH9paGdDvGP068DCVVj+87iFRYTjkhuzjZSpliQYdXamjve7FcRioz
	UZFun5F4cv4qTjPbfl/AZxKKMW4UgAezpC7E6wCjZnWBKMdWdaHmOYk4sz1RK+R+BTVxPP01Tn9
	XlrAuPjoEzMjogr0u+U6cPnAih9bO0Y0BxjiF/Wpp/8lKQDhU70WimQcgc+mu6APjakkn/C06g6
	sqErFdzQPHAqG9iurR0vs2EDkjM0J6dRSCbLWIZ/U+9XaRFOlh1ksps=
X-Google-Smtp-Source: AGHT+IEGuU/XmD9LzWAQH4urqH9KPSzTPmaLGhO4ldjnmlsaDbNT+Z6XLITK7f+gTdHHySgR9be02g==
X-Received: by 2002:a05:6214:410e:b0:6d8:8a8f:75b0 with SMTP id 6a1803df08f44-6f2c4540815mr154535616d6.14.1745171249198;
        Sun, 20 Apr 2025 10:47:29 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd3e4sm34110156d6.85.2025.04.20.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:47:28 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 2/3] staging: iio: ad9832: Refactor powerdown control
Date: Sun, 20 Apr 2025 13:47:24 -0400
Message-ID: <20250420174725.887242-3-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420174725.887242-1-gshahrouzi@gmail.com>
References: <20250420174725.887242-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace custom implementation with out_altvoltage_powerdown ABI. The
attribute's logic is inverted (1 now enables powerdown) to match the
standard. Modernize driver by using the standard IIO interface.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 44 ++++++++++++++++++--------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 0872ff4ec4896..a8fc20379efed 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -167,6 +167,34 @@ static int ad9832_write_phase(struct ad9832_state *st,
 	return spi_sync(st->spi, &st->phase_msg);
 }
 
+static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad9832_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned long val;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+
+	mutex_lock(&st->lock);
+	if (val)
+		st->ctrl_src |= AD9832_SLEEP;
+	else
+		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
+				 AD9832_CLR);
+
+	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
+				st->ctrl_src);
+	ret = spi_sync(st->spi, &st->msg);
+	mutex_unlock(&st->lock);
+
+error_ret:
+	return ret ? ret : len;
+}
+
 static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -227,17 +255,6 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 					st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
 		break;
-	case AD9832_OUTPUT_EN:
-		if (val)
-			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
-					AD9832_CLR);
-		else
-			st->ctrl_src |= AD9832_SLEEP;
-
-		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
-					st->ctrl_src);
-		ret = spi_sync(st->spi, &st->msg);
-		break;
 	default:
 		ret = -ENODEV;
 	}
@@ -266,8 +283,7 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 				ad9832_write, AD9832_PINCTRL_EN);
-static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
-				ad9832_write, AD9832_OUTPUT_EN);
+static IIO_DEVICE_ATTR(out_altvoltage_powerdown, 0200, NULL, ad9832_write_powerdown, 0);
 
 static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
@@ -281,7 +297,7 @@ static struct attribute *ad9832_attributes[] = {
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage_powerdown.dev_attr.attr,
 	NULL,
 };
 
-- 
2.43.0


