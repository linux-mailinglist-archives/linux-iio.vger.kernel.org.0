Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D141434F81
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhJTQAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 12:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJTQAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 12:00:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9AC06161C
        for <linux-iio@vger.kernel.org>; Wed, 20 Oct 2021 08:57:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g2so20078216wme.4
        for <linux-iio@vger.kernel.org>; Wed, 20 Oct 2021 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wg0KJqHRV08qX4QVL+ntQvH0cOPBhNXqn/SMEbf5V98=;
        b=U2SOf9kJARwcP8IJA+zkKOcS7SDbUbqF69fwz8T/Dl5L/KGAwvVa6XaYgbOFa6OGWb
         iVNnQCeiiJIBjw5DilysiOBw1H2TRBhOf4r2YG3uD7+GIYYrOmYegKX8h7hL/WnOg477
         8aPagA9sFfs+/GxCHD7hf3hqz28Ug4cVglGNJFvRn/sUakywQ4E9wIBcdKZlY7h6LhCK
         qgB6G7g0xFL7bNIplPvjfWgBNd9CF2GYWKbSvwG/Qn4oXRL3G70mr6+n9LPdbuTMzQoC
         z7vgF5HqW4O1V8cYASUvpod05GZDaIWCdnTUA/rgdOte8wVnoEtSQGZU2Sbir7PqmXqn
         Y85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wg0KJqHRV08qX4QVL+ntQvH0cOPBhNXqn/SMEbf5V98=;
        b=vDLK3PPVuzVnMh1CfBQRkznh+mgSKo2mnDzTscOTS1E8ZQ8pBDk1CI0l0qpL5f0WuZ
         TETOj2kyigd6s655RhbddWe+t5pxF+7gL5YNhyLicCJBBdlL+pnLbnREXRtuoRDpuchX
         WB6ROFvfBKNBoShsoOUZ5JMS9KuG9Vh9ngyauOiSQ/mcGyN3woqyXthGz+DJ6sfyoElm
         p8+G2igBqjkd+gvnFxIhOKbQzF4KVq3sfmZ8X5i24cPRO5nLO2EXjMac7gx6rxds1xy7
         l1d+PZtwUih9DJpa7lbNfOzCxo6/M+1bN2edHkJJANMn9GQXVycfzEXbr3WdOXJ+GyVE
         i1dw==
X-Gm-Message-State: AOAM533CGZa6aE3VNs5IVf91jvGCi0quJKaUeLebgHmjIqAhyPc4pAPk
        OSq2bzfGLjl7BQ7HXxIYPTQc4w==
X-Google-Smtp-Source: ABdhPJzInNCFCNWJ+mCj2v3d0N5Vo28HRFOV2AbllNKZOn9TvqF8m7fmuTpcxZWZHMzSi6OGjfbAbQ==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr44197wrg.23.1634745472287;
        Wed, 20 Oct 2021 08:57:52 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id q12sm2428423wrp.13.2021.10.20.08.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:57:51 -0700 (PDT)
Date:   Wed, 20 Oct 2021 16:57:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/48] TI AM437X ADC1
Message-ID: <YXA8fVh5Q7aWNFE2@google.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
 <20211020173611.07980c1d@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211020173611.07980c1d@xps13>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Oct 2021, Miquel Raynal wrote:

> Hi Lee,
> 
> miquel.raynal@bootlin.com wrote on Fri, 15 Oct 2021 10:14:18 +0200:
> 
> > /*
> >  * Reducing the Cc: list as this is just a rebase and all patches
> >  * received reviews already. Only the DT patches have received no
> >  * feedback, hence keeping the omap@ list in.
> >  */
> > 
> > Hello,
> > 
> > This is a (fairly big) series bringing support of AM437X ADC1.
> > On TI AM33XX SoCs family there is an ADC that can also be connected to a
> > touchscreen. This hardware has been extended and is present on certain
> > SoCs from the AM437X family. In particular, the touchscreen has been
> > replaced by a magnetic card reader. In both cases, the representation is
> > an MFD device with two children:
> > * on AM33XX: the touchscreen controller and the ADC
> > * on AM437X: the magnetic stripe reader and the ADC
> > 
> > This series really targets small and atomic changes so that the overall
> > review is eased, even though it leads to a lot of rather small patches.
> > Here are the steps:
> > * Supporting the missing clock
> > * Translating a single text file containing the description for the
> >   MFD, the touchscreen and the ADC into three independent yaml files.
> > * Cleaning/preparing the MFD driver.
> > * Supporting ADC1 in the MFD driver.
> > * Cleaning/preparing of the ADC driver.
> > * Supporting ADC1 in the ADC driver.
> > * Updating various device trees.
> > 
> > Here is the full series again, almost reviewed and acked entirely.
> > The clock patch has been acked, the ADC patches as well, so we expect
> > the series to go through the MFD tree if the maintainers agree with it.
> 
> Sorry to ping you so early, but we already are at -rc6 and I was
> wondering if you could take the series as it has been on the mailing
> list for a while and received no real change since a couple of weeks
> already, possibly avoiding the need for yet another resend of 48
> patches :)

Don't worry, it's email day tomorrow.  I have a bunch of high-priority
patches/sets that I aim to handle, yours included.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
