Return-Path: <linux-iio+bounces-27030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF2CB7B2E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 03:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932D8304228E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 02:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49144298CA5;
	Fri, 12 Dec 2025 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwk4UEco"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537022579E
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765507538; cv=none; b=SJ12T2MV7G1hfTlJvUnd1AgDON5xUvhdu+IwvAgWmm9Q/QaPmHygPmVtEzR61TztQnoNvBV15kW4ngiOXDFOGDTheRXdp+MLnb641qlgiiLh+yW+NiSN/euoilu30NOOqtIbwUFYAO6lN4sz1iuyTM5GkBSkFSJDEi8EmVg61p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765507538; c=relaxed/simple;
	bh=ZyZf8TO7PzHx7g5RugMBOmjIDzgzIBX1y6ZRU4DbrOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dwi325lP1iUjBsJbT2MGiae8r+liWVF5kpJECVoOxqHWEQWszwuszrM1ryvjfNZYZi/ZdilujCtTQKTH8kw5rf1IJ2jqKgYPKAM6sOeQwnsHyHL1BUAvgXaZ11zY360MjeMOJAImuLY9karsvKEMaFkVvrlC9ymTiOXu0FOvUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwk4UEco; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so611693137.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Dec 2025 18:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765507535; x=1766112335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FinWiyCFvPunbe27vbfgs550CHQE+u+zy2oBmwPsfB4=;
        b=Nwk4UEcoYXC5Rzb6m220G8R8FHDJILcEAZs0bfqws75jSE15rZFvIudEVdoVphWKE7
         nK4vVMFeHDD/XTv8Yguk2qoIKhSjP21EDLhMqV7I2jlWB2WPwO1KpT7hB2TsQORxF/ta
         DdYO3L6RopgRHU4p7RCK3jV0oF3pm484iS/2a8flFXNHGVUYFGX+jN3Jd0QiZK3sm2bd
         ChAeCxE2N44tlOAG3zPpmJrbN3ZPyPKbvZb4NL6XiyeCs8wz7BY2YPxfzs3JmGnYr7DI
         rsiFOJl4udFTzk38nnmmf0fEgqEQ/+YLV63DfsnLBZbw5ZjeMY4iJvoWu6xnHwrDF0pG
         XjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765507535; x=1766112335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FinWiyCFvPunbe27vbfgs550CHQE+u+zy2oBmwPsfB4=;
        b=Y9WXf35u157O4OKYuMgIsSqQTnTMSKvrFrTxc31hd46OSlgOTr1XG4Nco5rNpGPYD4
         uJha6Fgxgem0zgdg9MFJll0aQDNl83uYl2dArUJa5KHo3bnel6LaDVo1ts4tXytbHHNQ
         CgGHyf7fnAW6XGms95aje7J12v5qFlr8V11ygI6LiMaL7OoLWjOQvy5pYAu3tAoNcI+F
         lk3KZFSp6ixEYjl7xvitUxG1qwOgwyEe4O70W+YbiNNZMLAj0nK+ZrA3qJnLc//GbHfr
         ASr9XSxP79NiLqetyQcE9KgDOzA8GgYbMS1+5FRPXS5eBN3H0s5z3lNjcir27AWbJKnL
         xvkA==
X-Forwarded-Encrypted: i=1; AJvYcCXEWjC3qMX7AGNP0VPBrr3QPVs1nwkFP5fcRkQFCy8ukcv1N070nVzwJExIoBB/7IkF7cHQR3G5xTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmUIPAtmj9Xcue3h+e57N2hxKdhW2eh8mqS0kqhjPhMUfFNv5
	MV4WQ5yNgotbD20/juOL/IyvxYeB5LKAD5v5BnM2hL7MohHr0jJQPO8D
X-Gm-Gg: AY/fxX6yvgn2MIJ/ZTwODEDw+tJOrz6JKXjPamQT4+Lr4L/emYRB9cRGJUVHNTdYw5a
	uzE+BVF16JFBxE+MhLdzILLkvc1jFzg0P1auff5BzQGGGClKkZlZjyo6k1ZA4p66EQFmQtt/Zi1
	U6+n1M/h1ItF+iFKZkler2Fi73sG96KsTMtbxkbO744/E8RD+4kVaQQHhKjbaT/gxLCa/+vWmkV
	Jlb90zKKV1Fv/UADdsWrqGFRITAoKY60uCvNTHpJN3R6inbK++yOTj/71Jvjs0l/N3hZzZfIVXk
	58uqdIsJFmpqm82D+AOiJ8PHgqvrNXnK4SKujB8DMSrHh/Aur5Y5oWzKpl3COh+/TIjwAdfw+NZ
	7LdAW79ZvWRFrhoWDR2kUZHyWUWdNnP1I0GLIrocvpFnGgMFCPPS+SvWQGPGUW0qVM4P6DJyfuP
	V/qwCnAsYZbQP7y8O+BWEAS8M=
X-Google-Smtp-Source: AGHT+IF+ceBiyFMTLRWeRyVASsqKEDmZHzPSVx4bpNR94n9cZQdZ6LN/jPJOWf4xmhRScVw1fNAzfQ==
X-Received: by 2002:a05:6102:e0b:b0:5e5:6221:c5a5 with SMTP id ada2fe7eead31-5e827471559mr131690137.9.1765507534762;
        Thu, 11 Dec 2025 18:45:34 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0f25ce2sm1693762137.8.2025.12.11.18.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 18:45:34 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 11 Dec 2025 21:45:19 -0500
Subject: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
In-Reply-To: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ZyZf8TO7PzHx7g5RugMBOmjIDzgzIBX1y6ZRU4DbrOU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnWjSeFLp+8w63AfWhP4Hkhj+5bBwSPez6VkFLr9zx46
 tPMyhqJjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZhImhEjwwcRkZBgpfYy4eIt
 UjV3Fr5cftz0nBKD44SJ58KDw5f2pTMynGpay1dok3bNxvpoQLqt0fTqopYP3Y7XTvtePduxZLY
 dMwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add infallible wrappers around the internal IIO mode lock.

As mentioned in the documentation, this is not meant to be used by
drivers, instead this will aid in the eventual addition of cleanup
classes around conditional locks.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f69deefcfb6f..1cce2d1ecef1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
+/**
+ * __iio_dev_mode_lock - Locks the current IIO device mode
+ * @indio_dev: the iio_dev associated with the device
+ *
+ * If the device is either in direct or buffer mode, it's guaranteed to stay
+ * that way until __iio_dev_mode_unlock() is called.
+ *
+ * This function is not meant to be used directly by drivers to protect internal
+ * state, a driver should have it's own mechanisms for that matter.
+ *
+ * There are very few cases where a driver actually needs to lock any mode. It's
+ * *strongly* recommended to use iio_device_claim_direct() or
+ * iio_device_claim_buffer_mode() pairs or related helpers.
+ */
+void __iio_dev_mode_lock(struct iio_dev *indio_dev)
+{
+	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
+
+/**
+ * __iio_dev_mode_unlock - Unlocks the current IIO device mode
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


