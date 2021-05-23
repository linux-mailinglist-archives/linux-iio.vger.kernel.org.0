Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98338DC17
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhEWRNK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhEWRNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:13:09 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA1C061574;
        Sun, 23 May 2021 10:11:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w9so13016145qvi.13;
        Sun, 23 May 2021 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iwxLYsfnHOmvUnEFzHOLUjQtowCkQzZpZ02r9YeM+9E=;
        b=UTiwRr5o5hHzc6dxrDpEuYbJUd/Wxb7c3vNSqseoDKZkAprP0EsinNkPcvEqH/MtRf
         VZ0W4kk/h95ARtaM2DQ+f5Octj0jMZpOh4tfXdbCYNr0AfuCdBMW4eQMPUaGaoJaTVdx
         wuc4TfMTa+CaK82dcKDNctlqL6rCCQfSCCd7HI+sbgr8XvwooRBlEohWrf4OirSDYcgF
         PAs+hGT4LWyX390+W97wSGKcOCEJXJjGu6sbrPLdcUPv/1E2nSAgSle3Q1QFhIplWDd/
         e3E2t2LOUyDauctz8X1umaVVUMo+uaUq3FCM9omM+A1oKlECyu9nRVbvWia/epgJ9t1C
         tpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iwxLYsfnHOmvUnEFzHOLUjQtowCkQzZpZ02r9YeM+9E=;
        b=EuURJoIUkX5guPMQMFxV4ZQdDSAjs+MAkxSq1PsaR6GAM8bWkoKZ6xzEv5GLbrXIE6
         lrHOC5uiym+5O/Ctzr3j/4/hiSPy6RMX2CjjFt6NakOdbn7uNClE7gJEaMUNsUnLNWBe
         6JSb+mynECnyXNOI9YiLTVE38ogLitgFkXS8PUG87SziG1uwCvIuIJ9qrFasrWJ+NF9f
         89XNY7mqCjEXTaNFUcYKrXv7w6rJS+9llh+76fxKsPTFs1mq6lRT3iZbnjrJwsXQvaJr
         LybBw7oAipMhjg2y4oELkffJvYLPO6+xrQ7WFi5F4XDr65I4HL39Y6EOnXPzR0pFz20A
         7kSQ==
X-Gm-Message-State: AOAM532kTB8IwRharrYw3iuB1H3oISd8vtJMaOu2HJyzO8eHmggoQBd1
        k3qeGUugn/fPHHwqV88hYMqWauGCUJki1Q3B
X-Google-Smtp-Source: ABdhPJwAFPIdD87GUgQWCYNEK3Jp1a2Sl2yqNg4wK/kFXmXytCbX+euuNO7ZGj2PbhUYMaW4DrUCiw==
X-Received: by 2002:ad4:57c4:: with SMTP id y4mr25740110qvx.33.1621789900059;
        Sun, 23 May 2021 10:11:40 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id k125sm9221718qkf.53.2021.05.23.10.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:11:39 -0700 (PDT)
Date:   Sun, 23 May 2021 14:11:35 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: iio: cdc: ad7746: initial effort to move out
 of staging
Message-ID: <cover.1621786036.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tidy up driver code by removing vague comments, simplifying probe
return, and extracting capdac register write to a separate function.

These small patches are a starting point for improving the ad7746 driver,
hopefully to a point where it's possible to get it out of staging. I'm
looking up to feedback on what could be improved to accomplish that.

changelog v1 -> v2:
- Dropped num_channels fixup patch (applied from previous series).
- Split general code style patch into several atomic ones.
- New patch to catch capdac write boilerplate into a single function.

Lucas Stankus (3):
  staging: iio: cdc: ad7746: remove ordinary comments
  staging: iio: cdc: ad7746: clean up probe return
  staging: iio: cdc: ad7746: extract capac setup to own function

 drivers/staging/iio/cdc/ad7746.c | 58 +++++++++++++-------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

-- 
2.31.1

