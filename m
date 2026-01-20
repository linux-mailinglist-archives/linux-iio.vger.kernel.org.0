Return-Path: <linux-iio+bounces-28028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19652D3BF0F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD663362417
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CDB36E482;
	Tue, 20 Jan 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTaoP8+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F4636C59B
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890075; cv=none; b=HjZLN6kMd6wq6f8QoAXICAifO9S89eYNp48284FntUNf8tX7DpKpIQxIyDBIsar+fsqyQyoxniyTFlcJyAtoOH1Hwz/PsDZuwqh5G+6vV2OtQa09Gx4g7nhcrET+PsKIVT6Vt//d8HbTHycNBETYy2fWknHt7B1VTXoxmUAkROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890075; c=relaxed/simple;
	bh=Tc5/3NT6AVqhl2DjZzJv2Sn4xFJDlerjPios4AAER84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgUqBI5I2EZHfjrVfLAQlm7Vq6z/dfrsRunxqLX1AfZWCeCbyaIvXsB+Hl7ibsMym92JE2d9DIaO2Y/YvpImsd5UHbAk0gEcNhMcECEgRpMGrXEUIfZgFV5pxloXnKp2qh7o+RJEeWxTJxE4OamKcHQzJgpyQ1XujdR7M1g0+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTaoP8+4; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ed0a9cbb3fso3200196137.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890073; x=1769494873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awxt+DDD9i1Z2I3KP5u44VA06ZhetlDbI4UFSh79c8k=;
        b=GTaoP8+4IhTadtwK6Z2nJXtXYsn0s8u12Rn1G40dWtT3nOSr0NAUilCIBvyBNljsnf
         G8sdtqBH/wmTUu8yaAT2uK+IN+ntfkjIOuY0Ld+LPKCbH2WxhxfyyAJquFHdlk0xue2G
         OZwQ1AzZSgyGag7pALRzdglba96ul+2KhSiQGo7xmw8HpD26gVrx5blMWcWd+9vQiFXf
         Xxmy5GYsmKYkVS3TX3CLN+HPt7kkICO12kNycNNuBT2pH9a6udSqiqzJoenv3G4QHFuH
         +Ow+Vbq06CvE4nFC9Gd2o8ga+OK4skz1Go1/xwEnyncSG0hdJmA3GLbBQUFfS582hXd/
         5xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890073; x=1769494873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=awxt+DDD9i1Z2I3KP5u44VA06ZhetlDbI4UFSh79c8k=;
        b=CMp0EWiKUsjmQ8epuwiCerduaXbf1zTXTl1AnNkJaTlnr3t/66WKULeeopPmQG1NSs
         d49928nb9hed13ZeRFwJ+FyQuJQVaOD7afuQ/kkOxZwknVwfOrYytojXizI367VVHZgC
         wTrRR9ufLjR51LmnUByPe+cgISoQKNhRuzT99ovgJL7BqgTitPLrYqp3u5L5p0GMU+AK
         hXK/2FYq1rap+nmKa+9UfQxjHSRfNpgYPSApo41zgSN1tL2YYSXWEQuiVYNAcLmYyqM/
         2k73XLTSHZvR7ROD1aaApSWytQxK3Ur7UsfWuGJAEAUgNCF9WGAgpHyZDPgby98oAp05
         udnw==
X-Forwarded-Encrypted: i=1; AJvYcCXKh7wqGK/SAU5alLfa3BXkLS4MeJl1jcboJ0dQOLYFJqnle1podc4xS6E16i5nzcWvecMwkjvvhrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhH3TIWRwmYh+Jk4ve8lSIMZqj7O6o++mOB7cmC3KYNYEXALK
	Rzes4/7c/wre3t9zT5BVA3y+npdESLxyGI6P2VgPxO5jGNXPj5jxk+59
X-Gm-Gg: AZuq6aLDUZ8ABWtr5C5UINJ6zpRpgmqMG+EcDT6R9WIgASMiPJxwj5CbstBHn6HaeJD
	0Eumav9yEP5B413VXflnOuzxce0zaeSh/sPnLkAhjSJWKw3CJvo7ORVi8vWC/J2aBm2NgFV8tOW
	h5UfQ1ak4f06Vmt/m+2C0GefCVQguywcGEA3YDMqmPQXOMVay7vF2gWRe6/tjKd5RqTibrxqHl9
	rnW9J7Ja7ptWW4b0RTzu93VdFxJLA0FE1r45ry49/s+3jXzi47UsQPFu1EV8PcVNDwXbOWU+rcA
	jMxbCJBswlCZ9sKfyfwndfKcQqLK6+KDS0bssFf2bbB7Sf5esuyuGw1EXtVr4nESfN3bHDytyFn
	vhj8sSaGg9aeSmp5VompIEGGwiHWLyqLvzCZwHtFXrLkT3l27bGQaPjUAkni4PVo8vNHzIYoh1o
	QXI0YQUKh7RuE74GNaRwV5l0E=
X-Received: by 2002:a05:6102:3907:b0:5df:bb10:6334 with SMTP id ada2fe7eead31-5f50aa7f38emr239664137.39.1768890072897;
        Mon, 19 Jan 2026 22:21:12 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:12 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:41 -0500
Subject: [PATCH v5 1/7] iio: core: Add and export __iio_dev_mode_lock()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-1-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
In-Reply-To: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Tc5/3NT6AVqhl2DjZzJv2Sn4xFJDlerjPios4AAER84=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cpd37ymcE5MvdiLlS5ro7VTG8AX9gdpToh6cz+6Z/
 KxHf+mmjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZhI0gNGhq3ckxtdHLa7+G8I
 cTm6hz1GQVN1rXR06HtRDoMf3zz7shj+57ZOjdJUbFh+n7ni3ORULgb2G5XJWkZ/Fj0/5r33mbc
 eOwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add unconditional wrappers around the internal IIO mode lock.

As mentioned in the documentation, this is not meant to be used by
drivers, instead this will aid in the eventual addition of cleanup
classes around conditional locks.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..db803267df6e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
+/**
+ * __iio_dev_mode_lock() - Locks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ *
+ * If the device is either in direct or buffer mode, it's guaranteed to stay
+ * that way until __iio_dev_mode_unlock() is called.
+ *
+ * This function is not meant to be used directly by drivers to protect internal
+ * state; a driver should have it's own mechanisms for that matter.
+ *
+ * There are very few cases where a driver actually needs to lock the current
+ * mode unconditionally. It's recommended to use iio_device_claim_direct() or
+ * iio_device_claim_buffer_mode() pairs or related helpers instead.
+ */
+void __iio_dev_mode_lock(struct iio_dev *indio_dev)
+{
+	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
+
+/**
+ * __iio_dev_mode_unlock() - Unlocks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ */
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
+
 /**
  * __iio_device_claim_direct - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 872ebdf0dd77..aecda887d833 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+
+void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
+void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
 bool __iio_device_claim_direct(struct iio_dev *indio_dev);
 void __iio_device_release_direct(struct iio_dev *indio_dev);
 

-- 
2.52.0


