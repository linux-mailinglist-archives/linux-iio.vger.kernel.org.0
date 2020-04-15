Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18C1A8F8D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 02:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392276AbgDOAJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 20:09:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38475 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbgDOAJr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 20:09:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so1665839otl.5;
        Tue, 14 Apr 2020 17:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=an6bZAAya5UFMVN64A13WIP7W1tgVhL6AmvavG0wN9I=;
        b=hwucFLlbpj2T5QmzRGY8Np9g3L/DPcGn24rJ2615LwYhfJnNd+zvovXhJIuzt70DD7
         kv1dJL4uUPH93eYI8Zl3hqBal6qmIjFm+7NDEcNNpWU70x/5khS+RFpGjHIsFmHS3a2R
         FNiQN0AfVQ98QrE3rfWfEvdfdBgQz3neW8wCWBcHgJhJSfqZnjRK9b/aFKqe1qtY0x11
         tKZTFfqMp2VQ2RHRkHcOiwXeXDVKe1xbqVSu+Qf/1lCyW3hxEXnpbivJdeeQkJLa6Wfr
         hPJdrJ/UTONJT5bfxq775pEsDvMeyjoo4JT1K/VicRW0Gkp6Jr4cqJJp21Y+wiAbxRqd
         NSrw==
X-Gm-Message-State: AGi0PuZWlATaxV4Kx19HEBlDv32iIhZaHNb1ghT6XWCs1y64gxyDFCM7
        97FIX1JK9wmO3zidouLEJA==
X-Google-Smtp-Source: APiQypK/zIt8lYl2EV56gNELd6fXPPLg7t8f0BxW64vml85d8mUdZm916anEyGrITFe6sOhlmcIIlw==
X-Received: by 2002:a4a:d258:: with SMTP id e24mr20556711oos.93.1586909386602;
        Tue, 14 Apr 2020 17:09:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm1615962otp.3.2020.04.14.17.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:09:46 -0700 (PDT)
Received: (nullmailer pid 24234 invoked by uid 1000);
        Wed, 15 Apr 2020 00:09:45 -0000
Date:   Tue, 14 Apr 2020 19:09:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nick Reitemeyer <nick.reitemeyer@web.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] dt-bindings: magnetometer: ak8974: Add Alps
 hscdtd008a
Message-ID: <20200415000945.GA24169@bogus>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
 <20200406141350.162036-2-nick.reitemeyer@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406141350.162036-2-nick.reitemeyer@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Apr 2020 16:13:51 +0200, Nick Reitemeyer wrote:
> 
> Add binding documentation for the Alps HSCDTD008A, which is similar
> to the ak8974.
> 
> Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
> ---
>  Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
