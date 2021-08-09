Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B83E4139
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhHIH7D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhHIH7B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:59:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95EC061796;
        Mon,  9 Aug 2021 00:58:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d1so15509285pll.1;
        Mon, 09 Aug 2021 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kghyyJxSpclsPJ1K6EIJRBwrjxsocrELM9KMy58Xt2s=;
        b=ITInZ4BgwMvW8eXF1//m8DQ0ipmc8TztorVqzBZiH5dorIh8SG/8wqRNn6BjQKyq97
         3LULCewSbJ1LdKcV9CHDUZPWA4R2RYInGkKLpspBoBpQim45TlfJxjriaU93wv3nXTEr
         0k3R+EtXInC59yaAzgvsafyhJMg/38ayjgR9JAMMXxyYGOotoWw7MUpMk7Y2AgUM9FTr
         qkVqkjxnwGfKqV9LvxQPRwo9lDbZlE3i5aPJx6sQWb5QREnlxbxbTdReDB4KyfmelUDw
         xfNcsIbPeuvThgcg8Gw3DIXRSntRg5HDlqZMQUyROUhcKtTu2YqGCkFdyaxsekxPFI7p
         G9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kghyyJxSpclsPJ1K6EIJRBwrjxsocrELM9KMy58Xt2s=;
        b=JPGbnGy/stZBvHBLiBdwonuqNwurnr7T2ruONojvWo67bGJSibb/J/iq8je+q8dR+B
         VvU4zAl4VVygoxnSkdTUQ70EC84pf65OjA2ic/HlKUbpVPxNBOCaq9NFjVZX10JbniAs
         WLyfxuOOZLaJDKZE4eqJI40+MU3mkA8/W2t0K35Xle00cd7cCxbS0n9PPHzj0XT7GhTE
         K0WOjUZtCr7VRG9E1Ceq7MSoqLYfPsyoXQvTn0PSwAofkjyCM6OJ5yELXYeDlnZyJKAK
         20yEn+NlDLZPqCPI3+6yT+vjtOWCVdgzS18yRdEkmIB6yeN7dGjbq40QWWJi2+IABH0I
         YxIQ==
X-Gm-Message-State: AOAM533ee5Ba322CL16xr3JstJh5UhJehxztTalOVwgx2ht7XXc0YbEZ
        vuUG4OBxUerX6C3t5CX6F/w=
X-Google-Smtp-Source: ABdhPJxUTStj8fjjkEKOM7NYeT8SOu1bH4K5hWa1JRC2FyqKUkAO8HFwNB6kz5nVLdUgu3Gu+O1qrg==
X-Received: by 2002:a17:90b:fc5:: with SMTP id gd5mr573685pjb.193.1628495920210;
        Mon, 09 Aug 2021 00:58:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:188:d7b2:ea47:4575:ff46:5465])
        by smtp.googlemail.com with ESMTPSA id b17sm21425112pgl.61.2021.08.09.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 00:58:39 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
Date:   Mon,  9 Aug 2021 13:27:19 +0530
Message-Id: <20210809075745.160042-2-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809075745.160042-1-dmugil2000@gmail.com>
References: <20210809075745.160042-1-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add AD5110, a Nonvolatile Digital Potentiometer into
trivial-devices.yaml.

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8341e9d23c1e..55c8a6ce5057 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -33,6 +33,8 @@ properties:
           - ad,ad7414
             # ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
+            # AD5110 - Nonvolatile Digital Potentiometer
+          - adi,ad5110
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
           - adi,adp5585
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-- 
2.25.1

