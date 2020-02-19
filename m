Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52B16522F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2020 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBSWKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Feb 2020 17:10:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34870 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgBSWKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Feb 2020 17:10:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so25481080oie.2;
        Wed, 19 Feb 2020 14:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPifxSnWiVytnmnOry5j9plvKSEfXsq73O2oS5sU+Js=;
        b=gEjrUvNKA7MkziGR0D5fvWwCSqAC5cAzyscpNHEPqlsOfOBu5CkaSvMdHzYG/3LO0U
         iYYz45n1IHki1NaETmygH3qqolNPh5f24MTBj3y7ItL2GW7W2OvESIRxyKaavz/R9eJe
         cDdOD4gbyZJyFMhHQbpUQkwIut/3jCgAQd5zSXKrNvCp9Uir0S0uGT6sR1BeDW0h6LRK
         e/MvUn8qP2qayJ1JxD+eoSBCaZTd0Coi4kAcQYq7LWGvAKMS2O+6Q5P5CmYokqDr6fkV
         hEO+UUDAE0IaKYuaOJYj5LuFEJqk/04bJMeOs5IjQoJr9G4mjOjTBGW+4ot7pn4yPlOZ
         fR3w==
X-Gm-Message-State: APjAAAUFx47OiinJ2g+yQI6DqbZ7g9bkFHzkJS6amHy38dqqooFgpzk0
        B/Bj6Na7YzkmV+e1afUdiw==
X-Google-Smtp-Source: APXvYqz6yViBC3FzwCHJr3i3wEz0N58oq9KI5qrCf+l/j67npNUQS6xZ9W4Wga3XkrMXh1NSS30xww==
X-Received: by 2002:a05:6808:5d0:: with SMTP id d16mr6085453oij.45.1582150207160;
        Wed, 19 Feb 2020 14:10:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm417195oib.42.2020.02.19.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:10:06 -0800 (PST)
Received: (nullmailer pid 26368 invoked by uid 1000);
        Wed, 19 Feb 2020 22:10:05 -0000
Date:   Wed, 19 Feb 2020 16:10:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: max1363 etc i2c ADC binding
 conversion
Message-ID: <20200219221005.GA22158@bogus>
References: <20200208172312.467454-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208172312.467454-1-jic23@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 08, 2020 at 05:23:12PM +0000, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Split the binding in two to reflect the threshold monitor capabilities
> and hence interrupts vs the more straight forward parts that
> don't have this facility.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/adc/max1363.txt   | 63 ---------------
>  .../bindings/iio/adc/maxim,max1238.yaml       | 76 +++++++++++++++++++
>  .../bindings/iio/adc/maxim,max1363.yaml       | 50 ++++++++++++
>  3 files changed, 126 insertions(+), 63 deletions(-)

> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max1361,

Dangling comma.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      - maxim,max1362
> +      - maxim,max1363
> +      - maxim,max1364

