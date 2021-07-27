Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787A3D7B14
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhG0Qfb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 12:35:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhG0Qfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 12:35:31 -0400
Received: from localhost ([31.220.117.216]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPGJh-1mY30S3Gg9-00PaQk; Tue, 27 Jul 2021 18:34:45 +0200
Date:   Tue, 27 Jul 2021 18:34:45 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 1/2] dt-bindings: iio: chemical: Add trivial DT binding for
 sgp40
Message-ID: <20210727163443.GA3457@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:3Q37JsJczvB5k6tcKshryG835v3At5NIgLiOSLuF1XKThUHou4K
 P9kCAmu+VCqIudbKQkbwnziHw3oZoinuhkc7iqNznVljpTSRtugfJxd/VP7W8fl1sDdG+Q8
 AxLyKu0mJT7VDtqOYYyg3EJyZZbrcQZr7wxPwsGQdtJn4IbgVa8XFbDbqVbDjpGitlphuje
 yty+9D+XOIrtDd9GHQuBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HVXkFdyzUnU=:zSjFTqGdVS206Lf6gIyj2E
 Ip4tmI1pokTjJZRapZGji4eF+4rt9iO+xQEYmlpfm4AnzfUcGkV1UIoyEah8kb1ZTy9WCrYzk
 gKz7+YHg5foSbq9X5jbQbAduu28tNkcWUb54r4PPzmXNeMY7az0r9Uti+SLCwObdfpbfp+onU
 oM4ff4MlPJayQiGcRzgPhGYBDjpq45mY91h6HUk5rRF03m1oCCY2+bOw10rWyQckSDm7Mz4mM
 Qdln8u/RY8v0YVObIsJdvFAJqEjuyELjOZpNVkdiDnK3duQFhYxtjs9Mq36gE6JvcAAPmLrem
 KCA0+N6R0Uw4Gm9ocG3m44yWNBGTAEjO2+taKlra3uK3Q+nbnvkw58POZllJki4tsrixBoizf
 sQm1vY8q+ktbqEa2eqPHEwaJQb15EjGWtcvsn/VVZ+HtAizmzV4nj9fvG0k011uzcZMYV+svW
 YtESlVGVFhstSWTiGETFbbyXBgztzk4BhYHFC4G8Af0ckzIVY9yx+RJ5LgiyQLKWoDc1eLb0x
 C19RGDoIKqMxagiBdok5SEPznEmSF1PwNF5xKk/B9cdRcKGyhGPyjVUwCMnHrGVs64T3J3adi
 lOad0JR9oRo87BAnIopvkb/7pj2O+1LurQ54QuwAQcj7sGUdbH5lPlyIztGRIXth76K9Y1g94
 84xHTEJX4qSLCfXoFyfIcyBhmB1D4V6koPG79G1jM+h+Pyyl+Gl6khy/lPUTr8FgWYEFzb6zI
 OSz0F6dJeGu8njrXhliFPevEPlbyQyBl9MpJsTk1gDIz0jMigVE5aAWYU5GeijSNNQE4d9DXm
 RroXlSLfYz+TCW9tYgpQGJdf248CsKauoyp642RxOgdvhfKJe0eBS2+roQ44D7O6sQl6lY4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for Sensirion sgp40 gas sensor to trivial
devices.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 919a4bf03a5a..be313b6b4f81 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -269,6 +269,8 @@ properties:
           - sensirion,sgpc3
             # Sensirion multi-pixel gas sensor with I2C interface
           - sensirion,sgp30
+            # Sensirion gas sensor with I2C interface
+          - sensirion,sgp40
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312
             # Sensortek 3 axis accelerometer
-- 
2.20.1
