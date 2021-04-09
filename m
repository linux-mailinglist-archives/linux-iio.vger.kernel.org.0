Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2735A6DA
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhDITSj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 15:18:39 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36713 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDITSj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 15:18:39 -0400
Received: by mail-ot1-f41.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso6720884otq.3;
        Fri, 09 Apr 2021 12:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++xBK3NbqiI7OTm8h/f/B8YoNrErgNul0ps/EoyMiPs=;
        b=CC/28x01s8kA6mhnFozrsDb90Z3qqLa+ZL2ImB0P2kdTIovX9AQjQ469MXc0pMHu2R
         RfS9V9cxjj75ef6y/nQPDyQgeIT/LSRHPFYu9qecutwV7/piPNMtj7Km1X9uDxoawjVC
         tYpzKpZ4jeYsamsCOmPaGVlgPihh0wK55ecKrm/nfEEqR4fd0ibj5Dguc6K9tCrJClC7
         olT4O/PQDtFHOczpFfFoPoQj9+PSWgPfVySJcwn/ou4gpy5DPx0FerEGylnKfxCqr9oC
         EAKgU+Uwiyd/ylcpJDLsjAqx+DJ3AxSrmB96SehErPCoRy0olkXozl8KD4/+tW1RqMcX
         vlRw==
X-Gm-Message-State: AOAM531LMrMm5NlC/bkDgdyKknW9x6HWXNMhveC1+aJeaGcQZS8/C/Ow
        RbnCgl2TqTLliz5VMQXKnQ==
X-Google-Smtp-Source: ABdhPJySRaGojuIRUuBJc0I34FTPXHV5CUxJzL53Ui+6GO86wj/PgL4cKmUoLTaIez73LZorkMGdMA==
X-Received: by 2002:a05:6830:1c69:: with SMTP id s9mr6303658otg.369.1617995905336;
        Fri, 09 Apr 2021 12:18:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm762226oti.30.2021.04.09.12.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:18:24 -0700 (PDT)
Received: (nullmailer pid 3988366 invoked by uid 1000);
        Fri, 09 Apr 2021 19:18:23 -0000
Date:   Fri, 9 Apr 2021 14:18:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-hwmon@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-input@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3 2/8] dt-bindings: fix references for iio-bindings.txt
Message-ID: <20210409191823.GA3988279@robh.at.kernel.org>
References: <cover.1617972339.git.mchehab+huawei@kernel.org>
 <4efd81eca266ca0875d3bf9d1672097444146c69.1617972339.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4efd81eca266ca0875d3bf9d1672097444146c69.1617972339.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 09 Apr 2021 14:47:46 +0200, Mauro Carvalho Chehab wrote:
> The iio-bindings.txt was converted into two files and merged
> at the dt-schema git tree at:
> 
> 	https://github.com/devicetree-org/dt-schema
> 
> Yet, some documents still refer to the old file. Fix their
> references, in order to point to the right URL.
> 
> Fixes: dba91f82d580 ("dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema")
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt   | 2 +-
>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml   | 5 +++--
>  Documentation/devicetree/bindings/input/adc-joystick.yaml    | 4 +++-
>  .../bindings/input/touchscreen/resistive-adc-touch.txt       | 5 ++++-
>  Documentation/devicetree/bindings/mfd/ab8500.txt             | 4 +++-
>  5 files changed, 14 insertions(+), 6 deletions(-)
> 

Applied, thanks!
