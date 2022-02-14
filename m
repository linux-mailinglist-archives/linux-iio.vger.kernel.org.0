Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529524B514C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiBNNPz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 08:15:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353988AbiBNNPz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 08:15:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1684EF4A
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 05:15:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id p9so6253116wra.12
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/Lq/lzy3moYZH2sLB81EpzaYjHt5rNYfyYSNXBtmEmE=;
        b=SZgHORC9poZYsXAZpb8oIVDkwwTFLiENskTVwzzzRAAqoPNyum097EWG09HMAStzdm
         a09iy+BfXsbPmlCVSYdarsISxlyjz5D6V4KL+7bvGJTVc6D7RYyhQECQZK3Cqt+93TRt
         CpuieqU0IfhBCvQQYi+3onZI32fAh0mBQYELjj9YWkw50wceFm8wHET0tXzSgDnRv5wA
         GvPGCYF9GC/nLIZWVdqKoIkxgHynMnpa5fmdOGt/vizSoYQugtqETESOPD4vq87ZKJkL
         RHUVBrL4JWKtnHApAaq1sD7mYVFeP5qKH907Gyz13/eaQkIjaVCqkC0u7xUvfIbzbnjl
         xteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Lq/lzy3moYZH2sLB81EpzaYjHt5rNYfyYSNXBtmEmE=;
        b=V/u5Tgmr07L+jX4nkwuPL2p0UfBKhDYC7zElX1y0iN04tU5UC8++2AIjbt5oKV1p9a
         HlpCChYpmtJCcxEVlfCf52sZTD+z9/OeFJcXijR9otPSNL9pdWZSOuxZSUDrMb8W/I6J
         2Q2nP/C9pT25LL5YGTiziGGI+2C21xjEWtMImnx/UPYhrbz8RbuJsN+V20UaBM+6X5LT
         EuPf2UlvRAOLnxWZzqc640HWUjKFRrTVmnM+cE4zJvp42GV4SuTuT0CDw/qHuAkiBWo8
         Rk+sBl9F8AzU/j9+lr5gHD13TDh30RdxeEuRDSvisDlLNENC42JKlo5Zj98X0tOCvKE8
         n6UA==
X-Gm-Message-State: AOAM533jC61P3mR/1rcOudkNp3LDqnsqo+t789HBf5kwgCKXm9e3gDfm
        IF1nIrTqFBRJxyQQcvHyqOA10Q==
X-Google-Smtp-Source: ABdhPJyHdciGnPos9zWK6ZTQa0SZONhNgOBJVAtjyaODMTF+/JHA20UyOFNCYXg74t4vjjeveIN+OA==
X-Received: by 2002:adf:e683:: with SMTP id r3mr11266129wrm.512.1644844546160;
        Mon, 14 Feb 2022 05:15:46 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r12sm6311084wmq.33.2022.02.14.05.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:15:45 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:15:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Azoteq IQS620A(T) V3
Message-ID: <YgpV/0r9DmxmvsVN@google.com>
References: <20220123190106.80591-1-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220123190106.80591-1-jeff@labundy.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-iio-v5.18

for you to fetch changes up to 9e444dbf278c604110762b25d8e0b4e9f1d27dbc:

  iio: temperature: iqs620at-temp: Add support for V3 silicon (2022-02-14 13:07:33 +0000)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v5.18 merge window

----------------------------------------------------------------
Jeff LaBundy (2):
      mfd: iqs62x: Provide device revision to sub-devices
      iio: temperature: iqs620at-temp: Add support for V3 silicon

 drivers/iio/temperature/iqs620at-temp.c | 4 +++-
 drivers/mfd/iqs62x.c                    | 6 +++---
 include/linux/mfd/iqs62x.h              | 7 +++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
