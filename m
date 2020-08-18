Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D6247C32
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHRCaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:30:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44445 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRCah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:30:37 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so19614373iow.11;
        Mon, 17 Aug 2020 19:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkYkCuZTYOXK/1NyvMhhSwbAlGprF1p1HI2uuyPdLRo=;
        b=rIFwJGUUc5TMQHhBNFEPixPf1FHzfCyTFbVjb2eoEeGPbuDMfcvOGYcaZgFARIXu7u
         pmw2KaZQZZOM2NuDw4XJbGiAMVms9BV7/Tr/Qv/ix/asKFm8r7FWnC75sl0h49Sqlvi5
         oTtlsjjcDZGmU94ursXV9G/jAlGXIbY8T9tOEJR5ng1WdIcU+sVpGOaR7guXYg2x2wSm
         KuTER2RUKF7QZuPQrz+e1Ielt0MIWL6PqRmIIVtwbc8QPi+3WPLvQ79M6dKx0N226vxt
         Oehwtohs0SEYu7yf4cnhapg+u3IfPN0Pcne0eWyLgNKPpfeGrbqLB2hhBMgkC/qHRnlT
         5GGA==
X-Gm-Message-State: AOAM533lygGqc0E5mHskltm5LXOFKcw/JXewU1bUmtk5NlxlJESEd9/N
        7uFs0AKFbewqV4MbrsaO+w==
X-Google-Smtp-Source: ABdhPJxvCk3+gX0F37Lj68RXtA6uAC5NiEzSlyuSk5C4FlAZrKTnNiL5HQGoGjoeKgW57r2nfwhO9w==
X-Received: by 2002:a02:730b:: with SMTP id y11mr17527101jab.126.1597717836205;
        Mon, 17 Aug 2020 19:30:36 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c88sm6629611ilg.5.2020.08.17.19.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:30:35 -0700 (PDT)
Received: (nullmailer pid 2172514 invoked by uid 1000);
        Tue, 18 Aug 2020 02:30:34 -0000
Date:   Mon, 17 Aug 2020 20:30:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/13] dt-bindings: iio: adc: ti,adc128s052 yaml
 conversion.
Message-ID: <20200818023034.GA2172484@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-10-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:49 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding.  Only addition to txt version is
> as a provider of channels to other devices using the consumer
> binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  .../bindings/iio/adc/ti,adc128s052.yaml       | 59 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc128s052.txt        | 25 --------
>  2 files changed, 59 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
