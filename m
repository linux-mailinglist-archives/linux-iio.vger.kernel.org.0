Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568CA2F8118
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 17:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbhAOQqt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 11:46:49 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44709 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOQqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 11:46:48 -0500
Received: by mail-oi1-f179.google.com with SMTP id d189so10132832oig.11;
        Fri, 15 Jan 2021 08:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qpxgp00wN0qYeZYo3gwL+8xqHIsplT0Ne8rJnwk8ts=;
        b=KsZ/O6m8hgOIw0mVCyeoeRDrKK4RzATfmtxIiHOAfsdvv35n4PAkeK2Qk4jE1C9YbQ
         G/COLNV3PlcNbPgC+zMC8U67HS9uveN8kktZBEEaca3gmejVLPW9V7rwH0WgNwHl2Xk7
         NZjqaIe+vnIJ0rLFuWBf5sEavC/uwHGJ/SqxvJ4Blrs5JX+odP+/5b+wvIBNVX3eQtR+
         HhYrQAWWCCTogo15o8LfTheyII/6H0isnY9gCNzKM2k12yyNW4jnRwYvfp1V9s1/ewDT
         GyNW4xTSqV0rnJtHiM2qjdzMZjf2vfNH/AQQehorWK7I7qel088zbICoInoEU7yRvHCs
         PJPQ==
X-Gm-Message-State: AOAM530hjGthgOzC8x/hvd14LWhLlP/LCg741gGJBZLhxd631K6InFl7
        /BD8HgEQQt4+nRysDxE3Bw==
X-Google-Smtp-Source: ABdhPJxKezkGGuZxt6aZaHY+EN1XL8Y0TAJjDKLYIpjZp2/2mGPnNi7TzBIl4AbOYWHBYa4pJgI1hg==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr6157461oij.107.1610729167054;
        Fri, 15 Jan 2021 08:46:07 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s24sm1782964oij.20.2021.01.15.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:46:06 -0800 (PST)
Received: (nullmailer pid 1426045 invoked by uid 1000);
        Fri, 15 Jan 2021 16:46:05 -0000
Date:   Fri, 15 Jan 2021 10:46:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20210115164605.GA1425845@robh.at.kernel.org>
References: <20210115112105.58652-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115112105.58652-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jan 2021 13:21:03 +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changelog v6:
> 	- Use microvolt unit
> 	- Remove unrelevant to the binding comment
>  .../bindings/iio/dac/adi,ad5766.yaml          | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
