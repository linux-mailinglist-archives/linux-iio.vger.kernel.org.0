Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73A5412D92
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 05:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhIUD53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 23:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhIUD5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 23:57:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EE2C061574;
        Mon, 20 Sep 2021 20:55:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h3-20020a17090a580300b0019ce70f8243so996324pji.4;
        Mon, 20 Sep 2021 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+p/128o7i1UymqNDQ9P1ON/m0j3mTXGoYCXSuHhjJN8=;
        b=beixg3eVD/JxEI2rh/CC3BASJC1nP6HlE5LsHd7XZV+EJazY4iHXAn6np/vvWVqZu7
         w9/zBC98gmoo6H361uYMNsCnyzZSxrzkXeBG2k+kRPgPQni0aJ4JKNib32qNgMiODkk6
         AToJuV180FANjeUzcxehKpGMz52oJL4Bw4ejezxy+bAi9VYCRh189dswq7L5YLY0Qlq7
         L+d4EQ98LsfFeDFLdZ+Tv3RAqMyRZzBWIW2raZKLi+BnkP5cqWU5eMrXSTk91Pa9TkRx
         6yrFvW/W5q8Qms6sV1DK0CMwR3t9X8JvrmRVqA4aH8BuHu7XRpnqUVldjTj73uFHcgnf
         k6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+p/128o7i1UymqNDQ9P1ON/m0j3mTXGoYCXSuHhjJN8=;
        b=EDf0Mi0iIHLkRdDDKMvoi/z7d1HoCCr1u+uROnPMOZXC82h/YZvJ4xORwaOhxI7R8g
         Awm6DHBLZYXbQaXftOku5ULLLpBQBQwg1a+g9ui6XRlOHAfC/HiyKPccN6lLsB22LRKC
         Fep5WTj5DVJ4f7GzxRxMn282GfOQCejsK03RCXJZXHoxFuuFhSEwinf796DewiWUN0Zq
         kDl93ypu5fdEHbw9zWR5PXN0rbt81nfefiva1oDclqmZtSEHXoQqY7qYWrLy8lzuhq3e
         HCR5SpPgOmPv546ZxeCxX8GbmwkUm2/0N2SEHq+sXATKf8D+KmwyeMRrSBJAF1hGuE38
         E6OQ==
X-Gm-Message-State: AOAM5329sCWrAlCeYrI+sNZOz84nyQ9JIsNyLAmED4EDSPUiL6slDQJH
        BKLnG7mfKxbNHXpNFGLN2Ps=
X-Google-Smtp-Source: ABdhPJzAPVWqwNCAtMgLgO6fBJdjvBv9VGDMWgLMdIwvpqB1Rq40Vy4gadrm00xovYPjkjPXlw5eNw==
X-Received: by 2002:a17:902:e78f:b0:139:a3c3:5eaa with SMTP id cp15-20020a170902e78f00b00139a3c35eaamr25430110plb.47.1632196555577;
        Mon, 20 Sep 2021 20:55:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a5b4:f272:6a63:5b57])
        by smtp.gmail.com with ESMTPSA id b85sm16160889pfb.0.2021.09.20.20.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 20:55:53 -0700 (PDT)
Date:   Mon, 20 Sep 2021 20:55:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 03/47] dt-bindings: touchscreen: ti,am3359-tsc: New
 yaml description
Message-ID: <YUlXxpGO7oahbZ8L@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915155908.476767-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 15, 2021 at 05:58:24PM +0200, Miquel Raynal wrote:
> This touchscreen controller is already described in a text file:
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> 
> After introducing a proper description of the MFD, this is the second
> step. The file cannot be removed yet as it also contains an ADC
> description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I expect this will be merged through MFD tree with the rest of the
patches, so

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
