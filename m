Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B559FF59A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKPUvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 15:51:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36463 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfKPUvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Nov 2019 15:51:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so15198343qto.3;
        Sat, 16 Nov 2019 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=d20wT0cl7XgbwKLLYIFQXwUjPZkC30E2izyCFJ7mTnY=;
        b=QBIuhlxfj5Ty9/Pg1M7p1H+GFJf8dXW1rgRCfzDqhbyyI1EP/wDXeh5xcM10BAEBNE
         uV5ZZmOcTv2UsQLMOvr1nZEn3j4BuErWw3OLJTQmAdmPjT5Bvdojcv+ENK5zjVgcqu04
         lMmVkgyA7WxoMTQOTx+d4qYUaTGw9v19e36iEoHhN0YUtAb7q00F3Z4hrCmtHaxsf7BN
         aG1Ygd7qGYNMj9CJDLy1wheKzq4YBm/0wi5o3b2MBS/POylCJLfD2TliPNwymBF4RCNC
         ImqOFbarbZFdy97A4Tf+QgZ655Rd/lQuxU3bnJz6LGoR4FUpGPtrKc5PC0p+6nvPe3il
         kCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d20wT0cl7XgbwKLLYIFQXwUjPZkC30E2izyCFJ7mTnY=;
        b=K/BYHjU/3i9cGN+BupkM551jZPaWhWBjZK92THWIi6BODOxEG1ZVhocrUcdJKt957H
         dkyemR6Cj+i5MTuyoEkkWzRbYDsPm2oOwfUdIsr3dNd4mPIaSmw/so7lTOVZMLHDjcYZ
         njTu5StUDOCZe7tGP5q25Ym18jTNDIJgNY449UdMOsLsYf4i40A4aMc7F1I4jDc8BFQO
         BDYmpuyLwJt88bTOuZZf2FOBNo0ek5TdTIAWuxaDd/+gVupDeuY8Zi9ugyf0sH4BQhST
         CgoBO2J2vjkCn8otI3ddZxWpahNH0cg3r3JdPJvkSGBMpZapaeg4QeMtYJA05IcxBh96
         FU3g==
X-Gm-Message-State: APjAAAV0U51OzJt+GifmKTNv1UBv9iMx31S+qzm2jDZ290hxkf0OM+Rd
        PUfg4A1dVoa+Rsrrs1RsIK8=
X-Google-Smtp-Source: APXvYqyIMK5pNhn+/b0UG7IpGqDwo1UGwwZf1w16A//jV2cen+QvGxurE6/H0rN8/YC6Q4+m0J+rCQ==
X-Received: by 2002:ac8:7103:: with SMTP id z3mr20706819qto.387.1573937477031;
        Sat, 16 Nov 2019 12:51:17 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n3sm6999136qtv.17.2019.11.16.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 12:51:16 -0800 (PST)
Date:   Sat, 16 Nov 2019 17:51:13 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/2] dt-bindings: iio: adc: ad7292: fix constraint over
 channel quantity
Message-ID: <20191116205110.vvqkmujecc6u5fvi@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change items property of AD7292 channels to correctly constrain their
quantity.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index 5770f63dd511..e1f6d64bdccd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -53,7 +53,8 @@ patternProperties:
         description: |
           The channel number. It can have up to 8 channels numbered from 0 to 7.
         items:
-          maximum: 7
+          - minimum: 0
+            maximum: 7
 
       diff-channels:
         description: see Documentation/devicetree/bindings/iio/adc/adc.txt
-- 
2.23.0

