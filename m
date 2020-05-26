Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394DC1E326A
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391958AbgEZWYa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 18:24:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36784 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390051AbgEZWYa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 18:24:30 -0400
Received: by mail-io1-f67.google.com with SMTP id y18so3409610iow.3;
        Tue, 26 May 2020 15:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+tWQ04Ezy413BCxEPkyaWDBFIHzDQJRTdPoSP1wkus=;
        b=afpSXc7cYfecOkCLF0rVkDLaqoHg8RaCOvWoAPKbPIT+hrCOz5gm8mhvI0IlfgLsI7
         cdIdHbSJofv2nPyp67e6UONkSpBQuwhqIv8X+Wk0RJFSCNd7lhujXQjOAEc6KjjKuth2
         FND60Q/ftTPjzNUy70Iw6zL0O+RnyPMSX19jxtovEMJvgb6yeCRKKvJBtTqgQeLiRjSe
         dB/LvTGA7ybhRFWub82pSyC51II/zqTL/E4QV7j9UJ2FniSofpIp/0ncg7pGfdcRZdkR
         VAhmDcKiE4b304t4MX2GuHg4pdCXv/SBx63hBM+JPEak0BfbO+jY9p1Tkd93Xe8I/rjV
         KCNA==
X-Gm-Message-State: AOAM531TdGR7ORZWY6VpArknqAGqmGWa7yo4ds2GxDrDdALNqS48Mdf/
        C0K6TTjsM43/1JIBtY6WIEA/UAk=
X-Google-Smtp-Source: ABdhPJxs6wqH9u8vn+Z/jIYH604XOlL8g4F6C/yPbBYo2wCXlkbZFk5Q4dd/j7YdMhjb3QR4GcqTdQ==
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr5630889ioj.176.1590531869094;
        Tue, 26 May 2020 15:24:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r17sm657002ilc.33.2020.05.26.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:24:28 -0700 (PDT)
Received: (nullmailer pid 492521 invoked by uid 1000);
        Tue, 26 May 2020 22:24:27 -0000
Date:   Tue, 26 May 2020 16:24:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v6 1/5] dt-bindings: iio: magnetometer: ak8975: reword
 gpios, add interrupts, fix style
Message-ID: <20200526222427.GA492338@bogus>
References: <20200525151117.32540-1-jonathan.albrieux@gmail.com>
 <20200525151117.32540-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525151117.32540-2-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 17:10:35 +0200, Jonathan Albrieux wrote:
> Reword gpios documentation, add interrupt documentation and fix styles.
> Update example to use interrupts instead of gpios.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt      | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
