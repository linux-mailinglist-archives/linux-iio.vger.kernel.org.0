Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484D2311352
	for <lists+linux-iio@lfdr.de>; Fri,  5 Feb 2021 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhBES7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Feb 2021 13:59:46 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45463 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhBES7F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2021 13:59:05 -0500
Received: by mail-ot1-f53.google.com with SMTP id o12so8117934ote.12;
        Fri, 05 Feb 2021 12:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/BK7ustIanoJNUJSQwM8o9ooyu4BgVSwj4bIicyTic=;
        b=S7fJSUFXvOIWWkK4akgRg28xjqYWInDb8vufn1DfnYV1uFt821jzBIdeyxh0NmTpSe
         pCZovB/QB1BMJ4l8IafkIsJHEYXspgjEe9FqiDG80PS+hzAlfEJqWzV0urpf/UbD5OjR
         LZON8//R9FiEnhYX3pdbs87H044MXLSJytbKwaJSzAguTx/APe9A8TSEIYI+z9lv7dlB
         Wvu0BheeKUph8mUgRCCY8TZPxUffR+9edOtHR21PTJkhK4y9FRBXCK4an3SY7OGMZXjb
         W75HwfK2yyQZlwXLh6HIeq1bugaATHa4U0FgNdwkCm+ZCwTvKnLpwJjPTuGylAPNqYEO
         i3Cw==
X-Gm-Message-State: AOAM533XhnwJoznb0KJi3+83XpdD2syehj/R8TSFT3pGFESGkUdxW7eV
        sHFbVYfUj3iy8OmXkVydyw==
X-Google-Smtp-Source: ABdhPJwU9TZ9VboIT/rxqywVBtj4ZrBVcJcUtNQ0dwYRAbHmJFXgjD/5F+v+to3u3RkkSwyUuCGYDQ==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr522752otp.9.1612557650111;
        Fri, 05 Feb 2021 12:40:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k207sm379560oih.32.2021.02.05.12.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:40:49 -0800 (PST)
Received: (nullmailer pid 3692690 invoked by uid 1000);
        Fri, 05 Feb 2021 20:40:48 -0000
Date:   Fri, 5 Feb 2021 14:40:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20210205204048.GA3692656@robh.at.kernel.org>
References: <20210125150732.23873-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125150732.23873-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Jan 2021 16:07:31 +0100, Mike Looijmans wrote:
> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v8:
> Add spi-max-frequency: true
> 
> Changes in v7:
> Add additionalProperties
> Change bmi088_accel to bmi088-accel
> Add interrupt-names and adjust description
> 
> Changes in v6:
> I't been almost a year since the last commit, sorry...
> Fixed the yaml errors
> Add interrupt, vdd and vddio properties
> 
> Changes in v5:
> submit together with driver code as patch series
> 
> Changes in v2:
> convert to yaml format
> 
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
