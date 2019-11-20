Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590CB103DA8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 15:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfKTOtZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 09:49:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39432 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfKTOtZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Nov 2019 09:49:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so8119056wmi.4
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2019 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kI+6z7y49c6+W2tZw/F82eQLktjdxraputejG6O/yos=;
        b=b+xYT7WVEbv9Otm7uYIaVc/U/SKtsCTG6O7qEgDOHmN+0EI4GOblIzttf/WZju4sSD
         V8iZe8Aeazq4vJLLFwYl/Fq2bbb9aFCPABrX2qEC595AF22vgbo9gYIYN0+nSMWMvq+U
         Tp9A86ECBQtCYFF9jaSGSKZGnkiIXJq4F52JYCNuGd/J/rXEZaosZecqFVNmuvOY1uGy
         UzmEIGUKs+57+Ry50jQ8ybWzG/TZzWUFqYckVdu50MhlDsDowCbXtP3tWlED9uf//hI+
         ypQMIFK/xqoW8IMjvwTXNON3RrC9TBYcnIdoRqt0vwkL6bIYpMoDGt+i1K+d5wNJY143
         Pieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kI+6z7y49c6+W2tZw/F82eQLktjdxraputejG6O/yos=;
        b=PRoF30BU9kmHd335FPpJ2xCVBKENMbkbNkFdM/XXgNI/fGTlsq/uYjgTW0tKDPxBNc
         Uo4JPpmRWD+3NwcF9/Qvc1jk0q9h9tw5OutfRTmbCw8U9BapNcqQQrqSQnrQwvR6+OYt
         aMB0fA4OFu9BgGQ2P9GXfHr5PLIaphm+brHCSNzf7E71rqwgzD5fZbKpexlf9YOyei6L
         ueCnfV80qQcZg8Wo8+W+0QJO+2l5imGVMUcYQwLWaarCTjsMN60l6Z6XDXmvch+cfnTw
         RSaJSjzTtBE9+kQTcbzkdO2qwL+Tgnqohk1Jy/ATq+Q9UlAn97K7g3NBR2yoi8KAV7WZ
         znaw==
X-Gm-Message-State: APjAAAWtgFXKYplu6lbw4naYnwyotYGHXI5S4xxN7fPmrUsCLU57KA+T
        l62iyoJsNPpYO8SIUuKmtSI=
X-Google-Smtp-Source: APXvYqyA754sNmRl6zVbgNqLCDnQAPlj8lCFC/IQNwacCFN9hc/14702KqkTlIBun1Pz9Y50wX7s5w==
X-Received: by 2002:a1c:16:: with SMTP id 22mr3865056wma.0.1574261362954;
        Wed, 20 Nov 2019 06:49:22 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id b2sm5822120wrr.76.2019.11.20.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:49:22 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v3 4/9] RFC: iio: core: add char type for sysfs attributes
Date:   Wed, 20 Nov 2019 15:47:51 +0100
Message-Id: <20191120144756.28424-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144756.28424-1-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191120144756.28424-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces IIO_VAL_CHAR type for standard IIO attributes to
allow for attributes that needs to be represented by character rather
than a number. This is preparatory for introducing a new attribute whose
purpose is to describe thermocouple type, that can be i.e. "J", "K", etc..

The char-type value is stored in the first "value" integer that is passed
to the .[read/write]_raw() callbacks.

Note that in order to make it possible for the IIO core to correctly parse
this type (actually, to avoid integer parsing), it became mandatory for
any driver that wish to use IIO_VAL_CHAR on a writable attribute to
implement .write_raw_get_fmt().

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/industrialio-core.c | 22 ++++++++++++++++++----
 include/linux/iio/types.h       |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f72c2dc5f703..958b5c48a86f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -596,6 +596,8 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		}
 		return l;
 	}
+	case IIO_VAL_CHAR:
+		return snprintf(buf, len, "%c", (char)vals[0]);
 	default:
 		return 0;
 	}
@@ -837,7 +839,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret, fract_mult = 100000;
-	int integer, fract;
+	int integer, fract = 0;
+	bool is_char = false;
 
 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
@@ -855,13 +858,24 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_INT_PLUS_NANO:
 			fract_mult = 100000000;
 			break;
+		case IIO_VAL_CHAR:
+			is_char = true;
+			break;
 		default:
 			return -EINVAL;
 		}
 
-	ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
-	if (ret)
-		return ret;
+	if (is_char) {
+		char ch;
+
+		if (sscanf(buf, "%c", &ch) != 1)
+			return -EINVAL;
+		integer = ch;
+	} else {
+		ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
+		if (ret)
+			return ret;
+	}
 
 	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
 					 integer, fract, this_attr->address);
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index fa824e160f35..8e0026da38c9 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -25,6 +25,7 @@ enum iio_event_info {
 #define IIO_VAL_INT_MULTIPLE 5
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
+#define IIO_VAL_CHAR 12
 
 enum iio_available_type {
 	IIO_AVAIL_LIST,
-- 
2.17.1

