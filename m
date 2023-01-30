Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67BA681AE8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 20:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3T4e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 14:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3T4d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 14:56:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB284ED3
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 11:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEC26123D
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 19:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB55C4339B;
        Mon, 30 Jan 2023 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675108591;
        bh=qgPC1npyzm5QkOkTgqQ4tUF+yuO02D7WEJE+oGHzYa4=;
        h=From:To:Cc:Subject:Date:From;
        b=bfcGdCiVCCwIZ7dfkev/Z25yjFbEdxIUUIGFcIVigcvcyoS+G+mPqmzeJt5UO5pw1
         HkK2D037xjTR1a0BQ34YlgnQW9jd+X6b5CxshYypH862NFgodWpau+yCpy7iEdDGgt
         P2Ic91SBhxhdf34uGsG/aefGzWYJ2AY6wCss7qoxskHSXsf+WWLwFpJE6AWeVNWKOL
         7uXQaT6apUqHEwOXZLxxoW0wldzFO6wMnIOHC2ecL7/MIu1EkW97t1ik/s9ynjV5QA
         TPf0UzQbq+k6lUtrKspQdBKAc+ppoIs09k6iHalXzafetEENgl++yGxZFrZq/fGHin
         BZxx3U2++kYpQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio: imu: lsx6dsx: support SMO8B30 ACPI ID.
Date:   Mon, 30 Jan 2023 20:10:16 +0000
Message-Id: <20230130201018.981024-1-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Darrell Kavanagh reported a failure to load the driver on his device
(for future reference, what was it?)

DSDT blob as follows.

  Scope (_SB.PCI0.I2C5)
    {
        Device (DEV)
        {
            Name (_HID, EisaId ("SMO8B30"))  // _HID: Hardware ID
            Name (_CID, EisaId ("SMO8B30"))  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.PCI0.I2C5",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_._CRS.RBUF */
            }

            Method (ROTM, 0, NotSerialized)
            {
                Name (RBUF, Package (0x03)
                {
                    "0 -1 0",
                    "1 0 0",
                    "0 0 1"
                })
                Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
            }

            Method (PRIM, 0, NotSerialized)
            {
                Name (RBUF, Buffer (One)
                {
                     0x01                                             // .
                })
                Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.PRIM.RBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((GAVT == 0x6A))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (CALS, 1, NotSerialized)
            {
                Local0 = Arg0
                If (((Local0 == Zero) || (Local0 == Ones)))
                {
                    Local0 = BAC1 /* \BAC1 */
                    Return (Local0)
                }
                Else
                {
                    BAC1 = Local0
                    BACS = Local0
                    BSCA (0xB0)
                }
            }
        }
    }

Jonathan Cameron (2):
  iio: imu: lsm6dsx: Support SMO8B30 ACPI ID for LSM6DS3TR-C
  iio: imu: lsm6dsx: Add ACPI mount matrix retrieval

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 65 +++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 16 ++++-
 3 files changed, 77 insertions(+), 6 deletions(-)

-- 
2.39.1

