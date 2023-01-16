Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118166BAEA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjAPJwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 04:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAPJvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 04:51:53 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38114193C3
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 01:51:46 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 137E6DF00AC; Mon, 16 Jan 2023 10:51:45 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: fix naming of 'struct iio_info'.
Date:   Mon, 16 Jan 2023 10:51:24 +0100
Message-Id: <1673862685-29308-2-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

We need the name 'st_lsm6dsx_ext_info' for the actual 'iio_chan_spec_ext_info'.
Rename the 'struct iio_info' to 'st_lsm6dsx_info' like in all other drivers.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index f2b64b4956a3..43304b198040 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -714,7 +714,7 @@ static const struct attribute_group st_lsm6dsx_ext_attribute_group = {
 	.attrs = st_lsm6dsx_ext_attributes,
 };
 
-static const struct iio_info st_lsm6dsx_ext_info = {
+static const struct iio_info st_lsm6dsx_info = {
 	.attrs = &st_lsm6dsx_ext_attribute_group,
 	.read_raw = st_lsm6dsx_shub_read_raw,
 	.write_raw = st_lsm6dsx_shub_write_raw,
@@ -737,7 +737,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 		return NULL;
 
 	iio_dev->modes = INDIO_DIRECT_MODE;
-	iio_dev->info = &st_lsm6dsx_ext_info;
+	iio_dev->info = &st_lsm6dsx_info;
 
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
-- 
2.31.1

