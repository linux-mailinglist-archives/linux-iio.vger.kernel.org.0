Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AA39DF25
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGOu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:27 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:33435 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFGOu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:26 -0400
Received: by mail-qv1-f54.google.com with SMTP id l3so1906595qvl.0;
        Mon, 07 Jun 2021 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIYmVltKuxRnkxYcd9xvPWWLAIb4zf9uKDKMJAX/FqI=;
        b=dnkFfa83ehPPJyRlGhkh58704bNclKyszpk7vqlAPudPzUVbgkdbKVE+ozKaw5/H2L
         0ulMn1nAYUCbv9qYvSd6dx0Ll55InzEdhxrZzupdDGMok3ZNW58obgXbUR55ylio0FHF
         TVQDK7G4rgpN++CtyuBEO6RvMGBkmH7Q2lfH9M87LKhnqGo2MP+BCEsevBtMqro33EM6
         BNxTbjTPMo9N5ARPsFF1XC+Yb1WcEmj8FxL7D9oGSZq7ufFsghABk6t5pEUlnYNYC2ib
         u370yQ/B3/D1nArTIRmSfqI+lNw+tR7pwMLMTERj71LSDIaj9kWf2MHgJjDMIWwQBiAr
         yCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIYmVltKuxRnkxYcd9xvPWWLAIb4zf9uKDKMJAX/FqI=;
        b=ABJ0QOyY10aNQyHBRcs2IJLhNnPjogVqu5FeLydQ27XicFRf7HSRDIzkqeAXGZC4r3
         PBxh77JH4535nPqX+1MUbRbgbmvhIVsExkuCT+EhV3Zvb3RHC/RcZ0UuViHpwbCwfAUq
         yMi2dZfOAXDLlJFS8+UAp8gNs7VraJYQtdCJ4KSUzkhVP2BplRampVHb7CQJabOXpS1+
         qwrAyjNkwTeskh52bRd9C78IbLla6FEJ/LyzXXPlsKAYcTFU8XHH9L8XPUVS7HMPJRwb
         DgtedDRDf95yVxk3u5JazNXFUe0nxRuwz1Gki0K0gHjnthwZ39/JW67usHeqXbrMaGFp
         U6wg==
X-Gm-Message-State: AOAM5307DwOr6V0CcYYvEg8IqeBHrNvunsOml6HooK5tXL1uU4l6KtSX
        DFGCuIc7kFauBFmf6z0gM+npY09UGZWkXA==
X-Google-Smtp-Source: ABdhPJziXMUPDmuB8eReZYaO8QDT9HaY8NpaHSptfAzqtBzWhjdoEId+1up7WpgPwFcQdIEzqR8GMw==
X-Received: by 2002:a0c:be8a:: with SMTP id n10mr18468344qvi.2.1623077255117;
        Mon, 07 Jun 2021 07:47:35 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:34 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 7/8] iio: afe: rescale: add temperature sensor support
Date:   Mon,  7 Jun 2021 10:47:17 -0400
Message-Id: <20210607144718.1724413-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add support for linear temperature sensors. This is meant to work with
different kinds of analog front ends such as RTDs (resistance
thermometers), voltage IC sensors (like the LTC2997), and current IC
sensors (see AD590).

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3d445c76dbb2..9e3c7e2b47cd 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -272,10 +272,29 @@ static int rescale_voltage_divider_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_sense_amplifier_props(struct device *dev,
+					      struct rescale *rescale)
+{
+	s32 gain_mult = 1;
+	s32 gain_div = 1;
+	s32 offset = 0;
+
+	device_property_read_u32(dev, "sense-gain-mult", &gain_mult);
+	device_property_read_u32(dev, "sense-gain-div", &gain_div);
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+
+	rescale->numerator = gain_mult;
+	rescale->denominator = gain_div;
+	rescale->offset = offset * gain_div / gain_mult;
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
+	TEMP_SENSE_AMPLIFIER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -291,6 +310,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_VOLTAGE,
 		.props = rescale_voltage_divider_props,
 	},
+	[TEMP_SENSE_AMPLIFIER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_sense_amplifier_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -300,6 +323,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
+	{ .compatible = "temperature-sense-amplifier",
+	  .data = &rescale_cfg[TEMP_SENSE_AMPLIFIER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

