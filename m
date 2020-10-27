Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CE29C9F5
	for <lists+linux-iio@lfdr.de>; Tue, 27 Oct 2020 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411042AbgJ0UO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Oct 2020 16:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1831044AbgJ0UOx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2020 16:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=tF9++WwQg6cQ8ITD7V7/Vt6x+InCx00EmcD89mL3eyc=;
        b=FWO0m/D18wDG98Po7X8MoNT01Fp/aQt1rXKYCNSZZZwGAdgdH2dGQ8+kxQujxdel6FLvyb
        4sPkVRtaybij5DdAalX3/oqOBFfLnBl/C2Cy0lcbzRLi7IDnEFZSRqWZjjnkSLLQnX28RW
        BS7wL3D9iEGQdkx4eNSvaaMIwCnpHlA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-NdgWiw61OiC7rtlaC8zODg-1; Tue, 27 Oct 2020 16:14:50 -0400
X-MC-Unique: NdgWiw61OiC7rtlaC8zODg-1
Received: by mail-oi1-f198.google.com with SMTP id 65so1201125oii.10
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2020 13:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tF9++WwQg6cQ8ITD7V7/Vt6x+InCx00EmcD89mL3eyc=;
        b=S/W5MXztmsJTGkCkoNeIUNQM/5PfZa1VgunpVB7VJgYiAYtT0nTFf1Hsmclu2wQ7OA
         lRpFgLyiSyRc6AhAaTxPI0zg4ftKMTsCv5q9gyo+8kVO6j6i1NkXY49XeIGKpx+pk8QY
         +p0OpR+HvDQHyrjHCz0QkbPrFAKVjzDqG51TS+4QjdFeSoa/FB4L1qD6Qvz+y/GoHru9
         +D4pxSmXg3DMsItRrR724gghn/5UdMLBt5JjoaQXfTaszSG+/35kVDOePC4Q+UYkyV8j
         NpRAsazgJ1PHPbLYX9Na6MWJxnCT9RPqYm2vH5A7HcnZaa0V/klhKtDsjcCcycO2awRH
         p5ng==
X-Gm-Message-State: AOAM531f/r8kS1g4NjUQprhWZFqlkEAjXbCS30kXOKA3Zzan6QYlwGdN
        MXdp3sylV7YopZhvr8MbclRjNy2P7SbjgMaiyJ/TYHQ1e7w1hOeyAd9+en0KL9jWwl7ppD9h8yr
        v7SVWV9cijQLxTBZH75Kq
X-Received: by 2002:aca:47cc:: with SMTP id u195mr2193431oia.83.1603829689603;
        Tue, 27 Oct 2020 13:14:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdPYJAKhiib2dLfRpsridr517hmHhi+755qXgffr1bWQRiifi9uJtbkou/BqGwafFiBmivQg==
X-Received: by 2002:aca:47cc:: with SMTP id u195mr2193418oia.83.1603829689445;
        Tue, 27 Oct 2020 13:14:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 104sm1473139otu.81.2020.10.27.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:14:48 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linus.walleij@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: light: apds9960: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:14:36 -0700
Message-Id: <20201027201436.1597726-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/light/apds9960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 9afb3fcc74e6..547e7f9d6920 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -561,7 +561,7 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
 		}
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1

