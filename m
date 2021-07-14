Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317223C9418
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhGNW7K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 18:59:10 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:36438 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhGNW7K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 18:59:10 -0400
Received: by mail-io1-f42.google.com with SMTP id u7so4181374ion.3;
        Wed, 14 Jul 2021 15:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fz1rz6E9JCbKFxstFk2ckl0238MIJflfpA68L0i25aI=;
        b=Q/xU1MzDXezOz6rXQ45hRH8vHlUXjmmq9zQBDPweNes/H6mwNl1kwN9mnr+pVZQ3lz
         pJEgZ8PKqaf6hgW8Mg5QWS4lsopRP3uY5NprhidJbMPrxP5D0uXUPHOvty8hjAbpdm/S
         7pBzJiP6sSALp2UtWwGTPIAkwDF1beuIS0MPVsxwYufRzL4aSy4cTTwUxly06xest2uB
         51GlHn0WnQuCwb+lp9no5pgi965+HDCXKAsRBXOJDt5+v0leyPwfH9yI2w1pcoBsLu0S
         1aIBKml74Fg0EOILD04mZXGaj5W1hN78rNNLVenwGdVPlK1/cJlA5Y1F4mdiOZb1TEHL
         k94Q==
X-Gm-Message-State: AOAM530zIxqIgs0B0bJ5HBh6CGmMeiLJorOwWGMm6ljgNk0AUnrfbzVO
        rDV417Pn2M5d5iVA6y8RGg==
X-Google-Smtp-Source: ABdhPJyddzQThO1zPUtr1UgcQAS3g67vyXuG9wMNNXt2AT0by2IAtXf37buqgBCz9UNl1EsHZHAB7A==
X-Received: by 2002:a05:6638:c58:: with SMTP id g24mr486982jal.63.1626303378298;
        Wed, 14 Jul 2021 15:56:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z18sm1950080ilp.68.2021.07.14.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:56:17 -0700 (PDT)
Received: (nullmailer pid 3692763 invoked by uid 1000);
        Wed, 14 Jul 2021 22:56:16 -0000
Date:   Wed, 14 Jul 2021 16:56:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Message-ID: <20210714225616.GA3692729@robh.at.kernel.org>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
 <20210702111239.174189-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702111239.174189-2-antoniu.miclaus@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 02 Jul 2021 14:12:39 +0300, Antoniu Miclaus wrote:
> Add device tree bindings for the ADRF6780 Upconverter.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  changes in v4:
>   - fix dt_binding_check detected issues
>   - update license to GPL-2.0-only OR BSD-2-Clause
>   - add dependencies schema
>   - other minor fixes based on the review received
> 
>  .../bindings/iio/frequency/adi,adrf6780.yaml  | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
