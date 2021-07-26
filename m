Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D03D69AD
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhGZWAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 18:00:02 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:41788 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhGZWAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 18:00:01 -0400
Received: by mail-il1-f171.google.com with SMTP id u7so7246005ilj.8;
        Mon, 26 Jul 2021 15:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PKyPZZFWNBD3YGcaGyBrYxxu9nXQpsWEDIZhCced8rU=;
        b=o5+J8qYdZRkPQCMiwWVZDv8hVXJaoHCuft5ZCedNzmGe+oT+eVtWe7HEZD1Nujo7l/
         FlghBxgoE3TPn3NgQsw/Na3XfH0Jyv4WnA1QNRHfnVtDRwwnabDchBQuo8JFEhkJeS+U
         TPZAmxJ3g43KpyII860HFJ96T94EATKoXzQPZtDn8xwn8Qn+Gg5PzeRia3d08cROvXeo
         ee8SkQ3+vMr0dsPPxhNOz73ZPnFqBQwTEfxb6g/eZQz1SjLKbY+R3RdkxH8cdtqXYqHM
         NZBa6hwdFn7GU4CZTAeSjwcMrbrdHeH4n79XnA5RghRtyMs/XV1xq7AQN7sYFlq3CxAh
         WiOg==
X-Gm-Message-State: AOAM530DuV850zED9eIATOsQfTIJGf53u/Y6HWTxdmNHI2VnZP3ICh4E
        /pVqlQSL4yQS9C0c+tElPQ==
X-Google-Smtp-Source: ABdhPJzwaI8/pHCM50TQ39rAr0/bljtTErcAH4s4zj9xoSkOpgh3I75KNv8VFfhGiEXVQGLbZiG5pA==
X-Received: by 2002:a92:c0c2:: with SMTP id t2mr12199743ilf.260.1627339228514;
        Mon, 26 Jul 2021 15:40:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j20sm724437ile.17.2021.07.26.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:40:27 -0700 (PDT)
Received: (nullmailer pid 1006511 invoked by uid 1000);
        Mon, 26 Jul 2021 22:40:25 -0000
Date:   Mon, 26 Jul 2021 16:40:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        paul@crapouillou.net, linux@roeck-us.net, contact@artur-rojek.eu,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-mips@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v4 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
Message-ID: <20210726224025.GA1006453@robh.at.kernel.org>
References: <20210726082033.351533-1-cbranchereau@gmail.com>
 <20210726082033.351533-6-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726082033.351533-6-cbranchereau@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 10:20:33 +0200, Christophe Branchereau wrote:
> Add both the jz4760 and jz4760b, plus a property to use the internal
> divider on the b variant and document it.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../bindings/iio/adc/ingenic,adc.yaml         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
