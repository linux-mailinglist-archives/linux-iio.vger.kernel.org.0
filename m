Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045732CAC81
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLATi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 14:38:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32845 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388660AbgLATi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 14:38:27 -0500
Received: by mail-io1-f68.google.com with SMTP id o8so2871948ioh.0;
        Tue, 01 Dec 2020 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DtE/p2TZ8Lna105TKUgynqS92/YnY7BZEeXnFSFbQB4=;
        b=J053gZgPZkFcL9lfcpSHPIE/ikTnU6cag95PsjLJoBy3vgmmc9sgbptfP6mEXU484w
         3y+fOtAKFEc8PAnkaTJbFnTusOhOYSIjnV+Gt5bcl5/4RSLwoy/0svNxpeePmyi64gNZ
         mMbyi+mt7kcHt26brOJxzWizaY6l4uzy3OtE+jsdG+lqEyw2JK4EnQC+BxPConyiw12r
         bxQBQain8lpSmR8yXjEcw8tF4pNtwFWejgTmBhNFdsvdEviYAeDBJ9rvKtXB/xNjuYcg
         R3qqzNfprj/vvy4GjNGZEueQtkib3R/heDrazU8ueSNDesLqtUfaGh5vJ/u47l77+Vrs
         k6jw==
X-Gm-Message-State: AOAM533s6DDNX8ZbaPihQUJMOmAxWA00nxJ4mwe76z+Unwl/EUrf2pET
        /4HDLJUayZ4Qd0VdyD6hGA==
X-Google-Smtp-Source: ABdhPJy7eoYIeaAoD/c92WUVo3P5uWDOitDJsS+gtbjSNEJrAey9IGrfy0zEfCu1rqEZLp4YgS4tbg==
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr3755338ioj.169.1606851466619;
        Tue, 01 Dec 2020 11:37:46 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o12sm270848ilj.55.2020.12.01.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:37:45 -0800 (PST)
Received: (nullmailer pid 928302 invoked by uid 1000);
        Tue, 01 Dec 2020 19:37:43 -0000
Date:   Tue, 1 Dec 2020 12:37:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 1/3 v3] iio: accel: bmc150-accel: Add DT bindings
Message-ID: <20201201193743.GA928272@robh.at.kernel.org>
References: <20201115205745.618455-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115205745.618455-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 21:57:43 +0100, Linus Walleij wrote:
> These accelerometers have bindings used in the kernel and
> several device trees but no proper bindings documentation.
> Add it.
> 
> Also add a compatible for the BMA222 that I am right now
> adding support for in the driver.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Fix up an include directive in the example to be
>   outside of the I2C node.
> ChangeLog v1->v2:
> - Rename to simply bosch,bma255.yaml after one of the
>   common accelerometers.
> - Specify that the SPI uses a 4-wire interface.
> - Specify maximum SPI clock frequency to 10MHz. (Checked
>   all the datasheets.)
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml      | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
