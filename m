Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A9358E41
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhDHUWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 16:22:24 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:39921 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHUWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 16:22:24 -0400
Received: by mail-oo1-f53.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso813261ooq.6;
        Thu, 08 Apr 2021 13:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LLV1cxozsumUnosBEPtpPo52UB7xTqrcSob2VugBfqg=;
        b=EUDpPUoSO0NizvSnfupG/sbUi9rROznj5dpT/eekzMmZtXLbC7PotcIj09MwfdW43r
         CA18JJjdn1CLC+pfgNS8HurlHV5kCMH+BoZNYZlDfBKE6Qvgww7cJbhVLhw5SWIIpOfh
         1hRCSL+5MPY+M9a27b1n9/IsOCTY6g/ybschz/xvrVsOeuxLe8ZCIcyGypQoBst/Cjn9
         vvExkD/0Ir3cTnoo7uw7rmVk3TGCLCSleLh8tcwxOP5hO5GiTBgnByQ/ltERVjy3GdWQ
         A8ZKVd8kUzYKMuMFCZfAvHb9tBKh522dtNF8vNkMF192ptxHXk/aiWQ2qQExiJDPaFyg
         oGtw==
X-Gm-Message-State: AOAM533O3p48oFPw7Z0g0xviAyJuEO8uKxbF+xJPgg9WfKoL14om94QX
        pqnx9vzh0pyzsj7IUB1Mlw==
X-Google-Smtp-Source: ABdhPJzZHCVOBYUfbqqfdSWcK4IRWECDobMJIyXTKP8kvt0GzVnaUCZYvxvBjZYnHVrJH2S8evNRMQ==
X-Received: by 2002:a4a:2a0a:: with SMTP id k10mr9187455oof.88.1617913332257;
        Thu, 08 Apr 2021 13:22:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm97493ook.40.2021.04.08.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:22:11 -0700 (PDT)
Received: (nullmailer pid 1898149 invoked by uid 1000);
        Thu, 08 Apr 2021 20:22:10 -0000
Date:   Thu, 8 Apr 2021 15:22:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, knaack.h@gmx.de,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: Add DT bindings
 for TMP117
Message-ID: <20210408202210.GA1898100@robh.at.kernel.org>
References: <20210407182147.77221-1-puranjay12@gmail.com>
 <20210407182147.77221-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407182147.77221-2-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 07 Apr 2021 23:51:46 +0530, Puranjay Mohan wrote:
> Add devicetree binding document for TMP117, a digital temperature sensor.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp117.yaml   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
