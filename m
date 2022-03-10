Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D44D486F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiCJN4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiCJN4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 08:56:41 -0500
Received: from mxd2.seznam.cz (mxd2.seznam.cz [IPv6:2a02:598:2::210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A535F141FDA
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 05:55:39 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc10b.ng.seznam.cz (email-smtpc10b.ng.seznam.cz [10.23.14.45])
        id 33bdfb5368b3af3a3214370d;
        Thu, 10 Mar 2022 14:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1646920527; bh=bURihk1BJ9DBqC4GxcjF9QaBinkfaCKVea25LTFyWG4=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:X-szn-frgn:X-szn-frgc;
        b=KJ9uGvINW2MqP6EHnRklKeFl4xzSC/Ol70//dbDbSpn/wz7Blcp82cogbjHXHgHdR
         uih59mql0sUP5CPn/3b4a8InizetAOYdwls/l5+rUcLmPUpNdi38Ajpa+oGvHMaQOO
         3yBVDY5hH8F6x+bkpaMXxF90KvpgTrMVYQRR/b30=
Received: from localhost.localdomain (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay27.ng.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Thu, 10 Mar 2022 14:42:45 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH 0/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Date:   Thu, 10 Mar 2022 14:39:36 +0100
Message-Id: <20220310133938.2495-1-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-szn-frgn: <fb960f2c-0da2-49df-9b84-d5f1f54ebf8a>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Srba <Michael.Srba@seznam.cz>

This series copies the invensense icm20608 support in the inv_mpu6050
driver for icm20608d, which is for all intents and purposes identical,
except for the inclusion of a DMP (Digital Motion Processor), which
is deemed significant enough to change the WHOAMI value, thereby making
the driver fail if the invensense,icm20608 compatible is specified.

Since the driver doesn't currently acknowledge that there is such thing
as a DMP core, all that is needed is to copy the icm20608 support and
change the WHOAMI value.

Michael Srba (2):
  dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
  iio: imu: inv_mpu6050: Add support for ICM-20608-D

 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml  | 1 +
 drivers/iio/imu/inv_mpu6050/Kconfig                      | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c               | 9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                | 6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h                | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c                | 5 +++++
 6 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.34.1

