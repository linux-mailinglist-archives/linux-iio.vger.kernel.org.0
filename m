Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31A4D65ED
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbiCKQTz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 11:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350194AbiCKQTx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 11:19:53 -0500
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218771D0D43;
        Fri, 11 Mar 2022 08:18:49 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc9a.ko.seznam.cz (email-smtpc9a.ko.seznam.cz [10.53.11.15])
        id 70c56c4d2bcb3824716ca013;
        Fri, 11 Mar 2022 17:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1647015503; bh=GOkgU+I7znFH30Y89bAlfFtupNZUaFPDkJtbpJoAeZQ=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:X-szn-frgn:X-szn-frgc;
        b=KLW0Mkg3Ki2cNr0q5OJvGvUAIrUos9z2I1qqpe4LIvt/94e9df07vo6dMCumXMxju
         EiV8Smkl9eeV6hMiJg9LGFAgIJnA8wcJ/517ESOvqBzYwfnMjBHSb2bsx7bJzXTU8k
         Rc6qeHitp5XEcPAmp7sn5EhxYkCi+4hHfbwXN7uk=
Received: from localhost.localdomain (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay29.ko.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Fri, 11 Mar 2022 17:18:17 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>
Subject: [PATCH v2 0/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Date:   Fri, 11 Mar 2022 17:15:58 +0100
Message-Id: <20220311161600.1469-1-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-szn-frgn: <d6c2749e-97fa-4666-8f1e-e8876269ce75>
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
2.34.1

