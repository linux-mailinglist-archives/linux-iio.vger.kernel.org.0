Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFADA22176D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGOV6Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 17:58:25 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45966 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOV6Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 17:58:25 -0400
Received: by mail-il1-f194.google.com with SMTP id o3so3327523ilo.12;
        Wed, 15 Jul 2020 14:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQTLdwvSzoY7qnrKs3bx2cK5No1Qw8keJ6Qduu3x6DY=;
        b=s1eT6lA+qbDvhcbvnEpW2mgmfUIPF1f7hUsuM/djo0j96VYjnBko7kfzvBvQ0ge6ZH
         vIqVOb+lbFCXBIFDx0Fk+dqMTqAsQmS+g/a67hM1LAz5/PwlV8uNLG3IGGoqRU+a/GmN
         nHStAtNK3BjCSe2jS1yNeCB8YNL38+C3y4VIgDDiDbN4M6Y+8tMnkQSdH9E3o4n/7H+M
         E9Eg2F714N4MxJR7CyqZFGNoeyFAqhydP4NR35NLwTDk/K38N+/FZuN+y/5EbLP9Dmol
         rqhkEZKYgH8bJOYGRyyKdNIsMMsZWx+xrfY+krKynTF9AcGhfqLo/gBe+nyNOi0q88Vr
         7n7w==
X-Gm-Message-State: AOAM5308wOZg56srOcbsbweSKgntJvmuw3joP70YprDzh4TIlXZsw6XX
        q8GYDxm6sHBmDQmkJ/3fPgjz+eXbRQ==
X-Google-Smtp-Source: ABdhPJxJoVaaBbWoU64Z+i+EAbJPZz4ZBb/zRSAl7TxI1CXvbm++wX5KDuLJHIJLUZfs6ksOgPvOuw==
X-Received: by 2002:a92:488f:: with SMTP id j15mr1563921ilg.269.1594850304394;
        Wed, 15 Jul 2020 14:58:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r124sm1711394iod.40.2020.07.15.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:58:23 -0700 (PDT)
Received: (nullmailer pid 888952 invoked by uid 1000);
        Wed, 15 Jul 2020 21:58:22 -0000
Date:   Wed, 15 Jul 2020 15:58:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] dt-bindings: iio: ti,ads8688 yaml conversion
Message-ID: <20200715215822.GA888901@bogus>
References: <20200705131720.240574-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705131720.240574-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 05 Jul 2020 14:17:20 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly simple binding.  Most of the changes were filling in information
> not previously found in the binding.  I dropped the previous explicit
> mention of spi-max-frequency as that is covered by the generic SPI
> binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Sean, are you fine with being explicitly listed at the maintainer
> of this binding?  Previously we didn't have that formally laid
> out in the old txt bindings but it's now a required field.
> 
> I'm going to slowly work my way through some of the simpler yaml conversions
> over the next few months.   Of course I welcome anyone else taking
> some of these on but for purposes of review, please keep it to only
> a few at a time.
> 
>  .../bindings/iio/adc/ti,ads8688.yaml          | 45 +++++++++++++++++++
>  .../bindings/iio/adc/ti-ads8688.txt           | 20 ---------
>  2 files changed, 45 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
