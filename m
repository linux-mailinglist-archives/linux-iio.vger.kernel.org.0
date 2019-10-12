Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FFD526B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 22:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJLUbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 16:31:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfJLUbV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2019 16:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/sb7daPXmmrV80bJqu1buwZ0sTd9HCj7RCL2luEA9/I=; b=D1FXbIS1Wx7RobTe89idi89Tw
        FuqxZ5NRUbmqLN7PldVQ8K6Hcd9nphCpbe6KepQKXR8jKy1l57Q0qXU5NllgeBRXmxxZ9yWYapEZ1
        cwtImrh9K2dLCRPX9wa84Qyx76uZ+cG3w1Xaif6zx26/ZkvzorJi88RZaHFf//AZjUH5oHL4Q/wcT
        dwRMfh4+HOKMu3kzRw4Q8vARxzELxVdFh2FqGZGU3kDt9j+hGEsTzsZW+FZcrRSsboObsnUM5YWYH
        8ltPjVC9GFghoQ+CkiMdXjzSzlDKiHQ2OM3/EUulFBSDkF+rICB+AYIHVCn55D5XpdyvGXCgTjN5r
        bv0OJiV0Q==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJO2p-0005bN-US; Sat, 12 Oct 2019 20:31:20 +0000
Subject: Re: [PATCH v3 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191012192525.21040-1-dan@dlrobertson.com>
 <20191012192525.21040-3-dan@dlrobertson.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e55c408-acd8-0e8c-38a8-e48406b8bce6@infradead.org>
Date:   Sat, 12 Oct 2019 13:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191012192525.21040-3-dan@dlrobertson.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/12/19 12:25 PM, Dan Robertson wrote:
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  drivers/iio/accel/Kconfig       |  18 +
>  drivers/iio/accel/Makefile      |   2 +
>  drivers/iio/accel/bma400.h      |  80 ++++
>  drivers/iio/accel/bma400_core.c | 788 ++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma400_i2c.c  |  60 +++
>  5 files changed, 948 insertions(+)
>  create mode 100644 drivers/iio/accel/bma400.h
>  create mode 100644 drivers/iio/accel/bma400_core.c
>  create mode 100644 drivers/iio/accel/bma400_i2c.c

No comment other than thank you for ignoring my previous comments.  :(

-- 
~Randy
