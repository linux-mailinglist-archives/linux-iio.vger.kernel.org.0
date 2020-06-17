Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBE1FD85A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jun 2020 00:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFQWFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 18:05:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQWFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 18:05:52 -0400
Received: by mail-io1-f67.google.com with SMTP id c8so4782284iob.6;
        Wed, 17 Jun 2020 15:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LYeHqze5g0l30MtYSpo5dmNTjlZMFsKizX2Q4MTzYI0=;
        b=YMK9A9X9sxheOYerd6idQnYhbUPh73Pde3LBYDC57ViO3PGZXVwY7XL0Hg0hoviUV1
         GEwGTwF9xJkTxHE6SG8wOzgcAae/2a1Y9kICAEebw58i9KFSnoEZCN9jWdPIzpVe3ZLR
         4Ehqf8KRQgEoZIHMEdfTk+tsmBGvbkjYVqyfwXAs41/HXgj2Qcr96w9ywIHKMkj0HK9U
         9qjO+4q8ov8UiPIzPsHEmweZ+kVqjpzRbNqHMzkP8Azakoku9bC27T8+f2/7V35JE9pD
         1gYKruCJH2o5kGk4I2wig3zHRqoNpZPavq/PT8T//Lt+MW5ha7iVkOM0VnYkuOJAUaiv
         96CA==
X-Gm-Message-State: AOAM532IpyO02glaJsw2g7DBJjgtcK+WPGcSLdQzZL+pGEOU1qDJc+ve
        pvGdYeBNdBY1cyI6ElIV7A==
X-Google-Smtp-Source: ABdhPJyKyP/RHyF4fF1V22V3F4JS67v39QDdMOJ6FMe0lOamSJ4eOYyOPKvd3Oll4W8SJ+OanpGqxA==
X-Received: by 2002:a5d:9a81:: with SMTP id c1mr1676038iom.35.1592431552157;
        Wed, 17 Jun 2020 15:05:52 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s71sm507067ili.44.2020.06.17.15.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:05:51 -0700 (PDT)
Received: (nullmailer pid 2914245 invoked by uid 1000);
        Wed, 17 Jun 2020 22:05:51 -0000
Date:   Wed, 17 Jun 2020 16:05:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: chemical: add O2 EZO module
 documentation
Message-ID: <20200617220551.GA2914216@bogus>
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
 <20200609194117.5837-3-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609194117.5837-3-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 09 Jun 2020 12:41:16 -0700, Matt Ranostay wrote:
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
