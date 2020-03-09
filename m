Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239B817EA39
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 21:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCIUiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 16:38:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42459 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgCIUiR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 16:38:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so10971998otd.9;
        Mon, 09 Mar 2020 13:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sv47E3whDnk7QFlUz6K8G7Rk9bNvaKAJ3x+BtFqMd8=;
        b=XDnFVn47oye6Q/VhPPqy25QWTqwgGYvlxyDgKvncP8MXRc32LQJV+KPPdZ6u7RoKZW
         w5W19cBYQ+TV38+LYFbzSkUh2UXqNb2CdqZgNCdUZ0MpSIENynqifj8RuiutOMKuQfQt
         6UWeg5hvzFVGS7l8ydOdij8fvUeDk1z+Zwzne6hgTWeo6EoImu9n/Lz3C8G62Km0f8a1
         9tuIPQ1BzyRkf5f0OzG+ZKJZCpn3Y2I5/tyaxnDCZYs6+nzBZZZlepjhHJnfHYCv1pcl
         TF+HMPSMXfXYv8YzBa+3THJzveKdP9Nf0QRPEHQFBK6ZX9sXjClz7X8KbOdRs/4mbuAx
         3mcw==
X-Gm-Message-State: ANhLgQ24K5EytBywQrO+ZUGKFSrYkylRhzDVeexdsrE0KiCwsIJvPald
        9UFdPYUgHh3YePXyL3XflY3k0DE=
X-Google-Smtp-Source: ADFU+vt/J1NMy19Vg3cxnshnY12AaBqTlB+fN96FHy9+jFEUvpyhOuxvj76cKzr6obrAP+oVo7WySA==
X-Received: by 2002:a9d:23e4:: with SMTP id t91mr14274415otb.125.1583786296250;
        Mon, 09 Mar 2020 13:38:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm2358588otp.80.2020.03.09.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:38:14 -0700 (PDT)
Received: (nullmailer pid 30910 invoked by uid 1000);
        Mon, 09 Mar 2020 20:38:14 -0000
Date:   Mon, 9 Mar 2020 15:38:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v4 4/5] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200309203814.GA29255@bogus>
References: <20200307211412.44148-1-contact@artur-rojek.eu>
 <20200307211412.44148-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307211412.44148-4-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Mar 2020 22:14:11 +0100, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
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
>  .../bindings/input/adc-joystick.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/input/adc-joystick.example.dts:22.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1250951
Please check and re-submit.
