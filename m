Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF81400629
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348976AbhICTwq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 15:52:46 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40746 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhICTwp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 15:52:45 -0400
Received: by mail-oi1-f180.google.com with SMTP id h133so509490oib.7;
        Fri, 03 Sep 2021 12:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HW3SdKQwfNKyynFaaOauQH4RTjAPcHmQSvvL/lhub/M=;
        b=Kjc/JZ8QvHLsiyF/oG0CMtc7M64BcdMLnActlVcKEedwYCnuxxL8Tq12NAbE9p0I0H
         lnao4ym8j4cHxHArHQdHlc9E6TijpdvcN8puFAxMT2cfVzRmLV0Nsopu9xVguyJXNIuy
         FJ702ov+A0FTbJw07e9KufGVL6uQsOq/InUrfPhLfP6WacOU5bfANblEP+AfpXnIwq1b
         PiZoRV9+PKBoC7TySaxX9vvwc0JsEGTIPAwQWy0ufW08SQyJFuKWXOEWGTkPj0ERj2Vp
         STFVxMEhyi7KcEi8tgbq/yH5N32DHX3sh+Yv+Joah7+PGhHHn0kww6RvIHjx8mMFUaKU
         wsdA==
X-Gm-Message-State: AOAM532e82D0BTtXi5YE4EFye/StjObeKsFYVtb/XE9PyzN1BpQ947Ac
        fOweK4SjMKjP/cCYnjEVNg==
X-Google-Smtp-Source: ABdhPJwILUGhUdMia4TlHx7SxzYuowAPhgJlfF8ag4vp6TxQOyabv+LVNkPu5cSgBBpiEmDW553Lfw==
X-Received: by 2002:aca:efc2:: with SMTP id n185mr336418oih.142.1630698705329;
        Fri, 03 Sep 2021 12:51:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm35649ooa.1.2021.09.03.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:51:44 -0700 (PDT)
Received: (nullmailer pid 3348435 invoked by uid 1000);
        Fri, 03 Sep 2021 19:51:43 -0000
Date:   Fri, 3 Sep 2021 14:51:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     david@protonic.nl, Jonathan Cameron <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: chemical: sensirion,scd4x: Add
 yaml description
Message-ID: <YTJ8z2RpR0JUo2Yk@robh.at.kernel.org>
References: <20210901105911.178646-1-roan@protonic.nl>
 <20210901105911.178646-2-roan@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901105911.178646-2-roan@protonic.nl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 01 Sep 2021 12:59:09 +0200, Roan van Dijk wrote:
> Add documentation for the SCD4x carbon dioxide sensor from Sensirion.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
> ---
>  .../iio/chemical/sensirion,scd4x.yaml         | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
