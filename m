Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FC1E2A27
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgEZSfL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 14:35:11 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:32958 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZSfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 14:35:11 -0400
Received: by mail-il1-f195.google.com with SMTP id y17so19318632ilg.0;
        Tue, 26 May 2020 11:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9N/OIe12zkuEZSWrorLx9oP1Y0GJi2RHq+u7ziPUtAA=;
        b=LePIibVj43b7OMIIduYUgVlPZl3Ngqp4YlH8CRJEUqDbSQfGg0motYHYibmK2UPXJ4
         oWWmEb1VGk43z9GQvtNOkmoTbjJK9tEmICQ8cGToLvSTztcu0bKZ/UqqEryEqZ8Ynzpj
         YCbNm9HpuqJYSbHbk21F8988IdbHkFkFUISMZGUvj0uxmBslVyVKhjbhGrYWqRZ+DsQs
         OI6h/82OyAKUPZ1MvesnRgLIDEdmIx1wyXzgLvpW5aRlddVc715AL5/8629JtW+dv5Rn
         8l3wRzHGaTO4nNVtdquMrvcyyrd/u0LaAzwxwU1LKRiM/Iu2pCFuq8+X8X6QRsC4tQZg
         HhXw==
X-Gm-Message-State: AOAM531UlsgY3maSQW6Y2+BB1U4X/999UohfT05qi28EiIw74A2EzXc4
        G3Trw6t1SCGv9zhhCFf7ckEDOIE=
X-Google-Smtp-Source: ABdhPJxabv7NA0xb/8qehpcN+QTNDVF6DnbjbDWcTnx9mlhcj2fiTgyCxjhsC2d+KUsaHR23pT5e8Q==
X-Received: by 2002:a92:b750:: with SMTP id c16mr2484285ilm.290.1590518110357;
        Tue, 26 May 2020 11:35:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n22sm205962ioh.46.2020.05.26.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:35:09 -0700 (PDT)
Received: (nullmailer pid 139962 invoked by uid 1000);
        Tue, 26 May 2020 18:35:08 -0000
Date:   Tue, 26 May 2020 12:35:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Message-ID: <20200526183508.GA135564@bogus>
References: <5489E47F-47D4-421A-A7EA-E11B0205A842@norphonic.com>
 <3309CDF6-5DED-44E4-972B-6D741ABE541E@norphonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3309CDF6-5DED-44E4-972B-6D741ABE541E@norphonic.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 07:22:54PM +0000, Eugene Zalkonnikov wrote:
> Device tree bindings for HDC2010/HDC2080 driver.

Bindings are for h/w devices, not drivers.

Run 'git log --oneline <path>' and follow convention for $subject lines. 
(Hint: dt-bindings: iio: ...)

> 
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-04-24 17:50:58.213007228 +0200
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

GPL-2.0-only, not or-later please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
> +
> +description: |
> +  Relative humidity and tempereature sensors on I2C bus
> +
> +  Datasheets are available at:
> +    http://www.ti.com/product/HDC2010/datasheet
> +    http://www.ti.com/product/HDC2080/datasheet
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc2010
> +      - ti,hdc2080
> +
> +  vdd-supply:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      humidity@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;

Not documented.

> +      };
> +    };
> 
