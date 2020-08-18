Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CF24903A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 23:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHRViN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 17:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRViM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 17:38:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5723C061342
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so19602914wrf.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U86mn2kEau7t7AV/3TYAZlozd1Thks5A7onfWqZ6aA=;
        b=gQPTPw1kOMTq/0m65ziy6G1Cps9/UtYrm/rVmzZ/wUkZU4cBvpsixFB17WxZpKW4Xg
         HeyF9wmaQ1Ua+P7/c4z0gpZhsm8b21LX+/gqMgs0yX8DU/a7UwfK8xjUs6il+CGVkIAw
         LQJn5q0botLpXUK5qkqGEfGyhB+DLRnAGx3BHwQGVDDAnouRO1SheZF7P5gEQpaT+wZF
         5pNSReZ26+ZfgdS8o9nzYPa2mTRljxaqBFSxUuVc/uHGfMmTaO42qxC0AnMtykz7MoFz
         kHFcgWkMu7KjnsaUq0MU6m2zX03kIAMPWFU9nS5HszTAVrnfJ+bt6Ln7Bdj7PQ1Ppyvp
         ovrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2U86mn2kEau7t7AV/3TYAZlozd1Thks5A7onfWqZ6aA=;
        b=E9A1koTGufZs0Z2fEb5Ql6xmDZ7XBzSXI3PPr5DBIBsr5/FTDTFgqc0tFfMCV3WlTL
         d+J1JDRLn0h2Wio1LRrPrmMtVL02tKCsdSpbODPbBXmOAyEFxz+NHtyJCKMK8F8djq7d
         ws552F0B+04rnRrtjWxDzbyeW+FIbyMjlPnh0/tjsV6IHHlCooBsa4DpbjzXGac/FEAK
         hE8/HufouOkqmj4uiKmLgn0ZU79fRh5jCnnEw2TMRUHlGP9mAR20GQ6TzzqSk93v5qKU
         M8FBbg37Cc/SUKYz45MKQXxOdUPDbraI6f70nTyib9Gu/mHmnGIIyluUtvhqduUuxkjd
         41Vg==
X-Gm-Message-State: AOAM533BtYHh3SJimxjZ2ZZBKGOP1PuAAePu1p5pgUNcaDDaT/q+z7Cp
        ccNwnhsuj+XSHH8ifZYf/GD/mw==
X-Google-Smtp-Source: ABdhPJz5BjgpVZ8GKUjBMWJAl5KjmdW5nKSfbODZyfNl7vVKL8frQpBLGVl1sRdOgsTEuFOgKTVrZw==
X-Received: by 2002:adf:f248:: with SMTP id b8mr23195251wrp.247.1597786688706;
        Tue, 18 Aug 2020 14:38:08 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:07 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 0/5] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Tue, 18 Aug 2020 23:37:32 +0200
Message-Id: <20200818213737.140613-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add extended calibration calculations for the new subversion of DSP5.

V6 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
	 - Covert all while loops to regmap_read_poll_timeout or
	   read_poll_timeout even though udelay of more than 20ms is used
	   in the second. Problem was, that timeout needs to be 800ms,
	   while polling frequency could be 20ms, but we konw that that
	   will generate more noise on line than needed. Did some tests and
	   current number combination seems best. This also caused that
	   commit messages were adjusted.
V5 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
	 -  Swap order of patches to avoid re-doing the calculations
	 - Add fixed name defines for Ambient and Object RAM temperature
	   channels as per suggestion of the Jonathan Cameron <jic23@kernel.org>
V5:
	 - Add style changes patch along with current series.

V4 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Move the function creation for Ta4 to first patch
	 - Add kernel doc patch for documenting internal struct
	 - Add patch to convert while loops to do-while loops for
	   polling

V3 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Change commit message text to more proper English as per suggestions
	 - Drop unneeded brackets and parentheses
	 - Use defines from limits.h
	 - Remove userspace typedefs as leftovers from porting
	 - Testing of timeout loops with iopoll.h was no successful,
	   because delay between measurements is 10ms, but we need to
	   fill at least 3 channels, so final timeout should be 40ms
	   which is out of scope of usleep function
	 - Fixing some typos in comments

V2 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
	 - Convert divison back to shifts to make it more readable

Crt Mori (5):
  iio:temperature:mlx90632: Reduce number of equal calulcations
  iio:temperature:mlx90632: Add kerneldoc to the internal struct
  iio:temperature:mlx90632: Convert polling while loop to regmap
  iio:temperature:mlx90632: Adding extended calibration option
  iio:temperature:mlx90632: Some stylefixing leftovers

 drivers/iio/temperature/mlx90632.c | 274 ++++++++++++++++++++++++++---
 1 file changed, 247 insertions(+), 27 deletions(-)

-- 
2.25.1

