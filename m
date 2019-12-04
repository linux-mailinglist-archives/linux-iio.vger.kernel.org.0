Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABAE112F24
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfLDP7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 10:59:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40151 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfLDP7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 10:59:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id a137so344971qkc.7;
        Wed, 04 Dec 2019 07:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yRIWo7lKKgqJCu/aBUPmRsLV0Wkkk5/DYmont9tq1qI=;
        b=rk5spJZk1saeoY744UNyx+wXqmmNfCrwihWJBMslEhpdRoRXMOEL/weiPQc+ZajJfI
         nIv2riK0GB72szsbYLQZbOdoE3KqvkEO+c9yvtS1s70+mXQ3A/wQoZyYfG6x2zP3AnCk
         k5dwdXNyuRDyTqmI0V7qpvZgwhbZexcldeZEyOdHYqF+J45z00RZD7eZI+UL1lMdWbPV
         Vn4wzxXB84/vPmNHM2qnuUnRcFs/YZLW32es3UCXvBi1zcL3ftsu2c/nmeNEvjrv2o+N
         9Usucm3+1n5m/eJzYWQIEAfRdpwg2QfFyplmuat1byjjOZ1a5PegX7i3fmaWMH4LHGsJ
         ShyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yRIWo7lKKgqJCu/aBUPmRsLV0Wkkk5/DYmont9tq1qI=;
        b=X4Q5kk9bkehYWGbGpxOdaCP8t3eR3A7xibV1HlhmRhDiOtpkayxs9Q83cA3ZhZAqpW
         aASUtyzB73EbuKfIGjzbDd9qg3ancbmHbDmXXaubBYB1E7/yVtA57Ls2AM9styCYhrKa
         6fhcva+Io/9TtS0rRJjaPCLs1E7Og0XZ8QcN3T8uFRym1jUSgN65mSpH0UflICc1UIBI
         qgP9z7uhT1Z5r1laeTv8qGypK1QHJmd01DL4aCXwXlezhhfrLfauE1cn/+3MQgOD2xQM
         k+CgsbN1nILxyqSo8Yt3Xs7d+0ARs+h1cAhIcvrIhX203ZFAzYQzTsxst98XPXW6agnd
         JEBg==
X-Gm-Message-State: APjAAAWpA0A9R6x0kRzJBh1KQYGxVOjgfUCn/8G5GnsuR9yPAOtNUffz
        Altyk/99uoVAa/Fu3qJ0KzA=
X-Google-Smtp-Source: APXvYqw6YVY5BvKuYFjKrTa10B9ON4/0NJEdCx3hp8wekexd4CoYPvPrdFofnV0kKgvQRFItAs68eg==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr3680024qkc.132.1575475172496;
        Wed, 04 Dec 2019 07:59:32 -0800 (PST)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id c16sm4002902qtm.48.2019.12.04.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:31 -0800 (PST)
Date:   Wed, 4 Dec 2019 12:59:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ad7292: fix channel constraint
Message-ID: <20191204155918.5ot4tplceqjeul6a@smtp.gmail.com>
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
Changelog V2
- Shortened the message to make it closer to 50 columns.

 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index b68be3aaf587..18f1032b86f3 100644
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

