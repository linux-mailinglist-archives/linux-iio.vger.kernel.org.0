Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92487247C2C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHRC32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:29:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43820 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRC31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:29:27 -0400
Received: by mail-io1-f67.google.com with SMTP id s1so6601100iot.10;
        Mon, 17 Aug 2020 19:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRB66w2MJgqQyApGcQsPcl+Nhb5geUiqMnsQiVzgExQ=;
        b=ZJoeIWgtfzl4bSvD5hiO+66EIV0SrR1aixipWbqRZyFuD93hF6bM4PLNz6f5aRGQEc
         RNI5Kfub8+FIvFZvQ3CTeRzHgC04LfrwZByrLbm7FxEHEz4wOPFG2OuHblGf6bnx+l7L
         luBTeH0baWUKJWHNLKTcJjS8Wn0QVdqHpxFPmjzG4ViFgPBEeP0Ipibz3Ha5C48zZ5JT
         ftXRwdDUGlXsjGEOmUiKvNS7n55ztT4XZcxs3wCH5FDj94ItlmWYmYcsE+P1kCWYsn31
         68KPiQd4OYf58vXz5DWZuwrbiB/ZFG87BT+/vCja0fY8YPQVggJeAYJ0xMMKVJOZU7Xz
         dWVQ==
X-Gm-Message-State: AOAM530VYvin/WXWxbZEGjlYDGlECCVQFzEs4PgVAxAu1DDO6ubKCcP5
        b9pz4DfGg2rogjhXZFo17Q==
X-Google-Smtp-Source: ABdhPJw9nGRdtCF9VNDyW45yJWTb8Ec6U2I7dvTsj2TUVX1K6lL31CQbPZfAUyWSsKpb7o6x+wB97A==
X-Received: by 2002:a05:6638:250f:: with SMTP id v15mr17520120jat.75.1597717766591;
        Mon, 17 Aug 2020 19:29:26 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z9sm10517670ilm.78.2020.08.17.19.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:29:26 -0700 (PDT)
Received: (nullmailer pid 2170452 invoked by uid 1000);
        Tue, 18 Aug 2020 02:29:24 -0000
Date:   Mon, 17 Aug 2020 20:29:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/13] dt-bindings: iio: adc: ti,adc0832 yaml conversion.
Message-ID: <20200818022924.GA2170397@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-7-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:46 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple binding conversion of this SPI ADC binding, with reference
> voltage.
> 
> Added the optional property #io-channel-cells to allow for
> consumers of channels if that makes sense for a given board.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  .../bindings/iio/adc/ti,adc0832.yaml          | 56 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc0832.txt           | 19 -------
>  2 files changed, 56 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
