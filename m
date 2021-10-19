Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD143408C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJSV1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 17:27:20 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42580 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJSV1U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 17:27:20 -0400
Received: by mail-oi1-f182.google.com with SMTP id g125so6974450oif.9;
        Tue, 19 Oct 2021 14:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+OJDx5FymiLds3Rk5vgoSW8vy1KRIWasS3RIQPvnjw=;
        b=lYAubNTkkXy9ifQUJJqxxNi8pc0WxcZbGTV0245NTRT6BvVopMCxnhqwdQFiKs02Y8
         Pd7XYSUEdBEg5DOufYAqW/ThTgTMwJ8eY4W98agW9hupmZ2FhHhg0PPQWPDY8Z9i/vMY
         KR3fv44ocVtf+sFfqckVlVHluMto1P6Kd+6/l59ZUwoW/HQl1Q2nXinQPE3rrUGpvGk2
         ovEHO2CGkEFpbMmby0ADBb6VvrmjHAgqGeLLryRGk44PHTt/BTiwupL4fXtrwiYRXl8i
         TgeX///Yych9qKFV1wiU0sRHRSIxKLXbrySZyij4D75kaFQbOIZ5VH63wDvSlTergoHh
         U0mw==
X-Gm-Message-State: AOAM531ML8WPdvWMvwGLCqs7/nLA5HK/5l29XDzcUSE6PJ1UJP4nRPcD
        4PeFl3yXlN3ZTdYv194Glw==
X-Google-Smtp-Source: ABdhPJyjnK98KH12DbshUH97zi4FbzM0bds33eS4InU42Epat5TE8jC7RPfxeZZyzNjt5jXpMeVEzg==
X-Received: by 2002:a54:4e98:: with SMTP id c24mr5974224oiy.159.1634678706591;
        Tue, 19 Oct 2021 14:25:06 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-67-78-118-34.sw.biz.rr.com. [67.78.118.34])
        by smtp.gmail.com with ESMTPSA id bm43sm41495oib.50.2021.10.19.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:25:05 -0700 (PDT)
Received: (nullmailer pid 866769 invoked by uid 1000);
        Tue, 19 Oct 2021 21:25:03 -0000
Date:   Tue, 19 Oct 2021 16:25:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel@axis.com, devicetree@vger.kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/3] dt-bindings: iio: io-channel-mux: add optional
 #io-channel-cells
Message-ID: <YW83r+AqgTookHjp@robh.at.kernel.org>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
 <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
 <43e22ba4-0619-49bc-8062-b561cf19ca23@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e22ba4-0619-49bc-8062-b561cf19ca23@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 09 Oct 2021 00:11:21 +0200, Peter Rosin wrote:
> Needed for in-kernel use of the child channels of the mux.
> 
> Fixes problems like this, reported by dtbs_check:
> adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
> 
> Suggested-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
