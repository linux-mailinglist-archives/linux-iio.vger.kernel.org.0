Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7404E18D384
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCTQFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 12:05:35 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54011 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTQFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 12:05:35 -0400
Received: by mail-wm1-f47.google.com with SMTP id 25so7112456wmk.3;
        Fri, 20 Mar 2020 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpjuwl+LsFZPdKq0vacsPR7/n0kW4CGO5FHuy+8EwdM=;
        b=hhcIS9O7CpkJLc5KzB74NBmfCsS842FVMRZyNBG8Gj6LNj65Nvc2Rm4pdeoZkMGDR4
         T4pyuyz4MuJYt/FvsQRnhwJgHHxbYNX9P/eRtHBsIgAhLzciQvvlWYQ5HloaMrJcUt8O
         VYRF8/TciCRKdJctQ81NdigbFzjP9TIMXH26WocQ/vMZKld+8L022/iepBp9RRWJbGX1
         4wgaSb5nn93oT2SnaYBTqXPiIU8zksVzuSvLyjQnJ+1a+LCD4cCU+SGaXHfmc6Ty2C8T
         WWojJAQVcVVvQPIzz/1EKHESwt4HMIjYJJiVmM2Qb7JtW/v46fad0FkMDRRJhDRXc0I5
         xj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpjuwl+LsFZPdKq0vacsPR7/n0kW4CGO5FHuy+8EwdM=;
        b=Nu8+k+7ad66TkM7nb1GrmjXIGDMIcwwtSYMIq8/9eESR0vrsKevnQstVmcc6LWwfOM
         QK2Jfc8gruq527qSHdevp8eOkoO6Emr7nvyxJhGTl92VmKPTkxDQCOGlyymH1qr2Axov
         582KI6xL/3gkuPsDpiBa2PVYuXAt1YBdVN+Gt9sJgcRTZAHPXCZdXaxAmDZxWhetbl8F
         QMSFWkpBWiKrCilea/WkeSPlFD47tn77roNnbQ6J6rGYIhn07ZqS1D/V1IyRTnjicoVD
         fM6dt2uOsWJQjVqNYTCTCYG59rfiIQ9CHafw2tlOQ4Hgwbbu2nKDKIw+RMSARCLnykD5
         hHJg==
X-Gm-Message-State: ANhLgQ3l4bi5gFI2CS8U19zz6clxIMiFedxAeu8ECVSbPT6IrgK041O9
        U07v6S6QiEyN17ZI6c6dEWWnZ9i6
X-Google-Smtp-Source: ADFU+vuOewXWo9Y/O/veCxWDkWXZ7HxULhDmSbhOEIdUneKtc+2OZ8p2+MDCmuBstnwc1IAHm+c2zw==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr10730693wmc.19.1584720333218;
        Fri, 20 Mar 2020 09:05:33 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id k3sm8348895wro.59.2020.03.20.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:05:32 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH 0/2] iio: dac: ad5770r: dt bindings fixes
Date:   Fri, 20 Mar 2020 18:05:29 +0200
Message-Id: <20200320160531.23732-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This aims to replace use of num property from dt nodes with
reg property both in dt bindings and driver and fix
dt bindings errors.

1. read from fwnode reg property instead of num property

2. replace num property with reg property and fix dt
bindings errors

Alexandru Tachici (2):
  iio: dac: ad5770r: read channel nr from reg
  dt-bindings: iio: dac: AD5570R fix bindings errors

 .../bindings/iio/dac/adi,ad5770r.yaml         | 77 ++++++++++---------
 drivers/iio/dac/ad5770r.c                     |  2 +-
 2 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.20.1

