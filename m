Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF792D4AA3
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgLITk7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 14:40:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42358 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbgLITk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 14:40:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id 11so2546524oty.9;
        Wed, 09 Dec 2020 11:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYc9vJv1oqW+FwOLyX+uGrv6wMqWwT4kKtZYcKQrg8Q=;
        b=kADTVhCvv8B+8Ffwrjv4XBqg9sQw7Rq9V6JYFswAjuNOlBamqZkKBn8q/Ol/Snm3F9
         vOq5flNhMxCbg1EW9Ku7PlqONtgk/sb+nD2t3HDKtu7076pf55zIH232F4PnKGFjBik3
         3AG55aw7F6HH+HoNrD0EbjWVfAloU7dWizCix3NQjuF0H36tdxQ3vwrGXrlP6VpGAxK/
         B7n8RG4oR+swOl0kPrPB4AtCx8l9fGAxvrzBLdZuKIQSLeJumfMUb+h7OFRs0i92/kzT
         McEwaCgV1PaHSHtN/ei8YY7/wnSUAVsBdRE21C/FxFTDNtZ4yFb48JwkFBdWgtfLRQVE
         zsEg==
X-Gm-Message-State: AOAM5319bmiBFmmuSLcjOcxog0/H7G/xx7HTWL1rT04zJDOU/Jz3G356
        6w9g1vobf8gvnMoTsSV2YcEvCDwQbw==
X-Google-Smtp-Source: ABdhPJyNNdo/5u5IPwkbkYV2b1LxUEF/CZtgvSfiSj7Pw00VMP2aGu0GRdCSD7lmCzvGJMuL0ncDog==
X-Received: by 2002:a9d:7851:: with SMTP id c17mr3221347otm.255.1607542817478;
        Wed, 09 Dec 2020 11:40:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h62sm531290oia.9.2020.12.09.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:40:16 -0800 (PST)
Received: (nullmailer pid 820157 invoked by uid 1000);
        Wed, 09 Dec 2020 19:40:14 -0000
Date:   Wed, 9 Dec 2020 13:40:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: magnetometer: bmc150: Document
 regulator supplies
Message-ID: <20201209194014.GA820110@robh.at.kernel.org>
References: <20201202093322.77114-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202093322.77114-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Dec 2020 10:33:19 +0100, Stephan Gerhold wrote:
> BMC150 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Document support for vdd/vddio-supply to implement this.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml           | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
