Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48B3B37D0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 22:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXUbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 16:31:16 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:44610 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFXUbP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 16:31:15 -0400
Received: by mail-io1-f52.google.com with SMTP id h2so9857536iob.11;
        Thu, 24 Jun 2021 13:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGjkqdWMJk8hr3ylOB03Y00XZ2KWJfOU+B9pPQnUdw8=;
        b=iS7ISSpN0PLMbQev+ds/IhZLdXMzr/pX2vXPwKkjVJNopJNQydlgoAKXqiDDTeXgh9
         W+1GOEN/pHcnvlCSZPnQ/RlmL+9RHAME2U+cHCPu+G5KsM7DX9qzF9BolmBQNUfTC6hH
         qp+pv6tlRY7fCnSoeu94GUdE1Bo+fOqXhBYYHdbINQMQFR/oKPpGVm8dmZX0TNaNrjjb
         V6rNOZX36idXnX795dsddc+TrA03J9e+Q/ZGepgjgPcRstRz+z7fhLc4fmDcgAsdeugw
         e5v9I5vd64TQYuewYivMQN4AmO0ozbKC+iR0CGAUKPIUXaAZhMgYD4g4NDE4aW3BmUVl
         ydMg==
X-Gm-Message-State: AOAM532B2BVJvy4tCT25QOfVqCdKfvnod8JIgnooYe3kmZDXjdYOW3e6
        kUpbZfE3pH/kiMwwAdUufQ==
X-Google-Smtp-Source: ABdhPJzwMEC6jd7wJ673WAnl5B+OHlyH2s7timnEek7N882Z54GTDxw4SMD2sVgqfioQCqDo8IvmYg==
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr5360950ios.141.1624566536152;
        Thu, 24 Jun 2021 13:28:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k4sm1963191ior.55.2021.06.24.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:28:55 -0700 (PDT)
Received: (nullmailer pid 1935915 invoked by uid 1000);
        Thu, 24 Jun 2021 20:28:51 -0000
Date:   Thu, 24 Jun 2021 14:28:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        Nuno Sa <Nuno.Sa@analog.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Message-ID: <20210624202851.GA1935863@robh.at.kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
 <20210614113507.897732-16-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614113507.897732-16-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 12:35:05 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
> as it is now clean and ready to move out of staging.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
