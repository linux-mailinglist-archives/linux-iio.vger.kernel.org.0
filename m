Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A223AFE1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 23:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCV62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 17:58:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44938 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCV62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 17:58:28 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so24895386iow.11;
        Mon, 03 Aug 2020 14:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tk9R+9ti9qwUNfwKpXRUC+vzSncyu3vSdfJgtp7CwUU=;
        b=kzBOmE65ybLCj29oUwVkPnu8XZBqKjVbDyTq2U+RL06GR+egy4SycIlXnmBybO1YLk
         NQgdKN8PEdb1bl5ViMi1efGQFWTaPr/7VQCrzPw8pmjAZ3iMbQ0951wDG4qwErfv0S7h
         D4QEsgfuIdVAsst4qtRtQPm2ShjR7PRs8MwTgym+OVD0n7aTufg1vlc6J+0wATi3Bacp
         yNYWGXvOsS7jSF21D/PsQz4AX1xZIRcjsMYvswHlCAz5ltkArtwfHwDEZ3uAz6VQ/IMS
         2Tbb04yf4c8J//ULphyz0GCf7oMBerGU23hcUVkq/p1TLwWE8hQNyPEIUx3a4gA7qom7
         7fMw==
X-Gm-Message-State: AOAM5327+fVX9xP+bEusrhhXql26xZW2qXqiEsyrvNUqlnYW4CH3+NB/
        aSbc0vVGt+3VDXRoGPVJVQ==
X-Google-Smtp-Source: ABdhPJzZkYiklS4YCr+61tDmXUEFuV6zWukOJ7e4K8TI/LNRT9xwQpUwcG+0wzjSA//q2jkGmfwAQw==
X-Received: by 2002:a02:76d0:: with SMTP id z199mr2075134jab.39.1596491907624;
        Mon, 03 Aug 2020 14:58:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p3sm11398308ilc.45.2020.08.03.14.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:58:26 -0700 (PDT)
Received: (nullmailer pid 3211639 invoked by uid 1000);
        Mon, 03 Aug 2020 21:58:26 -0000
Date:   Mon, 3 Aug 2020 15:58:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: iio: adc: maxim,max1118 yaml conversion
Message-ID: <20200803215826.GA3211566@bogus>
References: <20200801175850.1140006-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801175850.1140006-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 01 Aug 2020 18:58:50 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple device with a simple conversion.  Special handling needed
> for the max1118 which is the only supported part that has an external
> reference voltage.
> 
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> * Added additionalProperties: false. Other changes are to make this work.
> * Move the vref-supply definition up
> * Add an else clause
> 
> .../devicetree/bindings/iio/adc/max1118.txt   | 21 -------
>  .../bindings/iio/adc/maxim,max1118.yaml       | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
