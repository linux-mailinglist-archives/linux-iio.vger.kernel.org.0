Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38286FBD74
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 02:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKNB3s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 20:29:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46662 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKNB3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 20:29:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id n14so3712194oie.13;
        Wed, 13 Nov 2019 17:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MkSV4WUTTRk3P116snJnQhPSQmUlJUtpb4z80AOnhjY=;
        b=iKQrvc/N4u7wcR5juOFxG9CrDTu4nWyWD/eTZlNc0xKuRayRQiirgWDMDj0edeCxRq
         f7rQN0AHEhw9pdTjCe4M1MCOclmCmaDF/7o4zevBpKR+PYhSqASaS1Mr6ijwIhJat1MP
         WBkpsTWNZkqOcUIKXDWjUMi0xwy8JxxQuy7r05bBn+tTWHJIUWXsaIzs9yid5O8+nYpm
         Ojo6ujW19Okn/PFdXXt1O2VYdbQKREZC5b+l3lH3oHq4wP8OTJgdmGA15feuUdyviRKc
         xMaXJx2yffstWFw1FnOgYOyevJWxFMTiCTaK5R0CKKuLe2F1lKXshE+RVPtU7Ph4MHsC
         wvGw==
X-Gm-Message-State: APjAAAUrFftjja3GTwp02g9SEQuuFB32LcO3rfXUhGUT0iBpKysw0zxI
        PJ/uhmwG/1trVcvYvBt3bg==
X-Google-Smtp-Source: APXvYqwpyD4mHPpEejKvVt/xOEivlwwbnes8oqT+MRV1d6o9XUjRrr0vN32yezmvw2Qp0y5Qw2o3GA==
X-Received: by 2002:aca:b286:: with SMTP id b128mr1421594oif.1.1573694987562;
        Wed, 13 Nov 2019 17:29:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j17sm1328804otk.27.2019.11.13.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:29:47 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        paulmck@linux.ibm.com, mchehab+samsung@kernel.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        biabeniamin@outlook.com, Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v3 3/4] dt-binding: iio: Add documentation for AD7091R5
Message-ID: <20191114012946.GA18103@bogus>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
 <20191107150759.5937-3-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107150759.5937-3-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Nov 2019 17:07:58 +0200, Beniamin Bia wrote:
> Documentation for AD7091R5 ADC was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v3:
> -spdx identifier updated
> -compatible property with lower case
> -additionalProperties added
> -hex value with lower case
> 
>  .../bindings/iio/adc/adi,ad7091r5.yaml        | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
