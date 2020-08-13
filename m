Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82A243579
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMHxO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgHMHxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 03:53:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C850C061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so3452477edb.12
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMQG+gPDVY3OFt2LOxuYy2xvWRV/+Hl/ipweeI0yGEA=;
        b=I0XV0l07OpHFTazOJDjoA8vG0u0p9cnmSyNO5wcXQ/QL9inGUKmPADU+WcUalfo0FN
         eYNtX08tea3gafGqht3b90rSeph9poJ5ivuYfZaAhf7EVEv5FXjtVD4JcKs+7nX+N2mo
         cOi/RmwUeI5vR0oiuk/liKShssFXFOI/uc93h/12us/96cTzPMbJJBJoQi7UFc8Rh+q/
         JhAAQme0aCgsW90tglMLbE7bcusspPAzpFmdE5FOb9KYC430mLWKmlmE19S/fWbIdivx
         Df7DQ/6Y5SwHu09PviVOpGYwFWyU+/Nv+oQjFNXQ0dYr0JYH9VhIe5PG5sqpj5AfKZHF
         s0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMQG+gPDVY3OFt2LOxuYy2xvWRV/+Hl/ipweeI0yGEA=;
        b=rkcTObVCpaSoUTnE4taOA90HazBFG7PujNEWYP4JPdx7n95wC/X6L8DrLqk1opu28o
         8IOafsN6SAWdKYC1bwy26zexyGhjMdm2iKfAj9uTwJbuiaP2ry4MRmKLNGnDCPJ0Vobf
         /8srhRq0SvHyNYXB7ZaBPOp7JddJphrFwIBp1C/UK+bRLUkCtac/huGQcn5zvmWFKdpF
         80cEiiN+dQw3iYv2Esvgsx1yGlnrG0puZSTbNcHCVjXY9+kz9RoFymR+ZiJuOM/Z/8jh
         uAsVRN7/ZqRt1WX9sZ30WlPFPRl7urMP2UZw/QniS7VnaydhwpEOZ9wHVqdUevz0bhEM
         UzFQ==
X-Gm-Message-State: AOAM531y1FVXAejF0tQ/OzwbNRcJFmSor5i1uyy0h3DVqAQee817cwfM
        mSfF5gsaqkwrtqmZ7DpoWtSUMw==
X-Google-Smtp-Source: ABdhPJzqHGAZMCVQjzPfnf4zndzNAsrqiDkUQNTYamQYsbpGFmywFa+VGhKv00SKkT7ci+GFRVDxhw==
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr3480450edb.106.1597305191659;
        Thu, 13 Aug 2020 00:53:11 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyw9mz6ybkfgzn4.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:8d0a:592c:7d6d:8770])
        by smtp.gmail.com with ESMTPSA id br25sm3363449ejb.25.2020.08.13.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:53:10 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 0/5] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Thu, 13 Aug 2020 09:51:20 +0200
Message-Id: <20200813075125.4949-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add extended calibration calculations for the new subversion of DSP5.

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
  iio:temperature:mlx90632: Convert polling while loop to do-while
  iio:temperature:mlx90632: Adding extended calibration option
  iio:temperature:mlx90632: Some stylefixing leftovers

 drivers/iio/temperature/mlx90632.c | 301 +++++++++++++++++++++++++----
 1 file changed, 267 insertions(+), 34 deletions(-)

-- 
2.25.1

