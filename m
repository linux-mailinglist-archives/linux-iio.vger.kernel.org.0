Return-Path: <linux-iio+bounces-13319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C381D9EBE6C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 23:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C433318882FD
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9A23A584;
	Tue, 10 Dec 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRVCd7za"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37196211278;
	Tue, 10 Dec 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871089; cv=none; b=B2WS2OsmwfwLZgsYrzFtug4QNnaivQ8sbhlk55w7bkOXPx3+hORfZqcsGthlnlwKqrEfDyW6S/PQ9bIyuFlauFGzT8gQLXThAGOF/RkUTmOti5LNtnOox1Vc0smnteM6PQ2DJ/Z0Kd636hUu2aaF/BMMg8PFyAepYBDPMuDzkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871089; c=relaxed/simple;
	bh=8siJdl6SX9/0iyyOmBd/PiIKQzG6mbjhlgA9N2ypec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWszZfOJZmsqDc8WDb/SdE68IPtpJab6qxnfmvckLel6akdZKKOSnQRJ/nXjF1Q9VdM4nn1ipJjxcTdVogX1nvWiBapJ6N1EZfUarOMMymXPGM5D9Wi8mNybdCfoNMe19GX/PDDgmPgp+zgxh3wRkS93dIn8K8hwzGP0I10j0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRVCd7za; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e02eda71dso853670a34.0;
        Tue, 10 Dec 2024 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733871087; x=1734475887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP8TCa1W6Nwgx3e9Z8yLnkSmmFGmFeYQ1MSese63Hjo=;
        b=LRVCd7zab7Bcg9Er7vet2qcJXTGyNKJH3cU4S2fdeO3UwdKl7K0dpdyfRdgq4q2kcN
         DBQSdAgq5dfZTr6sbCG+7UjYmUkusc9yLXp08OfPg/HGRZgiTlv1jPGtYJE5bGCd+ctY
         sb3sPwvAr+stsTUI2m9zgiZLhZUsfqqUZO6DWL9Pay55ieHqyd9bTTYZj19E5Zg83JZa
         xLFr3vhNTv2sPbHjSYuvgvdQqAXhyj5C6TrWaaqK+v8a3D257ZwKleZVD/rsyJd18HJT
         1TdT+iO0uVKTAcNBQhHGcZcqApWAZeS6L8ZlehRsNLs6EpFJDmTl+DzjhUKv3uFGYpsy
         Z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733871087; x=1734475887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EP8TCa1W6Nwgx3e9Z8yLnkSmmFGmFeYQ1MSese63Hjo=;
        b=k0wQbdvxhSkPOrAxKmHZVZpfa4A90j1YDwNx8OvM8yInPJiv/Hdl6T6HIJrVlNcdWL
         bpzydgv7MLbSZcnqPlRAwMDI9XLu08lII/MsnTNey1p4EL8RWVjV/JPwUk7i+qJL/d3n
         l5LjBohvC18qyzPicg3suUdNms4B4ZaOKfI1CY0i3w60gYwqU1gaKEXyqYLpm6VurOeX
         Bm+Huf6CajuzEsfWjos5f+55GU/rVz28vPt0O6+AapuBe8shcv4gpdyvVeEte0dEiDYB
         8Bt4URZ8T6aqUYUzMi0hJ1ROBmu1BPlxt545huE21lMvwA8LCoj+Y0JCpvHZD2vLozcq
         dyzA==
X-Gm-Message-State: AOJu0YxTpBaESw79IaxJMXBRE6lDaUY0ZxjEG/GbZewTnsENkhJc6w/Z
	UGXaDpYO0Jqtka+ENdCmkRm1hic9EVx6jZ2DcXbf1eT7PpX6U0ACuJA40Q==
X-Gm-Gg: ASbGncsZusjmQAkYngSequIkgVdqgu+bgJS0gSlTFtgQvjPUeJAuwi9HEhIY3ZNjSeI
	cwgE3Woa418F/kkGbuA5pagugOYLX3J+ety/jsZ/Xv/L0qF0l2X2+W1C1IxM9145X0b2+mokyYF
	BLmNKjYVhTbVSLDwvvzNQbutd9Jm/wQ5l0Hi1NC98p9VP/X3+5h0aDcasS3V9/XrpkDUL0p4Iqn
	N+VyZ0K/sIj/JeF/dg56hulW5aKakW2RYl3XRfPtudKTIkXb++F
X-Google-Smtp-Source: AGHT+IEKKooqF1u/QzmyDqq0bvwQvz76TxS50uKHiht5smBqBgmx66Nxr4IF8Q8pSCJx6aFhiktM0A==
X-Received: by 2002:a05:6830:63cc:b0:71d:5604:2084 with SMTP id 46e09a7af769-71e1979c403mr435806a34.5.1733871087146;
        Tue, 10 Dec 2024 14:51:27 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2a9d525f2sm1704136eaf.4.2024.12.10.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:51:26 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	andre.przywara@arm.com,
	lee@kernel.org,
	wens@csie.org,
	sre@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] iio: core: Add devm_ API for iio_channel_get_sys
Date: Tue, 10 Dec 2024 16:48:58 -0600
Message-ID: <20241210224859.58917-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210224859.58917-1-macroalpha82@gmail.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Some kernel drivers use the IIO framework to get voltage and current
data via ADC or IIO HW driver. This is complicated by the fact that
the consumer of this data is not a child of the IIO HW which current
helpers depend on being the case.

Add resource managed version (devm_*) of the APIs so that the client
driver can call by name alone for the iio channel.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/inkern.c         | 18 ++++++++++++++++++
 include/linux/iio/consumer.h | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 136b225b6bc8..5df9e272743f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -418,6 +418,24 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get);
 
+struct iio_channel *devm_iio_channel_get_sys(struct device *dev,
+					     const char *channel_name)
+{
+	struct iio_channel *channel;
+	int ret;
+
+	channel = iio_channel_get_sys(NULL, channel_name);
+	if (IS_ERR(channel))
+		return channel;
+
+	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_get_sys);
+
 struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 							struct fwnode_handle *fwnode,
 							const char *channel_name)
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 333d1d8ccb37..bde075b5fb65 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -64,6 +64,26 @@ void iio_channel_release(struct iio_channel *chan);
  */
 struct iio_channel *devm_iio_channel_get(struct device *dev,
 					 const char *consumer_channel);
+
+/**
+ * devm_iio_channel_get_sys() - Resource managed version of
+				iio_channel_get_sys().
+ * @dev:		Pointer to consumer device. Device name must match
+ *			the name of the device as provided in the iio_map
+ *			with which the desired provider to consumer mapping
+ *			was registered.
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ *
+ * Returns a pointer to negative errno if it is not able to get the iio channel
+ * otherwise returns valid pointer for iio channel.
+ *
+ * The allocated iio channel is automatically released when the device is
+ * unbound.
+ */
+struct iio_channel *devm_iio_channel_get_sys(struct device *dev,
+					     const char *consumer_channel);
 /**
  * iio_channel_get_all() - get all channels associated with a client
  * @dev:		Pointer to consumer device.
-- 
2.43.0


