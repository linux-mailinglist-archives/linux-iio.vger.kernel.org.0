Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458630C963
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhBBSRJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 13:17:09 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34316 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhBBSPL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 13:15:11 -0500
Received: by mail-oi1-f178.google.com with SMTP id h192so23779190oib.1;
        Tue, 02 Feb 2021 10:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESu9qocOeJ67z2OHdnWOiQklfbvu6intt3N2b/O4T2E=;
        b=hi7Sp6TZ1J54Lup5UcO9GcV+7qFChvzdlp1V6teSJ3bJU/om/vCmrtDZzgZRPj2MnP
         CWHAe+K4xs/GQ4GpTYyZEOBrEpxTAqvYzRa1pJl/a4KPRHgim3M52gJL8t/r+sk66HzM
         4gjmxvNyAOHgBx6kgaeScWDNwcXN1vsPGu5QmWkSPYz+t8fhOD9UQhbQBD4EcjYVUD0A
         CchEIhkINDQn+yhVrcBPT1May55R9kzxKF/bJJKZ5q4W7Ou8bjXRL2kq6POQjppKPVPA
         E1uyLCS27KJ/pM4VO4aaJ/t9yk7l6YsUvqpEvJrvzLz6g1S0G62TZlWiiIdAxwZD2eQl
         Dvcw==
X-Gm-Message-State: AOAM531zS3hPGLjXkV7zTGCfT6TvhrdDrnW3P77Q6zVz23qvQjARpfdU
        XN3kh+OfdU80Rv9VS4Y4lQ1xY1HzKQ==
X-Google-Smtp-Source: ABdhPJy9KzWuD4sI+4nuXCmVu/ITJu+fqI2M2n6z+ZmyhAeAa22PZCmdGMbZ2jZAXV6BfCf8OAforw==
X-Received: by 2002:aca:d908:: with SMTP id q8mr3507672oig.67.1612289669762;
        Tue, 02 Feb 2021 10:14:29 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k20sm4733387otr.34.2021.02.02.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:14:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: dac: Add missing ad5686 compatible strings
Date:   Tue,  2 Feb 2021 12:14:27 -0600
Message-Id: <20210202181427.3934218-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The example uses 'adi,ad5686', but the schema fails to document it. Given
the filename and there is a similar part AD5686, let's just add the
compatible strings including the 'r' variant.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Michael Auchter <michael.auchter@ni.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 8065228e5df8..190919291828 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -19,6 +19,8 @@ properties:
       - adi,ad5338r
       - adi,ad5671r
       - adi,ad5675r
+      - adi,ad5686
+      - adi,ad5686r
       - adi,ad5691r
       - adi,ad5692r
       - adi,ad5693
-- 
2.27.0

