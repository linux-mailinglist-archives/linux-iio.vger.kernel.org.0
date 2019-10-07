Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC3CDED9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJGKKy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:10:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43260 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfJGKKx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:10:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id i32so607083pgl.10
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2019 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XO1tUWwVg3ldpvvlr197QyBHXOPBJs+Oz3B5tCIDh7E=;
        b=z32D50XwrbQhoMs5ZlCwo6nkE3o2ABiqql4DpVNn93SVGIxKiBRu2bX3xhk6VLxzj0
         0L2ofFTziab40NeP8sLgVezl0TJJ+PW9E8mJcJsKRWZjippsF+DSNYmQ5xs20yRWAbcE
         mCRkN31mP6Xk5ZsB3SQL2k82fS+NRAnLw1dbjXYWHR2VpzTWCyMeaj75tGi8HPB9wE6z
         eOjzScJt1omj1BhxBAfCbXwCY4HTpcn2z6ImgJPTB/g0VTqlTdLnJnbYVlWfSj2jjYQg
         klO9JOZBDAQeybsbSeI+0t5mS74wXVrtJsmlJZcQVRe9yA1ywDwItK9rx0FrEkoauhbH
         gtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XO1tUWwVg3ldpvvlr197QyBHXOPBJs+Oz3B5tCIDh7E=;
        b=Or+4i5KCkB3BAsiLE2WBh7zEOMUcdilLVvbiQhgD2H0U0KWnleCuy6nVXRcJRYKJs4
         X0PY+cnw6dzrlt3zWJ3eGPnVe69nsNQ823iZHqEmLj5DVHXqEpyvzjNvq9ThjASwN7uT
         DW0vD76MjJsAAuyMql8LlC+TuqCK0XP280el1Uk1+u+ictVOiYfk3eBt5Vs75Zmwh1Zv
         5GsJtUyInqM5mxQN1m54YrGzLfO/zbCAZSUdK1herwSRj2zMZnwAdnfH3kKdWHMQzYn4
         Bubw8FAqS+UT4ClU1QSqhDLRCYsX12Ha+7b81/X2y2817/s0F0Ys3QgadMo8xRlkKrvU
         M9vw==
X-Gm-Message-State: APjAAAUTGaTHXjE6QdvKC1YlJqzeM6vkkwSYP3q0xomi7JkhVs/9YA04
        FLAJUe0aKVKj1+SoQhXpYqg0
X-Google-Smtp-Source: APXvYqwnDB36e9vSf5ng1nGbWTuo/pYuBppzVrHRrTabh7OcBrr9kil8al08FbBTpHhuKA6wPFzfPA==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr33214998pfq.111.1570443053002;
        Mon, 07 Oct 2019 03:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:5b45:54fa:fc3f:2c55:c2df])
        by smtp.gmail.com with ESMTPSA id z4sm17465132pfn.45.2019.10.07.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:10:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add support for ADUX1020 sensor
Date:   Mon,  7 Oct 2019 15:40:25 +0530
Message-Id: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This patchset adds initial IIO driver support for ADUX1020 Photometric
sensor from Analog Devices. This sensor is usable for multiple optical
measurement applications, including gesture control and proximity sensing.

This initial driver includes support for only proximity mode with event
based interrupt. The driver validation has been performed using Shiratech
LTE mezzanine [1] connected to 96Boards Dragonboard410c [2].

Thanks,
Mani

[1] https://www.96boards.org/product/shiratech-lte/
[2] https://www.96boards.org/product/dragonboard410c/

Manivannan Sadhasivam (2):
  dt-bindings: iio: light: Add binding for ADUX1020
  iio: light: Add support for ADUX1020 sensor

 .../bindings/iio/light/adux1020.txt           |  22 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/adux1020.c                  | 783 ++++++++++++++++++
 4 files changed, 817 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.txt
 create mode 100644 drivers/iio/light/adux1020.c

-- 
2.17.1

