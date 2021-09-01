Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE73FD85A
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhIALEA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 07:04:00 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:60480 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhIALD7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 07:03:59 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 8D1DC44A024F;
        Wed,  1 Sep 2021 13:03:00 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v1 2/3] MAINTAINERS: Add myself as maintainer of the scd4x driver
Date:   Wed,  1 Sep 2021 12:59:10 +0200
Message-Id: <20210901105911.178646-3-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901105911.178646-1-roan@protonic.nl>
References: <20210901105911.178646-1-roan@protonic.nl>
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
index c6b8a720c0bc..7398ee8fda22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16732,6 +16732,12 @@ F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
 F:	drivers/iio/chemical/scd30_serial.c
 
+SENSIRION SCD4X CARBON DIOXIDE SENSOR DRIVER
+M:	Roan van Dijk <roan@protonic.nl>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
+F:	drivers/iio/chemical/scd4x.c
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.30.2

