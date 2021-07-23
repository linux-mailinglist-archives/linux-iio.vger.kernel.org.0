Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F343D4264
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 23:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGWVHY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 17:07:24 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:42785 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 17:07:24 -0400
Received: by mail-il1-f173.google.com with SMTP id q18so2819066ile.9;
        Fri, 23 Jul 2021 14:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVXTIkCEA/Uqqb0Qz5i9W55hpLq01WXGURBWMkYAIZ0=;
        b=KYcbY+jXuHOqmAh4r4T981Yr9aHPTLkYH5Pvwr5sIUb+V4rXYoNUytWD3dBKM5E86z
         Yhx9NQRRZrlZLXrb2wqvFrJbKuWxZuSJLiq+kamEl3D9eMRFeO5Di+KPSSsqJ+vXS2sK
         o4J4fbm8mSduEK4/kfZTeipBPs6z/5KO9fvvutdnaGIs/QaorepVjVm50TIlNEbh8h3P
         myIfw9ZJxvFz8pWkT6VQKdojS9cPwT3lgf6THwzoz7IG1eVuTHLX3FYbSlY+fLMOgSBa
         nr/fKf48SfTUscBo/jzyEdmGarCfl/CimUa2qAE6+cliaUK4JMGlHQINNwhmTBZA5d1r
         /+SA==
X-Gm-Message-State: AOAM530fVgBf8C8h85VfGeax6SAyNB+SI+QktRNRMe5k/+JSPKQpcNcM
        UeREr6iRonAd51490IxGbQ==
X-Google-Smtp-Source: ABdhPJxMiz87Kv3pUTKcMiLxbQsUeBdSF/0voUus+UsqA7kZ7DEuPGGZAYTfure9ZZgMsES2t8ogNQ==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr4591885ilj.74.1627076876758;
        Fri, 23 Jul 2021 14:47:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q7sm368379iow.12.2021.07.23.14.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:47:56 -0700 (PDT)
Received: (nullmailer pid 2649238 invoked by uid 1000);
        Fri, 23 Jul 2021 21:47:54 -0000
Date:   Fri, 23 Jul 2021 15:47:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 15/54] dt-bindings: iio: st: Remove wrong items length
 check
Message-ID: <20210723214754.GA2649204@robh.at.kernel.org>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-16-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721140424.725744-16-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Jul 2021 16:03:45 +0200, Maxime Ripard wrote:
> The original bindings was listing the length of the interrupts as either
> 1 or 2, depending on the setup. This is also what is enforced by the top
> level schema.
> 
> However, that is further constrained with an if clause that require
> exactly two interrupts, even though it might not make sense on those
> devices or in some setups.
> 
> Let's remove the clause entirely.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  .../bindings/iio/st,st-sensors.yaml           | 41 -------------------
>  1 file changed, 41 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
