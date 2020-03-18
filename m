Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155B5189670
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 09:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRIDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 04:03:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46488 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRIDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 04:03:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id y30so13205767pga.13;
        Wed, 18 Mar 2020 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tjztlV5Mv0iMohhZrLS2wOZqAb5HkFjm8+HcL+NmWo=;
        b=cJe+1kTgLZMTksYnnj5t+rRVT6v3V0tkI+kcIX+jzCC69I+XumCDIKjTDGaVgIvq+7
         /PVdZHmhdDUjpeCVlG96aCdMhqpusIA9NrTaUSlIKELvIm8s+tklb/h5NxxoPpIog24k
         kPC0NKz35S9D3t7YxC1igGaOgCsIfgV9IRErOrYjgkOzsGvDnEl5dD3pd48btwJk6MnA
         8ZbVmU1TTnQBdjg3YC7g3onJuDkth3gasKf1mEkr1nRoNqMsyp0OLdO4YAAJojXO41Rt
         KFnDVKwWVKNJzQssdMuKH1DmMnWRVm93dRo+wQf5cVZYc5I/Fkr1h7kUIgwVm2RmS+it
         FNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tjztlV5Mv0iMohhZrLS2wOZqAb5HkFjm8+HcL+NmWo=;
        b=p2/ab+aRhbLK+Td/b5Ny6mc3rYpN7EmPNBMYyrm8qA4qLBJ1NpLSvXK/jC8bjNcXhD
         LnUZ1BlpqPMbsi9GDLiqjL6icFPxhUJfojj8efbdwMUnlYqQPPrNx3rLIxY7u+PTEa/f
         /eET+xeu8RCVEkUaq8pYvCinvSOLa2j4nbGY36Wto/ApZeq/WBjfipq+SVmZtH70Ge9T
         OV06v3A8sLfkBE38pSWV92yVY4QUJ3alAVyRbXx6yM7bgD+Cn4uDK7Wasik1aiIWKB7+
         fP3icZ7nwfg6aQxPmcWkVcppFsb2NDbDG27qmq/HtqXqOK+qFhQoSg/8i7xfAKKu0vDa
         eTlA==
X-Gm-Message-State: ANhLgQ1UzMF8JZEoRGBgC10L92rbWzef2ggt02ptdApsCRTqkF8nr71a
        jnXvdJoIJI+M60Dg6h6u5j8kuqns
X-Google-Smtp-Source: ADFU+vsrLIOON3SE0xGvJYZKl1MCEb0SLtrxPf7VDlXH0VOc1znagOnbAy1D5LKY6d1HOLuqpvyt/w==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr3279575pgc.226.1584518599727;
        Wed, 18 Mar 2020 01:03:19 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id 184sm4969255pgb.52.2020.03.18.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 01:03:19 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nish.malpani25@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: light: tsl2563: Fix checkpatch warnings
Date:   Wed, 18 Mar 2020 13:33:09 +0530
Message-Id: <cover.1584518000.git.nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset cleans up the TSL2563 driver by fixing warnings generated
by checkpatch.pl.

Nishant Malpani (2):
  iio: light: tsl2563: Wrap comment description
  iio: light: tsl2563: Rename macro to fix typo

 drivers/iio/light/tsl2563.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

