Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C181E30DC
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391618AbgEZVCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391593AbgEZVCu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED32C061A0F;
        Tue, 26 May 2020 14:02:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so13184309lfd.7;
        Tue, 26 May 2020 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHKHbTyN3ylvMC+aGrTtOuZ55SQGmQ/6ZcuOSRWhTEY=;
        b=ai74PIuFnMWqP1O0lNzIM6WBtZw27atnzkynbEe+q0ax/kZTBQiO0Ish62iqwNK2Bj
         E1LOskzUCBk7cU4ksNqe82y0JYly3zBnk6Oz5Z9+mMFAQ6eONOdAVupMpiNFWVwGPa+o
         xa1/sXLEoKj+sK3rCr5qcTUVRbOOzKLG3VD9J2ept1c4b9bF+fAzLc8Drn3tnZfxLNf4
         i+kMfYRQzWjx6aTuBejX1KYMOV/DVEv0XrHHyDQVqsIv/8VTwtJm6ulutot6Jy5Pucrh
         zrc4zYteFD/49ig0M1rho+iY8b53Sl35hUS3CkveTl4MQdB3LwKTfmkEB1zJQueSbqvp
         Na8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHKHbTyN3ylvMC+aGrTtOuZ55SQGmQ/6ZcuOSRWhTEY=;
        b=CXhoeKElmLvbaptz6+WtB9gcqFCXAJiof/NBcaxFNvffQePDnzVkMDy7ZTwiqdrsUg
         GcEu5oY/k6DC1+vjvmTSNYMNDEA+d8pOrADUdruPWHLuwZcPMZFnwtRbT+E5C5eGiEhu
         gdI5I5XXlInolEHly9fICH6IRh7aIBSbgZZrlHf+dK5pkJCbH3gvJGmHT4VQ1ms5gyYu
         sKeVTOQUhNbnDWT+dqWKDBbUXQwZNAPDzeEGcQ69uQKqgnNjsnXIAFiNeqbKndIfOswL
         j1eV144e6HtJk+BRgZ037K1gWylcu0KRTS5JnjKsyMaf0crC5jrE4eCXYSURJIoXgLuj
         VfgQ==
X-Gm-Message-State: AOAM531pjaPzJwEJZ9fL0fhNmdTwmf8w3ZTftm0a/KiAl3LqbIL341Yp
        uyG751xMISBmodVPt3AN6v8=
X-Google-Smtp-Source: ABdhPJyN5FFTKIy9wC2jaw1hQm6/RlMhGiwkK+QuE93ZhLUixLU0l7k8VV9Eln5IF/+w5B+whuUKLw==
X-Received: by 2002:a19:8453:: with SMTP id g80mr1401351lfd.167.1590526968106;
        Tue, 26 May 2020 14:02:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:47 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 2/6] iio: dac: ad5380: Constify struct iio_chan_spec_ext_info
Date:   Tue, 26 May 2020 23:02:19 +0200
Message-Id: <20200526210223.1672-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ad5380_ext_info is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  12060    3280     192   15532    3cac drivers/iio/dac/ad5380.o

After:
   text    data     bss     dec     hex filename
  12252    3088     192   15532    3cac drivers/iio/dac/ad5380.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index b37e5675f716..04c74cc1a4ec 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -240,7 +240,7 @@ static const struct iio_info ad5380_info = {
 	.write_raw = ad5380_write_raw,
 };
 
-static struct iio_chan_spec_ext_info ad5380_ext_info[] = {
+static const struct iio_chan_spec_ext_info ad5380_ext_info[] = {
 	{
 		.name = "powerdown",
 		.read = ad5380_read_dac_powerdown,
-- 
2.26.2

