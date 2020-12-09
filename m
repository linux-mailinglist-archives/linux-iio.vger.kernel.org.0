Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B043C2D4AC9
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbgLITqF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 14:46:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387986AbgLITp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 14:45:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id d27so3024607oic.0;
        Wed, 09 Dec 2020 11:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O4QZQahd+kb6lLt1jk16fpKTFa3TcPRasJZkWxq6wg0=;
        b=r01s4joNZoZFLDJWwjM6z2Vm21gt/Egcr7IDhG4UjPK+6hC7zKdTPggNiMNeFbx3my
         /oOKNnyHN/aMO1QQMtUe+uWku0evQDSu2TZfobH5KrkVZK23zHsg8RBEjHMAe72hiPkf
         32rtK36kVabJ1xAW0WlBd0hAxU36D1klRU0KSh0cvSSV6xpvDyBkb6ENuERrhTPG1MUW
         vd6fVU+nbilU9EKW/2piqQ9TlWG+rDc00cbl7faCx/NIyDN1R6n+M5sStI/9zVP0Gq3A
         AENcf0ZFyPPpbU1KX7E1B9ksPOx/3qWHI5vK4c4tTwOGd3FiRySZJ59ekpGK6dfiR8nB
         OSpg==
X-Gm-Message-State: AOAM533F/lj/RrhITKGHuJv3Q1PqTqwfExEdqkR6zlIiWM7qjWmlixTZ
        H9yAQKrp+tkWSlKfA2nX9zaQAVacaQ==
X-Google-Smtp-Source: ABdhPJwpM/OujPlyALjll/cAh28ibmMD6Whnp7JPX0eUi6J4d5l7ET3x5TlVcgKNxCLSQZ5H+/gIeA==
X-Received: by 2002:aca:ad50:: with SMTP id w77mr2992013oie.41.1607543117456;
        Wed, 09 Dec 2020 11:45:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c6sm487659oif.48.2020.12.09.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:45:16 -0800 (PST)
Received: (nullmailer pid 826880 invoked by uid 1000);
        Wed, 09 Dec 2020 19:45:14 -0000
Date:   Wed, 9 Dec 2020 13:45:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4] dt-bindings: iio: gyroscope: bmg160: Document
 regulator supplies
Message-ID: <20201209194514.GA826766@robh.at.kernel.org>
References: <20201202093322.77114-1-stephan@gerhold.net>
 <20201202093322.77114-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202093322.77114-3-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Dec 2020 10:33:21 +0100, Stephan Gerhold wrote:
> BMG160 needs VDD and VDDIO regulators that might need to be explicitly
> enabled. Document support for vdd/vddio-supply to implement this.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
