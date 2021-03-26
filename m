Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50F334A9F1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 15:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZOft (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCZOf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 10:35:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28647C0613B5
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 07:35:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so5843392wrw.10
        for <linux-iio@vger.kernel.org>; Fri, 26 Mar 2021 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQiBvBGnEPCfXvDLlcXYmYRETtwubP2zncCLn7n+qro=;
        b=I00rzJ2Pb7xw7qyx/Ux/iw5avL4Qa+ePqFm2O47i8SPa2MwvByhdllikoreR5RZPq5
         gmf29+BchuESCtjhbW500HI1pMhjDYSqXRz0zpDsl0VWtvfTtm+yyvYEQLZq7ygzrLax
         uhk3PwjegUKYtD9HfqGHoLz2N1l+lBtd/82MXC7T39KAink0dpxWK8q0V+o75Bz6ijTg
         VQELl51GdcI6SVg266nyjrsOigDblcjUYU/UG48jNjSZGpYeMgUzogjETeYNI8OXS9ws
         bzBYIx32n/T5T2bFM/Cb5T+T45cBCLIOP22bxe37CEx/vLAW5+ETfsOQhYNDt5YYlW+o
         duEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQiBvBGnEPCfXvDLlcXYmYRETtwubP2zncCLn7n+qro=;
        b=oW9xrHUNxP7qUSsA72U1Bw/3o1/cgPukdNzp4ABgy311r7vAEwlKG1xyMNNol6r6OP
         zLxB3tuaZJZ72M3eMGC/1fkvMoD6NYvP3SGNrLUDtCIct1/gNLp660EXz2e3fIRkCkZs
         gvlGFmVVvP9wzkbUtES89ER7/+0YreS0P6Vr9kCAe946tOZFTf+E8BTZTlYYWWGhMwez
         N6NRqm+LhuGmnk4s/CCurue8GtnyCDGwDIiyFX6JTPsMSC/k4y8N4sOTKSwoUe+wgQvS
         1TlLpQBksuNCg44lghGejAHM9BcQdwPjJY5e3jp2QTdaJn5HmlTeTXWg7NIiIb0FMPnq
         lEtw==
X-Gm-Message-State: AOAM533taG6PKWiIdwkgozJJtSvvKaWIk/OIMFS4MVPRCE1c50zjJkAV
        7B5ZTm022OvzwRO2Y25k4Ui9Fg==
X-Google-Smtp-Source: ABdhPJxVQH9E7yz/g9mCKCmuf6kL2CneZmZwGC42RiuDWq3ME4fXeUoxutDqT538V/wUc8tO54qLtA==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr14838333wrj.224.1616769325875;
        Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 23/25] HID: hid-sensor-hub: Move 'hsdev' description to correct struct definition
Date:   Fri, 26 Mar 2021 14:34:56 +0000
Message-Id: <20210326143458.508959-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-sensor-hub.c:54: warning: Function parameter or member 'hsdev' not described in 'hid_sensor_hub_callbacks_list'

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-sensor-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 36b6852f75dd5..95cf88f3bafb9 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -18,7 +18,6 @@
 
 /**
  * struct sensor_hub_data - Hold a instance data for a HID hub device
- * @hsdev:		Stored hid instance for current hub device.
  * @mutex:		Mutex to serialize synchronous request.
  * @lock:		Spin lock to protect pending request structure.
  * @dyn_callback_list:	Holds callback function
@@ -41,6 +40,7 @@ struct sensor_hub_data {
  * struct hid_sensor_hub_callbacks_list - Stores callback list
  * @list:		list head.
  * @usage_id:		usage id for a physical device.
+ * @hsdev:		Stored hid instance for current hub device.
  * @usage_callback:	Stores registered callback functions.
  * @priv:		Private data for a physical device.
  */
-- 
2.27.0

