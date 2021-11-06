Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298B5446F61
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhKFRmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Nov 2021 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKFRmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Nov 2021 13:42:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC36C061570;
        Sat,  6 Nov 2021 10:39:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q17so967349plr.11;
        Sat, 06 Nov 2021 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdbEfkJBvrbNWet81woueXuFuv+VlrSnI2pi2cLi0Ug=;
        b=OXBEnfk6skoe+xFvFv0S8dVtbqjCMfv4TYDXhXY7olwCaGJdvyPXiD6THilP+4d6+g
         FnVZzWdDZayV4+WKP/VHPSN1/bElqs0hIsRfobMCfSm4+ojIalaZvBXz5R+f/j5EIsWO
         nMQjEYB72dTqqbGyaKu0Uw0C9oNeDpBSwNCe6413lK4k3N9t5dQFuW6ybQ6v4xPNaNPp
         EBkKxmEZLukRZL7sCB74RXh12w6P6GBMF7wCdzekpids/DY4EGPOebhoaC4f8AB33kMP
         vhScy3/OoBjemNOza1yYinJu29roh4WD2NfKbgW0Lsn/HtshhRGnO7gQzv/QUpdaLjtd
         LHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdbEfkJBvrbNWet81woueXuFuv+VlrSnI2pi2cLi0Ug=;
        b=jNIRtGAaKzWRurWHRC1ERvMqVAwGqtFexN/BFS+Gr2x1NNLJR+vrM1AqpJ9XcH/8EQ
         0a3W6ru5mlViYrqSpiCUqRbEjpsiGqpIgZ1ug24SNboTHWalC3nB7ZF6Kqt3YBEWJ0Sj
         lkUCEZBYP9Zbb1S4pQQhjFO8ogjICrwaVT4SJTuo/1OGTab8p7jm14M3siCeMG06QD+U
         Qa4t4mQnSFh/9N8Gf2nsjRLH49aY90Vh5iGijEiXQAU184xbLBCxQPSXbEzLur5mQZQF
         f3+ewSTTDpyB9r1cTcdI97D2Jgq9yoC3oeA9zNDorT1TbRUhLlise0/L0fvvmlcq5yQ3
         lXAw==
X-Gm-Message-State: AOAM530kRN3a01k+d6gqUtwpQMcMkZYA6tEdQ+LFhG6OLLYcnCAfgGNK
        5AP/Pq20AWOYqpcADiev+gg=
X-Google-Smtp-Source: ABdhPJzCxJwNCZAqLz2Q0qb5HWeHDFOD6sgQO9uwlhDSgDSncmbGZI1bWVSlGcZlc26I6etjSC+L9Q==
X-Received: by 2002:a17:90a:4fa1:: with SMTP id q30mr39074480pjh.12.1636220361933;
        Sat, 06 Nov 2021 10:39:21 -0700 (PDT)
Received: from localhost.localdomain ([49.156.65.8])
        by smtp.googlemail.com with ESMTPSA id o185sm4859724pfg.113.2021.11.06.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:39:21 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 0/1] device property: Adding fwnode_irq_get_by_name()
Date:   Sat,  6 Nov 2021 23:09:08 +0530
Message-Id: <20211106173909.34255-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While working on an IIO driver I was told to use of_irq_get_byname() as
the generic version is not available in property.c.
I wish to work on this and have written a function that may work.
I am not sure about its correctness so I am posting this patch early for
review.

Puranjay Mohan (1):
  device property: Add fwnode_irq_get_by_name

 drivers/base/property.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.30.1

