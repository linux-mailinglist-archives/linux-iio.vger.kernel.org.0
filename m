Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA5C3314E7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 18:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHRbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 12:31:24 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:40424 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCHRaz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 12:30:55 -0500
Received: by mail-io1-f43.google.com with SMTP id i8so10791367iog.7;
        Mon, 08 Mar 2021 09:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ww5R7YB6OMqN9S95aXNCM+yueiGYK0NTQTcF+jNYQg0=;
        b=TAqmKqEkcAyojfKGm/7LlOM3FN+Ch/RAMkb20UScp8d6vRYCuT7T9a270sM2C0+Ds7
         qMT1M0SLaH2eQENEYU59/NEAv63kHcPswgl+37J+gqZqxrzB9HNMSQvR6Ozu+GTYKPLm
         U7z8cphL7IaZIvDWWEHklVa1iJHDHoBQXfAn1K+K01DLku4cfGRzyH+BXmYKOqw0zZnp
         TyZlZSoQ5eSaAN6r3fdSa5HhXvgTZ6fG22KsZvey1DuQnmsg36t5HphSZaWq25icLmX9
         m+ObqCfBUJ5y4wFDeG93EkuTX5LxyF8MBQ71qjmhOsG/Az+xdSLSdQ5eaVTiO0e7T60B
         bzFQ==
X-Gm-Message-State: AOAM533pYBVyYC0Jy8OVN0PJXBHM8pqrlwW+ZZJAilb+xisLLacMatR9
        PhliDN6O6avxC70z/wN8miC0KdBx7Q==
X-Google-Smtp-Source: ABdhPJylYBdfP/xIoQXXvWHJVJQ11VrHFVJalq2Sa5FkojYGrThm6+8840gJxuiBFcRNHaP+9JVOcQ==
X-Received: by 2002:a05:6638:bcb:: with SMTP id g11mr24468826jad.96.1615224655309;
        Mon, 08 Mar 2021 09:30:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e2sm6311109iov.26.2021.03.08.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:30:54 -0800 (PST)
Received: (nullmailer pid 2667967 invoked by uid 1000);
        Mon, 08 Mar 2021 17:30:51 -0000
Date:   Mon, 8 Mar 2021 10:30:51 -0700
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: counter: add interrupt-counter
 binding
Message-ID: <20210308173051.GA2667913@robh.at.kernel.org>
References: <20210301080401.22190-1-o.rempel@pengutronix.de>
 <20210301080401.22190-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301080401.22190-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 01 Mar 2021 09:04:00 +0100, Oleksij Rempel wrote:
> Add binding for the interrupt counter node
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/counter/interrupt-counter.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
