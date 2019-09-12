Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE8B115B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfILOnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 10:43:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43649 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfILOnf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 10:43:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so24067444wrx.10
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2019 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b4t5nB2QVWNukgq5iv7R34CeS+j38P7H1tDcqxbpq/U=;
        b=PJpLeBcu7YE9LtkRKrtGcZA/DCrfMc0xROVfDBDudB8EdQX1y12430/dJNN31XIPFw
         suQOy79+CBUz/gsRmhqyCexaEQwKpvx/VINa4lfi1jGLvJUCG4tJLS0SR8r5CF8PIDWr
         Sg+sIO2cUczPJtThhwQUBjoh2UC8oXY1nzGOKL+rm+aB1q+e76pislPGzaiE+6WAKwUQ
         iYA/bkKG5XtJpwjRkaiEpr71uqZPnaCrejy5nqQ/QBLtuTRsSYrR2MZYRoRpOv0bRd/7
         Gd8/uy1uCr8z4xuJY64yOjQifjyq6WRIqPiYFj97O0EyXYhCLzuHKKL/l/P3xdQJoajw
         urKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b4t5nB2QVWNukgq5iv7R34CeS+j38P7H1tDcqxbpq/U=;
        b=D9AiMBnLjWu7J5l8XmH23a6/Lxr5vFUcJ5+h3DyLB1XUlUk21WHe1aG8DxhCzKJgzy
         txbQExTAY6pxSRQYs6TGy9neCbrTM4rFSMhJUq5ZfBWI/msJXDT1N7ZfqHAOCnT5VjrZ
         W9SqwTRcWkoSlOyhHyVIqaxk5Lkyn/K2jbhuVMbLlk4cklUnsplOh4T1RmqmeM5RiITU
         WqnkSuWE03AVdOAb8KS1OxqpdzVTr5OyLP21KVZqQeaG77+7Z2n1lYQLdPGMAbDbmean
         pdrLcOPwAcOn9d87lLlZKsgvkv3SA5RmvKXym7uJomQZOYwGDV1h/xupRuC/Mp7zqT0K
         gu0g==
X-Gm-Message-State: APjAAAUIBEftRYi2qj02tm+OPKaZQavym95/WjR4Qtoer3gPTawD7WrL
        Wxkqf6MZ6rgo+UTFf3zX50g=
X-Google-Smtp-Source: APXvYqz8UtbSf5jWGg/xJuhak4QVWftXE67TNLuGD7oWN0NR3wdxW31iVghNEUEqXiNucZ9kSClfvg==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr34734626wrn.299.1568299413508;
        Thu, 12 Sep 2019 07:43:33 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id q19sm35175256wra.89.2019.09.12.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:43:32 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 0/4] Fixes for ad7949
Date:   Thu, 12 Sep 2019 16:43:06 +0200
Message-Id: <20190912144310.7458-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series fixes ad7949 driver incorrectly read data, simplify the
code, and enforces device timing constraints.

This has been tested on a UltraZed SOM + a custom carrier equipped with
several AD7689 A/Ds. Patches have been developed on a Xilinx upstream
kernel and then rebased on linux-next kernel.

Andrea Merello (4):
  iio: ad7949: kill pointless "readback"-handling code
  iio: ad7949: fix incorrect SPI xfer len
  iio: ad7949: fix SPI xfer delays
  iio: ad7949: fix channels mixups

 drivers/iio/adc/ad7949.c | 64 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

--
2.17.1
