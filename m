Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0998425D558
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgIDJoE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgIDJoD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 05:44:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A23CC061244
        for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2020 02:44:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l63so5469458edl.9
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2020 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srTYjN/v0NsAtAehftCPIDDx+jGUu2qvxTBDneqVrP0=;
        b=CjScPqz2SBolWAJAapTrECQm2fd8qhCZhSB8POHbr4xspsj1co45CPYyU799HsiOWr
         k8OVbIrHFOkuFu68GJRBzOzUTErCwOHvNTmXBjcI3SeEtdGM9mTHzCC8Mx6jmbIf5wRs
         kD9IxCNTkFcI8QUyTcjC3x6djOZuVcDhOMGiWwg4/JcEkrDOo9/uYX+fR2HN9SWe1v2K
         b7ZptaiXzsbH/HOne5/eQA6Xoa3/7vlF8CYKF2uoTPxt6PgkAcnL5BUsplvey9hf6Wdx
         eUwtz7QIGPezpMSfHGtxLflFigVe37SU3P6Erj30vc3A8/jTd+TISaDs27V8ZzF8JOl/
         bpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srTYjN/v0NsAtAehftCPIDDx+jGUu2qvxTBDneqVrP0=;
        b=U8SoyfLu4nAvZkw23Dl0NY+REZp06WTnAHdwUTcaRyTNlPIGcTWPv19UNCi6rRU4N7
         lmJus7uMVRpBhlqw8DlaKjAHyb3oQU9w3SOvkk2JL/tB7qwa3+tcgyBevHTXElyVb5wh
         PPsUnVvqMTL6JUOF1x1ZvcqPXsODUr8dsP3LJxaJq3+lKiAufJYPGqbFXR8C5VEtRDnR
         bjoZs2MP6udwFJWoYB8E+ZYpVuvJZmuCro2+gWOHuT06ns80JrP06Wboj+kDqHQ60Egb
         dYEt82TmhtqZqsG9oxkkLgSorSJ8UR4SCKa2htNnKrk5AN9dXaq9dFJ2qINGSIbNlkwj
         NJuw==
X-Gm-Message-State: AOAM532TuGtgWMC7fqeq2P2GpoXj0d0PrK207Y7y43NUGkxNxEdf73Jp
        8gvskzaOQOeZn/cVL9G4XOja3skmozvmdyqr
X-Google-Smtp-Source: ABdhPJwDRTL8x5tU1b5+XGDP+K0/abuFNXdupe+5YsGSU3BPTXpP0SeUR+cUT0clCxwdtF7iIdkzdA==
X-Received: by 2002:a05:6402:b64:: with SMTP id cb4mr7550742edb.25.1599212639134;
        Fri, 04 Sep 2020 02:43:59 -0700 (PDT)
Received: from cmo-t495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id u26sm5664786ejj.11.2020.09.04.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:43:58 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio: temperature: mlx90632: Interface to change object  ambient temperature
Date:   Fri,  4 Sep 2020 11:43:47 +0200
Message-Id: <20200904094347.188834-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since object temperature might be different than the sensor temperature
the infra red sensors should provide an interface to inject ambient
temperature. This was in past done via write to ambient temperature
interface (in_temp_ambient_raw), but I think most people did not know
about it. This solution introduces a new iio type of the CALIBAMBIENT
which is hopefully more descriptive and more explicit about the purpose
and capabilities of the sensors.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/industrialio-core.c    |  2 ++
 drivers/iio/temperature/mlx90632.c | 10 ++++++++--
 include/linux/iio/types.h          |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 606d5e61c575..754597f087d1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -165,6 +165,8 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
+	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
+
 };
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 94bca2b2866a..67bf9f000122 100644
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
@@ -798,7 +803,8 @@ static const struct iio_chan_spec mlx90632_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
+			BIT(IIO_CHAN_INFO_CALIBAMBIENT),
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

