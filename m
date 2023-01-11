Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618ED665B3D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jan 2023 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAKMWQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Jan 2023 07:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAKMWP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 07:22:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE76376
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673439735; x=1704975735;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=WL9u6n6lQcezpgmxlhgyTpMFXB9OIZ4oZiEg5MFEDfA=;
  b=GLIm9Qz02hgZwW91/gPKS1vObEovTlZCfG7kj/IYV8b817TuQdbqbjDR
   uDzUadbP/wORNX/utDTSZUJmXA4I10rrS0Hr15e8R9olQ8PGP8PNEi/OK
   RRyQX1zJ8koUULZJff3ZoQFEdu+bCvOjsP289Su7DbQtC+hUKykbNxBCz
   Qbph2ez9Y/CL+/tSa0DYaoQlFcQtAUdqfgWTO4ORMx8vagzZwPxAOI7uv
   VFQXmjpb2E2u3msqxWRupSHS8Ac0nhBXKWxtZx1/GeQFtn6eaiFofR9vh
   9i8+H+G5Lcx15BXjegAI607PeUp072RsIxcg9DaQfZUPqRvtgYkVCcc+c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="311208957"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="311208957"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:22:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687918554"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687918554"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO kronos) ([143.185.115.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:22:13 -0800
Message-ID: <a6dc426498221c81fa71045b41adf782ebd42136.camel@intel.com>
Subject: [PATCH] iio: hid: fix the retval in accel_3d_capture_sample
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Date:   Wed, 11 Jan 2023 14:22:10 +0200
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Return value should be zero for success.
This was forgotten for timestamp feature.
Verified on RealSense cameras.

Fixes: a96cd0f901ee ("iio: accel: hid-sensor-accel-3d: Add timestamp")

Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 1 +
 1 file changed, 1 insertion(+)

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
-- =

2.39.0


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

