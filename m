Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD94A7283
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiBBOCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:12 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59283 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiBBOCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:11 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C99CC200004;
        Wed,  2 Feb 2022 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmLCmMWpjGtflzXx1HNHByt2kN8tM4HeD013Yp4bZDE=;
        b=WgEhaNjAeuFJviUJcnMe8n2k5s+uflB8K56nwYeet92eLyo6lCk4+aqXS8O23JO6TIib+s
        SY3Cd4U2yDk7BxkrB7XkPsO9fhdzAUddtVGzwY67GxuMhHHhpJtgoE+HkkhmsUDQiyGwkt
        EozjJl0tEqljNfmOB8y9soDYZJYOhoOPC1+2/0+qNwVsKxTUUbPS0Lnb0fb408CyrHLrKV
        0lUvNRopJy2vwyJOmUoNlDQvFg2puO56rkpMfbxaFL6R96KEK24GwVcJhsyhAa1WW+Ln5r
        Fqba05iHp4WTkhBsmURkPUjbAqFXZkGk9RKk48yjIfVhSecUJIls26KjhWwx/A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 01/12] iio: core: Enhance the kernel doc of modes and currentmodes iio_dev entries
Date:   Wed,  2 Feb 2022 15:01:57 +0100
Message-Id: <20220202140208.391394-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Let's provide more details about these two variables because their
understanding may not be straightforward for someone not used to the IIO
subsystem internal logic. The different modes will soon be also be more
documented for the same reason.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/iio/iio.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faf00f2c0be6..f191b80466cd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -488,8 +488,15 @@ struct iio_buffer_setup_ops {
 
 /**
  * struct iio_dev - industrial I/O device
- * @modes:		[DRIVER] operating modes supported by device
- * @currentmode:	[INTERN] current operating mode
+ * @modes:		[DRIVER] bitmask listing all the operating modes
+ *			supported by the IIO device. This list should be
+ *			initialized before registering the IIO device. It can
+ *			also be filed up by the IIO core, as a result of
+ *			enabling particular features in the driver
+ *			(see iio_triggered_event_setup()).
+ * @currentmode:	[INTERN] operating mode currently in use, may be
+ *			eventually checked by device drivers but should be
+ *			considered read-only as this is a core internal bit
  * @dev:		[DRIVER] device structure, should be assigned a parent
  *			and owner
  * @buffer:		[DRIVER] any buffer present
-- 
2.27.0

