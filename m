Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94C0426781
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhJHKTY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 06:19:24 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:54414 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhJHKTS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 06:19:18 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 21CEC44A0250;
        Fri,  8 Oct 2021 12:17:17 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v5 2/4] MAINTAINERS: Add myself as maintainer of the scd4x driver
Date:   Fri,  8 Oct 2021 12:17:04 +0200
Message-Id: <20211008101706.755942-3-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008101706.755942-1-roan@protonic.nl>
References: <20211008101706.755942-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a4a0c2baaf27..99b559cdc1b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16879,6 +16879,12 @@ F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
 F:	drivers/iio/chemical/scd30_serial.c
 
+SENSIRION SCD4X CARBON DIOXIDE SENSOR DRIVER
+M:	Roan van Dijk <roan@protonic.nl>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
+F:	drivers/iio/chemical/scd4x.c
+
 SENSIRION SGP40 GAS SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained
-- 
2.30.2

