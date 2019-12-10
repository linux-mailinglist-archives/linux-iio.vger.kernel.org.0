Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94413118C02
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLJPIS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 10:08:18 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33823 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPIS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 10:08:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id w20so7372386uap.1;
        Tue, 10 Dec 2019 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBjHUSVAs8hfKdce+8zBPIAqnry3MtjxUESKLEs8Jxg=;
        b=VfYQErSmD6H18Q6hbuo/08+HWoNzKrIEqwG99OU4YcqDzo3JKEtD8ruUPvHuUhf/zO
         mMJbXimDn7bmVgHB5NdRMI22fGn1FKRVWUSndIVKUNVaLMv5JyPzQzEv7EXpStbBjes5
         7sxSXbzM6yR6sLXL7zsutLQkqNRlYXGPuzUUJ6QHqz4gmBcnO4eYkv1VoG+DRqApQ1oB
         W0nJl5i2c4QfRvEdbuTGZlXFBJCUCCyuz5vgSZ01KKN/3ngKoSxlr0En1KWulwbGfhBZ
         l8e8k/jQ9RMmWttGiaQoikHPC95nuKM2Nm9K2uniUXVCJp/kUsalytjyke2tzqUTRv7F
         NpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBjHUSVAs8hfKdce+8zBPIAqnry3MtjxUESKLEs8Jxg=;
        b=AIyQ3/Ivsp1DuCZw18pbW/6evc8SsN5B/wD4F4NCQ1Dx6W7R7cuygeOesOIkCqJtvz
         AiSZXGGiefT/kMAh2kK3iFWXi2VPQBSeVa/Lc53F5tIQZOkGQME51sXXRFvFinZJDEAV
         RVcJXzjTojEeBu3sBe+q8QLgQUpnmeoQ+mOZupzUAAeYqbdwqrKGNJPBT0YH8UfJJNve
         UZe70BRHpXnTAFbqGDRj9Yw3ksGdvCsDTHtXbeQ0yT80aS5fnQgg0+be5H0t69e/GFeJ
         ZopRCKIeVDoq6YLmfdiq3CWLuQpoAqG9Mw5VU1WRg91n6Zi2pG9rMw42vuhHJe8bbUAo
         t7uQ==
X-Gm-Message-State: APjAAAVoWQTv+/MbcXkzS+RwPM3p4Q5tBrA9J1av33KhYwmn2jXgPAup
        lH63mtELsiXMO/2aOu+hYx4=
X-Google-Smtp-Source: APXvYqxRgs/6iImNrzKTIpq0txUgN7uEdpnapQeebFfKZTdOyAR1kFu9woj5SuNFg1a1ZxCFMqopdg==
X-Received: by 2002:ab0:5512:: with SMTP id t18mr29749046uaa.128.1575990496608;
        Tue, 10 Dec 2019 07:08:16 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id k45sm1986139uae.9.2019.12.10.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:08:16 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2 0/4] Add support for the ad7908/ad7918/ad7928
Date:   Tue, 10 Dec 2019 12:08:07 -0300
Message-Id: <20191210150811.3429-1-djunho@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support to AD7928 family on the implementation of the
AD7923.

The ad7928 is software compatible with the ad7923.
The ad7908 and ad7918 are the 8 and 10-bit versions of the ad7928.

Change log v1 -> v2
- Split the v1 into 4 commits.
- Removes a buggy line committed unintentionally

Daniel Junho (4):
  iio: adc: ad7923: Remove the unused defines
  iio: adc: ad7923: Fix checkpatch warning
  iio: adc: ad7923: Add of_device_id table
  iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928

 drivers/iio/adc/ad7923.c | 78 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

-- 
2.24.0

