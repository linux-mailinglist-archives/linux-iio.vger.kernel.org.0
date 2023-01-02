Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5065B6BD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jan 2023 19:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjABSve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Jan 2023 13:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABSve (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2023 13:51:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E189A180
        for <linux-iio@vger.kernel.org>; Mon,  2 Jan 2023 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672685492; x=1704221492;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=dx5fKevLwyjXB0MxVolAKvf7tOMSd6cS3i1gg2o55o4=;
  b=iI/22FIYEUv2XjjS8dd+uI3zrLO4+TdEWTZIxvDylYxe6Sjb/JQ1Gqt9
   9eTfu52/+bG4l3R6x3Pl+S3Whw4x9qg3/kscn44xHfmVA5tyebQDWR1b8
   o5crT8xtBsiraWkMxMcRoVSfJuKye2P58Lf2MlIf5lQuUSBB52SEKbeGl
   FqM6HIPZ4UyAGSqgkz3iyko/qGnLWq77I2AAqXBuqgVozCO9mz/uHA5Fe
   6+eUtH9gBNop89ZRRzXnV6uhwMPmJtjobvVEAkTwxtw5f49EBS4pxD/gi
   TSI0ezeasO6mWzEvuhri6BmWe9f5ptXZI9jcWFc5T63FjvLJGc3gJY9G7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="385963644"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208,223";a="385963644"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:51:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="743267454"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208,223";a="743267454"
Received: from tmishkov-mobl.ger.corp.intel.com (HELO kronos) ([10.214.220.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 10:51:29 -0800
Message-ID: <80a61ea3eb5d00febdaf24ab27e3301fd8c70f74.camel@intel.com>
Subject: [PATCH] iio: hid: fix the retval in [accel|gyro]_3d_capture_sample
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com,
        Dmitry Perchanov <dmitry.perchanov@intel.com>
Date:   Mon, 02 Jan 2023 20:51:27 +0200
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From d12f607f83c0bdae6529d8cfbb0cf17f8920c380 Mon Sep 17 00:00:00 2001
From: Dmitry Perchanov <dmitry.perchanov@intel.com>
Date: Tue, 13 Dec 2022 17:44:01 +0200
Subject: [PATCH] iio: hid: fix the retval in [accel|gyro]_3d_capture_sample

Return value should be zero for success.
This was forgotten for timestamp feature.
Verified on RealSense cameras.

Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hi=
d-sensor-accel-3d.c
index a2def6f93..5eac7ea19 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -280,6 +280,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hu=
b_device *hsdev,
 			hid_sensor_convert_timestamp(
 					&accel_state->common_attributes,
 					*(int64_t *)raw_data);
+		ret =3D 0;
 	break;
 	default:
 		break;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-s=
ensor-gyro-3d.c
index 8f0ad022c..698c50da1 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -231,6 +231,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub=
_device *hsdev,
 		gyro_state->timestamp =3D
 			hid_sensor_convert_timestamp(&gyro_state->common_attributes,
 						     *(s64 *)raw_data);
+		ret =3D 0;
 	break;
 	default:
 		break;
-- =

2.39.0


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

