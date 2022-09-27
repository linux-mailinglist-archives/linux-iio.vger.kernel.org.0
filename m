Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA945ED078
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiI0WyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI0WyN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786EB6D1D
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:11 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j188so13596920oih.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0goa3iZq7fzhzlKMmlBdhP+G/08MKXZMle4tsbg1pLw=;
        b=KV9LhqzLg2iWY5VxLqdWxhUI5VgqgCq4qJ2XLxUMX5yFRqbCwLv7VvLNSAFq98dMiH
         hdCf29suRm4cX7MvbCml/ID4X+MiaWc7ysmTHAHr4SQzaLxtufBFyk1sR7Vzn2Z0yYcS
         6gieguwwNvUra2uHAMTu3wNPVlcJh6Jh+E7WKOEAIiSLzrVB+hlaXQj6KPunseU/ozZa
         VckZ2DvXMJfg1mV3gDbcpJk16j9dcukKVxfkm/jLYQo4uBhLqdJPr52g0qjXMD3ulRyI
         TtznaMvEXiMuIuVy5dwizjCeyzxve+0ZhV+9ludqtnqlwR4sAGvTkIfJNfwEh+JrJ3xq
         YFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0goa3iZq7fzhzlKMmlBdhP+G/08MKXZMle4tsbg1pLw=;
        b=Hwt/SZZPceFKtuLXvnBvUTDv8SAeafl4+k1TPsNjW1c01PW2voGDTmankyQatJkUtM
         KJ4bNZo7RCqXap9g7vIFaw4HRIuFLaJc0AgZE6daVUCR64gzuS6b2Lbww2QN2Nzao+er
         ztsAv9IGpvnHQuiuNd4h/ck0jwEHzVWGSDUWoy/nqnaXTp9J5kxK9q/YG4AickXsO+xm
         aci/cjObtAB5QTYlTIpaeiC1dGkZHYhyhVtUaip/xoDaT+1xON5/pw4WRt3Ms5Jvd6sT
         KJUSJF6VFhwbk6rEVP9kAcabVIRCz4lLduNUwBVcVgbz0ssyMcHgrmfqX+IuRvRUxf4u
         vRZQ==
X-Gm-Message-State: ACrzQf25CkJTViSArwTtIy5Sa4oh3WNSlbLtFvq2Bmt6U6St3vxs/CTV
        MVaHxhsAsMl4oHrwL/3tHCUYw8l3HhlyFJ2L
X-Google-Smtp-Source: AMsMyM7HGaXCKBXeJwdlK/ZBtBLEUb4W4AkVFfEdtH979IuPc/AKjaRwRRdTcRT6AhY+1/q99QswYg==
X-Received: by 2002:aca:1117:0:b0:350:42c:55ba with SMTP id 23-20020aca1117000000b00350042c55bamr2929750oir.113.1664319250865;
        Tue, 27 Sep 2022 15:54:10 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:10 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 06/12] counter: Introduce the Count capture component
Date:   Tue, 27 Sep 2022 18:53:40 -0400
Message-Id: <3cebaa0b807a225eb277d771504fe6dba7269ffd.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some devices provide a latch function to save historic Count values.
This patch standardizes exposure of such functionality as Count capture
components. A COUNTER_COMP_CAPTURE macro is provided for driver authors
to define a capture component. A new event COUNTER_EVENT_CAPTURE is
introduced to represent Count value capture events.

Cc: Julien Panis <jpanis@baylibre.com>
Link: https://lore.kernel.org/r/c239572ab4208d0d6728136e82a88ad464369a7a.1664204990.git.william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 7 +++++++
 include/linux/counter.h                     | 3 +++
 include/uapi/linux/counter.h                | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 2a996deabe9e..3eb6b063970a 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -4,6 +4,12 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Count data of Count Y represented as a string.
 
+What:		/sys/bus/counter/devices/counterX/countY/capture
+KernelVersion:	6.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Historical capture of the Count Y count data.
+
 What:		/sys/bus/counter/devices/counterX/countY/ceiling
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -203,6 +209,7 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b3fb6b68881a..e160197971dd 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -453,6 +453,9 @@ struct counter_available {
 	.priv = &(_available), \
 }
 
+#define COUNTER_COMP_CAPTURE(_read, _write) \
+	COUNTER_COMP_COUNT_U64("capture", _read, _write)
+
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index e9610e1944dc..8ab12d731e3b 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -63,6 +63,8 @@ enum counter_event_type {
 	COUNTER_EVENT_INDEX,
 	/* State of counter is changed */
 	COUNTER_EVENT_CHANGE_OF_STATE,
+	/* Count value captured */
+	COUNTER_EVENT_CAPTURE,
 };
 
 /**
-- 
2.37.3

