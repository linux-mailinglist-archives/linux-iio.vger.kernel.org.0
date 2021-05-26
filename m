Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112A53913EC
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhEZJp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 05:45:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:19383 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhEZJp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 05:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622022265; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fXar1epYPpne9MpJy++t97IHoBGkHrdG8TlVT2DAvmzg/7CsWbegqk2joM5NzbySQ1
    +CPJL09KfcBVQvlHmFsFwVdNEc05evF194Ykh5OJc82ShOqfIyvd74Wtv7vocX0OK5yX
    U0ty62SaXxI/mL+IXWBOFVXzhP2bL4HrFsLi0M7CsGZqwuo/XlAyRdwo+WARQn5mTjEB
    Xx8iCstRN+6eflOLM5p8ZhHo7KY1cOpjpIuJjQz1fhsjnCkcNZ7sA3+AzKIrN4gIQv0u
    LgT1okTtm4gI5DsRitJd0dH4+DbK6nLZFZa1FjDemqNL2DX2kKgvMXOAoQWqZHTwbGi3
    ecoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022265;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xWSdbjBNuaVmrQKNfCq8Fq65NZR6YxUG1Z2YWWiyaa0=;
    b=rvOadQuSFmHq7tlsmyQm5O4PDpV/pnhU6xOiTbMphYArw8p20DWL7ocyNPp+lzw1IX
    Zy2EO7a0/WrERNK+DiDw9SsKs8sAYAoU2Us2YVINI5DW0w/5Q0cIJLr/Zixn8a+9kclj
    hUo3o6Zfb97xj3qVddVP//HNuM1Ag+RPHDY/P4bZUSNriQiTbdsvDOuvUDJtIgHuT4GP
    vnwufHM0yhMOYG5GPPCVr4miE6clHiRP72jZDKebZtYJ5KQfUZleC/c5z/80iEozFWO8
    keu5RgUk9Ssp4VNjVbqJMdalhJ4TTvytx0inwvOYql0LhmrHNW9dBDYBaZGEf3e81yyh
    iqlA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022265;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xWSdbjBNuaVmrQKNfCq8Fq65NZR6YxUG1Z2YWWiyaa0=;
    b=Ter1yHUlH4UO5nMlGFu+scEIb9v+Aj7v0HwiUDhRK5R0GY/gLebiqvdfAnz7wBIL7y
    /87PPHV07s71sThIVVilgV0zU48O7H9ACmuU3qojx7c4WXPWo2jlNAqAiE2c4OpriT94
    KmbfnL3LnnQ3Ni2ELCz8TtwDMoVy/3vufXh1aFDRfOVKkGUCk4QEBF1znsiL7COZA3hL
    QIUAOgc0pO+wU76pEqe5pQLGYc3SCNVcFx1Ql3O+sN/d+NaaCo/I+Kox9bdWK/aemrNd
    ggQgl58UN/vT02J0ZPdXrw8GZjRodCszud+/CpomiPTzIs/gJsoqZOyThykldDWLsmeR
    yl4Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6JG0s="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.2 DYNA|AUTH)
    with ESMTPSA id w02ed1x4Q9iP6KB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 May 2021 11:44:25 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] iio: accel: bma180: Add missing 500 Hz / 1000 Hz bandwidth
Date:   Wed, 26 May 2021 11:44:08 +0200
Message-Id: <20210526094408.34298-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526094408.34298-1-stephan@gerhold.net>
References: <20210526094408.34298-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the BMA253 datasheet [1] and BMA250 datasheet [2] BMA25x
also supports a bandwidth of 500 Hz and 1000 Hz but this was not listed
in the driver for some reason.

Add it to the bw_table to make the driver match the datasheet.

[1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma253-ds000.pdf
[2]: https://datasheet.octopart.com/BMA250-Bosch-datasheet-15540103.pdf

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 81d1e070a2ee..e7c6b3096cb7 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -184,7 +184,7 @@ static int bma023_scale_table[] = { 2452, 4903, 9709, };
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
-static int bma25x_bw_table[] = { 8, 16, 31, 63, 125, 250 }; /* Hz */
+static int bma25x_bw_table[] = { 8, 16, 31, 63, 125, 250, 500, 1000 }; /* Hz */
 static int bma25x_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
 	0, 0, 306458 };
 
-- 
2.31.1

