Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093386ACBA3
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCFR4e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCFRzw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:55:52 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DBF6C69D;
        Mon,  6 Mar 2023 09:55:26 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3lkT-1pYxZQ0Hqd-000tYL; Mon, 06 Mar 2023 18:23:15 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 4/8] dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
Date:   Mon,  6 Mar 2023 18:22:45 +0100
Message-Id: <20230306172249.74003-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wQRPex7XRzipPrnANRDADxZJE2vb54rgHl+nepAI703ge7CdZAd
 wBQQEv8D5RoFYWvTcdUDp8/wxCc0OVffAnl6LIf8bIjT/OQ5+j2PMyqSTNjOpeqI0rL6+23
 2oT0eaxJKFcb5uHJtU9XR1Or0NwKNLIyEGEO7mgrjLURo94lhq0Aj+oKQK50DaIlPh8reIr
 1RHw7cZPZfig5/B+kzmEw==
UI-OutboundReport: notjunk:1;M01:P0:2YqeGNcQlRk=;a94tKlFdzg5LskCYLPpEIORYcKC
 kL9C6+b+gaX6+UtOZo/99wzXNvOcOgdJLaY0dvKYKdCra0hXdCPXgNPm+RRP1yl6jv7Itxdak
 W+EYcPsV2TN5awziJF5rkGJmQeeSh0JYqaymw71cy+ryB2SsHuhbdK3AOR+WaMNCbb065wydw
 86xYJuxk0DxP+XV43l35RSp8PbXxYIYv/7zrA0s8yNbAT3AQq7uP+/YlIdnSJ2cT+7QIcELiG
 a2uO+/yxGHDTQbjCydpQTBPMF623YdWTmzfz5gUS44BaxXTKlkabS3MYa1N8jTvDapW2qUKN8
 tfHqpieNYdhKcZzTAJVOwyJnkBRobjS2WRF67ERcUly7o7SVUVKKZX1oLl4Q35XaTwTAgnxyO
 uthCYxIunbI0fObJLhLgSsfRYlci1LfrA0GsBkwyxNwN7y8PNFncKHqNsbKK5vpWhnabFVK0S
 PubYnsMMI0Rp0couUyiGlkJG6fBIud25S49vs3cmS9ujuPnkguwWhdqjse1Ud6RrOjpgIFyma
 Rj0ElM/fypebhnWruXVy7any23KcAS8VBVDkgo4ez1oq3ULn4BcfkO4FyEv4Z0AQE8uT42dRc
 pbiTPyBlWF/F80rjy86T8VEjRSfyQm/zYJju+zXMD+Hdj9k6Y2mmMkRBUTCI7Ytzzq603Ulih
 n7dsAaIvZRStHwrXXRw4SEYacAYXwV8WYFPf9zGtiFiKDmFSkb3FVoPeR88HYf/iRy7/CAHHP
 CDAKlzXtfbCEgx73d2Sg0ZW+fqvX+6C1x91CvjR/e3Y0xoM9lOXF5A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

The ST IIS328DQ is an accelerometer sensor compatible with
the existing ST sensor binding.

Link: https://lore.kernel.org/linux-iio/2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com/
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index c6201976378f..247700537aa8 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -25,6 +25,7 @@ properties:
       - description: STMicroelectronics Accelerometers
         enum:
           - st,h3lis331dl-accel
+          - st,iis328dq
           - st,lis2de12
           - st,lis2dw12
           - st,lis2hh12
-- 
2.34.1

