Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244C2D4B26
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgLIUAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 15:00:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33219 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgLIUAQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 15:00:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id d27so3069506oic.0;
        Wed, 09 Dec 2020 12:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Rhw7vfDvFqf9Is8UG+TtStZomdt12ooCiKbL5gtpuQ=;
        b=kaKsV4mOrVdh1o+DL/FwbPXoXuB2+oS+jLERRHuYgfhzF8Tn3ijqtn8lHtAIIvh241
         2jlqglcg6rPBvBlb3pCm3oWvOtpBuKD6kDKuml0xfWkEhpE5B75ygutUhkLDKGth1YYk
         LCZSubvW7ShvA3jNcQfKu8VCvTHeqD9OIzTa/M0L40IPpbphljYetM1nNQUIZkHiT8U5
         RVoIqws6gMvsUrNvzCdy12NcqdlSHSClSiCHKI4OV655GG4kYtCgt0MJoTMeJoIZ8snh
         TVOgw8MBAlDxeo6/7su9T9h6ERB4TQaBm14N+B8gOxeLy++oChmhYMBhmPlMvCDuVin5
         fOTA==
X-Gm-Message-State: AOAM5329RGb/P618688yKxCb0MyLdQHIbG6j9cT/HhlwCn9waTRM6gm+
        o2VM1NlHGAUC7QQSM9l4gA==
X-Google-Smtp-Source: ABdhPJwZzo++sBwyLaMObe+V5pRAB06qeB2OJ62Bk7PI+S8o9AnWXE80n6D/0P6kAPixOke2/pw3rw==
X-Received: by 2002:aca:b457:: with SMTP id d84mr2962988oif.149.1607543975211;
        Wed, 09 Dec 2020 11:59:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s189sm505727oia.7.2020.12.09.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:59:34 -0800 (PST)
Received: (nullmailer pid 845361 invoked by uid 1000);
        Wed, 09 Dec 2020 19:59:32 -0000
Date:   Wed, 9 Dec 2020 13:59:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,mpu6880
Message-ID: <20201209195932.GA845313@robh.at.kernel.org>
References: <20201202104656.5119-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202104656.5119-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Dec 2020 11:46:55 +0100, Stephan Gerhold wrote:
> MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works
> fine with some minor additions for the mpu6050 driver.
> Add a compatible for it to the binding documentation.
> 
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Note: This applies only on top of the patch for the YAML conversion:
> https://lore.kernel.org/linux-iio/20201128173343.390165-3-jic23@kernel.org/
> I guess that one will be applied very soon so I think this is easier :)
> 
> Changes in v2: None :)
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
