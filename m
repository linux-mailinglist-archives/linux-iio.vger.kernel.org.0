Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1869A4762AA
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 21:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLOUJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 15:09:05 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:38407 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 15:09:05 -0500
Received: by mail-oo1-f41.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so6246072ooj.5;
        Wed, 15 Dec 2021 12:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJpJ0ljbGWntpa5UwL50FK9KD8X/vANdlV/FONVM9ds=;
        b=s5znhuRaos7E2Clv7t0WPydLevkiZro6grGakWWksagVszVSq4gWAU3tMORTq7sp7X
         jTjnYaFEWx2cYjKP7EVKyxavocTs1mVyCeWBJY91CKLgfHgftppCYjUKCNLU0jeJjpm4
         YW3Rx4efDj16hdYSBaKb8xkjlXlI/jg87VkVLTFYCJq4f9aUNjFJjonkrOsfbjfb9wpa
         jfB2oT1Z592s3Fuh6LNMC/kRdZbSmvtGQzwuUoJix/oB/dyEE1CGGekFDyfm8BADEc3N
         6GiFj5cQ/6FwuKic9OPUrCnb2umOCUT9f7ZuGZpBu7NMyG3Eg3zH3odb35pvZskLZ3xT
         cJnQ==
X-Gm-Message-State: AOAM5306zY8IlJbkMs3e1Q28zT7gWeo4twAYACDzrD7PkJbKim/kT4aQ
        D9hBYsZmrde9wB6QMWknXQ==
X-Google-Smtp-Source: ABdhPJypLiLChB+k3nUOy2G12jHepV/leXslIqzeyY6CoofbDkLv89dy6aKtACQZUBQ88KagLqRONQ==
X-Received: by 2002:a4a:a641:: with SMTP id j1mr8696199oom.63.1639598945005;
        Wed, 15 Dec 2021 12:09:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w71sm525463oiw.6.2021.12.15.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:09:04 -0800 (PST)
Received: (nullmailer pid 1752705 invoked by uid 1000);
        Wed, 15 Dec 2021 20:09:03 -0000
Date:   Wed, 15 Dec 2021 14:09:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        swboyd@chromium.org, jic23@kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: Add sx9360 binding
Message-ID: <YbpLX0VVrakPBOUs@robh.at.kernel.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
 <20211213024057.3824985-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213024057.3824985-4-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Dec 2021 18:40:56 -0800, Gwendal Grignou wrote:
> Add binding to configure Semtech sx9360 sensor.
> It is a simpler version of sx9324.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v2:
> - Use const instead of single enum.
> - Use proper syntax for maximum/minimum
> - Fix spelling errors.
> 
> Changes since v1:
> - Fix cut and paste error.
> - Add . at end of sentence.
> 
>  .../iio/proximity/semtech,sx9360.yaml         | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
