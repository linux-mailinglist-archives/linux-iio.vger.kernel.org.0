Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51A53D69A5
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhGZV7M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 17:59:12 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42911 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhGZV7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 17:59:11 -0400
Received: by mail-io1-f51.google.com with SMTP id h1so13804221iol.9;
        Mon, 26 Jul 2021 15:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVvGxhML1s/c1Z4UmKTuDO1TqOVXR7jHdb7OwqrmdMs=;
        b=Rjk9E8GHmc1v8rLrO6T1OsOUr1FRkJGbuBXMep2GSNiXDtL+tFkJIc0iKa+ltBdR/Y
         hbAbFPPMU6/DFsgMkWTDayQaE+XQED98FXeQd2GgCtfUYlUNWXmFx5NyVOu7EZbx2g31
         xuXW2zwnlh4AEnO1tFhrd+1gJlZfW71CLdKrRGxCP5SuGWbOXZhcHeAmSJH0Qo/v3dVj
         /DRO1sLlpqLrLsSupyUuQ2pNgN7VcnF5X44fWDxYZ96BssA5Q1Zk2YuLAOeTJs7gTDT1
         ZTb2wOm5GUMNxf/Xvp5CaSfM4ZZ5OOZrg1Q5kEFq/LWmSFaSYCnOn4HlZNV5rhwAidGb
         n/Cg==
X-Gm-Message-State: AOAM532GfR6UyxjqY/yjfPRz3BA8yCnN3CkPxA4d5BbzpPf/5M6dU+qw
        VyjkCy7O+IUx5Gn0XXrVYQ==
X-Google-Smtp-Source: ABdhPJz4q8G8J2GYik3YDtbXs1CHxl4Ho/+h7C0nWkNFkdMSaApcGIFyvuC5/VBWTKUHtZLZokCI5Q==
X-Received: by 2002:a5d:8b85:: with SMTP id p5mr16249627iol.43.1627339178788;
        Mon, 26 Jul 2021 15:39:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c11sm723456iod.8.2021.07.26.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:39:38 -0700 (PDT)
Received: (nullmailer pid 1005107 invoked by uid 1000);
        Mon, 26 Jul 2021 22:39:34 -0000
Date:   Mon, 26 Jul 2021 16:39:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     devicetree@vger.kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        contact@artur-rojek.eu, jic23@kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/5]  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0
 entry
Message-ID: <20210726223934.GA1005053@robh.at.kernel.org>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
 <20210726082033.351533-3-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726082033.351533-3-cbranchereau@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 10:20:30 +0200, Christophe Branchereau wrote:
> The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare including the one named AUX in the sadc driver.
> Leaving the rest untouched as it's ABI.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> 
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
