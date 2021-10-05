Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04D421EC4
	for <lists+linux-iio@lfdr.de>; Tue,  5 Oct 2021 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEGQo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 02:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhJEGQo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2021 02:16:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D3C061745;
        Mon,  4 Oct 2021 23:14:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a73so15871317pge.0;
        Mon, 04 Oct 2021 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au1Vrd4vqmeD3zgvwTDIH32GDjUt+PEXRkVst82OMZU=;
        b=CDeLehxSRpNRSNV9p8WMPJcprhnk0tJVsyBiEQTVoFplEK1fJ6KOMo1qYGba8jDS8N
         OTNP8EnW2+/JMCRehbe1oXpNlsgfXSmR8h3iON5OnBM/c5fcwx8G91kpT8xsi/ug7F3k
         qdQpLzZybvwtSJs1mRrR33un6gPBbajcDuDghuXjL0nh4nG86x8k7jHMd23IitPg4K6R
         xr1BJptNilxGm6KgSDhORaABFPKuSO6HDprHqQIipVuNofv5vIjNbtnmx/cbwMAhdyhO
         x/FCDDjn3xP0lgi6uANVVZ1LdwQ6U0MafdMAyCfYvNfnmL6tOoJUCXUV8pTbFjqyA6MH
         J+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au1Vrd4vqmeD3zgvwTDIH32GDjUt+PEXRkVst82OMZU=;
        b=boU67RgMMKJ1tXE1zBAzo+CVddRn200FQ1L9byFGt/c4ZZ7LqlwV+m6jz32F5s+Ufg
         D8EM4CeMuHuAL2FRMF7jH8nnqtxCdcW0OPzYd1S93dUIVsAKjC6Ss0vfAiwPb2ruUrY5
         nGtc3nrbw1nZc9DkclWpsKoRG2yk2BZK2BtNchQoHx4+JYKQSg6EA3MGYXm594wT3jdg
         1ELs+u971Ui57XMiobIqXe5i3r//IIShgGQK24x8GLLyRJHcJiZG4LKGfiIu1Btuvogw
         Y+y4pNyIyA7Mnsy5wzuJazmK+fsold15+DWFYI7/UQn+zmI8gEqp4aW9HZKFkF1T65YL
         HW8A==
X-Gm-Message-State: AOAM5304Xu8AuY8mJi/YzLfPbnAAUKtoUl2VzB5AMl800vX9Mses0lkF
        WZzc1W/dUIlgcHDPqsQzdK+znCDQEuKkDw==
X-Google-Smtp-Source: ABdhPJyGcwjbha4Phz6yL0g64hPZVRsZGJFgrvPB8yT8NFurG9QFdj6GhtvsLuw5B8dV7IR1gOXoDA==
X-Received: by 2002:a62:7a4f:0:b0:448:6a41:14bb with SMTP id v76-20020a627a4f000000b004486a4114bbmr28828537pfc.31.1633414493878;
        Mon, 04 Oct 2021 23:14:53 -0700 (PDT)
Received: from localhost.localdomain (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id z124sm16931744pfb.108.2021.10.04.23.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 23:14:53 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] docs: counter: Include counter-chrdev kernel-doc to generic-counter.rst
Date:   Tue,  5 Oct 2021 15:14:37 +0900
Message-Id: <20211005061437.4846-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The counter-chrdev.c file exports the counter_push_event() function.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index ae9d3c2079f1..1b487a331467 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -237,6 +237,9 @@ for defining a counter device.
 .. kernel-doc:: drivers/counter/counter-core.c
    :export:
 
+.. kernel-doc:: drivers/counter/counter-chrdev.c
+   :export:
+
 Driver Implementation
 =====================
 

base-commit: 4c2d124b3c9dade959740e0a842868ca4520cf46
prerequisite-patch-id: afa00fa5e8b34bd71871f41c5542dcfd688d03e0
-- 
2.33.0

