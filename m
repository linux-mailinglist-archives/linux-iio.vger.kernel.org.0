Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434F1413B36
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 22:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhIUUYD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 16:24:03 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33622 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhIUUYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 16:24:03 -0400
Received: by mail-ot1-f53.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso327363otu.0;
        Tue, 21 Sep 2021 13:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXxN/Tsfx5bmrn6IRFt7LP7UFNWkTcdd8J3Fel3tlCM=;
        b=01KSvepbxz2IJYO0BUsC3OLSWsrrQVywTEaC0tPGUuk70gCuHmmD974g25HAz3dAfS
         zi0PW2t/w6P7G7EGyJB3oAQ2ZCBYwYuSm9orA14r6ZYkCJ32vzC3n02UPYojq8dAD1vb
         Z4T4r6v5yv3qQiOz0PmZq4MKflA/lEKpTJ1j1FlwmydmTKc+VkyM1BtT0lIA6iZ4CzHz
         GMaQcSIfksWc1/s2uD6rMBD6Ti3B4+IrpvJEqJC0BkirY9yJB8QdeYpEBolFuRS16GLC
         ztDgx154Yf0Ih9dut6NFszAYQD5/AJc9CMMNkRLJ49vQTvIla7eaUiqJhGuOgPslRGio
         8/Xw==
X-Gm-Message-State: AOAM533zYW2Su55UrPw/Fukbqtb7u0nPTaGZb07qf5iPLjXGJ6P1bAih
        QtNCawkZhFeO83+5FzysSw==
X-Google-Smtp-Source: ABdhPJzsEROHqcVPN+E7NmlIWG2PVc84xkEcMet/kB8kZAxVLmgiNTCM5aut56npYcGtdZVPAjAlXg==
X-Received: by 2002:a9d:6398:: with SMTP id w24mr26957420otk.140.1632255754431;
        Tue, 21 Sep 2021 13:22:34 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id k8sm21966oom.20.2021.09.21.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:22:33 -0700 (PDT)
Received: (nullmailer pid 3266694 invoked by uid 1000);
        Tue, 21 Sep 2021 20:22:31 -0000
Date:   Tue, 21 Sep 2021 15:22:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add
 vid reg
Message-ID: <YUo/BzWUBQArrMkS@robh.at.kernel.org>
References: <20210913181949.83179-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913181949.83179-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 20:19:49 +0200, David Heidelberg wrote:
> Driver and device-tree also use vid-supply regulator.
> 
> Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iio/magnetometer/asahi-kasei,ak8975.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
