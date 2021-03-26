Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA768349D31
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 01:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCZAE3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 20:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCZAEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 20:04:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C1C06174A;
        Thu, 25 Mar 2021 17:04:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h13so4364298eds.5;
        Thu, 25 Mar 2021 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hOTKNlq4H1/dCwJVlYChXs9MjCEtvc42KBPGymLZ8CI=;
        b=EJLGzPItvUCPmXWgdjq9eEdhUAe5Zdjr8N/YQnNvLuGFirRQeWuQmwcInrxi1eKgDN
         mUyRbPvwhkRcTezLXXeZ01jUy4UqDU37wk9ChytfNdO/p9imI8px4JfG8XHa1piucOwK
         j0PXqy10WyglOCyw9GWZRg3dD6E2KyzcQHowbjeEeARxAiDp0OWiI81U+ramzmUKTGTD
         A59mfDBJ1pQnRhQ0c0JaLrIOlN09P0m9PtGqt048OLwJLzeqIuN7DvKZ9KaWBDCn6aIJ
         xZPokVhIeQdCZ77y5pbwO9SbcRdEldHcCPwpciaOdb+15ldhoKJYgghg4atJiciAbXwi
         4xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOTKNlq4H1/dCwJVlYChXs9MjCEtvc42KBPGymLZ8CI=;
        b=isgcwFm+Xrcrb/yVIY+pBaBwIVxf8IPtOAhTZss2YJnSIrvr0Cbo64dLai1BicMk7q
         uWBypxSkkyhPmV5/jaq5TQSxiKX9KQD36gKQZxp2tsBqAt1K10VXgQiQIhVbr6KCIQoN
         9ivDMAu7p7xRrMjK9bSOmnGofICYbx8G20QZiIRxSyasOMmUVAQg0znnZyYS3vqKn7Mq
         Fp4kIbT+si3zTLCisLlhT72C59N7qdokMehxLp9WO2ktQwg/IvcK+aZRNP4qgS0zU5JG
         FNaEnMqTGX3/zTsRDq8kVaerFXeM1aFWALBayoD/tDr2kUMGa7Obwr1OzqFBf/4KFwtV
         e2BQ==
X-Gm-Message-State: AOAM531mgzyc+mp4nlcgWr505IXBDJuyBhOJhq7p5Ztr5n/MGkd9ggWk
        ++rbhBCFEmbDWx1poCjCxoc=
X-Google-Smtp-Source: ABdhPJylADn3l5x2uEuxgSEapUegFiQ6JvNP6hvUyDICO7GdYLtbzb8UwreBkQkWnxUTaQnJ6HKSPA==
X-Received: by 2002:a50:ef11:: with SMTP id m17mr11957948eds.151.1616717052434;
        Thu, 25 Mar 2021 17:04:12 -0700 (PDT)
Received: from pop-os.localdomain (cpc97922-walt21-2-0-cust248.13-2.cable.virginm.net. [82.16.251.249])
        by smtp.gmail.com with ESMTPSA id v22sm3097651ejj.103.2021.03.25.17.04.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Mar 2021 17:04:12 -0700 (PDT)
Date:   Fri, 26 Mar 2021 00:04:10 +0000
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        Rob Herring <robh+dt@kernel.org>, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 2/2] Added AMS tsl2591 device tree binding
Message-ID: <20210326000409.hosr72pmbjo5sadx@pop-os.localdomain>
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
 <20210325220505.14507-2-joe.g.sandom@gmail.com>
 <20210325234343.GA1959978@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325234343.GA1959978@robh.at.kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 05:43:43PM -0600, Rob Herring wrote:
> On Thu, 25 Mar 2021 22:05:04 +0000, Joe Sandom wrote:
> > Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
> > 
> > This driver supports configuration via device tree and sysfs.
> > Supported channels for raw infrared light intensity,
> > raw combined light intensity and illuminance in lux.
> > The driver additionally supports iio events on lower and
> > upper thresholds.
> > 
> > This is a very-high sensitivity light-to-digital converter that
> > transforms light intensity into a digital signal.
> > 
> > Datasheet: https://ams.com/tsl25911#tab/documents
> > 
> > Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> > ---
> > Changes in v6:
> > - No changes
> > 
> > Notes:
> > - Re-submitted to align the version with part 1 of the patch series
> > 
> >  .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> > 
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
>
Thanks for pointing that out Rob, will amend that now and resend for
this version.
