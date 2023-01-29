Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1067FF62
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 14:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjA2NiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 08:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2NiQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 08:38:16 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB7F13505
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so25054553ejc.4
        for <linux-iio@vger.kernel.org>; Sun, 29 Jan 2023 05:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvyZHr88nsPGqfqx7PDcpEDGTJKWRojRhvQx//Ct4GI=;
        b=S+h62Eu3naR7Z7+cqtELO2WhQ6QVwe4geOpHlC58qyJ6zMlqUi/RVbXAPsIzuGhASC
         3FW7nmf2aukHWLaWQLqZgg4JdrbNdRWArGcGHRIV+nuqn+21ZFMoZNO870uPA675FSYh
         c+FeKgxIrp4t1GimBHJ7zycgfNxMcjlwOwMiz4ssucw0OwQ6YLC7NMFhPzuoLjYw7FQs
         ck4yIwIei4HYy6w7JQVodL7ZITENRXJWFAYTpCMo1zvFOM4wVwVeeMmPkqiXLqqQjoYV
         9uPIVnz6ARRx6GJ/3O2lVSsOCAD69ckkN4V9PnyIsjbVZJ/s4L1Qe91PKny1WeY8hXUH
         eHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvyZHr88nsPGqfqx7PDcpEDGTJKWRojRhvQx//Ct4GI=;
        b=UMXwLaWIsbxJbfKpm7/0Vb3AT64xHeTnnqUlbTpOP5leu0QJuTH7W9dWqBN7VD8pMt
         yAA3gvSUMxy0xIcEsv1ZegUYoPboluw/0lysaJEJijiUY6aXTALXz0nFh8dIF8ZZZYGp
         FzAcVhauPtDHUAoS6sKBiCg0ePp0DYBJcG6AlUOFAfsBC0pR/Uj0u/Gw9F64mZtCqZ5h
         5AXd3WFkbx5qHi0lmPQl8jMjyK/UkV/GeDLK8oeQ3K+l5mV+NxIEvrHd5aLAKqX+HQe5
         PhmY2JaiEUU5oYVo+xFYMWP+SoaKA6Qoth333dA53kFadHTjNmMW9i8FO/1yuUKrx4n9
         E9Fg==
X-Gm-Message-State: AO0yUKUtsHky5+5tt3Yqf2wVXn1ow/O4oc2NZKE+7sz3QpHvyW0ichBK
        guNgOiDg8I4+gu/nQp74WQk=
X-Google-Smtp-Source: AK7set8JagvWLux/jX/9i5Y8svZubvXumYkL+A3AXeHuo97WZ+iQGeyrsTQmhf/RoEN9thtNxZ5HeQ==
X-Received: by 2002:a17:907:9626:b0:879:36b4:486 with SMTP id gb38-20020a170907962600b0087936b40486mr12634302ejc.13.1674999493933;
        Sun, 29 Jan 2023 05:38:13 -0800 (PST)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::c406])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906474400b00856ad9108e7sm5371018ejs.70.2023.01.29.05.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 05:38:13 -0800 (PST)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 0/2] iio: accel: kionix-kx022a: Minor fixes
Date:   Sun, 29 Jan 2023 14:37:44 +0100
Message-Id: <cover.1674996464.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Two minor fixes. Swap the setting of rd_table and wr_table and remove
the g_range member. 

Matti, I thought about defining an unsigned int array for the 4 possible
g ranges, setting a g_range initial value in the probe function and 
updating it in the write_raw callback (case IIO_CHAN_INFO_SCALE) but 
does it make sense to keep track of the g_range value ?

Mehdi Djait (2):
  iio: accel: kionix-kx022a: Fix the setting of regmap_config rd_table
    and wr_table
  iio: accel: kionix-kx022a: Remove the unused member g_range

 drivers/iio/accel/kionix-kx022a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.30.2

