Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE86918A8CA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCRW7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 18:59:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45458 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRW7S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 18:59:18 -0400
Received: by mail-il1-f196.google.com with SMTP id m9so423616ilq.12;
        Wed, 18 Mar 2020 15:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :content-id:user-agent;
        bh=WG++1Z0XEGF8QjOEAy+cWUTtbp6Q7m3dGXGb9K3xIFE=;
        b=AbZ3qUI/CKmrt/ajVHPiCV45CTqy5HvXZET0G1UgCkxcDUEtLT2kR73/ptZR0g9UnK
         RlZA5Om9Ll1F7iges0dBXqDrreqzzTsiAN4hlINViOjJSfm3uWJz6p9FmIwIPfL1lHLy
         JEUvnOSDGMAUq5iGTsMWxENdXwCgFr7UwWZOovSFJejppiAlPp+13TLmPS+L/NFHC6Q/
         8cflHGqmbqWQYlU+SIfg52g/6XonuG/NzOGC3GH7POUeq/8CB4llDgz8NkCm+Sx+VKei
         yd6FqTzO03D3iWTa/9E4JNgCPkNejfgq4/a4tn4lYYYRx0hqT/J+nfAVEg1l5DnzTDIJ
         oP8Q==
X-Gm-Message-State: ANhLgQ23hAK9X78iRLRdJmcYIMZHiT6eDwvoizE+hBZJC1hnQqD5U3C3
        DMqPhRDOOkPB+s4CLGUOfA==
X-Google-Smtp-Source: ADFU+vvQu/ofiAgtyXPA30BdpK0s2M4IVdyqhYxGuUk+ta8FD03+S125+4JrMJsyywR83s2B6+q9jQ==
X-Received: by 2002:a92:358b:: with SMTP id c11mr425751ilf.64.1584572357681;
        Wed, 18 Mar 2020 15:59:17 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w88sm114692ila.24.2020.03.18.15.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:59:16 -0700 (PDT)
Received: (nullmailer pid 27686 invoked by uid 1000);
        Wed, 18 Mar 2020 22:59:15 -0000
Date:   Wed, 18 Mar 2020 16:59:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] Device tree bindings for TI HDC20x0 humidity and
  temperature sensors
Message-ID: <20200318225915.GA25864@bogus>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
 <1C2C8CD5-4BF0-40AE-932A-4AD506664B9D@norphonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C2C8CD5-4BF0-40AE-932A-4AD506664B9D@norphonic.com>
Content-Language: en-US
Content-ID: <3A479F18FEBC5A46BFE84B5E87D23497@eurprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 20:09:48 +0000, Eugene Zalkonnikov wrote:
> 
> Device tree bindings for the HDC2010/2080 driver.
> 
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-02-12 14:28:42.562903814 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
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
> +  vddd-supply:
> +    description:
> +      digital voltage regulator (see regulator/regulator.txt)
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
> +      hdc200x@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#

See https://patchwork.ozlabs.org/patch/1256878
Please check and re-submit.
