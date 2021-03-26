Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553B734A9E9
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 15:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCZOfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCZOfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 10:35:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE77C0613B1
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 07:35:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v11so5847255wro.7
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OURK0/BtiRmYmxdr9eDjqtjV+BCQ8RHntM2yCP2zSg=;
        b=PtT7cwy7Kq+1bup/YFbEJarCVzHxuEVc84amtcMt2h+VpFZrtcrInuDnq6EqibA2Fd
         fj68TSdpiKv4NbeM2Uww/Bs+rUREHG1Ec0QSCmFZdLwd/BrgKiKUI61ekI12IC8wH6la
         uNBN7ibIy1PNF2z9mutas7vHVc6k/3Xe9IbpSZaIi4YeGFe9WL5soXxTfHc3gvbrFhVm
         zAjvp5E8L1Dr79OibPl0dfASqXLujV2VUIBhSL268DEwj1FvBNG2DRuLL+w3jstQznTr
         ScQzsT5V3hDnqeV4Ac7uuKMutmm9q5NiAbXe/ozjwXZ5prQy6O7QC8hBbLGTeDGMefxK
         fo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OURK0/BtiRmYmxdr9eDjqtjV+BCQ8RHntM2yCP2zSg=;
        b=HFF6LOjxshDokVlLsqh/Xg9uRdV+fy/oKJBGMpzyoH377soA/fa+GfQtpqGGtgfvsa
         /u48QR+vF7cly8rMZ91UGnic5rRq3IyMP3xhsLJNcPOW8CI2h60hBso9kC5+iZO6Mfyk
         syJr0x5N7deXKZkHckg1qOXj4y9zuAVtSTCHF45qJWiUAn4eVzKr+2xZHfdeGgD2OlzH
         49VXGAR7CqWGItL1abxkItMdt1VC5k+Z0Kiu0bO6x7PWLRUVpWEP1e4gTTSPmqa07b6G
         eNtwB8S/IkJU5fpmek1v+UE0Efp2jv8LHuALGx6a33ykZ+Xpl0WzvgTxyQ1e0OBZQ7Qn
         bGkg==
X-Gm-Message-State: AOAM531muvtWwsgSqiX3cIrN4tNnVMnKdO4X65HyQxdXY4ARgTV85mPv
        ogDrl47WWDQnhg69Ymv/PZGPbA==
X-Google-Smtp-Source: ABdhPJyx2thqrRk6seohVbZh5o5G2l8H68FVAIdYkEEG0m4XDCj/sno1gMcTDejHXnqfiBiYzqMxXQ==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr15131963wrn.121.1616769322202;
        Fri, 26 Mar 2021 07:35:22 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 20/25] HID: hid-sensor-custom: Remove unused variable 'ret'
Date:   Fri, 26 Mar 2021 14:34:53 +0000
Message-Id: <20210326143458.508959-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-sensor-custom.c: In function ‘store_value’:
 drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-sensor-custom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 2628bc53ed809..2e6662173a79c 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -397,15 +397,14 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 
 	if (!strncmp(name, "value", strlen("value"))) {
 		u32 report_id;
-		int ret;
 
 		if (kstrtoint(buf, 0, &value) != 0)
 			return -EINVAL;
 
 		report_id = sensor_inst->fields[field_index].attribute.
 								report_id;
-		ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
-					     index, sizeof(value), &value);
+		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
+				       index, sizeof(value), &value);
 	} else
 		return -EINVAL;
 
-- 
2.27.0

