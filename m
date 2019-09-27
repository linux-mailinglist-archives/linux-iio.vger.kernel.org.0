Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D29C07CF
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2019 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfI0OoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Sep 2019 10:44:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38947 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfI0OoX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2019 10:44:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so5402871oia.6;
        Fri, 27 Sep 2019 07:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUbx8H+XGvr/S5SFZFE4XWPecTb/RCKWHx1H2qjLZIo=;
        b=AGDEZ4xAlrhAy8/Ih1be5tUvD19SX4J/Fsx2AZWlivvCsRHoIupO/zJFhTgOjmrSly
         BNgLCq2d32SWPfb+HEKnMj+TyxDfyBM2towwp75E7sv6fJwHourYYpzh+nbM1CfzxFgz
         By4HGu41KZ80gkNBxTkkziNEkAA/LSVFmvYeTY+GLfvSj8cOGlu4Z2Sn+L+uPQyqKhaB
         DfGd6WESd36/Hz8MiF5G0FPHnZHNB9bvX6dOPkPXrrOo0Cm91/t8NRHEK2WFOYU3YxU2
         Vcr6jwbB9anuHXw/5Wgp3mPODcsyMESvLESe3tWRln/TN0zy/sa2aFiQdUuMadTTrbFy
         dqwQ==
X-Gm-Message-State: APjAAAXcQxuj3TzuCQ30YeRIUxp22V6irwhGG4T6tQudb49pPtV+0+Xg
        cDSmjSiytoj2LcKuku3sFShXj7Y=
X-Google-Smtp-Source: APXvYqyJyGAFMPm36l+NjNA9pxhi/svYE2pWZd90T5MysCjHY64TBeDp9wleQB6umr0pYaeCUKbXWQ==
X-Received: by 2002:aca:645:: with SMTP id 66mr7112367oig.117.1569595461049;
        Fri, 27 Sep 2019 07:44:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s194sm1716330oie.19.2019.09.27.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:44:20 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:44:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH v2 1/2] dt-binding: iio: Add optional label property
Message-ID: <20190927144419.GA26041@bogus>
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
 <1568903768-65998-2-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568903768-65998-2-git-send-email-preid@electromag.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 19, 2019 at 10:36:07PM +0800, Phil Reid wrote:
> This optional property defines a symbolic name for the device.
> This helps to distinguish between more than one iio device
> of the same type.
> 
> Suggested-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
