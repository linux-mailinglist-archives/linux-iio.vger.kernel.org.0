Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF78665B4D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jan 2023 13:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAKMYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Jan 2023 07:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjAKMYh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2023 07:24:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBD6376
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2023 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673439877; x=1704975877;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=2Ga1xCVh2P/BbOkp7POskzvDm4iUs+kPYyIVTQyvtHs=;
  b=d6WrVOxD55z0up1I+xLqR2eJ/+AvCLKj9eplzeXPsMspjtKFTZNJdUGp
   Dg06irX8y08av1g0/kDAqIcgMW800cYmA4Q16esx5/H+2vMxqIstwtKFA
   PefrYuHIegSs9tOshSQTDUN+sfWXr16Dks9sXf4AMkigxsYZ4WZ9Ifxwj
   nbkt7nI19LiD3J+quGHccv9ZBde2WnKyRjQXNxmyouYb+iYTb87NYAseJ
   8i2xP6OuzuT/lZW33sWgHYQt1WTnncoEecfCw3MTk3/JG+AxYizFCCr73
   4v4UyJaiekxg5HT8WJCTOEgKG/aLqiB+RgNICRU1z4QLFIaRTv2F8Hjxp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409643175"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="409643175"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:24:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720714553"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="720714553"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO kronos) ([143.185.115.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:24:28 -0800
Message-ID: <7c1809dc74eb2f58a20595f4d02e76934f8e9219.camel@intel.com>
Subject: iio: hid: fix the retval in gyro_3d_capture_sample
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, demisrael@gmail.com
Date:   Wed, 11 Jan 2023 14:24:25 +0200
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

Return value should be zero for success.
This was forgotten for timestamp feature.
Verified on RealSense cameras.

Fixes: 4648cbd8fb92 ("iio: hid-sensor-gyro-3d: Add timestamp channel")

Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 1 +
 1 file changed, 1 insertion(+)

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

