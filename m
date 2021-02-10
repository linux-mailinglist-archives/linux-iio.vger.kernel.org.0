Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481CE316F22
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 19:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhBJSrH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 13:47:07 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38001 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhBJSpC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 13:45:02 -0500
Received: by mail-ot1-f42.google.com with SMTP id e4so2767679ote.5;
        Wed, 10 Feb 2021 10:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ahso0QDSvDSXFKJOsdbbWRqbLm5ep4rJ48Sx+MK06OA=;
        b=aROF0BjFELOhVll04O5658i77zebThzNIgoyf7azlnoVX/Fn4VZXWrg0i0D/2VIhuB
         yRKshIVa47+FkluUtm/eMZvPKO9OBWWh0gjjuphNQUAyGW9WgrKFhFyfwoqtcurixb7g
         aqS6X18n1f2/5YKYy8enqXNQYVxfIN8fg7ENMF7dD0oVAN67Cbpm4ZafCUJ1cPDJY5Yc
         3m9LnqrhnL2aIjUCO6AGPc8Tj7xN2AlAkPKr2IjWoH9baIIVbOMcOrAUFkAXbSVjrC9P
         2vXinTjOPKVrnH63uYuuq7uTHNGBMFrabn9Yn2UCdCxnLOLD+4kxnsDZCubmKJHxwo1G
         KzXA==
X-Gm-Message-State: AOAM531kghbsWzYm5rL6MGNlp3rldIxy36JNzxFbyEvTzik7x7GbtA6h
        guU0MPpPHPdCKkKq83jBnA==
X-Google-Smtp-Source: ABdhPJxn+yriZhQhWlS6MHI/6i+mrUUNHNzUBdbXaJa9vkvHUFOcvlpUwFxio4kX5vhbqsNmfCNCEg==
X-Received: by 2002:a9d:7742:: with SMTP id t2mr3033090otl.347.1612982660616;
        Wed, 10 Feb 2021 10:44:20 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p16sm616308oic.6.2021.02.10.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:44:19 -0800 (PST)
Received: (nullmailer pid 2521708 invoked by uid 1000);
        Wed, 10 Feb 2021 18:44:18 -0000
Date:   Wed, 10 Feb 2021 12:44:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
Message-ID: <20210210184418.GA2521618@robh.at.kernel.org>
References: <20210210025142.3609708-1-swboyd@chromium.org>
 <20210210025142.3609708-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210025142.3609708-3-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 09 Feb 2021 18:51:41 -0800, Stephen Boyd wrote:
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
> a node that is a child of the main cros_ec device node. Devices that
> have this ability will describe this in firmware.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v4:
>  * Reduced example in iio binding and moved to mfd
>  * Dropped unevaluatedProperties
> 
>  .../google,cros-ec-mkbp-proximity.yaml        | 37 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  7 ++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
