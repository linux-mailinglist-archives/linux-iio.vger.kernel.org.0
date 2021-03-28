Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75234BF6B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC1VqB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhC1Vpn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 17:45:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52902C061756;
        Sun, 28 Mar 2021 14:45:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g20so10762532qkk.1;
        Sun, 28 Mar 2021 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=52ImhcdTd2k+4hTCfqpJsMxZgo5rg074rlAi91ivBRA=;
        b=GKUnA4BSCyMMO7zzJQEnlyrOBCUr8sKg7b1JXpHOdt84If/u+HJdsU7J3Ry0o0Ep3e
         cqvD4OmrYFwaFLZRlXMaiFyljDz4V40MVUbDB6Wkl8XtvhCldkujbCpIKKTPxU1Il7Bn
         f5A0NnUUIKkM1K2BMokhcIB9W+9O+0ebL7mYngCY1v5J60j9LREMhsmXuzZGzqsDew+L
         Ab7vpX9LtzJ96BZ2t11ZNXzGqIvVBdIAFGAEb3cdYNepE8Xr02JONtyfZx2BKCEgcEUB
         ckdpcAitchy5mNGy1arSVx677c3XiWPcbxVyn1ZTPFJsLLsCRHPtE6s1jr9ZH+piHoxF
         Owyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=52ImhcdTd2k+4hTCfqpJsMxZgo5rg074rlAi91ivBRA=;
        b=Jmv/6o2TP3DnIy3U8Ph23z52Kjn+4XOsSS/rfax9Cdk1Y4apQIEbj4x2fbciTBc9cx
         uaYa9GPWacR3XVQ4//ByCdFwGmbbDm5yHeKTYYmDMG6bxWy7Dqz7CU2vRsYIUcaL0V2i
         LAEO3vr385CEnOv96vOQgejQV20oomS0nBOUzlgdSl/GWL0iv0mfrIgRZSE3IREiwGEe
         UOOl4orRL+pSGOEjTd+YrRYV0j1DHgMaTtxf3h0KP+IsxsdvjGfoAInK+MYqCXKHRaEQ
         MOi6iVOIhSINakKMTR14pXPrPLHH1fhGH6gZ+uwzcGV4Pjn0Hgd74mZ7N1nVBg+x4v1n
         IZxg==
X-Gm-Message-State: AOAM533Jl50kZTxxCr6z3L8VW6sd12CugNnByTjHSQElDvz5qTc/YT/A
        QYPGTl+1lVFQAUAUhOoKBWL+beMyCk4vEMF+
X-Google-Smtp-Source: ABdhPJy/gj8ITUcERNrLlmeRSo7xZP57XCr0juEQZIr6S572APDx3NOVNK+nQrTJpzRzKi/aWo8iSw==
X-Received: by 2002:a05:620a:55a:: with SMTP id o26mr22846782qko.43.1616967942466;
        Sun, 28 Mar 2021 14:45:42 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9e91::1002])
        by smtp.gmail.com with ESMTPSA id c17sm3726960qtd.71.2021.03.28.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 14:45:42 -0700 (PDT)
Date:   Sun, 28 Mar 2021 18:45:39 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad7923: convert driver resources routines to
 device-managed counterparts
Message-ID: <cover.1616966903.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Following the initiative proposed by Alexandru, this patch series aims
to convert the ad7923 to use only device-managed routines.

Part of the driver was already using devm_ functions, so it was possible
to convert the remainder of it without much hassle.

With that, the deregistration function was no longer necessary and could
be entirely removed from the driver.

Lucas Stankus (3):
  iio: adc: ad7923: use devm_add_action_or_reset for regulator disable
  iio: adc: ad7923: use device-managed function for triggered buffer
  iio: adc: ad7923: register device with devm_iio_device_register

 drivers/iio/adc/ad7923.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

-- 
2.31.0

