Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52C81FD673
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQUxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 16:53:51 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44170 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQUxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 16:53:51 -0400
Received: by mail-il1-f194.google.com with SMTP id i1so3656650ils.11;
        Wed, 17 Jun 2020 13:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obA+GdDh49FILe8YYBu+Ke+2o3UKObx/roC/7+lZrtM=;
        b=G/drJoP8IYFzq9MV4s9GeDTFZY7w4SVxHvwx51H7Ic5QEmW8nO50cMlTWTcQxSVJWH
         YnbS/QQ/XXAvMCoDRlsSawp9LVmVuBHO0lWbnOmRUWu7V/nPQA0Lt5cBjZlo4c2PyVvp
         4as2Qa9SvbUioHAnTP+dfVTYeMR0ZsC94Xp4X3E29xwP/emVegKUjtAKHVpCxhcrus/a
         yMb57sBBRk+x4IBxCKOc1OdqNxy9z3rhyL8NTgwp/+22Xr2R9J+526LQP1InHk0SsHQZ
         Z9iWlFd2LoLgayZUFEYGtGVczo+O0jXHdnbNwfHfcn2mwSlBiw6itlp61oE+OufcVf/W
         nykw==
X-Gm-Message-State: AOAM531Xf9VQNxwxse7k5rn2kxoFp9LHs81QM2l+NmukAFc1aIszjQib
        eY0i6753P5O8d8AWPPR8qA==
X-Google-Smtp-Source: ABdhPJy4YFqxchSXEFMNwKJ+5lIjVFOcC8wuZ/9147EWd0Mrx4JCmml+81agFcI2rPQoCvOzSDRx/A==
X-Received: by 2002:a92:d188:: with SMTP id z8mr746318ilz.251.1592427229632;
        Wed, 17 Jun 2020 13:53:49 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j63sm432326ilg.50.2020.06.17.13.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:53:49 -0700 (PDT)
Received: (nullmailer pid 2790230 invoked by uid 1000);
        Wed, 17 Jun 2020 20:53:48 -0000
Date:   Wed, 17 Jun 2020 14:53:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab+huawei@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org
Subject: Re: [PATCH v3 12/13] dt-bindings: iio: imu: Add inv_icm42600
 documentation
Message-ID: <20200617205347.GA2790117@bogus>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
 <20200608204250.3291-13-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608204250.3291-13-jmaneyrol@invensense.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 08 Jun 2020 22:42:49 +0200, Jean-Baptiste Maneyrol wrote:
> Document the ICM-426xxx devices devicetree bindings.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
