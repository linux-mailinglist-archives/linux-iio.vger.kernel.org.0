Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3295D25F08F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 23:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIFVCx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVCw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2020 17:02:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED173C061573
        for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2020 14:02:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so10817009edk.6
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2020 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MexUXXpkNBh8jJgugD/DXfCaaSN9U9Ti89qUBhKPkkw=;
        b=MgJKva+DcJQil08jKoCjfwot/nFyYCHBpaXykZcguQwHcO0caJShYIPcIJywSpxzdh
         s/ew4GzTDpz47+wbYdKxvzFi3TxxAoTy9hap+u21FG0SP4x/qzdwHaSsIfopagsVDdHA
         scG/l5xJQZRFslVDnE7QXFLJy4YnnLD7RJodI+rsQnWRhuFFkvq1A5GghsWuZPvpBjll
         brCkdQ1Rcv2HhZRuMyWkuQBQovNDIPY3AWzIOplN7bEfD6elFprXN9pYu0WGuxNIsNIU
         cESDnpsJT3zLK2OtATxowtWWoDAP+C4HeWiLx92HsUd2Z+M6p2zA3sF7th8qIqgGJoS3
         fCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MexUXXpkNBh8jJgugD/DXfCaaSN9U9Ti89qUBhKPkkw=;
        b=ciFIdGn6TZJ4Vgq55zoexpsceNLIfbay7QqEAXO362l3CFaLJUHHs3ZWmDC+0lluw0
         vC/bBTwxpS3KMU24+RKausGn9rC/Mel3Fr4MujcsjaEFz12b1IQ2NdXZv7Kqm97slVfZ
         Fs57Y1GGyZ7DDgal55pwArfizaoXHtpzVDxQIc9H4R/HzHLdqrpGSnXQwTaifXgi5L+N
         Dp5xSAQjqyTN5ZfenCBAEmHtZTLWkoCcVT+oSQzerJk4TmZosBbATFOjsqi9KY3GCA0v
         E6DIgx3r3HsHDlMInwoS6d+pewL32hLmXuRB76bImFYP+iqx/kwIsLrJ3pqK82eLiRD9
         jx8Q==
X-Gm-Message-State: AOAM5302WOyu59+SK8nw8HVxf9P6Oii6Xh+Q2qNFM3vPuWUQj8wve0VZ
        OOgJ7BG7kB3v6CFNsmn/opsX2g==
X-Google-Smtp-Source: ABdhPJwgnIv30s9uhnTolJrQhndoE7Z4WI/qKscaHHC1vlWvoiXtOEXZZY9E17BDBT1qOeuC3Ii4hQ==
X-Received: by 2002:a50:fd0a:: with SMTP id i10mr469837eds.277.1599426169866;
        Sun, 06 Sep 2020 14:02:49 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyvlf6ciazu67wc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:60ce:4622:d654:d77c])
        by smtp.gmail.com with ESMTPSA id bm2sm10521694edb.30.2020.09.06.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:02:48 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] iio: temperature: mlx90632: Interface to change object ambient temperature
Date:   Sun,  6 Sep 2020 23:02:31 +0200
Message-Id: <20200906210231.383976-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since object temperature might be different than the sensor temperature
the infrared sensors should provide an interface to inject ambient
temperature. This was in past done via write to ambient temperature
interface (in_temp_ambient_raw), but I think most people did not know
about it. This solution introduces a new iio type of the CALIBAMBIENT
which is hopefully more descriptive and more explicit about the purpose
and capabilities of the sensors.

Signed-off-by: Crt Mori <cmo@melexis.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 drivers/iio/industrialio-core.c         | 1 +
 drivers/iio/temperature/mlx90632.c      | 9 +++++++--
 include/linux/iio/types.h               | 1 +
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5c62bfb0f3f5..084436a315e2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1740,3 +1740,11 @@ KernelVersion:	5.5
 Contact:	linux-iio@vger.kernel.org
 Description:
 		One of the following thermocouple types: B, E, J, K, N, R, S, T.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibambient
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibambient
+KernelVersion:	5.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Calibrated ambient temperature for object temperature
+		calculation in milli degrees Celsius.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 606d5e61c575..941011502f4d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -165,6 +165,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
+	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 };
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 94bca2b2866a..048cafa04455 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -761,7 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 			*val2 = data->emissivity * 1000;
 		}
 		return IIO_VAL_INT_PLUS_MICRO;
-
+	case IIO_CHAN_INFO_CALIBAMBIENT:
+		*val = data->object_ambient_temperature;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -781,6 +783,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		data->emissivity = val * 1000 + val2 / 1000;
 		return 0;
+	case IIO_CHAN_INFO_CALIBAMBIENT:
+		data->object_ambient_temperature = val;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -798,7 +803,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
 	},
 };
 
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index e6fd3645963c..1e3ed6f55bca 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -59,6 +59,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
+	IIO_CHAN_INFO_CALIBAMBIENT,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.25.1

