Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AD3D1090
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhGUNYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 09:24:24 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47865 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239096AbhGUNYY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 09:24:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6651B58046C;
        Wed, 21 Jul 2021 10:05:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Jul 2021 10:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=QeOchd+CZdjeE
        XdSS0D9yGD63me0JpT1UMDTmCureZ4=; b=BhgMFZfHMh5c8P3JHTp63tKFNX0ZQ
        mRFbsP5Q7kfXvTMyiwMp1GHlGn2pll7NDVJx8JBTjSdWdsacjgLjTcmjlZPFfZUJ
        3Q2CPr/qk1vM4mbEiwiCR8MZf5iDBw+RmqvPT6jIJf5h6eS7oIx8vCRFtIaomIes
        65zQCieGj6oQkaAFRIZmWW39bSOTaahZFkG0+3kFK+nmwEhAo64sfQmNryA09IFx
        I7uWJW33wZ1ZAYz4QuyrvlmS0espzspyCSk8Nc1dFliPGEInINdKWRFGVQ/8Ipp4
        1RU6dAY3m3ojNgZLdd9fV+dzlCWAD2k/exBI6xJ64KacTi6Ru3ysI6WHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QeOchd+CZdjeEXdSS0D9yGD63me0JpT1UMDTmCureZ4=; b=vFP2kFT/
        d7HnW7M4Cjom+4bvsCOAIuB0NmJBVdV5gXqZmJE3XkWctcJAXTZq5jwyqonD3hV3
        LO/bRzl7OjLrrEJkADSRciLdnszA10G2VrIIo9JqT03D7nwhe8rr4+qyKFzH67hv
        QXRjxYvdK8xhJH5o9aC5M5Z4gmV7stZtbJIbUZ+uO2/lkVBWZsvD2TLbMzGqwLLr
        NFcYC76xvLzSVv74X3FG0q05o2Wp0yNMWkvxdrMp9r63WkEU8/4S+1GjUsnGNepU
        y+TgTvj/ashm3ZVn3q0yL/PKOddJ1S+LKob6KocGUPAD7Z2hLSEi8OIKTRDUdkC5
        xJOQr+gV4G844A==
X-ME-Sender: <xms:jCn4YKIYULJX5CoSEAcQ4yNj2KsARWS3MStSBBf8D7yIs1epTrNAwQ>
    <xme:jCn4YCIlilvxKeaNptJAjcrhpZVlj9HydEYmmvfCpCkhudiO_kKDZ-bCnU8mbg9dt
    L0G_7om_fglRSO26EU>
X-ME-Received: <xmr:jCn4YKuz5sV2cuyFBhUdCqNAH4Z8C-hx1cQ-qcAZopejOVKDGbwXzIQnHjJjzkK89v3A_RbkZgDN9q15eK5EMGEU4jxTDx64UR1H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:jCn4YPaNLbmBhp5Um7tvnFp4uDs19SgCXiUKyLkgs1TIhA6bw9LVRA>
    <xmx:jCn4YBY6_DRGK4P9Hmh1BzNarReGPEX9OJ5I2fY5HQ4N9TeptkMgkQ>
    <xmx:jCn4YLAbw0wJLNWZ_WDwGe2MPD1rpPZ4MZjDQS0pYTiz3R645sNl9g>
    <xmx:jCn4YHB6F85aot56X7PVuzxhIjZCXscGFW9pKUQ4I9r5E5bBe6Uieg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:04:59 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 15/54] dt-bindings: iio: st: Remove wrong items length check
Date:   Wed, 21 Jul 2021 16:03:45 +0200
Message-Id: <20210721140424.725744-16-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721140424.725744-1-maxime@cerno.tech>
References: <20210721140424.725744-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The original bindings was listing the length of the interrupts as either
1 or 2, depending on the setup. This is also what is enforced by the top
level schema.

However, that is further constrained with an if clause that require
exactly two interrupts, even though it might not make sense on those
devices or in some setups.

Let's remove the clause entirely.

Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../bindings/iio/st,st-sensors.yaml           | 41 -------------------
 1 file changed, 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index b2a1e42c56fa..71de5631ebae 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -152,47 +152,6 @@ allOf:
           maxItems: 1
         st,drdy-int-pin: false
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            # Two intertial interrupts i.e. accelerometer/gyro interrupts
-            - st,h3lis331dl-accel
-            - st,l3g4200d-gyro
-            - st,l3g4is-gyro
-            - st,l3gd20-gyro
-            - st,l3gd20h-gyro
-            - st,lis2de12
-            - st,lis2dw12
-            - st,lis2hh12
-            - st,lis2dh12-accel
-            - st,lis331dl-accel
-            - st,lis331dlh-accel
-            - st,lis3de
-            - st,lis3dh-accel
-            - st,lis3dhh
-            - st,lis3mdl-magn
-            - st,lng2dm-accel
-            - st,lps331ap-press
-            - st,lsm303agr-accel
-            - st,lsm303dlh-accel
-            - st,lsm303dlhc-accel
-            - st,lsm303dlm-accel
-            - st,lsm330-accel
-            - st,lsm330-gyro
-            - st,lsm330d-accel
-            - st,lsm330d-gyro
-            - st,lsm330dl-accel
-            - st,lsm330dl-gyro
-            - st,lsm330dlc-accel
-            - st,lsm330dlc-gyro
-            - st,lsm9ds0-gyro
-            - st,lsm9ds1-magn
-    then:
-      properties:
-        interrupts:
-          maxItems: 2
-
 required:
   - compatible
   - reg
-- 
2.31.1

