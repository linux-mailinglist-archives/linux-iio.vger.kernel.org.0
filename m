Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B83C881C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbhGNP7F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:59:05 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:33790 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhGNP7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:59:04 -0400
Received: by mail-io1-f52.google.com with SMTP id z11so2767713iow.0;
        Wed, 14 Jul 2021 08:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gT61I+y3voLYcHJBrlKmKOjOe+L5q5PFbLzIvXaf0sM=;
        b=Rbzf1wkAgXzfjQco5x46S/Mi0NivZhaJP6VYCPHZLJtu+Gey2/JttXC41Vj14xoPn3
         kjQqihFYjG2YWcJIyIY7YCdzVV565CuKSjtejG9paPycgvRGYk3pAh4mTP1Few6JSPz1
         EwWWAQ4wQrRQV+lT2f7iIEo8aS8pfEEzFLt1F38eMLCT1epj5JYSiy/RDraW33UVbswm
         HiQ5NVi6tKGFk+Nd8Gr86+zfC9gho0UWrlruml7ull9XlSmAIsQTKzedCXGSxoEG2rYg
         IoxA4Muf5sgRN59EoRSLq5abwg6Oo6F3NU81enw5GZPdabc1CPQyFH5ONrk7Pc+8Gdtk
         tGhA==
X-Gm-Message-State: AOAM530v0jDbFWc5qmFbeQpUqwJIwE0lALSwAig7Gf3mmUc+XC7268dw
        5hdVI+bo4lxI9I5sJz0tfw==
X-Google-Smtp-Source: ABdhPJxtF2OxSQWcZHjf5fS88gOQB4T9unhcsnbtqELeetBJaR8RPIMuhiVRbciRqbexsN/PH/N1cA==
X-Received: by 2002:a05:6638:24ce:: with SMTP id y14mr9286266jat.82.1626278172549;
        Wed, 14 Jul 2021 08:56:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m12sm1476540iln.43.2021.07.14.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:56:11 -0700 (PDT)
Received: (nullmailer pid 2650251 invoked by uid 1000);
        Wed, 14 Jul 2021 15:56:09 -0000
Date:   Wed, 14 Jul 2021 09:56:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: iio: dac: ad5624r: Add missing
 binding document
Message-ID: <20210714155609.GA2650198@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-10-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:38 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding, with optional vref.
> Note that the Linux driver does support vcc-supply for historical
> reasons, but lets not let that get into any bindings that are checked
> going forwards.  Hence I have deliberately not documented it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/dac/adi,ad5624r.yaml         | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
