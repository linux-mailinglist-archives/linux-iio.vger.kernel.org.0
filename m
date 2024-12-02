Return-Path: <linux-iio+bounces-12953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE09E07C8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF251771A8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58620B207;
	Mon,  2 Dec 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPvw9aPw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280B20E320;
	Mon,  2 Dec 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152304; cv=none; b=FU5hJCvtJxXTrYRcrtM41KUWnUt/I1ISH2Ofd6i0qeIxAm44xLduKxlO4ZoKZSloY3f5xz8FomYDjPbzznWSCB8OZ4dYiyFcNRRzB/sW2ULr/5yFTc/zKC4hc8GWaHj+T9En6tCiQ2qXhxzMOmIOkn4IlSHSBcnwSnQX8PoRwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152304; c=relaxed/simple;
	bh=jOURbvIBqcaxRauahaNmGNs8QWjyLcPZWcsQoQf7Bnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQOyAT+gf0TVU8NhQKjTjI7RrwiLsnqvXOA16hA1PHdNKQNqmsP0rt33suddJLcbna0Mbvum/5gfz/ln8H6t12yAORnqLA9igFiNaKxXaG/krwGnwJLWo2ysYG7MV+oxbeJGMSdm2gLdVY0lEUX6QuSrtt1NUkITuCgu2rD4flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPvw9aPw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385df8815fcso1896355f8f.1;
        Mon, 02 Dec 2024 07:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152301; x=1733757101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUnUP56auFT1j9K/I596a3ZwowwD4uPA1BDcedJEb3M=;
        b=CPvw9aPwG9CBLVaO2jF3qlWa2jXE+3yaGavVNxnLz9RFHKgkEmkHgVffrMeF3GNMy3
         3vdRglASNl6+eiidRyfpE4pA3NIHkICLBLa5eESM8Y5mgEfVEh2lFiNFaXcYjvCkogx1
         VV2Dv0klyTfQZm7htJofc2JVXlA8Zr0qDdALQue9tnkQ5bG5NMe9ggAK7QXweXFfh+j4
         hIwtV0GJQ9CZMMyDkZFD3lKGaBLfpaRc2YEPavF7J5gttUHu5fhXIF6tJ8xCy0a9FkXH
         sfycVADqMmOXeP69uEhIxdIlaVmvIQqKMhqsCAHI/ezbyibOGMNrLotNXI9y4+p3m+Aa
         x1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152301; x=1733757101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUnUP56auFT1j9K/I596a3ZwowwD4uPA1BDcedJEb3M=;
        b=LxOW6icdcZDWQzQ3C+RJAaitZMG7t0YQZunS3xnr6f774dCZqK3jFlbjZyphNes9zZ
         n4MSPZmQhBGHG6WKcYVfL5wt9r3jOjbdmqhCa4EBd9S/I+DfovWgT/gFTYRF3IEk95lL
         zFzOaK5IVfFgfrTGeIhcW6xZYABtNxRzkzJaBIpDNnd7XDrmwvEC9M/3olGlQ7pfznn6
         493m5I7iQWEhe2BD7qwFQO2WbMwtxGvyWKkjTv1KSWsGTt1yXHaLd0O/351mckrwQGwM
         uhh3SjAGMyVID34eB12M19Cq7bO+9dbU/BUmoZcAl51v+oTN5UCtDlIhxRBxvnTWzqhT
         aXTA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3rLV3KurL/1NumNUFJTebS/j/OAyCZhZzekm0DfhWScA7qcqpyPVVojbcxzYnRud61+ov9qjNtmiUlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+u8ptz4E0w/kXyVl+YV94hNHVnDu3ysiWRz8sCh/JlRJBedHy
	xA6I82Fn4CWvH5x8t7+lsc3azomJlujPW82ximoJscXpMN/Vb0u2
