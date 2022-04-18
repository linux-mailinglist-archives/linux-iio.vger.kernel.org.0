Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE0505E6F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347673AbiDRTYP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347674AbiDRTYN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1EE3586E
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45D3760E0A
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00905C385A7;
        Mon, 18 Apr 2022 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309691;
        bh=BDpIENFNuMlesggVJDYLo8PfT0a4928SawiqYoWIxFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqOr4+nKp+eIWxq8VYxYTKbPDeaX6Ig5ZMCHOd3AiXZCfw1kUXOqsTWgrWeBHByAq
         PMhO3BjFQfv9fHvI3+g66GTvRvmpjbeG7VYZNR/7mYk1BjypRC23lXPxX8eqvZAGY5
         KhEoSt/+x7EYAH7azsUoAWoyn5r7ODrtmTpfFx9nZ8yhvop2m0KAI64ADFIcYL+Wx0
         mYsq/VbN+/jiH1xqaHtxPxKk7uqQqslM7PB8jZXAQ8hcs1e7qlLyIxOYDTywq7Pp69
         z2h1YU878V/syAtCsKG9A0u/9WuRqzuIZVoVF5EvgFdxKkOCyft894n6Anz73K/C2w
         9HHm8iDmgPBCA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/17] iio: core: Introduce _inputoffset for differential channels
Date:   Mon, 18 Apr 2022 20:29:01 +0100
Message-Id: <20220418192907.763933-12-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Address an ABI gap for device where the offset of both lines in a
differential pair may be controlled so as to allow a wider range of
inputs, but without having any direct effect of the differential
measurement.

_offset cannot be used as to remain in line with existing usage,
userspace would be expected to apply it as (_raw + _offset) * scale
whereas _inputoffset is not.
Similarly calibbias is expected to tweak the measurement seen, not
the adjust the two lines of the differential pair.

Needed for in_capacitanceX-capacitanceY_inputoffset for the
AD7746 CDC driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
I''m not entirely happy with the naming on this one, so if anyone
has a better idea I'm definitely open to it!
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/types.h               |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index b19ff517e5d6..4fbb5a257ef5 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -199,6 +199,19 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are nanofarads.
 
+What:		/sys/.../iio:deviceX/in_capacitableY-capacitanceZ_inputoffset
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For differential channels, this an offset that is applied
+		equally to both inputs. As the reading is of the difference
+		between the two inputs this should not be applied to the _raw
+		reading by userspace (unlike _offset) and unlike calibbias
+		it does not affect the differential value measured because
+		the effect of _inputoffset cancels out across the two inputs
+		that make up the differential pair. It is expressed with
+		the same scaling as _raw.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d831835770da..8aebef08ca1d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -168,6 +168,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
+	[IIO_CHAN_INFO_INPUTOFFSET] = "inputoffset",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a7aa91f3a8dc..c7f79a251a14 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -63,6 +63,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 	IIO_CHAN_INFO_CALIBAMBIENT,
+	IIO_CHAN_INFO_INPUTOFFSET,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.35.3

