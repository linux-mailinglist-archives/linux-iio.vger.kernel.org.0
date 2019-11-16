Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5CFF596
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfKPUuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 15:50:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33328 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfKPUuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Nov 2019 15:50:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id y39so15238707qty.0;
        Sat, 16 Nov 2019 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IgR9yFlnkTLp2xXRay8i5nzS1cYkIa5/QSxH05dSlL0=;
        b=juUv8+t1CWRILYNBB5Fz5/VRKcZaRnyzIrsi3B4aVrl4+jCRyeM/ZnJYXeUqJPOn+k
         AAsqNvjC2UkNcL4gGkIbMxAHPbUvYyX5aeQyC4S0Ewz4xgn82IY9cXNpXKCzDGip/2eb
         H3OJCQ7vfq3sLbewDurmUKfQ//e6grKxTr3oV108zAacEl5OT8e6mOaR8Kh323UBxTuw
         kr1tfFaiSgb+A50n/8gbzrvaXXEBJU3ptcmfYsB/rqvVAnmCTI/flXow+GrLRr7fG0z1
         J/bTSzHgVd38Hl5ymqgxkX1sD75tQOKNNZJUCZFRFBQTkZGAm45iUvDG6FSgx7zMOqbt
         hpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IgR9yFlnkTLp2xXRay8i5nzS1cYkIa5/QSxH05dSlL0=;
        b=X1Sy0NmFui31kX05l4ZEgTvXUdyS1Hev9bApp50yRF2df1mFUazRJYyL3pMpK9hG0n
         nhf7+nGbr8RJ0sceOALYm4FAPY7dTDADqFxrGEDJYRX4m18VQQVygLUD1McKDewuBY6x
         o51heOit1jypHn6um+ejFtBwa4UZ9Kwg+3LPNxj8zmpQ4+oiMZV8Cy1cCmBQoKZ2v7QX
         d6/fgLgBwpXjnqKfO05Gds9FBHRMShlBA6dKAQiqJhp9uYkQYx9i/hpfdmg0cFYx1RsF
         z4eKsBTZu77qJz4Xlp89KwgYUD30+rA83SXCMaW1e3uQsnfcwpTPQvJStK5+wSXk10W/
         mQMg==
X-Gm-Message-State: APjAAAVNqFkbgkKFhr9UsBhqP0AohV8ZD9nD3Y0DhDfGNMhOVnR6zKAu
        rXKKoquovdtXOtiSuNAotVg=
X-Google-Smtp-Source: APXvYqxQM0WInjnJ/eVmD8Bz8e0hfDGxTooPflY7Hfz3KHFu1WROasjqDKOBroco3HFuM9aSEtS7yQ==
X-Received: by 2002:aed:3baf:: with SMTP id r44mr20358974qte.30.1573937433338;
        Sat, 16 Nov 2019 12:50:33 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n55sm7416978qta.24.2019.11.16.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 12:50:32 -0800 (PST)
Date:   Sat, 16 Nov 2019 17:50:29 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad7292: Update SPDX identifier
Message-ID: <20191116205026.dvlevawj5obq7weh@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update SPDX identifier to the preferred dual GPL-2.0 OR BSD-2-Clause
licensing.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
I split the changes into 2 different patches since they are about
different issues.

 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
index b68be3aaf587..5770f63dd511 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
-- 
2.23.0

