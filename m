Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770D250BA7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHXW2u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 18:28:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46109 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXW2u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 18:28:50 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so1133583iop.13;
        Mon, 24 Aug 2020 15:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pPxV5Cdh+vs/BDetb3c1wYzRLunbynyApl0aftF7yTk=;
        b=aBTvafkrvUtup4FPY5T21hSf1RjfDlUnqYTO5bIkAJpiKfvD8ybnwOs+1Gg+ytAgx9
         kWJykqyFJ7RsJ7Y9Ld4hg9gK5PrPjVTEdIiUoxnqie1xW3m+8kDCHYmkmoTluoIeMwuY
         H2pOGcnVn5LvDCDGxi3PhD2sNCYTSrJtKMDsv8J1YnVkrTB64xm1HOuFYv3Cigf970Z5
         yCgkYrbWs1pEZh2luZYhoWclaZ2Bex4igZHeOOl8vLKsCf29BmDlcWLd0cn3GdKZEy7x
         4mSGiYsVMOOGOXGAEZNL+hadlfGEgB52uwHqxB8gD6t20l2CHFKJrM+KA1434qE8UcDH
         I6qw==
X-Gm-Message-State: AOAM532rxOmzdtY6XwqIVLVvbNH+FQCJBc9I9VE0j1Z9WfjctGJcO/Sb
        t0QdayeoMj0mkFa5BJzAnQ==
X-Google-Smtp-Source: ABdhPJymXDmIiE0KeFE1pYhiN37UtMRKvGl8wKiFSycay7/S1rGGpnJMml5yA214piCa5OfrkmhSMQ==
X-Received: by 2002:a6b:681a:: with SMTP id d26mr6640267ioc.70.1598308129193;
        Mon, 24 Aug 2020 15:28:49 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id n5sm8009267ilj.43.2020.08.24.15.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:28:48 -0700 (PDT)
Received: (nullmailer pid 3434133 invoked by uid 1000);
        Mon, 24 Aug 2020 22:28:45 -0000
Date:   Mon, 24 Aug 2020 16:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
Message-ID: <20200824222845.GA3434080@bogus>
References: <20200810033806.15503-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810033806.15503-1-chris.ruehl@gtsys.com.hk>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Aug 2020 11:37:52 +0800, Chris Ruehl wrote:
> Conversion of the ltc2632 to yaml format and name the file to
> 'lltc,ltc2632.yaml'.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> v6:
> Remove tab and drop unused label
> Related patches already in linux-next.
> [PATCH v5 1/3] iio: documentation ltc2632_chip_info add num_channels
> linux-next commit: 6f1c9e0da9aae51177457731357ae8a2c8af27cd
> PATCH v5 2/3] iio: DAC extension for ltc2634-12/10/8
> linux-next commit: aefa5bc87c808dd08db2fc79ebdbf19ed4af7be2
> 
>  .../bindings/iio/dac/lltc,ltc2632.yaml        | 77 +++++++++++++++++++
>  .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
>  2 files changed, 77 insertions(+), 49 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
