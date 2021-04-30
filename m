Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952713701DE
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 22:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhD3UMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 16:12:32 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:36381 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhD3UMQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 16:12:16 -0400
Received: by mail-oi1-f177.google.com with SMTP id i26so15834360oii.3;
        Fri, 30 Apr 2021 13:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvO3LxOxOIkv8yR5Vc69bUEj37EUFhpgFZtgFVNXDtw=;
        b=jHBUD20r6//oLO7Ow5Q9om8HhF6mqpcAujDP5opCGeczS+R1GOmyuvzs+GDEHEuCnY
         04k1nyBKAO1DeQDgVKSbwRZdh/muB2T0ZyCmifcN3HbypZQdKaOxWMLTYIK2Cl+48ZVg
         j3fqjw/gplkTf69R77m9h+laTrGsxhIpQSED2EEjd0k1fK8HgWDfXit0dQyBsD3axtOS
         wc6LcoRHuaGH9IKIlu/YuGn5F1JuS2wSruaO0yt9NJ+IZawHFCq4nhxOueXFGGom+Qyu
         mw2gg4SRPKYcQuEuQ47cCu9LAgKdOKQgbxd5fN2/u2ABJXgdKTzanXBTV/+xwhG0PMaH
         bw2A==
X-Gm-Message-State: AOAM533GE3NP/vI1s+UwVCIdqOOJ0wOJHH+UKwIcsgz6v74x7HFuCoRt
        z8AXtROMITP0/gkwYSswRA==
X-Google-Smtp-Source: ABdhPJw0uvLCVyy4NAu0MSdkZzahieMTHD/PKbDqcmpklekgLaJo0mK5gTRC4XI0+9wB55raSQYHnQ==
X-Received: by 2002:a54:4704:: with SMTP id k4mr11960683oik.127.1619813487100;
        Fri, 30 Apr 2021 13:11:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g5sm1032459oiy.24.2021.04.30.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:11:26 -0700 (PDT)
Received: (nullmailer pid 3806058 invoked by uid 1000);
        Fri, 30 Apr 2021 20:11:25 -0000
Date:   Fri, 30 Apr 2021 15:11:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, David Jander <david@protonic.nl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 1/3] dt-bindings:iio:adc: add generic settling-time-us
 and oversampling-ratio channel properties
Message-ID: <20210430201125.GA3806025@robh.at.kernel.org>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
 <20210428073208.19570-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428073208.19570-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 09:32:06 +0200, Oleksij Rempel wrote:
> Settling time and over sampling is a typical challenge for different IIO ADC
> devices. So, introduce channel specific settling-time-us and oversampling-ratio
> properties to cover this use case.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
