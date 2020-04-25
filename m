Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE51B842D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 09:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYHZb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYHZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 03:25:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29386C09B049
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so9592129lfo.8
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYXnpIGxuv/FeafLgsgJQGCVqUTf9hqimJXTy/xqVGc=;
        b=sjE9PDH9paPyHU2K+nWms7OS7d95ojonI4UfGGwkFKnOJhqc1fAYMobZDW6z2k817R
         rDL2HdJpzJinfOiCKBUokdVtg/4AHULr3WuFA8mlzizpTAQ+1XiNjMCdpHLSCEp8JdTu
         uAfYMi+kxrAYTcZl46aB27/hcFxRv5Yk8yMUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYXnpIGxuv/FeafLgsgJQGCVqUTf9hqimJXTy/xqVGc=;
        b=B1RGL9UMh8Lld+iQR4xGcZFt8P+94ShKOgk7VikcGvnqouOayNiY29u9UbqDvTrKIp
         mPQqQjP37xJnZA95F5cVtUw97N87ApgeXMdE6TkyCa3dw0y+kkTrU/s81G7FlaVezoWv
         /B4ReLv2dAZba7Wff0jn2vChKoScsKkRm2+AJjJPWBIRjyX0zCqg80UF+wy4/XoRlQzj
         2dYPsSzwmXtBhf4YcNNsq/HC6ibB7r1JCWcXOMyKnItxxMkY9Y5gGy1OtwHgbXDcpBE4
         xrHxSNTOA3Z/0wBC4mwjaYBzbjN4X1A2TfCx3ofPg6DdoPRQlrYuHkXiRvanYxpMUW8c
         DKKg==
X-Gm-Message-State: AGi0PuaWyxGR88mEvABy1QTuFWn0hGSW12SuuvcvbxpcTdbPW03CFwQM
        /mBQPQNlM9U7MWpKvQpihRONAjdJ9iW0Mg==
X-Google-Smtp-Source: APiQypK5TzHpqqfW93eBXaYktt7aLsoGnJvmH7iIo2WcAGnLIvTr1ULdxxnIHvhgiquJoeHzFC4K8g==
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr8641040lfo.69.1587799527382;
        Sat, 25 Apr 2020 00:25:27 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id t8sm6382662lfe.31.2020.04.25.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 00:25:26 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 0/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sat, 25 Apr 2020 10:25:18 +0300
Message-Id: <20200425072520.27776-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes from v1:
* fix borked patchset

Changes from v2:
* add missing IIO_CHAN_INFO_PROCESSED fall-through in .read_raw
* confirmed the temperature value is a signed long from Atlas

Matt Ranostay (2):
  dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
  iio: chemical: atlas-sensor: add RTD-SM module support

 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 ++
 drivers/iio/chemical/atlas-sensor.c           | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.20.1

