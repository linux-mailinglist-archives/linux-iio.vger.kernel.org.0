Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C65E60CE
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiIVLVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIVLVL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:21:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3EE05CC
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s9so5904788qkg.4
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VXXntc9cd9WEvxBQigYGlhgUQJ3E7EY2ZxJ1FR/IAZ8=;
        b=rTmdhFXgmKmrBm/8+vKx1pOl9wGfcgeLDZ8CEA0jlDaCWMqSVguPZYKalwnniQGL+R
         IIUEzr0DdfkOFVSIAL5i2IsK7lHZxMthi9ZpnPBrDSJGyamXUyOS3BuVtAup45re2YsP
         XP3EwZJLW0znZSoQdI9AnKQ3nwIxJ7W799UYt6WxxTj6oVMBPxwZjuhVf2rfXuuSB+SE
         YB77DymTT+dRabFKYbSva58AJbSbyQm2HIAm3hTO8r/N/QTapKX7DP6gzrbWXpl1wPfr
         4JCq46Bs3Ozd/dmJ2py1GTMbWgcAUfwrbmXvesE5fCheWxW5zTPh4WD3RdEDHT3rVXSc
         PJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VXXntc9cd9WEvxBQigYGlhgUQJ3E7EY2ZxJ1FR/IAZ8=;
        b=Q+i7PNOnRyKy+AYdhH4ZvfGJQWYTeNkj6LNFZa01ig+lrDBfnqQ4Pc+KMfuxo4tcIK
         HGS1om+FrcC0kN+SlRMdf46GUdmqm1I89+JiDKVV2NbW4xcx9ehqtDg7FNHTzBFXkEXV
         ku7tId51gMApNG2mNKefJ+ONg/YVilTwwUbojzfBPW/5T+ZAsazKNAyosC8I4e4xx2MB
         LuKjjvIdLzMsbIOiFusw87DHzZpgPE6V5A83/TAND1/1hd8IAAAW0Q7Xkfa6/UD4uBrh
         QURbXLjQrVZIttj8x38TMuDAgaTIenOaG1S3kXXgLdBeCwXk1w47owv4JQUw3nh9T+gl
         IRAA==
X-Gm-Message-State: ACrzQf2Rcj0IR8B7fqPGwOQ1QtrzLdRrkLXM820y9slfHYp3d6tRG8HD
        lNVVFV9C/dv9dfkPezfmOpTcgIOlGnT/0A==
X-Google-Smtp-Source: AMsMyM72KBjYPDyYEanvh0I9IDqTqipqrjq8aht9wPv1gHw8tw/ch+5R7HAnJZ9qTZvuPQk6Tt+X7g==
X-Received: by 2002:a05:620a:12f1:b0:6ce:3f13:ab31 with SMTP id f17-20020a05620a12f100b006ce3f13ab31mr1583145qkl.299.1663845668082;
        Thu, 22 Sep 2022 04:21:08 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b0035cf31005e2sm3487115qtb.73.2022.09.22.04.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:21:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/2] First set of Counter fixes for 6.0
Date:   Thu, 22 Sep 2022 07:20:55 -0400
Message-Id: <cover.1663844776.git.william.gray@linaro.org>
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

This is the same as the earlier pull request [0] but as a patch series
here instead.

There's nothing particularly special here: just a patch fixing a bug in
104-quad-8, and another realigning some comment blocks.

[0] https://lore.kernel.org/r/YyNWADWgfl1sL10S@ishi/

William Breathitt Gray (2):
  counter: 104-quad-8: Fix skipped IRQ lines during events configuration
  counter: Realign counter_comp comment block to 80 characters

 drivers/counter/104-quad-8.c |  6 +++---
 include/linux/counter.h      | 40 ++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 23 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.3

