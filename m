Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD34F261DFD
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgIHTo4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 15:44:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35529 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgIHTou (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 15:44:50 -0400
Received: by mail-il1-f193.google.com with SMTP id l4so91938ilq.2;
        Tue, 08 Sep 2020 12:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3xtBC39CZgwRvTtp6n/epd2lOGTmsGabfSGcJrY4g4=;
        b=WXiAgrsNgvhTnIVOFD2XGXr5RLoyf1Mz0nApdRXQRhktli630KkfghvEkiPmMBtde6
         G825JiecEi5Ipf5jVVRCXqvz2uIFVoGiFTpmmRzY/JAizuYChoRRJLqxdn9HvxfbB8zd
         X1zNjKfp29FoL49Y6xhAXYy23QZ4DYsYkHuyflx+e4YjYYUUvcVcLs9VhVVRvdJF1//W
         HAtfE/YTzZs4QTjAL7zyeqpnNo0JSR7j+il8ZtM7bnMviggMj45ms5p5+PezAyRjoLHZ
         YcT4HBvFYlyqxTUbz9csEzxRykA1ZFJ4cigWrjURS9AM7N6eOlAzPde0DFlCqQrmg6YW
         eDvw==
X-Gm-Message-State: AOAM530qcXvqCJ7exNd8OD8SGcjgdwWqWM+BtXNRkhwDAl6cSaiO+peM
        buwBH593HOMX5WVL9R2UPQ==
X-Google-Smtp-Source: ABdhPJwiaJHc9+2FWqhHmrwfZkXwadVWnnvvrWUJptsGOLlriuemrrJR2l1thSDKawc2KsZf8qiJaQ==
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr353955ilg.227.1599594289150;
        Tue, 08 Sep 2020 12:44:49 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u17sm65547ilb.44.2020.09.08.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:44:48 -0700 (PDT)
Received: (nullmailer pid 785807 invoked by uid 1000);
        Tue, 08 Sep 2020 19:44:47 -0000
Date:   Tue, 8 Sep 2020 13:44:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/20] dt-bindings:iio:adc:marvell,berlin2-adc yaml
 conversion
Message-ID: <20200908194447.GA784758@bogus>
References: <20200905173004.216081-1-jic23@kernel.org>
 <20200905173004.216081-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905173004.216081-6-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 05 Sep 2020 18:29:49 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Part of a general move of IIO bindings over to yaml.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  .../bindings/iio/adc/berlin2_adc.txt          | 19 -------
>  .../bindings/iio/adc/marvell,berlin2-adc.yaml | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/iio/adc/marvell,berlin2-adc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/adc/marvell,berlin2-adc.yaml#


See https://patchwork.ozlabs.org/patch/1358086

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

