Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA83A37B055
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEKUyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 16:54:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44EC061574;
        Tue, 11 May 2021 13:53:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so16049497qkc.5;
        Tue, 11 May 2021 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r8GpdZWOTFpi9O+rI32Nwxa8bsE6E39ijBiAWv0y/n0=;
        b=eHLBb8VtEYa9FAPtg1iUGl/yOgPHSTXs50Dipi0itrbcf7EgwYaB5a56rZgCuT1QCo
         cQXwI7USV/IaMSHamV8oJwr+fy/KwCxq7m7wrVR4Gg+QHpkMFMCI7/VoAzYWDZOEaxCf
         216zz+p8ncAryTRcvRWFtbvMdr33LVjhZdmMzQsAhGVh1P2TsHDSumnXRk/cxSzfgUFS
         Cfwf07Rx5eksiwqaDl1b6HAsaw1sT9nbWuGv9lGCL+1I23c/MF60ABjpc+HJxi4RODi/
         JDHPQSkh2UvJSWoc9kX7Q4VTAFPjBRa90vxVsFb96Wt7BZpcLyFv7KvpMFdBca+44w9R
         Y10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r8GpdZWOTFpi9O+rI32Nwxa8bsE6E39ijBiAWv0y/n0=;
        b=YL8VX0PdjTaT0Hm8zEdkfgguGmkyzk4dJs184LIG8TIJI42EJclXrDGb3f8cMsoMGh
         r/ONiHOmLkVjBImdjsDqGE5ZxCGeGD++tUf+hi85oNY3Gp7HR9fgdvkms+0m4S57qEX7
         wphu4+U6/yZ7vO4WrClfd3daXMJqd2joNGGFwMtP4TlTwvhEmPHLL2h8MZAaLizkL0Gj
         73ln3zfNxhAWVRBV9fa+wNB9FbDHqPqcrX6kdLhDInpZpQumMnvjtTIX4UqtbYaagg55
         EY7t+QDIzGQ5/VC6gsb+jJfwG8+xP1+DtOgPvGJe+IPTPMD+Ax48nrPC6iw+PzpuQWvH
         5nbQ==
X-Gm-Message-State: AOAM531aEsMl/c9OnKTNkK96asRxlz55b1h2qsNFFmw5PXOtG+CVIUdQ
        J1eqoH0N7nMTLwqL+Xs2Fxc=
X-Google-Smtp-Source: ABdhPJyaHVyOgPTYNozxyXu0MHMgueYWTMAaKhF7eXCeAFh2xiWQ6PAZKqh90LDMOYdRWgBuK+Z6DQ==
X-Received: by 2002:a37:648e:: with SMTP id y136mr30027346qkb.391.1620766425619;
        Tue, 11 May 2021 13:53:45 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1002])
        by smtp.gmail.com with ESMTPSA id j6sm15303621qti.4.2021.05.11.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:53:45 -0700 (PDT)
Date:   Tue, 11 May 2021 17:53:41 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: iio: cdc: ad7746: initial effort to move out of
 staging
Message-ID: <cover.1620766020.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cleans up the driver by removing vague comments, fixing code alignment and
refactoring the probe function return. This patch set also contains a small
bug fix when setting the amount of iio channels in AD7745 devices.

These small patches are a starting point for improving the ad7746 driver,
hopefully to a point where it's possible to get it out of staging. I'm
looking up to feedback on what could be improved to accomplish that.

Lucas Stankus (2):
  staging: iio: cdc: clean up driver comments and probe return
  staging: iio: cdc: avoid overwrite of num_channels

 drivers/staging/iio/cdc/ad7746.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

-- 
2.31.1

