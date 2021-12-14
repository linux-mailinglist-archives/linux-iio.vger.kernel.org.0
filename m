Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B009474724
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhLNQIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 11:08:34 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44856 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhLNQIc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 11:08:32 -0500
Received: by mail-oi1-f172.google.com with SMTP id be32so27699222oib.11;
        Tue, 14 Dec 2021 08:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZNvON25TsmO8LX7NN22FohLWfskQmVGPfJRP/nd6Kwg=;
        b=ixiz+Ayz9pb7x0ubr6j1Rl7EUdW2brEt0H0VnjKn70RPes1TkMcFjsiHeo69pr5L4P
         Hk6AoSvY56gZgWJMj8VogivMBnrUTCc8bLtxeKgCtMWb8NSw0vb8nxCmU/Spcwkq9acC
         lbIcRqbkdYhb6ZQWRN/fLUOdgX3ChRpCB/j/UDFh4EwyZk8EoRPd4HGpe0Ew0ZePQtnD
         SVC6exP8bJ5AMM7oPQ/LQeAwsk7aAhUv5URhQS5viqM2KNfEsevz4MM8CB1sWw9VRvgi
         iMJfK3km1negrnKkepVQI4oDuv+I0e5UCM5gEFT4oWW4oRsY8ywSYu88Zx+xBbm94Jbq
         ikvQ==
X-Gm-Message-State: AOAM532/34MwzK8SvQnX8I/BqVRWMsbw0egQGJb8zquzCf+0Z/6TRkP2
        nTeqUvghjw250+vryPmTRQ==
X-Google-Smtp-Source: ABdhPJxpBgOBAPTkUBf4uAxqEk/iZVOwp8n88IpX0XBmuncldMF5kftsNIZR2MMyerp9nLJNjAsIOA==
X-Received: by 2002:a05:6808:dc5:: with SMTP id g5mr4986910oic.58.1639498112167;
        Tue, 14 Dec 2021 08:08:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i29sm36728ots.49.2021.12.14.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:08:31 -0800 (PST)
Received: (nullmailer pid 3479533 invoked by uid 1000);
        Tue, 14 Dec 2021 16:08:30 -0000
Date:   Tue, 14 Dec 2021 10:08:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     andy.shevchenko@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, robh+dt@kernel.org, lars@metafoo.de
Subject: Re: [PATCH v7 4/5] dt-bindings: iio: Add sx9324 binding
Message-ID: <YbjBfoAXPFKxFI5c@robh.at.kernel.org>
References: <20211210192328.2844060-1-gwendal@chromium.org>
 <20211210192328.2844060-5-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210192328.2844060-5-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Dec 2021 11:23:27 -0800, Gwendal Grignou wrote:
> Similar to SX9310, add biddings to setup sx9324 hardware properties.
> SX9324 is a little different, introduce 4 phases to be configured in 2
> pairs over 3 antennas.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v7:
> - Fix 2 remaining syntax error in example.
> 
> Changes in v6:
> - Fix syntax errors in device tree binding documentation.
> - Run 'make dt_binding_check' to make fix errors.
> 
> Changes in v5:
> - Use consistent field naming, prefixed with phX.
> 
> Changes in v4:
> - Use const instead of single enum
> - Specify ph0-pin better
> - Recopy type information for phX-pin
> - Fix cut and paste errors.
> 
> Changes in v3:
> - Remove duplicate information.
> - Use intervals instead of enum.
> - Fix filter description.
> 
> Changes in v2:
> - Fix interrupt documentation wording.
> 
>  .../iio/proximity/semtech,sx9324.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
