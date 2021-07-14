Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558733C883B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhGNQCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 12:02:13 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:35656 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhGNQCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 12:02:12 -0400
Received: by mail-io1-f52.google.com with SMTP id d9so2737376ioo.2;
        Wed, 14 Jul 2021 08:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+1u0PiMtrYoL/1rhz2zqkaY/o+HvCLB3gBhT+B3kCk=;
        b=JZuZx0P1mvpOGEM+eVKfgSyJPRzMAM0S9nZBwH4TkuUxRI2Y3/F0vEQV/+6yC1NYLB
         tNFox97J7erhdTptNc9ieYSg+ZBYXpO4ITd9zn3Jei2EQPKUhvhMjAP27n5eB6F/ESKs
         cQB6bTHTC1XINmyhHuCS6+V/8oFRItKLmahQFXnPTHxeNHMtEabDRCmjeuIqcMNDlz06
         t8Rq6+xdltp+KPOEZ3XCIpNw44wXechTOZq0SZjfV49y5DvfjExsLXey1PZjIT1+PECq
         RHaHZfBivSTJJXiT6yOhIrGbvCzEonUBGE3E3I5EfE8Zdh9KBYoPWqdnCJs2J75watJn
         eDjg==
X-Gm-Message-State: AOAM5323oYxfYLL7xUojkBkS9xP5nua8bXTEu8BySGGM8+nQlRHEjQ7e
        0nyMSu2HQObu8qe9j6U7JA==
X-Google-Smtp-Source: ABdhPJygB1AhPcHuLk+Cx6ToYs6fcNgEawcMncvHkd78chepSgJX3dP+uZIT00nxqRzSrn/csUS5sw==
X-Received: by 2002:a02:8521:: with SMTP id g30mr9469981jai.113.1626278360913;
        Wed, 14 Jul 2021 08:59:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b2sm1527910iln.5.2021.07.14.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:59:19 -0700 (PDT)
Received: (nullmailer pid 2655671 invoked by uid 1000);
        Wed, 14 Jul 2021 15:59:18 -0000
Date:   Wed, 14 Jul 2021 09:59:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/15] dt-bindings: iio: dac: adi,ad8801: Add missing
 binding document.
Message-ID: <20210714155918.GA2655642@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-15-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-15-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Jun 2021 17:32:43 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This device was missing a binding document. Simple binding with the
> ad8803 requiring two both low and high references whilst the 8801
> only has a high reference.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
> ---
>  .../bindings/iio/dac/adi,ad8801.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
