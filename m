Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF2349CFD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 00:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhCYXoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 19:44:12 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:43930 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCYXns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 19:43:48 -0400
Received: by mail-il1-f177.google.com with SMTP id d2so3591718ilm.10;
        Thu, 25 Mar 2021 16:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p59ML68zK60wq9YD60V5pptsxHulU7hq4xvqJD4wijM=;
        b=RW90zVF7jF9fBKktnDYRj9GsPbCSqm147WHJaDCxYbf4TAh9i5q3Ffm11FhqKVgpB1
         62lmWx5hZWAMmN/xe8WiLidPbil6pT4aEny9qp811VsbUU3h0/FqUxbd+iR7c+HR0jPR
         v9RQYBwLPBDp4JPMoBSgthHGYNzJglW25PPkCk8hsz/MlPt/L3SM7SO4bt9Rui4d8p3o
         p699gSGlKwBU5LbdqoJQi+u/BVHuF0N8M0drZ8s5OO+QTY/gQtEhHb7mYR9BgIpJgnjI
         BO80roifCtAjGSCApWHarv3CiRZ4DvuH6pbLgBt8w75N22AeuOpo+i3+onlmdkhdXJCr
         YLZQ==
X-Gm-Message-State: AOAM533ID90DBcVQXOZOuv5v1WsTpQfcbtCWFMSRm+AnJBUHGCsoUTtQ
        97sCtry4W8d849+MkohfoA==
X-Google-Smtp-Source: ABdhPJwfa4q5Qfn77dFh+CE0bpIsOOj53QrW0DhxciTZq+4XZ0reu29n+NslYP5CilZsWawJZ8U8TA==
X-Received: by 2002:a05:6e02:2182:: with SMTP id j2mr8950348ila.89.1616715827402;
        Thu, 25 Mar 2021 16:43:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j5sm3442416ile.52.2021.03.25.16.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:43:46 -0700 (PDT)
Received: (nullmailer pid 1960656 invoked by uid 1000);
        Thu, 25 Mar 2021 23:43:43 -0000
Date:   Thu, 25 Mar 2021 17:43:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        Rob Herring <robh+dt@kernel.org>, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6 2/2] Added AMS tsl2591 device tree binding
Message-ID: <20210325234343.GA1959978@robh.at.kernel.org>
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
 <20210325220505.14507-2-joe.g.sandom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325220505.14507-2-joe.g.sandom@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Mar 2021 22:05:04 +0000, Joe Sandom wrote:
> Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
> 
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
> 
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.
> 
> Datasheet: https://ams.com/tsl25911#tab/documents
> 
> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> ---
> Changes in v6:
> - No changes
> 
> Notes:
> - Re-submitted to align the version with part 1 of the patch series
> 
>  .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