X-Gm-Gg: ASbGncvsQ1CQ79peB/7vKqn37eUZIy6gbD3zF+YyamFpoLEuxis0/ErwWiblg34i2ns
	IeIPZeEVm39l3TxKnNgQYWJS6jmjT8uCok2PrDwKmM8yAa+Ys1QyNR4uXjkCuGZKHLFVzP6qa4D
	uu4ITaka0V+pXcOcZuDJekYttvJeKIxS7bQ1qMrunqBNt7ioqKD17T1cv3HnN3g8Re2SS0QK+4G
	KOv4065Uv+N3sHevH28Y8CFGOuLuKLPQvmnmqL30pZDwxTuLis+nAWG9sWvZnh/JKR6qMCNFAF6
	rvEINageJu6PaAXTIaPW
X-Google-Smtp-Source: AGHT+IGqq+9lgtk9pVBWPZO9WpNKI0QexYnW7pTyoCwXBNi+ps5n11meIyKK5EZjurfaMTmhuOLFHw==
X-Received: by 2002:a5d:6f1d:0:b0:385:e88b:1a76 with SMTP id ffacd0b85a97d-385e88b1c33mr6688498f8f.30.1733152300434;
        Mon, 02 Dec 2024 07:11:40 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d26b5sm185585795e9.35.2024.12.02.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:11:40 -0800 (PST)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 02 Dec 2024 16:11:07 +0100
Subject: [PATCH 1/2] iio: consumers: ensure read buffers for labels and
 ext_info are page aligned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-iio-kmalloc-align-v1-1-aa9568c03937@gmail.com>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
In-Reply-To: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

Attributes of iio providers are exposed via sysfs. Typically, providers
pass attribute values to the iio core, which handles formatting and
printing to sysfs. However, some attributes, such as labels or extended
info, are directly formatted and printed to sysfs by provider drivers
using sysfs_emit() and sysfs_emit_at(). These helpers assume the read
buffer, allocated by sysfs fop, is page-aligned. When these attributes
are accessed by consumer drivers, the read buffer is allocated by the
consumer and may not be page-aligned, leading to failures in the
provider's callback that utilizes sysfs_emit*.

Add a check to ensure that read buffers for labels and external info
attributes are page-aligned. Update the prototype documentation as well.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/inkern.c         | 11 +++++++++++
 include/linux/iio/consumer.h |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7f325b3ed08fae6674245312cf8f57bb151006c0..63707ed98e1d7aca1e446122bbf69c85c0dd06a2 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/minmax.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -989,6 +990,11 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
 {
 	const struct iio_chan_spec_ext_info *ext_info;
 
+	if (!buf || offset_in_page(buf)) {
+		pr_err("iio: invalid ext_info read buffer\n");
+		return -EINVAL;
+	}
+
 	ext_info = iio_lookup_ext_info(chan, attr);
 	if (!ext_info)
 		return -EINVAL;
@@ -1014,6 +1020,11 @@ EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
 
 ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 {
+	if (!buf || offset_in_page(buf)) {
+		pr_err("iio: invalid label read buffer\n");
+		return -EINVAL;
+	}
+
 	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_label);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 333d1d8ccb37f387fe531577ac5e0bfc7f752cec..6a44796164792b2dd930f8168b14de327a80a6f7 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -418,7 +418,7 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan);
  * @chan:		The channel being queried.
  * @attr:		The ext_info attribute to read.
  * @buf:		Where to store the attribute value. Assumed to hold
- *			at least PAGE_SIZE bytes.
+ *			at least PAGE_SIZE bytes and to be aligned at PAGE_SIZE.
  *
  * Returns the number of bytes written to buf (perhaps w/o zero termination;
  * it need not even be a string), or an error code.
@@ -445,7 +445,7 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
  * iio_read_channel_label() - read label for a given channel
  * @chan:		The channel being queried.
  * @buf:		Where to store the attribute value. Assumed to hold
- *			at least PAGE_SIZE bytes.
+ *			at least PAGE_SIZE bytes and to be aligned at PAGE_SIZE.
  *
  * Returns the number of bytes written to buf, or an error code.
  */

-- 
2.47.0


