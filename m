Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74C247C27
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHRC2f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:28:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40635 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRC2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:28:33 -0400
Received: by mail-io1-f65.google.com with SMTP id b17so19686440ion.7;
        Mon, 17 Aug 2020 19:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjzogNP5tTTXxoVLvj1gyI8tv/q78wYu/fnSVZqZ+/8=;
        b=fh1ojDibsfZLLOr8k52ImcXuwYNqwqCUgVIiMbssKiFjusiYZP705Iy2Q+jcEZEQfn
         7pPOgK5uWZq7lTTN6IBBJ1hdc8P67tHVJDjdzTIPkAhAZKGb4pKntSpTd6mFgNmKIv20
         Ris75J5E/meT+BDx1MAgOZu0NpLkr9ZuYdzyV4enOEUQbw7lwRrDe5cRUOOKUSbK+UCF
         /sbZzXWK+lgPfauc9LxE/XYCpbSSSPEExRLPkc5FahthgEQATZjyMHUIE9kk3DBNxQ6C
         tr8/um2z1t5LoHtlqXhS6V5oFnySXA8ZW1DInfRilI5I4APYDhOYGHefwQmAs+f0D+w9
         gY6g==
X-Gm-Message-State: AOAM531QBl+yF5+CtSZXvbz4nCfCcIfIh3kIG1qyJkz+aauf7Ym6zKg0
        DT9gzAvtq1N3UKpOXspQeg==
X-Google-Smtp-Source: ABdhPJzpsUa7SGdZE8214ZXBbMN958PR7m5g+fbVxLcNX8xwjKwsZF2I2qc4EISOFat1W2Al7504Lw==
X-Received: by 2002:a6b:e006:: with SMTP id z6mr14416973iog.118.1597717712644;
        Mon, 17 Aug 2020 19:28:32 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r7sm9845867ioj.42.2020.08.17.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:28:32 -0700 (PDT)
Received: (nullmailer pid 2168803 invoked by uid 1000);
        Tue, 18 Aug 2020 02:28:30 -0000
Date:   Mon, 17 Aug 2020 20:28:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 04/13] dt-bindings: iio: adc: lltc,ltc2497 yaml
 conversion.
Message-ID: <20200818022830.GA2168744@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-5-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:44 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very simple binding for this i2c device with a reference supply.
> 
> Added the #io-channel-cells property to allow for consumers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../bindings/iio/adc/lltc,ltc2497.yaml        | 44 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/ltc2497.txt   | 13 ------
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
