Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115C83C87F3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhGNPwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:52:44 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:33523 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNPwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:52:44 -0400
Received: by mail-il1-f181.google.com with SMTP id z1so2094570ils.0;
        Wed, 14 Jul 2021 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQcGmQ8pAQeAA2QdBEuPJq6+K/3yQ98L+WLLnfW0HFA=;
        b=AW+MLTletzQph/SHDLeJBtx1b1ejKaY9pQBq6TvAqitoJ2FywJTO54uLrgx4I3oyyk
         DckU3WIKmJNg0t8tBe45zf0qA5SXZLAheWji8iEXytdh+XVR3LuS6UvW6X2xjM7NK6VJ
         +oJJs9zM5O4uHh83mdh/dKp8xohTvujF3J+g9Uo2uxxMZWbrT0EgkQY9CjVSJveHMWeJ
         i4BuQffhBKR2mfkVC1FjTsLroI0CXbbPZPLgmgFHrkVMXvrdJX3Dnuoo9zyDZTdaCUuG
         NaT1b63mZ/cKuTZi8BiR2+1X9c+KmlAQ9EwkHZDwvSm/f2H+ezuLrNt1tIGKUjnfQ/dq
         l/PQ==
X-Gm-Message-State: AOAM531YWJDxDIu1ygNmEtwWPWBFyB850wuonL9Q9QuNVqK+d6FIdDWL
        a49NRvpH1oIJRIn3T9DC2Q==
X-Google-Smtp-Source: ABdhPJxmSMn1GuFG8GGdYaEZ5QxexRzv+LmbD1Pix18dMgLEN5eNJy0xQkAkxk8sp6nWWdbcNaPssw==
X-Received: by 2002:a92:8750:: with SMTP id d16mr7332624ilm.281.1626277792540;
        Wed, 14 Jul 2021 08:49:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b9sm1540672ilo.23.2021.07.14.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:49:51 -0700 (PDT)
Received: (nullmailer pid 2639945 invoked by uid 1000);
        Wed, 14 Jul 2021 15:49:50 -0000
Date:   Wed, 14 Jul 2021 09:49:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 02/15] dt-bindings: iio: dac: adi,ad5064: Document
 bindings for many different DACs
Message-ID: <20210714154950.GA2639907@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:31 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note this is documenting bindings that have effectively existing ever
> since this driver was merged. The naming conventions for the ADI
> parts are inconsistent on the data sheets which has lead to a mixture
> of -X and -reference voltage part naming.  We could attempt to clean this
> up, but as we are stuck supporting the existing binding it is probably
> not worthwhile.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5064.yaml          | 268 ++++++++++++++++++
>  1 file changed, 268 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
