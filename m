Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0566BEDF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjAPNLK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 08:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjAPNKm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 08:10:42 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461D323C5D
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 05:08:30 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id C5AF6DF00AB; Mon, 16 Jan 2023 14:07:38 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH v2 0/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.
Date:   Mon, 16 Jan 2023 14:07:12 +0100
Message-Id: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>


A simple patch to add the missing 'mount_matrix' sysfs entry for the gyro
channel of the st_lsm6dsx 6-axes devices.

v2: use 'shub' in the renaming

Philippe De Muyter (2):
  iio: imu: st_lsm6dsx: fix naming of 'struct iio_info' in
    st_lsm6dsx_shub.c.
  iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.31.1

