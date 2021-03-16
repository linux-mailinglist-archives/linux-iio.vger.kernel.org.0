Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F333E19C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 23:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCPWoQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 18:44:16 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43397 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhCPWns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 18:43:48 -0400
Received: by mail-io1-f47.google.com with SMTP id f20so38945043ioo.10;
        Tue, 16 Mar 2021 15:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AQHaxNTgps1UYSis5tdzaUweEo/y4yOoyxoMH6xdw0=;
        b=tw+x6XOCAgSicAHsyGZAEmlAF0Vdb2aE5Be6G3hNkf5PFga+5xLfWkEInEjS4fbUW1
         zHW8ol49h58ZDvWah+iPBGyXA3i7nu9ENn7UTBqrt18v00Wogf2jfRU9kjy+zW4yyt+g
         0NBEq2QB08viskgLG+ymV+GJcH7xRHcIfqyUj27WuxriGmQJWm7qN5CKgAWiytsHnECz
         XDLmcyX0oyPBS1/3NJtbt8vHykENoAPJn0PSnivRsnU1FPyMvplNhx/Tko8eTtJz60+m
         d0vvhy9Nvg8kFEA5IyFy2CG3HtvbS1lK3j1HpixOPhD0W8puRWjCPJnXjhz/RTdbM9my
         98fA==
X-Gm-Message-State: AOAM531TiYn+044ukj5ISqOVDI0mtyeoDnSGOwfFjAbUwu840Ygei24H
        B5Wt/haJvY1gN7W7ZoO0fw==
X-Google-Smtp-Source: ABdhPJx7hy5YNHZ9YdWaP/Qmd/x7PZIbYcuO0BREm5pPQpv5v4qXdle2dM1a/H1nxKpNbXiVZWcvqQ==
X-Received: by 2002:a02:662b:: with SMTP id k43mr653990jac.139.1615934628209;
        Tue, 16 Mar 2021 15:43:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b15sm6551871ilm.25.2021.03.16.15.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:43:47 -0700 (PDT)
Received: (nullmailer pid 3823592 invoked by uid 1000);
        Tue, 16 Mar 2021 22:43:44 -0000
Date:   Tue, 16 Mar 2021 16:43:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        denis.ciocca@st.com, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de
Subject: Re: [PATCH V2 1/2] dt-bindings: iio: st,st-sensors add IIS2MDC.
Message-ID: <20210316224344.GA3823538@robh.at.kernel.org>
References: <20210311030554.6428-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210311030554.6428-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311030554.6428-2-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Mar 2021 03:05:53 +0000, LI Qingwu wrote:
> Add support for ST magnetometer IIS2MDC,
> an I2C/SPI interface 3-axis magnetometer sensor.
> The patch was tested on the instrument with IIS2MDC via I2C interface.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
