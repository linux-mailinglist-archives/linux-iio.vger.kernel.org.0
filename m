Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB80732FA8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFCMba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 08:31:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36608 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCMba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 08:31:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so8816536wrs.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4X+BKjND003CtQsEu+k+KAJanuZbQYGlrUQr+5ocFpU=;
        b=EvYzUk3KxhoDlmZYNnORhdLGXpQ+RTHVmdf6+Pgdw65nQ3NyQdkrMDkRzuUP1fn+I9
         WPQQZfB9jp3vWgquy9gNfYbRZNQtTpQ8eOVlH/7leSw+/Mq8GG6ttQHxXuew0F3ieBZj
         s/KM8KMnKwW7uYE4TBZviG9FI4iYnLpJ6d86L+IDFVdwQrAQ2f8kI1ZaWKsfFTaY9NL7
         lPX8a/eikBLOIU1F/xpaGauI7oS8uXCU2r1qWq64P6ldvea/KEceaQZv1yEiK/0u6IJq
         EdweNiFBYg9QUNUP1UM69G1dODugi+rNx92C3vtrSrNgy5/80CAtrqlTz0FrNGoVisHY
         QCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4X+BKjND003CtQsEu+k+KAJanuZbQYGlrUQr+5ocFpU=;
        b=aBALWE00uQykB3LuDhDxO9vFdjPSkFzrPJoG5tzROWZqUq7hmY7EAvxuWzo95L3A7w
         qhKi5yChkV3Py0ZuRYJqSKWWp0xxJk1Cl2LHb7BGO/160rz/t58j3xucDrXMAxm/mrEe
         h1pDdUEWBMqfPq4x5E1KSKZRL7204LOGyWkczmQp0P0BTKuGg7cEZokDoG49db9IloFL
         uz68y36Kg9mY5satr+KBgCHPt8piLZMmqxwo2pYsIi6nHN1VKTf8PJ3t4H/nWaSzgP6Y
         7xer7kMTvw6+qVVqw+HGmTXc4N1DmPY3JeYjGVSSfrEmhv3M3Ovh3v+Ys03mT1G9Lhi5
         Ztlg==
X-Gm-Message-State: APjAAAX6VSWApsHJ+06m/wnEUBfUZGcMiFwmCsP/Yv2JpF6s30/WhaMs
        SEkjyGzdhu3wDclBr6rSAcgGAQ==
X-Google-Smtp-Source: APXvYqw81sDtsOxKKZ85mVia8pbhoEesE471jLmJbbheZK0UTWnVYLHf4UriX72xynwRi7y/P0FgxA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr15983765wrp.133.1559565089078;
        Mon, 03 Jun 2019 05:31:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id i12sm10373956wrs.43.2019.06.03.05.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:31:28 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:31:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] mfd: cros_ec: Register cros_ec_lid_angle driver
 when presented
Message-ID: <20190603123126.GL4797@dell>
References: <20190517233856.155793-1-gwendal@chromium.org>
 <20190517233856.155793-2-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517233856.155793-2-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019, Gwendal Grignou wrote:

> Register driver when EC indicates has precise lid angle calculation code
> running.
> Fix incorrect extra resource allocation in cros_ec_sensors_register().
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v7:
> - Split patch in two: This is the MFD section.
> 
>  drivers/mfd/cros_ec_dev.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
