Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1538733C185
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCOQUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 12:20:18 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:33924 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhCOQUL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 12:20:11 -0400
Received: by mail-il1-f182.google.com with SMTP id z9so9909635iln.1;
        Mon, 15 Mar 2021 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kr4OMC1op1BT+aoSdNJWUJjIKZl6gd8/tZF3DArBYO8=;
        b=U05RfH8EcOnW82vZwUsg4+KUEbtS3wuzv26VI+bx1j3ssbDHn4r04Sic5wTqB73xxG
         y01gw/a0tR5Kl2J4J8aFRB5dGBJn68WEwjCoIVsB8qkwAnXi8sFBMmflrhmasonGzjxN
         hc06GBO6IhcvjXpA90/Ks+Qb/LwfJN7z7Y65HxaF3LwWVpFcFt5TRaDxTsSEOTB7Ok7u
         YvQfVav1dh9n7y/qtKs0LxFYyFNrKdeWAA7K7hlHZIflCPEqiiw+6JWN8L6IssJ7W/T4
         a3UbEvRThh+r+8/axV5bBKb2E29NWn3sgarBbZGuDL1hAV6XpI8Tqkq+1bOjF+afKqV6
         gTWg==
X-Gm-Message-State: AOAM53246H5zecOODyoPBjQtY6j05E/oYT6UFlIfkxcXMSr+bcBfy9BQ
        3cUHeGoZKYFsWwFONO7OqA==
X-Google-Smtp-Source: ABdhPJwyJu/KGiP4wsae33e5rozsMMIRwiCYEhCbt63FG6Yf/6k0s/A3J6Q0q4Gxq1bALwSOPLuK0Q==
X-Received: by 2002:a92:4a03:: with SMTP id m3mr281296ilf.185.1615825210549;
        Mon, 15 Mar 2021 09:20:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h193sm7479901iof.9.2021.03.15.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:20:09 -0700 (PDT)
Received: (nullmailer pid 972277 invoked by uid 1000);
        Mon, 15 Mar 2021 16:20:07 -0000
Date:   Mon, 15 Mar 2021 10:20:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] dt-bindings:iio:adc: add documentation for TI
 TSC2046 controller
Message-ID: <20210315162007.GA972089@robh.at.kernel.org>
References: <20210312105515.32055-1-o.rempel@pengutronix.de>
 <20210312105515.32055-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312105515.32055-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Mar 2021 11:55:14 +0100, Oleksij Rempel wrote:
> Add a binding documentation for the TI TSC2046 touchscreen controllers
> ADC functionality.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/iio/adc/ti,tsc2046.yaml          | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
