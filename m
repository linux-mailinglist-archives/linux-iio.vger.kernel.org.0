Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8E58EDE9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Aug 2022 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiHJOHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Aug 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiHJOHv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Aug 2022 10:07:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79ED6E886
        for <linux-iio@vger.kernel.org>; Wed, 10 Aug 2022 07:07:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s23so682608wmj.4
        for <linux-iio@vger.kernel.org>; Wed, 10 Aug 2022 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=saNlXTXB51vCTSXiZxahbXz4v7+9GH/MAa0h7DJY6Cs=;
        b=Rp2dXb668XuG/+hI6ohbx1Dq80GfHGdQ/2Cl16uoMtyaW9JsI+yU4meP34bODv3m/T
         FKOBsLPVIm8GX3UdVbQ4o0SXWgegOhSu8rLj2ROyvMMc6qa5wiTqJSvjfwMgCMHhDSqD
         766zzB14499A1eCxeOEi1OoPz3J7Q9T1Wh+pgZT0sWr6uckHi5swc5Bm5KO3JmtdfYkj
         g0xNmu33vjnMruIEILUohMK/6ag2VBpFyCgq+k2GvkjqChQeqIGizwemTSmTEuMj4ZYs
         rLndrRqXaAC8gkD4F1MUoPlrb53UhRyoPtz+q5vKRP9Mgr7yIGIrpsuiFwdNF4c8zbIk
         To5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=saNlXTXB51vCTSXiZxahbXz4v7+9GH/MAa0h7DJY6Cs=;
        b=f0BCYJEcFmTv6Xqm/2CtUVkCY8nvV4xxaQnAXwDg3moloyzSZ3XY7bzsdyH0LsiUVt
         HtwkD2l2RY/FZZF/ZmQR7lxmSksbd4/boBTd4WWQptubvx3B4zIxeX4uhQU3PU7ng9Es
         2QttFzk/HGfALmajKrwDrYsvYZGkfwgwqEM58d8Lyg7DGNFsLKqI2Kk1VB34sm6hBnA1
         CwS+93wQJ3Os3NK05fL3KxBWpBYEHID0Qa0i7/KNJoxSvSiAr4KbfCSeKNSJB8Z3dBZ1
         JtJOLEgmQTLNN7exhvt4oyy3dSgtbGgowW3eE/qmaQZjrI8z435ibe9rUiLePI0o9yNL
         o8FQ==
X-Gm-Message-State: ACgBeo1cauqweGCx8bFayKL4kaOM/brCvoipMAogKb9eqJ/bi4BwuBgS
        Gu4dXfJ+wp2BfKnKnKiteFnBuA==
X-Google-Smtp-Source: AA6agR5vjoTRwnjXdkJx3Cg8pAB0tbVog7lDt4rC5XIE2WKSmZnhbp64mkFAWZYK1yFvmH5MfnvTow==
X-Received: by 2002:a05:600c:600b:b0:3a5:b811:e7fc with SMTP id az11-20020a05600c600b00b003a5b811e7fcmr77002wmb.190.1660140464270;
        Wed, 10 Aug 2022 07:07:44 -0700 (PDT)
Received: from localhost.localdomain (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm16258229wrj.47.2022.08.10.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:07:43 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v4 2/3] Documentation: ABI: add sysfs-bus-counter-ecap
Date:   Wed, 10 Aug 2022 16:07:23 +0200
Message-Id: <20220810140724.182389-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810140724.182389-1-jpanis@baylibre.com>
References: <20220810140724.182389-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds an ABI file for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../ABI/testing/sysfs-bus-counter-ecap        | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ecap b/Documentation/ABI/testing/sysfs-bus-counter-ecap
new file mode 100644
index 000000000000..ca530a6806de
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ecap
@@ -0,0 +1,64 @@
+What:		/sys/bus/counter/devices/counter0/signal0/polarity1
+What:		/sys/bus/counter/devices/counter0/signal0/polarity2
+What:		/sys/bus/counter/devices/counter0/signal0/polarity3
+What:		/sys/bus/counter/devices/counter0/signal0/polarity4
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		ECAP module includes 4 timestamp capture registers.
+		For all 4 sequenced timestamp capture events (1->2->3->4->1->...),
+		edge polarity can be selected. Then, each capture register can be
+		tuned to capture event by either:
+
+		- "rising"
+		- "falling"
+
+		Reading returns current trigger polarity.
+
+		Writing value before enabling capture sets trigger polarity.
+
+What:		/sys/bus/counter/devices/counter0/signal0/polarity1_available
+What:		/sys/bus/counter/devices/counter0/signal0/polarity2_available
+What:		/sys/bus/counter/devices/counter0/signal0/polarity3_available
+What:		/sys/bus/counter/devices/counter0/signal0/polarity4_available
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		Discrete set of available values for the respective polarity X
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counter0/count0/enable
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		Whether ECAP is enabled. Valid attribute values are boolean.
+
+		This attribute is intended to serve as a start/stop mechanism
+		for ECAP.
+
+What:		/sys/bus/counter/devices/counter0/count0/count
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attribute that indicates the current base counter value.
+
+What:		/sys/bus/counter/devices/counter0/count0/capture1
+What:		/sys/bus/counter/devices/counter0/count0/capture2
+What:		/sys/bus/counter/devices/counter0/count0/capture3
+What:		/sys/bus/counter/devices/counter0/count0/capture4
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attributes that indicate the last timestamp captured
+		for the respective capture X register.
+
+What:		/sys/bus/counter/devices/counter0/count0/capture1_component_id
+What:		/sys/bus/counter/devices/counter0/count0/capture2_component_id
+What:		/sys/bus/counter/devices/counter0/count0/capture3_component_id
+What:		/sys/bus/counter/devices/counter0/count0/capture4_component_id
+KernelVersion:	5.19
+Contact:	jpanis@baylibre.com
+Description:
+		Read-only attributes that indicate the component ID of the
+		respective extension or synapse.
-- 
2.25.1

