Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4941646838
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfFNTnF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 15:43:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36124 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFNTnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 15:43:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so2457223qkl.3;
        Fri, 14 Jun 2019 12:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mp8xTO5oNN7LboeBKHyfl41RYppmWJR4foCIg2c5W1s=;
        b=EknriUybNYqed1WZbFQUVevwq9svztvZ5srHJWTyzGaVziLtsMRxKcU3vTz/pjaW3r
         +35JiogVtbuYw949qB00IoYJTC5u2keANjmtyYjciEFa1k7cEmsAL7PoD/5Q+o5DmQY3
         niBkCA4DC1LbZLHzKhGmprq2Yf4b/7C1D//B4wqObTcY3fVrsicXTbZy1qqSCVff0ak9
         mmjFQXkd8ys2tSecgoZ1ZeFTVN2PU8XEUJMofv3v1A9OPd9Mx9/P8FR+nx77UsapKUkk
         Jxez95537JEhb8QrJu5ylw5OTBrxeidl6XL6++yxIWc1kjEyn1+xuYVtTAxdhczzQ5jB
         KhRw==
X-Gm-Message-State: APjAAAUbCJQ8ttv1ejc9tby4u2YEy/7Pf8Jyy41XN7loUdo2gfKtdf7y
        XZMb4YL75QHUSPzk2uY5ag==
X-Google-Smtp-Source: APXvYqz0aEx4FDJ3gg/LvUzydLqr7NaukJPecyN5OsnEwsUCU0LY+1pAYvSd5Ebr1tqcYxuiJF4DxA==
X-Received: by 2002:ae9:c106:: with SMTP id z6mr57253623qki.285.1560541383979;
        Fri, 14 Jun 2019 12:43:03 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id j141sm2430766qke.28.2019.06.14.12.43.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 12:43:03 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:43:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <20190614194302.GA18613@bogus>
References: <cover.1558746978.git.renatogeh@gmail.com>
 <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 22:26:30 -0300, Renato Lui Geh wrote:
> This patch adds a YAML binding for the Analog Devices AD7780/1 and
> AD7170/1 analog-to-digital converters.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> ---
> Changes in v2:
>  - vref-supply to avdd-supply
>  - remove avdd-supply from required list
>  - include adc block in an spi block
> 
>  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
>  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
>  2 files changed, 87 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
