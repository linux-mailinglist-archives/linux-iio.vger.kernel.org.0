Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538B31E02F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 21:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhBQUZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 15:25:38 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43489 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhBQUZh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 15:25:37 -0500
Received: by mail-oi1-f177.google.com with SMTP id d20so16330815oiw.10;
        Wed, 17 Feb 2021 12:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=I8XE64YH4B5ARsvI9j7IP7fE+KgkyF493Mcep8TBBTw=;
        b=HdRJ7+qQCHh2ujUnQ/gz4mltXNkVNZyzY7y2B9shf6DcN6aqWRnpMojrPAyQZvNaBL
         FAbp684i/ODKPkssewxn6WtstkckHVnunqwPIC2DNgm5Hr2gnPZQRYYirBgrUHt+6VuO
         +Jtg/ExRtH851FpTW8rNPnNxd1UHauXAIylDEGl6FLWPJpcwaX51Be//a5UWxHusXvDh
         r6cGy5yhdNof7l0UZRipq9lavw5apzj/AIW+Po3X6EUfDeyQ0qowLkbGlEP3VR055GGK
         kyX8ScTEiJYsZidLzH5Tr0cE+dYgnnYqrm1qlUdOHPGOqTLs0m5KzXEZvR1Cy9MSdYPO
         9Wvg==
X-Gm-Message-State: AOAM530yV7zAZDUW3bUZfxh5IZM1LGwaKQaC4AI3YrF1YcSzCKJYafip
        147aZV0P0hKE+vDxsaAiLsvjNBIITA==
X-Google-Smtp-Source: ABdhPJzm39MAB6GLlVqrHXSGYEnoN9W0dHfOkDBrpaOnmqMSq9THGamrYDZU1kwqwGa7z5l47CSYWA==
X-Received: by 2002:aca:5d04:: with SMTP id r4mr411811oib.43.1613593496513;
        Wed, 17 Feb 2021 12:24:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v10sm685915oiv.13.2021.02.17.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:24:55 -0800 (PST)
Received: (nullmailer pid 2681059 invoked by uid 1000);
        Wed, 17 Feb 2021 20:24:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210213132241.15808-1-joe.g.sandom@gmail.com>
References: <20210213132241.15808-1-joe.g.sandom@gmail.com>
Subject: Re: [PATCH v3 RESEND] Added AMS tsl2591 driver implementation
Date:   Wed, 17 Feb 2021 14:24:51 -0600
Message-Id: <1613593491.450980.2681058.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 13 Feb 2021 13:22:41 +0000, Joe Sandom wrote:
> Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
> 
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light, raw visible light,
> raw combined light and combined lux value.
> The driver additionally supports iio events on lower and
> upper thresholds.
> 
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.
> 
> Datasheet Available at: https://ams.com/tsl25911
> 
> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> ---
> Changes in v3:
> - Cleaned up descriptions in binding file and Kconfig
> - Changed macros to be uppercase
> - Cleaned up comment formatting for capitalisation and block comments
> - Changed tsl2591_settings to tsl2591_als_settings as settings only
>   related to als
> - Return -EINVAL directly in default case to save some lines
> - Consistent use of const in "compatible" check functions
> - Removed mutex use in _show functions as not necessary
> - Removed print's which contribute little value/have little meaning
> 
> NOTES;
> - Where spaces are seen at the end of some lines, it looks like gmail
>   has mangled things slightly.
> - checkpatch.pl --strict remarks that mutex definition should have a
>   comment above it. I agree it has little meaning, but just added it to
>   satisfy checkpatch.pl :)
> - For sysfs functions e.g. "in_illuminance_*", they're not currently
>   prefixed with "tsl2591" because I wanted to keep things consistent
>   with the other light drivers. Is this something we're looking to
>   change with the other drivers too?
> 
> REASON FOR RESEND;
> - Mailing lists were rejecting my outlook email, so switched to gmail as
>   mailing lists seem to accept without issues.
> 
>  .../bindings/iio/light/amstaos,tsl2591.yaml   |   50 +
>  drivers/iio/light/Kconfig                     |   11 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/tsl2591.c                   | 1220 +++++++++++++++++
>  4 files changed, 1282 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
>  create mode 100644 drivers/iio/light/tsl2591.c
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/light/amstaos,tsl2591.yaml#

See https://patchwork.ozlabs.org/patch/1440199

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

