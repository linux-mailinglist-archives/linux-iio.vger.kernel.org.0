Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA04E5209
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 13:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiCWMUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCWMUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 08:20:18 -0400
Received: from mxd2.seznam.cz (mxd2.seznam.cz [IPv6:2a02:598:2::210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5852E5B;
        Wed, 23 Mar 2022 05:18:47 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc18b.ng.seznam.cz (email-smtpc18b.ng.seznam.cz [10.23.18.21])
        id 6bd30b6430dd5f0d6a7ac73a;
        Wed, 23 Mar 2022 13:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1648037895; bh=cH5I5+ua42ikxVOB3r4IcFB04l7PFTclKG4TJdoGnkI=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:X-szn-frgn:X-szn-frgc;
        b=NJcvXkENICfXbfpKn4ynDv3Qmyj7AejNpVrFuMCKZC8krcsIGNte+gPtd+DuR0EXi
         /TAePfNqXNKrhitDw8/pvH4NfDaAqL+MWAQXvMISJaMgJexB8jLx5f+O9KIXkjM/eq
         wgDBogkP/nFqAcGNFwqLS2ARZY4f6bMcaKQaxcio=
Received: from localhost.localdomain (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay19.ng.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Wed, 23 Mar 2022 13:18:11 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH v2 0/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Date:   Wed, 23 Mar 2022 13:15:48 +0100
Message-Id: <20220323121550.16096-1-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-szn-frgn: <54464e53-3b75-4f93-8539-b1341e89bca4>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

changelog:
 -v2: require specifying "invensense,icm20608" as a fallback compatible
      in the binding, as suggested
 -v3: fix indentation issue with the binding

Michael Srba (2):
  dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
  iio: imu: inv_mpu6050: Add support for ICM-20608-D

 .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
 drivers/iio/imu/inv_mpu6050/Kconfig           |  4 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  9 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  6 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  5 +++
 6 files changed, 43 insertions(+), 17 deletions(-)

-- 
2.35.1

