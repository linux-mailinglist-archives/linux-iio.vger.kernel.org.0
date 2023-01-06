Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500C65FEB5
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jan 2023 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAFKYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Jan 2023 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAFKYA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jan 2023 05:24:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995336B5A9;
        Fri,  6 Jan 2023 02:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673000634;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vJ3Lg60sYJz8VxK7VMdeBvnb8ZCw4NP60AO5g6T6W0U=;
    b=T2QWihr7tw4eRz+tqMQ0Jw4xfpzY2LUQwWG3UEvH/akCUqIxxeVgH7pa6IrDSIv7Ps
    HxYCiXVvkCoiJ4adY3WdXr8LBDD3jr4Wn59Db9Log0LPraVIUMojdsifqbz3KFUzB6P9
    V0NlqaUsmgKMF5zOpPtMzzSR7pbQG/76jyVae7lCTpn2DBrOjM9W25poC7TUjRkpBZDL
    kbcmWhd3B3JkpY9tToETnJIjU1tksmhFHOcTYH+ELriQzniwhmndaQ0yefk8iwaVeyar
    bsEJenDBFhgOl3twuwrrhkIqBNM/CaxiuaPOwpmEdwlKcIIiGVz8RK8r0T08tOKbSkL9
    kkHw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIRvweFeMkcg="
X-RZG-CLASS-ID: mo01
Received: from droid..
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349z06ANrqz6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 6 Jan 2023 11:23:53 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/3] dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
Date:   Fri,  6 Jan 2023 11:22:37 +0100
Message-Id: <20230106102239.9647-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106102239.9647-1-stephan@gerhold.net>
References: <20230106102239.9647-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ST LSM303C [1] is a accelerometer and magnetometer combo sensor
compatible with the existing ST sensor bindings. Accelerometer and
magnetometer are exposed through separate I2C/SPI devices, so document
separate compatibles with -accel and -magn suffix.

[1]: https://www.st.com/resource/en/datasheet/lsm303c.pdf

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 250439b13152..c6201976378f 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -39,6 +39,7 @@ properties:
           - st,lis3lv02dl-accel
           - st,lng2dm-accel
           - st,lsm303agr-accel
+          - st,lsm303c-accel
           - st,lsm303dl-accel
           - st,lsm303dlh-accel
           - st,lsm303dlhc-accel
@@ -66,6 +67,7 @@ properties:
           - st,lis2mdl
           - st,lis3mdl-magn
           - st,lsm303agr-magn
+          - st,lsm303c-magn
           - st,lsm303dlh-magn
           - st,lsm303dlhc-magn
           - st,lsm303dlm-magn
-- 
2.39.0

