Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73337EE72
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbhELVnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 17:43:20 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33370 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385223AbhELUH1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 16:07:27 -0400
Received: by mail-oi1-f178.google.com with SMTP id b25so18161132oic.0;
        Wed, 12 May 2021 13:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8mK8FNLcUAP6zHwFtfduF9ONl8iQuSOq8udr35xhVZw=;
        b=rfbzN5gtwWvTTE3Nngn9kcc3WwV3oTr93yzevEWCk0Eo2HJZ2GgzKy+W7SPhyVJVfC
         dogCc6HqQ318qgiW3qrv3T2DK762IeWBRPd0yfnuYV2Exp7DVVKNpnGfY59CvH/yKQdY
         wRnC3+7fyvWnXQunvxbzo2uWCjq8Yn3h46NYuZzWP6URcIj/adpGGi31ou5iwwQ1bFS8
         OepJ8Mn988uhB87MT2oGu6RCl6D88f9Fp7lq9gO+W0PBO3I3rbg+crse54re4F5TI1c4
         LUrg/8dDSrs13VhJPH2pAVIiPQb1q8sqWzaR2LmYEXaIHmQ6XiaMV5z+iMSiHQJuTFGu
         Vc8w==
X-Gm-Message-State: AOAM5309vDH92N6pPyqDiH24PuUY2STfLbZVl9S26k7IBExOu7q7jeZz
        maPMx5ddr90gwzohV0uKqw==
X-Google-Smtp-Source: ABdhPJygkS5R5T5PEwrtsxUteg5Ksl4UaPopx1hiuVEvWf7CYPqSYko5JqMkb2MTszCKk1qkDDV6xg==
X-Received: by 2002:aca:c449:: with SMTP id u70mr163257oif.146.1620849977312;
        Wed, 12 May 2021 13:06:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v28sm238408ood.27.2021.05.12.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:16 -0700 (PDT)
Received: (nullmailer pid 2491536 invoked by uid 1000);
        Tue, 11 May 2021 19:47:17 -0000
Date:   Tue, 11 May 2021 14:47:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Robert Yang <decatf@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: kionix,kxcjk1013: Document
 kionix,kx023-1025
Message-ID: <20210511194717.GA2491222@robh.at.kernel.org>
References: <20210511142402.4457-1-stephan@gerhold.net>
 <20210511142402.4457-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511142402.4457-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 16:24:00 +0200, Stephan Gerhold wrote:
> The KX023-1025 accelerometer uses similar register bits as kxcjk1023,
> so it can make use of the same driver. Document the new kionix,kx023-1025
> compatible that is also supported by the kxcjk-1013 driver now.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
