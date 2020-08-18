Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E32247C25
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 04:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRC2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 22:28:02 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43617 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRC2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 22:28:01 -0400
Received: by mail-il1-f194.google.com with SMTP id e11so8358859ils.10;
        Mon, 17 Aug 2020 19:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2DOERz2Vr/tJqkjQeHPH0Rwcx7p7gsYChnRCTlNdDA=;
        b=pSZI91Xq0LYUqZh2bSCoIffJMyhfohEZSIDyQKHioGlFW90KnpDy+Twe4Z8O6SUHI4
         i97j9JPKEVz30/yHGS3FYPcmIbi1L2qf9Rky4isFt4QyfyOD5jFLCAAKC9IqCrzXivmh
         6Z/aXiB1iLxO9KyNCrMTemoK5ZBgnwSF0U+YDkZBB6GO5iwfMA5/QtIq5hrhvSUKSoiV
         CZLUULLx8aG9IOpxG03R859VtvpoDxxDpKeQjdTfGDF5pjlaBhbaZoH2fcCFEXKldsfa
         D2HPhZX4XDgS+2YUsKASXNN5qAT6wzl/Qh4C9dwK69IscNRoQRcGGMR++w1qza696hHV
         41Sw==
X-Gm-Message-State: AOAM533ewxW7HiqedvJN9osXVisYgNn9XCrxnkDKOrj2HvJ+KI5RlKN+
        ILxZ1fm/zDGt2YJEUeworQ==
X-Google-Smtp-Source: ABdhPJyanYVlrOiZjwr2zizLX+yF6f7x5ovBZ0teDO2i4S8+hYA5LvyooP/50Qc8SiaI0FZEBcfyNg==
X-Received: by 2002:a05:6e02:1103:: with SMTP id u3mr16333030ilk.50.1597717680472;
        Mon, 17 Aug 2020 19:28:00 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h18sm10154464iow.16.2020.08.17.19.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:28:00 -0700 (PDT)
Received: (nullmailer pid 2167831 invoked by uid 1000);
        Tue, 18 Aug 2020 02:27:57 -0000
Date:   Mon, 17 Aug 2020 20:27:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/13] dt-bindings: iio: adc: ti,adc108s102 yaml
 conversion
Message-ID: <20200818022757.GA2167774@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
 <20200809111753.156236-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809111753.156236-4-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 09 Aug 2020 12:17:43 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very simple conversion of spi device with reference supply.
> 
> Added the #io-channel-cells property to allow for consumers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../bindings/iio/adc/ti,adc108s102.yaml       | 47 +++++++++++++++++++
>  .../bindings/iio/adc/ti-adc108s102.txt        | 18 -------
>  2 files changed, 47 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
