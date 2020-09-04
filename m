Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4725D86A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDMIq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDMIm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 08:08:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C3C061244
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 05:08:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so8339544ejk.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvhcOlsH/PnVm0VGT3U+cKGoCnbsZGwuV+rqBKlL74I=;
        b=a6u4xO2fSYj7UdSzRYtXKfOrNkJ8Qskq/nZVDeYyXp2eaj7NKX6aBfQw94AvrLBSk5
         mRvuvMpjNfQxolk/QMH0R+G7II+6CY0WtrnuvPVXj+wo/aJvWn+30QCIpw5X3s+lozT8
         7mES8301iVFcj+nbFO1OjFMzvhgbELo+SojJO6oWFNp/Akk1TBMr/KFY0UqFP0MDsnHz
         wsyo+m9yZ7GbY0Jv/qaSXg+09ceKgZXNHolj6+qbjJ0PG6BcNo2NJJEdJD4FIMZ8XBbg
         n5+CkRK3JhYe7Oj9lLm4HBPQbrV9hbRVpkp0QJrYF7gbP0nXgfDOUrDQJf0VT294LPA1
         jzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvhcOlsH/PnVm0VGT3U+cKGoCnbsZGwuV+rqBKlL74I=;
        b=BfDHilPoUH29wqZvDFrupREatJaR1lUEBgurK2hJj9y9WCjXXfacSIeZ0vbpH77Z+D
         NPHRXyzL2obKlHeIee4DNKAzW3UtPBbwFenzo7qfnBTOI88Z1gn9MI/gEAu8Wg46Q2+R
         hGK1+PFYg5k7qC7dOYcJtAYfpvzUq6O+23Io7n+2+iis2GNAjw55SFTcbdYrbcrrfSGi
         P4qRmk305Rt2EG+k4LAEOAS1TPFVomX+4jnOkJ7schBjwkVBCEaL3x18Jlb8onXlIFXo
         dwU8T2UJm9XqGzGMUKYhhzySQqArDw7ZJ69PL74vwqI+etrlMQVKq2N82d23KmvS66+1
         UdMQ==
X-Gm-Message-State: AOAM533C7GVdSK8C1LhODsH5brcUmfzT9ouu/IR1Tl78F+hzQjRVXGIQ
        0JbtglyM76sYdzh1LH4VWSd47w==
X-Google-Smtp-Source: ABdhPJxYOPJh0ZOEScLRZw29bvgRorkCzf11PJgKbuqvlJfVniyjX+Rl3+m/++5p/VIH0aFhxvYN1A==
X-Received: by 2002:a17:907:3301:: with SMTP id ym1mr7506376ejb.367.1599221320008;
        Fri, 04 Sep 2020 05:08:40 -0700 (PDT)
Received: from cmo-t495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id ot19sm5817183ejb.121.2020.09.04.05.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:08:39 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] iio: temperature: mlx90632: Interface to change object ambient temperature
Date:   Fri,  4 Sep 2020 14:07:26 +0200
Message-Id: <20200904120726.199640-1-cmo@melexis.com>
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
 drivers/iio/industrialio-core.c    | 1 +
 drivers/iio/temperature/mlx90632.c | 8 +++++++-
 include/linux/iio/types.h          | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

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
index 94bca2b2866a..8e60d401b703 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -761,6 +761,9 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 			*val2 = data->emissivity * 1000;
 		}
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBAMBIENT:
+		*val = data->object_ambient_temperature;
+		return IIO_VAL_INT;
 
 	default:
 		return -EINVAL;
@@ -781,6 +784,9 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		data->emissivity = val * 1000 + val2 / 1000;
 		return 0;
+	case IIO_CHAN_INFO_CALIBAMBIENT:
+		data->object_ambient_temperature = val;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -798,7 +804,7 @@ static const struct iio_chan_spec mlx90632_channels[] = {
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

