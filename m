Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004B735A614
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhDISuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 14:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 14:50:12 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C6C061762;
        Fri,  9 Apr 2021 11:49:57 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s2so4945686qtx.10;
        Fri, 09 Apr 2021 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=W/Yva+lieaknSkZKEFwejE4Ku137WP0mlyV8FGttUOY=;
        b=V8VsrF+tjFecTf7SCocG9mdOFPnpVBNz3AWTy3oKFRA50BeHWhgFA1imI0SuNy/x6D
         trlvwlm9mMKWUj+KeRMTaW5zXdRTKjAvIMRi9igkSJd5ZS4R02axxwRu/dHe8BLyXAhq
         eHTgYdYI15/9K59Lc/LbTvNCCBFEiOCAkCb61Of0cYGRPQYNmvqJ3hahBw4ryI4oiotU
         mbntiwg3j9FcoVl7faoLC3PylQ7uIBVWKHvU4gYHC7XhMITKLoYPc04vB7CrYH8EdJ3X
         HlSoHe6yk0yFE2E/8DeJRMKJQqs8fBI7En0OisjrhIBHT5UDg2coKXz8afTnHU4XP2AZ
         W7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=W/Yva+lieaknSkZKEFwejE4Ku137WP0mlyV8FGttUOY=;
        b=TCtyJ/yGf9vIZ6mr379h2dl78I+m5DKs1N/zY+2SAR1E1/pe/bs0ss3s5vAoY9Xace
         mbsjbfakyoFN6xmiw6Vpp/0m1sPkC718idhfL/uw6EdiuY989PZ/H+99lozekj5vQhuC
         dhruhnV6JAWFcopzOlHQ1wIjW8tSob7+6i2AbiX5oE3qwmQozFZ5xzd+VILuyf1MVWj7
         WynY8V7w95965l+GPX5n/Sq4Z+PFUmlXjtd/k21/Jusd+U6QkuzCGkB54cp3QCnL3JJN
         VR7MDWk6SpaiMb9nYqDceJ3Di0W+1oY7x2fgsD1nBxLVONyHZDbn+eZO750r4ADUcHqi
         8m0Q==
X-Gm-Message-State: AOAM532lxh43dDAlc57pKpOHzxJlDMp1mtgGnue0qHC8KVnNf9mGDCXJ
        CFZ7Q5qTehTn1ldLlEnXbbpIIKRaui+5xroG
X-Google-Smtp-Source: ABdhPJyDbvD1+yHwXYLDhGXsuLgzJ1AgAyyUze5eUvFTOpfhHLZnJF4pvLfgegVH+5vQM3oeiFb5HA==
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr13785148qtk.68.1617994197206;
        Fri, 09 Apr 2021 11:49:57 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01:86f3:17eb:e23c:86fd])
        by smtp.gmail.com with ESMTPSA id 8sm2390329qkb.32.2021.04.09.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:49:56 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:49:52 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] staging: iio: cdc: ad7746: remove platform_data in favor
 of device tree bindings
Message-ID: <cover.1617993776.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to replace the platform_struct for the ad7746 driver
in favor of device tree bindings, creating the dt-bindings documentation in
the process.

Since the header file was only used to define the struct and the excitation
level values, it was possible to remove the file entirely.

Lucas Stankus (3):
  dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
    AD7746
  staging: iio: cdc: ad7746: use dt bindings to set the EXCx pins output
  staging: iio: cdc: ad7746: use dt binding to set the excitation level

 .../bindings/iio/cdc/adi,ad7746.yaml          | 79 +++++++++++++++++++
 drivers/staging/iio/cdc/ad7746.c              | 43 +++++-----
 drivers/staging/iio/cdc/ad7746.h              | 28 -------
 3 files changed, 100 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

-- 
2.31.1

