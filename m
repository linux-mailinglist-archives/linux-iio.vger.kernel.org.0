Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8232B22B523
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgGWRre (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 13:47:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42849 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRrd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 13:47:33 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so7152286ioi.9;
        Thu, 23 Jul 2020 10:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igJO29xYdhEX1YZcPaTW1/UQWYbjGuigif1HBx3az5o=;
        b=Dr7ztTS1Bw8nSdfIfDio0zEi0F9rCQsEtUYASh5MJhpUshYziGKXT002UQx26SYBgK
         NtUEN4w/mpiRkKVJkMHcwt+odCL29GMYA4Nx1b/wLH8nQWOFRmmuNARY8UGn8Qkbd7Wu
         +T6GiYS3GEWAsj5fJk3RVTA+prZDzVUiOJYCAq7rKSXwZd6THqIiIiAZ2yNd6pKADQC9
         LOR6P6CmBiZpN/7l6whs7IPAH+uZSuqD/3YmR5873riE0OXQdBtyDDm/cxPQBb1de4hs
         TFQpXF7Dpv8rgubriTTKtUiXC1wKmwXB0ZvbmGEFs4Z4umxyrC+q4BUGL0pHkBt81IPY
         PLnw==
X-Gm-Message-State: AOAM530SDRz56IGxPbAhkpdUFiydRhvSVv5ZbT+PwJVA+h+2LlEZNHHd
        wzdXjREb4fYWRAP1kstxGA==
X-Google-Smtp-Source: ABdhPJy27/VlKtHPpbL16r6sY+r3eYd1PpECzmmkVDUMiMNSdrTQRv5b79vmNs9h4w0jeamL027ckg==
X-Received: by 2002:a02:6595:: with SMTP id u143mr4012012jab.28.1595526452873;
        Thu, 23 Jul 2020 10:47:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y24sm1854076ilk.52.2020.07.23.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:47:32 -0700 (PDT)
Received: (nullmailer pid 596082 invoked by uid 1000);
        Thu, 23 Jul 2020 17:47:31 -0000
Date:   Thu, 23 Jul 2020 11:47:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: chemical: add O2 EZO module
 documentation
Message-ID: <20200723174731.GA596034@bogus>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
 <20200720070330.259954-3-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720070330.259954-3-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jul 2020 00:03:29 -0700, Matt Ranostay wrote:
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../devicetree/bindings/iio/chemical/atlas,sensor.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
