Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF0365CC8
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhDTQDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 12:03:35 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42945 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhDTQDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Apr 2021 12:03:35 -0400
Received: by mail-oi1-f171.google.com with SMTP id n140so39410142oig.9;
        Tue, 20 Apr 2021 09:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADnmKHAsx4NVOEncBCc7lt8okoolcZcwGDkULCgdHiA=;
        b=U7LnBcxYXRkYAwGEe+sXhvhb8Jtdr9kRGi7ANdrbRMTzkk0T9A9ezmBcX8bWlUH1DU
         1BRx0/8OsY+JlO2hrwWqWGSvjJxJXuAjJvApqsOlH0e0UCYdNSk7aLAvK2nU+r0Fg2z8
         Fxi7s49M4+fhUzAAApnfA8TWi8Ow1PU1X2/9KD9AHw2pZO0HQMTmB4lj+K+7sNZjukCl
         QUXGAiW4yCLKAx2WswO0vblheFcYPCrJ1JdBJYGkAInfzpe20X1RhQLHj7rTDphPmf1U
         6xejyGx7cUVS2JIuoP/BFCGrAap9ue/uYp6Tj3yj0cD4bA861thwBrhkF0xfP1CKC5Lm
         tuGQ==
X-Gm-Message-State: AOAM531Mf/UgGnbWd9kvVZSSX7BoWYuCAjfku1x2HV8hwTtlxKpgwlH0
        Kv8OlyewxXn4Tv2O+V+Rlw==
X-Google-Smtp-Source: ABdhPJw82p9JhXTo3yZ4APAxY73n7AHXducX/yk5pYR8J9Evr3+dNCSYhaVBnlf8pvYh0ibcuiijeQ==
X-Received: by 2002:aca:dc87:: with SMTP id t129mr3662364oig.137.1618934581641;
        Tue, 20 Apr 2021 09:03:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 93sm2862901otr.31.2021.04.20.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:02:57 -0700 (PDT)
Received: (nullmailer pid 3401936 invoked by uid 1000);
        Tue, 20 Apr 2021 16:02:56 -0000
Date:   Tue, 20 Apr 2021 11:02:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: accel: Add SCA3300 documentation
Message-ID: <20210420160256.GA3401889@robh.at.kernel.org>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
 <20210420132333.99886-2-tomas.melin@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420132333.99886-2-tomas.melin@vaisala.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Apr 2021 16:23:32 +0300, Tomas Melin wrote:
> initial DT bindings for Murata SCA3300 Accelerometer.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  .../bindings/iio/accel/murata,sca3300.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
