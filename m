Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6622B88C
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 23:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGWVWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 17:22:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36907 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 17:22:01 -0400
Received: by mail-io1-f67.google.com with SMTP id v6so7814371iob.4;
        Thu, 23 Jul 2020 14:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8WyRyR+5ME0ih4vjthDBis1NTviZRTP8dfOJg3kKVk=;
        b=Kd9nhHon5BqidyxSaSDjl0I0XrVmlzZf5Dz6Uk8eJFrbvj1zWjbEDn4x3bkdS/W2pa
         pT+eYS/kmj2KV7X02DRp/9iL73brcKiJT1zkZ5UBbCyUBP6yxHhVu8gb3D2lpB2j/Wd3
         nEJIMpgWLb+t83y/3aerVVJQTreSl3fUQPjOcdNfRDW55RJnPCMR6B3JrqF7BP7/jkjB
         C3/6Af634abUzdxjgJpgjs3um1n9vRAhvx4ec/Rny2Xdsz8ldYtZq/PN9zHDl2gEISlw
         1dyVi+vzUCHQtYVAkFdUILB+CPvH+ySwuC+afDaEygh/056fBJLyuqy05WNrCeW1rI4b
         13ww==
X-Gm-Message-State: AOAM532S89L0lj9EAeFUOoiOa6mAR/n2c8UsXZKK+Ta4YANtGyMlY7EB
        XtnBLR1LnqsTwqdG8nANciIrlp3Qgw==
X-Google-Smtp-Source: ABdhPJwZahqu6Exce5BMiIyH8QuA2Cpo2/5lIq9mDk5mfbVQwZHFYXQCpJ9uHnxhNiMuPlb5R+VoIQ==
X-Received: by 2002:a05:6602:2a41:: with SMTP id k1mr7157992iov.23.1595539320922;
        Thu, 23 Jul 2020 14:22:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm2066327ilq.9.2020.07.23.14.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:22:00 -0700 (PDT)
Received: (nullmailer pid 880629 invoked by uid 1000);
        Thu, 23 Jul 2020 21:21:59 -0000
Date:   Thu, 23 Jul 2020 15:21:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: maxim,max11100 yaml conversion
Message-ID: <20200723212159.GA880514@bogus>
References: <20200722171224.989138-1-jic23@kernel.org>
 <20200722171224.989138-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722171224.989138-2-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 18:12:22 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Straight forward conversion for this SPI ADC.
> Added limits on spi-max-frequency from datasheet (0.1 to 4.8MHz)
> 
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/max11100.txt  | 18 -------
>  .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
