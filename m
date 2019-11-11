Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA2FF77CB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKPfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38721 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKKPfi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so8213716wro.5
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zb7NkXBDvMsy7r5r4A8ZILqQNRPS4JGTch9zuj9udhk=;
        b=binb7/yIL022nAvMGnDrIdp2YcMVj1FNBKfZ+wKxwlU2LKrcRAHfvEywhcjwNwGhvH
         6Afps8XBY06cx0dRjgx2U6T00EbuHAe0n1zxSN5HrUDKy0ajho/V7iJ2tduRHIPbsPw8
         Dv+ASTzvkwQUyqbS/+shVh5/W/vEMXkwfZ6PV9Yd8+UCCHQ4Q3vMN1GYMYitIVtkcH9A
         oUgxeG17NNQbv96rL+AYroQE5VNJJpOLeEHnD2xMqA7UNXiLDVqA7FD+qZzK2XoRigu8
         On4vd1jdHFo3S9q0QFmxDMfBR0JqPD/3/b8Pq5GzF++HHF1RXOOSxN2JpcWmgVbscZm1
         YRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zb7NkXBDvMsy7r5r4A8ZILqQNRPS4JGTch9zuj9udhk=;
        b=l3X1mt7oLR6i0xbzL2JWJZRfdAwP63f02b3D//zrkHEU3jMlOZYsXf1IXQlot2n279
         CK2xw06IrzArfUicl9B2ADTwjLLDKk0VCTb2t0Y3C5KOA3XQp7vF05kW/6g7X5fDnbBL
         j2JjlgACKrAyVRJkQJ6B+8EKugcx0Bv9uzqGEc3m8mZ0kiDZqh4TqxpNkk1PPTUT7Fcc
         +7ZWFXslo/XoEJFHRznV0ItDMuUExr8+ljM+/0ey9WcwXxSOvgPoznHwBrTbCBx+4+Xu
         Q5+KemogX5LASHVkuV3YSW6hrD+VOcUm1TJ12dnPn34tb4rJz/fEMSI93PqJzUoTLh07
         AnEQ==
X-Gm-Message-State: APjAAAUThbEZJfwAjb1eO9m+qnOP+cw900w4vcTmXqpC4Fq8An9G45ad
        d8fhUxc9Q2T8nRHp6TWkd68=
X-Google-Smtp-Source: APXvYqxQOJm6XUey5rtZ/hSPad69wD/IqB2HbqJDHyMLFg9VdyLMa2e8YjdRALg9XzgJt7Wt+UyF5g==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr22079939wrn.233.1573486535834;
        Mon, 11 Nov 2019 07:35:35 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:35 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 4/9] RFC: iio: core: add char type for sysfs attributes
Date:   Mon, 11 Nov 2019 16:35:12 +0100
Message-Id: <20191111153517.13862-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
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
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
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

