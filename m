Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5937B05A
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEKUzb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUzb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 16:55:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5AC061574;
        Tue, 11 May 2021 13:54:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id v4so6892292qtp.1;
        Tue, 11 May 2021 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AgQ2n9+6IeoVaWhLZCiArb6AeGJGZzOWQRj/aOD3WEo=;
        b=tI8lM54Ig4ZEpd1yVxTqNQjEdAZ/Ew5lU8A5S6uPMke+7+KqWhNhJ3aInBN78lfoVU
         rDweYDB2VrTUBJDyFrgenM+E0exe4vjN/5GahDOtsabouUTukm5LeEU+9zuUb1EJdl2Z
         7/onCUq0aoe6fAYQkHXhK9AOYhqg4f5kuKCK0DBc/LSruU5a110n2MeXwyS9Dr7MXCfa
         XrOiV25he75aevKQGLM3f9fEd/lK1j+45MFX5MWUUmxBzLxxROidIdWaBS3iay2/XEEa
         dmC4qqTs5dE0ot0p+9tSUOlXx379iFinl+b/PbQAHN85qWi5A2sWb6in8g7vQGHvkl2j
         +Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AgQ2n9+6IeoVaWhLZCiArb6AeGJGZzOWQRj/aOD3WEo=;
        b=jQ+0Ee8Es5qkJ2WqFdOPoi/vg9JH1E8I0AlPgefhDKiZvOTz8V1ikk13tkWMaehJxF
         +u2Ztyv9kBE9zoO/CwzRTH9H7Im/SKI5TRm9D7FPG4p2TKGYaBBOhXDdxqY5YrLJyu+V
         8+nQhJLWGMj91QUflLF5Tpg9xEXRixi5nRagq7DrU52W468N4IEuBODlkJOcDRV3Eg9a
         lLKH35xeK/LZK5FpFTmezSBnr2PoBW6mEKerFeZE+evMN34iHXIzuQVnX4JYWPmTzXJN
         99j9j+S8TiCwf2JRETX/zT3VErKVTTd1JK641HtRDMCYoUToHAx6xLFvn+a1guyn88ba
         siIg==
X-Gm-Message-State: AOAM5332vH5nKe2XsnSpKXStZ4d2sqQowsSJNiW6NpCr30I2nmGEVVVP
        eR1tSeEERIA3dVZEK08SefY=
X-Google-Smtp-Source: ABdhPJzrlW5lo/tug8ic0QrjBCgy0r+P3AsCn/10snv0/LkF0zKsxj0+sJb11TkUGkgiCEEiYEZO9g==
X-Received: by 2002:aed:306c:: with SMTP id 99mr29292534qte.352.1620766462799;
        Tue, 11 May 2021 13:54:22 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1002])
        by smtp.gmail.com with ESMTPSA id c20sm16824280qtg.84.2021.05.11.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:54:21 -0700 (PDT)
Date:   Tue, 11 May 2021 17:54:18 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: iio: cdc: ad7746: avoid overwrite of
 num_channels
Message-ID: <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620766020.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AD7745 devices don't have the CIN2 pins and therefore can't handle related
channels. Forcing the number of AD7746 channels may lead to enabling more
channels than what the hardware actually supports.
Avoid num_channels being overwritten after first assignment.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index e03d010b2f4c..9e0da43b2871 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
 		indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
 	else
 		indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
-	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (pdata) {
-- 
2.31.1

