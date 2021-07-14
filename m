Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC83C880F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGNP6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:58:39 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:35706 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNP6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:58:39 -0400
Received: by mail-il1-f180.google.com with SMTP id a11so2087908ilf.2;
        Wed, 14 Jul 2021 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRFNtf9i7LUrBWOlXHfhVvsKW29kAFwerAW8yQlkGDw=;
        b=Zjoclc2Kjbq0zERX4rBHWj5ywprIxh9o0LlpOSVWlvmvnxhwpeXDN0Rr05stkaS87c
         vzy/sY84WFY64JU6QOPKiPcsidQg4dsPnuugp0n79BwVwa7thO9IjOkGRdAbX9pnJRHs
         GGhnt+AoCIxu2GIANrYqydt4y50ZCIAcPRDfzKFD225kq5B1aShi/yVMuM0NZZVLeY4z
         z0YUwf8eLgZSYsdlOI5H6Z4j4TzO4pZUicsrRcbVyY8RHqR03T/AOT4JmQb1BcpTo2lv
         jkFRhDce08rY+yzRK/OxXn504gm/hK/V61uTR4ZnHvp8J7dR0QzKrlw9UBWpy/2U8Mig
         anww==
X-Gm-Message-State: AOAM530/rolXtr/cgMyn/ZI49DwE6vQKPlIWBZQk98MeCDOtHbe4cc82
        sicpFrv9ba4E/vjMyj6pTg==
X-Google-Smtp-Source: ABdhPJw8Pro8yfdZEfI1H8GP/0xaJXXjVBIz0czf18VYFbRH3WL06+eAWucJW00WkuC72LqwkcOd8w==
X-Received: by 2002:a92:b003:: with SMTP id x3mr7242182ilh.93.1626278147099;
        Wed, 14 Jul 2021 08:55:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 12sm1383263iou.15.2021.07.14.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:55:46 -0700 (PDT)
Received: (nullmailer pid 2649475 invoked by uid 1000);
        Wed, 14 Jul 2021 15:55:42 -0000
Date:   Wed, 14 Jul 2021 09:55:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 07/15] dt-bindings: iio: dac: ad5504: Add missing binding
 document
Message-ID: <20210714155542.GA2649423@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-8-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:36 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Binding for this high voltage DAC with temperature event signal.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/dac/adi,ad5504.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
