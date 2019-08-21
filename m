Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1CA98592
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 22:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfHUUZV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 16:25:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42879 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfHUUZV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2019 16:25:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so3306362ota.9;
        Wed, 21 Aug 2019 13:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iJg47cQbCHnK8ufMuIHABp/qu3hQILpmFLj0ngT5bIQ=;
        b=bWTZTXAZGy3bVhx8KFAvNenPW8s+HOr51DOPCssSi9WRdxMt1A6CH+rlfNnkl56Xqi
         IFK51wBbQ77eTuyHwOp8dH7L7D8F71mf74G6g7taSCkfQm4nuybPzFCUtYTar0DCsumk
         GIehF38PDAQZxgRCInCYLLr6YXprQYrGAUnDfzREhrNLt6Z7NGXnhNij5J23TqD7im5l
         rYcvDeKdNDDFgVUsih1Etoy97frn4pelcPCrALs92RhTiqWYWSjAGvzNtmq4gXF65sNz
         EMUpPdu2yOXboABL1R5CGNVXY0iRpbc8G1oL4Z6luyeNSGM9KGF0HofBToAHs2cJ1Q6i
         +CBA==
X-Gm-Message-State: APjAAAV1aYIF5U+UwHJLtXjzPXbvVfhSvMqxczmQNOfJKlZdUU4npkFE
        mLewJ4i9k2YDf6gELM1oJQ==
X-Google-Smtp-Source: APXvYqwSwDIjlEYrjfOBpsOH2FMZcHzCO/vFpoXUufv4hyoncemTSLkRaVUBNRzsMdWOmbzBbC0Cmw==
X-Received: by 2002:a9d:1cf:: with SMTP id e73mr26436891ote.38.1566419120376;
        Wed, 21 Aug 2019 13:25:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a66sm7133353oii.15.2019.08.21.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:25:19 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:25:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        paulmck@linux.ibm.com, mchehab+samsung@kernel.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        biabeniamin@outlook.com, Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: Add AD7606B ADC
 documentation
Message-ID: <20190821202519.GA28686@bogus>
References: <20190807133137.11185-1-beniamin.bia@analog.com>
 <20190807133137.11185-4-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807133137.11185-4-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Aug 2019 16:31:37 +0300, Beniamin Bia wrote:
> Documentation for AD7606B Analog to Digital Converter and software
> mode was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v2:
> -nothing changed
> 
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
