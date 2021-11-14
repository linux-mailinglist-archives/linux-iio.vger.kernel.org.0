Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016CF44F80C
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhKNN1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 08:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKNN1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 08:27:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8664C061746;
        Sun, 14 Nov 2021 05:24:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r8so24889449wra.7;
        Sun, 14 Nov 2021 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTQDUuuYOeGXlpCl1WEix6oSc8ili0Czj+dST23vHVM=;
        b=MpukiRJzSg4v6dqygvWPHfY7dEQfTDziN6WmZfdPygY8eeeA1uHJ9E/6UpS0AuvfS+
         HEFY8fh9+R9pwZ2R96UTbKTkQw5/o2JYeNbBfuyQAFVqG4pdrWAnY+q4MRFMOdjp4C0/
         rAC/bhsKq2J5cp5OxIisr5C/ADIb/dVHll6QFCmnP17GnN5FHC4H+wdtJNnRPJ5QR0N/
         YuxTQY3Ds5mBakJE3ZAQP3XzA5yDVwBW+Au8fe/kT5i3WIHOfQZquGvaplAhxoNY/+Nr
         nQ7x3r2NzTnMeCbVJqM7ADuPndDGbDbxED17uWjUCFd1VcNyKKBVtYtV76n5IJvu3xbL
         RLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTQDUuuYOeGXlpCl1WEix6oSc8ili0Czj+dST23vHVM=;
        b=pDiHQR2AyZG8m06Cd4mitAQSQdBXQb258EpMxb3bDCOmxcd/i8F/Eva+K9tNf6e0Ne
         4oQSvvWPeDJWQdoIlk0S4mXNeCnmIYQ09caqXCfbMT0fZ6U8XwoqYdz+eLUs7LrTYEj/
         1mVMjLcLnR5YhPSJFveJ0FGmVBcR0w3i7fhot8V5HYT1I64ZTZZfYSNYJ7OjUK1FWeRM
         e3QP+taxdlXCzNaaOj0x4IuHEmbx4ETG2yHLREPsEYBCU1NmPhWhFVeX4n8m03ZoB4G8
         6FMQ7teCNJvSiipcSBvu8hE8QgbTu/4AtJEVU/rNxnkEw7IgRAE9wXgl0oQ+Ax5GNSQN
         3xBg==
X-Gm-Message-State: AOAM5334aASCr+GVzlBYZVwJCa40o12jo3BUcXvtGJKj56d766ad7A3L
        YnZnfvSWx1QYKh2I0vJWL4FK6cD6i+8=
X-Google-Smtp-Source: ABdhPJzcWoSckMiY7nRgC8xcCbxR3dQJvh3W0bWx8zv+l/+931jsTVs9fNfnZOOBQdihKgERAmKQ9Q==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr37623975wrw.21.1636896255491;
        Sun, 14 Nov 2021 05:24:15 -0800 (PST)
Received: from localhost.localdomain (138.23.87.79.rev.sfr.net. [79.87.23.138])
        by smtp.gmail.com with ESMTPSA id h7sm10858003wrt.64.2021.11.14.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 05:24:14 -0800 (PST)
From:   Gilles Talis <gilles.talis@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Talis <gilles.talis@gmail.com>
Subject: [PATCH 0/2] iio: humidity: add support for Sensirion SHTC3
Date:   Sun, 14 Nov 2021 14:23:33 +0100
Message-Id: <20211114132335.47651-1-gilles.talis@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and driver for the Sensirion SHTC3 humidity sensor

Gilles Talis (2):
  iio: humidity: Add support for Sensirion SHTC3 sensor
  dt-bindings: trivial-devices: Add Sensirion SHTC3 humidity sensor

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/iio/humidity/Kconfig                  |  11 +
 drivers/iio/humidity/Makefile                 |   1 +
 drivers/iio/humidity/shtc3.c                  | 286 ++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 drivers/iio/humidity/shtc3.c

-- 
2.27.0

