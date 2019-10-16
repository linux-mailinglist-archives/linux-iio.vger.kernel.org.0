Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42245D8D19
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404429AbfJPJ65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 05:58:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJPJ65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 05:58:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so27273219wro.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1JJaHMcbMsbLe6bqOLxOZ4LA46aSJph85+5srfwddWk=;
        b=Z6CtY8IeYv/HalcBoW1F/i9nFOEGtJcyEHLoTrJvOWkIrd7lsT0xGlWgWf/K+rBQaV
         GskTrw0KVuyJnWRsXo1QRtbZrtbEmVXy6hmQjA885Flilf/60H3DwOWlNCKL1TQ+uagD
         +GYutWOKmMVT6l7T3Ssr4pldQBte6lcC3va70H1zg+ozKAgwmuS3qMu9PiqDbWwwgI5D
         WP6dPtAagarekTDLslk9G/w0JGWABtcnhIq/hcg0FuWexqNJyX1OcoTZYdRtV9cQ6HK6
         0xgkHsj9mEqNbHSmxHo2EPWYXe7m90BhUMzXCElEJ/zK2zS13aSNLhU9ywm/T0X8s/oW
         LqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1JJaHMcbMsbLe6bqOLxOZ4LA46aSJph85+5srfwddWk=;
        b=BNAWs3xxCiOod2xETY26uAFSFmpHJMboj1LsnsTa64aepPJFibhLl5onlAPl8tXUiO
         s+3feXVS2rke+ZDa1zdauZpZ13dhMwz+4++u+E9WAX1XN3gD5yIA+KSUZXVu17hGdnSK
         Pnh2Xm60YaVYxDCBd6pGx/eEKuDfc7gTfmN243K6j6XLbps5437o6eWuLoSnBvucUaA9
         G48BZjx5i8C59++f7iAJyTFwt7ki0hcfgMvVv6PgK2c/DO9ydudyjIo6+CJItBixQARQ
         9RrjsGtZli377dhY4aUU3GYXNCcDKjXqw3wKYdU9fM3io418JnmAZy0TYiGy+LaVMwwc
         rn0w==
X-Gm-Message-State: APjAAAVfqS0H/pkcS2aquRyG7v2O9pts0YyhdyjBgSV4a5LJp+182RYv
        itGlG8MNJ0XWT7/yfr4/D+ddODltmBo=
X-Google-Smtp-Source: APXvYqzgKc4cNaPan7mRsJhVE2PgVKuFZ0jCy08TlGBE7OnPIIcloQPqzJoWdX2wrupcxjGbazR3lw==
X-Received: by 2002:adf:e403:: with SMTP id g3mr1789093wrm.294.1571219935315;
        Wed, 16 Oct 2019 02:58:55 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id w125sm3964759wmg.32.2019.10.16.02.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 02:58:54 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:58:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mfd: twl: endian fixups in i2c write and read wrappers.
Message-ID: <20191016095853.GE4365@dell>
References: <20191013093015.1395332-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191013093015.1395332-1-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019, jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use a local variable to ensure correct endian types for
> intermediate results.
> 
> Identified by sparse when building the IIO driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/twl.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
