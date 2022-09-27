Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78D5EB7EA
	for <lists+linux-iio@lfdr.de>; Tue, 27 Sep 2022 04:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiI0C5c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiI0Cz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 22:55:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC15A2F0
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g23so5317577qtu.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MU+wKQYrdKFuLFKlM955jc4CyzX+lP8pj1xvxzTau7U=;
        b=t2ByL0yttHKMUd6x2ww6R0pUM1xUPMi6Dk4L0zyaQ2bXT4rNibOmzdZ69lMpAK7BUY
         yVTqQ/Xpgj1d6kGOlQC5zBqt15R/qGy+lCaJjEX+cFaU2/1KXnhCtU2nXddxaZqNt0M1
         ktg+0h2zzeoCYLSzz35krSyY1uJmTIM/czQqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MU+wKQYrdKFuLFKlM955jc4CyzX+lP8pj1xvxzTau7U=;
        b=H8sdCFiSN0NKlijqsyFVD2eaoAyROmx68hNJHWKfWHLtdXTNWt1eae4XdrV6DquI/K
         1RHbY3dzFBDCjEr7ThkzVVkyXuA5QeMfvRptMZxU+KuXKkeVy4TKYxx8QnVqHygie88e
         S8TTMcSC6ysf3Vrwt0zYTt6KRn5IQ/xknR6MvsJTKIW+0EmVxO78SN2EBOmgMGhfXi8A
         xT+eJStYneNthJLo5eJEUC48EaxbXilvw+sefhNkn+r5m4HQeGF5dBxQC81/f3xU2Ft2
         1X8G8uv4YeVI8sQohN5TVsFJ/kO/4jZf1FBKVC8WS5x4MxknpVMES2ukx6R5cvOWnkxk
         U2ag==
X-Gm-Message-State: ACrzQf2k86B6h/zzzrosltRHhFhHDFb+Y8dhmd5BESbwfzAAztp2TT/F
        +gI68ncKsjKM+4jhKXMHoMISpw==
X-Google-Smtp-Source: AMsMyM6STBSuhM0MntUL0l5oruWmmHAmKZZRcSneWAfpz6g+wbyWT/aioofYBGfV8Z6CR0pDatAYJg==
X-Received: by 2002:ac8:5716:0:b0:35c:bd68:d34 with SMTP id 22-20020ac85716000000b0035cbd680d34mr20293945qtw.50.1664247076314;
        Mon, 26 Sep 2022 19:51:16 -0700 (PDT)
Received: from roguebox.lan ([164.92.70.235])
        by smtp.gmail.com with ESMTPSA id y5-20020a37f605000000b006bb0f9b89cfsm199620qkj.87.2022.09.26.19.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:51:15 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, gupt21@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v5 0/5] HID: mcp2221: iio support and device resource management
Date:   Mon, 26 Sep 2022 19:50:45 -0700
Message-Id: <20220927025050.13316-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset is primarily to enable iio support for the MCP2221 HID driver,
but requires several Kconfig changes and device resource management.

First attempt of this patchset is referenced here:

Link: https://lore.kernel.org/all/20220729154723.99947-1-matt.ranostay@xxxxxxxxxxxx/

Changes from v1:
* Fixing various Kconfig recursive dependencies that appear with 'imply IIO'
* Switch hid-mcp2221 driver to device managed resources for i2c support
* Reworking patchset per advice on lore.kernel.org link above

Changes from v2:
* add linux-iio list to CC

Changes from v3:
* replace .remove() tasks with devm_add_action_or_reset() in .probe()
* reschedule SRAM configuration read on failures
* add IIO_CHAN_INFO_SCALE values for ADC + DAC based on reference voltage

Changes from v4:
* add .remove function with no operation to avoid hid_hw_stop() being called
  twice due to new devm functions
* add retries limit to five for reading SRAM configuration data
* update 'io: adc: stx104: fix future recursive dependencies' to new Kconfig
  location for STX104 driver on linux-next pending-fixes branch

Matt Ranostay (5):
  i2c: muxes: ltc4306: fix future recursive dependencies
  iio: adc: stx104: fix future recursive dependencies
  iio: dac: fix future recursive dependencies
  HID: mcp2221: switch i2c registration to devm functions
  HID: mcp2221: add ADC/DAC support via iio subsystem

 drivers/hid/Kconfig       |   1 +
 drivers/hid/hid-mcp2221.c | 309 ++++++++++++++++++++++++++++++++++----
 drivers/i2c/muxes/Kconfig |   2 +-
 drivers/iio/adc/Kconfig   |   3 +-
 drivers/iio/dac/Kconfig   |   6 +-
 5 files changed, 288 insertions(+), 33 deletions(-)

-- 
2.37.2

