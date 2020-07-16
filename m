Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394482224C6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgGPOBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgGPN7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2BC08C5DC
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so7210153wrp.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0dhfHbo6Jhv4Yln3PlbJvX7LMKYF41HBBRlxGthXZ4=;
        b=nH29Z6gXpzv5rrELeKbsdKM3w0Q8+IhNcFKvDYYG+5ormhOG7cqwxfEWAJMPX+tIeD
         4YEFHvI1LUQC539kYwto5BLCq22ol9DE2V14VDMmTISmPt6cov2REhfTCXLxbQCw8+qQ
         8mIB3H5ZRm9fSWzY4MV2Ps/NNaMnuCF88HVFPyTTJvR4Djc5k8itxx0aa57B8C6H/5Uw
         7siUf49+UEmni9Mi+E5QPAXfys5420syQp3aVNCPGv9a3nL1IHCjmwA8vAP7iMjQgU8z
         4C+IN/Yzfw2ST3q17qtQFIUUu/G+OSPr+/qnWnUwNwyF+T8+Y/uF5EtVB8YwjrUNQuMw
         jvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0dhfHbo6Jhv4Yln3PlbJvX7LMKYF41HBBRlxGthXZ4=;
        b=rkOE6+ooCzX2mV3q5FoZ08Jhs8p8VwRnICUU1ZnjrgoCoOkZnJmBW9QBZQPuf/REjo
         Sx91wKuG+zHZzOcjx16UKIaJANAq4nm1uMa9ra1FgYAGekqZZmmUa8jNWZuK1zzyX1Nz
         DT67APycgsDOcoCQO3LHdg61/Hf87q58uqYYly/ZpYDQWUCHl46nuxN2EDYwm41ypq1J
         8fm6Cn7UYLedSRd0i42O59RgyHW8NKy6zjFjcZA1kUDqJq8Z//Q6+Vj8PUe0iyxFO3sG
         kYlpfsfNIsB0to5KRje5QJzMLOQdFobT5jsQ5rRBEKPqcpIX2ditLnJjwEgxrRoD4DB5
         NE4w==
X-Gm-Message-State: AOAM533b4sEFBCBRq9cZ8ti0C9n+LltTmr1+oWV0hZOyD3AESBKck/0J
        OPzevBVpQfUjBXlR2+ot46v51G+5RO0=
X-Google-Smtp-Source: ABdhPJzt85WxUm5a+7iQZLZMqFgtmD0y0IXrfcffy8eG4OYxdxAw6V7PIRtpH8R127p9kwRO8kn9OQ==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr4877688wrv.380.1594907974355;
        Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 02/30] iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Thu, 16 Jul 2020 14:59:00 +0100
Message-Id: <20200716135928.1456727-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'bma220_acpi_id' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/accel/bma220_spi.c:312:36: warning: ‘bma220_acpi_id’ defined but not used [-Wunused-const-variable=]
 312 | static const struct acpi_device_id bma220_acpi_id[] = {
 | ^~~~~~~~~~~~~~

Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/accel/bma220_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index cae905039cb62..439618d815594 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -309,12 +309,14 @@ static const struct spi_device_id bma220_spi_id[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id bma220_acpi_id[] = {
 	{"BMA0220", 0},
 	{}
 };
 
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
+#endif
 
 static struct spi_driver bma220_driver = {
 	.driver = {
-- 
2.25.1

