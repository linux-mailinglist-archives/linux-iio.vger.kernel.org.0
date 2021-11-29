Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF84627DE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 00:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhK2XOT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 18:14:19 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37442 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhK2XOD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 18:14:03 -0500
Received: by mail-ot1-f54.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so27702022otg.4;
        Mon, 29 Nov 2021 15:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77kfHfyKGJ2HztDbkf8db8E89hhLx3pJaRAlA+q2WdA=;
        b=BUKv+/K/QOlJ3EiNiYDUcfiiLlbYtzZD5IFGjCaG/rR08pFkZsAj20+XC7YLKR9zjD
         LKVGSP7wHQSLmvoTc8Lg1ewtzVQA7wYoWWlsuC5SW8SPfVcL0AeXXo3WC1rsTZDTHyKE
         /9Ve6O3m0f6vWTZiZ4fFSAOC2g8m4sCj/r4543KjjdKUDNCEWBVv97zddHsNXZ3WnhKb
         yOPh17NfB3QtBPbcbCSXAabFODSykx1yKNnRd7NM8TxA5LVosL1Wrev3YirT2zrWovaJ
         CMgxxH5kuCm7SN9j27RnI2V9Um3QQExeCD7L7N7hANEuuxB4GYQsyE+TRNqLJP8QyCZQ
         zhVg==
X-Gm-Message-State: AOAM533IvD17lw5hZHedJG6KmF+7s9EOmB+ART+BXBkOQ3H3iJm6h8NH
        JiUqONwwg3mVUZNllpAZftKR9I7mMQ==
X-Google-Smtp-Source: ABdhPJzrS04xDvnfnIZ1XN9JO4RsOgrUAO7Dh8tTPy7CGy/xndNLVkSkQDhjeCH8MEhP+1xzk0C//w==
X-Received: by 2002:a9d:390:: with SMTP id f16mr48399715otf.325.1638227444397;
        Mon, 29 Nov 2021 15:10:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j10sm2466931ooq.5.2021.11.29.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:10:43 -0800 (PST)
Received: (nullmailer pid 785298 invoked by uid 1000);
        Mon, 29 Nov 2021 23:10:42 -0000
Date:   Mon, 29 Nov 2021 17:10:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <foss@0leil.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-iio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <YaVd8j4fj69pmsnU@robh.at.kernel.org>
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118141233.247907-3-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Nov 2021 17:12:33 +0300, Evgeny Boger wrote:
> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
> TS pin. axp20x IIO driver now report the voltage of this pin via
> additional IIO channel. Add new "ts_v" channel to the channel description.
> 
> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> ---
>  .../devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
