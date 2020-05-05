Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B01C4CF3
	for <lists+linux-iio@lfdr.de>; Tue,  5 May 2020 06:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEEEFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 00:05:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35732 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEFk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2020 00:05:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id o7so878066oif.2;
        Mon, 04 May 2020 21:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NxcXGsja0RqwbNvyBbTQG5dqInSaMyIr4W7PW6vbWV0=;
        b=jXUnYvJQVStbcYVTkL/Jw2kaOFvCP7u+v3ywFtgA8TQGU3zsFXnaEw2OAbednQaVqX
         PH9ZnqDZZA+/CyUVFDHQfpV9ZPRmci8Wq5EVmx0y0cccFOGVW5sCHG5+owNcMlXCs4Kr
         1eS7IHfc92GWspuXCycdZkAflpRkiLstgPukUmTAcn7xZgQnfzT8KAyUYo2X1TbeIwPa
         GlTZQRLzB5JjK7XBlMxWiU5Pg9ap9mGtFvubgXxF6iyY43mmd0fxtEoJknmzdHTE3QSl
         n0/02lyeig+VmBhaJD5wtTZ+bZRAQjefDFjMiidM9dYZEfiPS+FNFBTqOqXN0WwlBVjg
         1oPA==
X-Gm-Message-State: AGi0PuaJomyo3ngPktiGF7onaBkbeHlJxK90lLJ0hq5ORsQ9CYCdSSno
        brt0bjq5kkD6NT2lO9YvfQ==
X-Google-Smtp-Source: APiQypIm6bJ2GYcUWnDrZJSKFY2MMrVaOZ5DgIjiUPpdrF0QvVmDwHdw5rjjHX4mQ/dYp0iumLOLcQ==
X-Received: by 2002:aca:d441:: with SMTP id l62mr1244483oig.9.1588651539145;
        Mon, 04 May 2020 21:05:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 61sm329855otp.13.2020.05.04.21.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 21:05:38 -0700 (PDT)
Received: (nullmailer pid 31439 invoked by uid 1000);
        Tue, 05 May 2020 04:05:37 -0000
Date:   Mon, 4 May 2020 23:05:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v6 6/7] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200505040537.GA30791@bogus>
References: <20200503171451.44034-1-contact@artur-rojek.eu>
 <20200503171451.44034-6-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503171451.44034-6-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 May 2020 19:14:50 +0200, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
>  Changes:
> 
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
> 
>  v3: no change
> 
>  v4: - remove "bindings" from the unique identifier string,
>      - replace `|` with `>` for all description properties,
>      - specify the number of items for `io-channels`,
>      - correct the regex pattern of `axis` property,
>      - specify the value range of `reg` property for each axis,
>      - put `abs-range` properties under `allOf` 
> 
>  v5: add `a-f` to the regex pattern of `axis` property
> 
>  v6: no change
> 
>  .../bindings/input/adc-joystick.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/input/adc-joystick.example.dts:24.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1282045

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
