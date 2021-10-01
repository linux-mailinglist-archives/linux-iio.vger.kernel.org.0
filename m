Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0741E7EA
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352291AbhJAHEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 03:04:49 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:53918 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJAHEs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 03:04:48 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 0E04244A0250;
        Fri,  1 Oct 2021 09:02:59 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v4 2/4] MAINTAINERS: Add myself as maintainer of the scd4x driver
Date:   Fri,  1 Oct 2021 09:02:52 +0200
Message-Id: <20211001070254.3940795-3-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001070254.3940795-1-roan@protonic.nl>
References: <20211001070254.3940795-1-roan@protonic.nl>
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
index 76e0fdcdd877..d6016b2112f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16874,6 +16874,12 @@ F:	drivers/iio/chemical/scd30_core.c
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

