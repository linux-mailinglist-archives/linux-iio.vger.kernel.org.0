Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588C65F17A7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Oct 2022 02:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiJAAw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Sep 2022 20:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiJAAw0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2022 20:52:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAB156C15
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 17:52:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o7so3824599qkj.10
        for <linux-iio@vger.kernel.org>; Fri, 30 Sep 2022 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jnXjNOMcrWPsVy2RNeqGYn0oFoeNjspMGl64MLEGGx8=;
        b=qR964shjkBTuisK+rVyNS6QKnQVkqPS+hiT7HZygH3ms/sCPj8lUZP03Kj2fqMLIn/
         hAKz7LtZyDCFLKLy712nr3tJObVCXs4Is3VdKJg6FSPXwp76+Y8efmx5rbdWAqjIFTVW
         G0Gm0dq982+1BzYTM0aAJ2AqXaZ1t3yUxSCzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jnXjNOMcrWPsVy2RNeqGYn0oFoeNjspMGl64MLEGGx8=;
        b=1RLxUbEeGBBixty/rVY+mUwpkjscSUmPjnluCV9WtEyoFkBaDqP0LNHDBE/JuGxYSV
         +Du0uvHtu+E0ig8dvJRi5ChmuGfOQYkAHiOWtWygTxfCjdLiHz4Mq4LHt/035nyUuaps
         RxcK6i46ts3wLD1qWLIrUdTwtJT5e5ZEVQjYLh8EJiFXeLOucA6MAXh4kJ4htljJcxjp
         EJvHksa9iyBQsHbdTlqoG3OAqxaRcfObHOh8v40wKH45MRyRPjvL20BS4wa42BbNEX4M
         3RPvDsqsXozrs5cKh0dUh4gqcu7spOSH4yfVy9ratvOrK4qqYxTT8svNtrO0N8ZhUR3K
         AKyg==
X-Gm-Message-State: ACrzQf2JR4R4Ep4bC7xDseuekTlGJDPmKd32/kS3NHQX4RHyDCYpvrFU
        FnwSuYnVHQ+gVi6qANK9rAdWrA==
X-Google-Smtp-Source: AMsMyM7fyzhQFd2yLPlRoHCItn3vz3uAOsUBQUrDF2lBzHWMk0PpoI2RPnNJzPB9of1f8ciwjqJzww==
X-Received: by 2002:a05:620a:13cd:b0:6cb:e443:e97a with SMTP id g13-20020a05620a13cd00b006cbe443e97amr7909232qkl.449.1664585545137;
        Fri, 30 Sep 2022 17:52:25 -0700 (PDT)
Received: from localhost.localdomain ([185.193.125.71])
        by smtp.gmail.com with ESMTPSA id r10-20020a05622a034a00b0035ce8965045sm3224817qtw.42.2022.09.30.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 17:52:24 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org, gupt21@gmail.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v6 0/3] HID: mcp2221: iio support and device resource management
Date:   Fri, 30 Sep 2022 17:52:05 -0700
Message-Id: <20221001005208.8010-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.37.2
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

Changes from v5:
* dropped all Kconfig changes not related to mcp2221 driver
* changed 'select GPIOLIB' to imply for mcp2221 along with IS_REACHABLE check

Matt Ranostay (3):
  HID: mcp2221: switch i2c registration to devm functions
  HID: mcp2221: change 'select GPIOLIB' to imply
  HID: mcp2221: add ADC/DAC support via iio subsystem

 drivers/hid/Kconfig       |   3 +-
 drivers/hid/hid-mcp2221.c | 310 ++++++++++++++++++++++++++++++++++----
 2 files changed, 286 insertions(+), 27 deletions(-)

-- 
2.37.2

