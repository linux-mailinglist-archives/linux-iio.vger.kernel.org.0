Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4AA3319C7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCHV4U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 16:56:20 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:43368 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCHVzq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 16:55:46 -0500
Received: by mail-io1-f53.google.com with SMTP id f20so11647951ioo.10;
        Mon, 08 Mar 2021 13:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ybSs0Ob1LnKKtK1l56OcRUxFWnlW7UjT4LMddyAcCg=;
        b=ON5EmnNH2z/PtndfSwlAW3uRzVWUWqN6rqdTu1PMDnfR+dWnmWT19H74qORLyarxza
         ACH5jeDPvjXr+5mpFdWDGdP3VJqMZr6cWB3+87wUbKlz1eINyEV0O6GiHZiYJYlpdFVm
         MeEQlsm+6yLAyqMN4BBAghEXBMo9F2artR5VNDWMkqp4FmI8dAcmkb3R//RyxFGIHXrt
         wcick+1DHN2ig+bV+pvNUCvTLOwq7ZnLEQkWKNzM1EUDMhiVbcWECZY+qsZsvveUwpyX
         sW9C25vjcjzy/E2QucRno/PpBCx9FH8ujtaO5FMSNpOMwkeRNY4TvtST0UvfIhnoSDq9
         5Clg==
X-Gm-Message-State: AOAM530cqUAk+4GEr6TheFvxC2wS/ECPXhq3D/WZwmDTJDVlKC3WFffG
        3YyZAMhb0nXDrlnum7VGb5PxB3yiuA==
X-Google-Smtp-Source: ABdhPJw+jYeeh0yZbRALgdv7Gt8iRqqYLmuyeQTqZhBuwAR0PKY+7idLLPnkGXg1qCg1b3ucyVLr+g==
X-Received: by 2002:a5e:9612:: with SMTP id a18mr20092046ioq.209.1615240545783;
        Mon, 08 Mar 2021 13:55:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k14sm6509122iob.34.2021.03.08.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:55:45 -0800 (PST)
Received: (nullmailer pid 3022527 invoked by uid 1000);
        Mon, 08 Mar 2021 21:55:43 -0000
Date:   Mon, 8 Mar 2021 14:55:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        denis.ciocca@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: st,st-sensors.yaml New iis2mdc
 bindings
Message-ID: <20210308215543.GA3019487@robh.at.kernel.org>
References: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 05, 2021 at 07:05:35AM +0000, LI Qingwu wrote:
> Add support for ST magnetometer lsm303ah,sm303dac and iis2mdc.
> The patch tested with IIS2MDC instrument.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> index db291a9390b7..6fd61ffde72b 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -66,6 +66,11 @@ properties:
>        - st,lis3mdl-magn
>        - st,lis2mdl
>        - st,lsm9ds1-magn
> +      - st,lsm303ah_magn
> +      - st,ism303dac_magn
> +      - st,iis2mdc_magn
> +      - st,lsm303agr_magn
> +      - st,lis2mdl_magn

s/_/-/

Though if magnetometer is the only function of these devices, then the 
part number only should be enough and '_magn' is redundant.

>          # Pressure sensors
>        - st,lps001wp-press
>        - st,lps25h-press
> -- 
> 2.17.1
> 
