Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7183DE1BD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhHBVem (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 17:34:42 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:34392 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhHBVe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 17:34:29 -0400
Received: by mail-io1-f49.google.com with SMTP id y200so21986849iof.1;
        Mon, 02 Aug 2021 14:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW4ZbtCEvtyGOUpJnlHWxhQ9OU/Hb8837kT5vbURzXA=;
        b=EeaGubKP4l35m5RbwdVonguCOgHG3uajz0CIwZXF/IJGu7antCpYJA05y0m1B9XQn9
         FdBIaHOcrofqBRI2TqknFtB5ehkg2gvJS8BPnfkHkZD8UGzjTffj9w0NYfektov+OgaR
         6yaN4/2PlAdruM3Pnf12X2GbD/WTT0TeQPGmQhbE27YiduDlHw9MNTisuzCVYNZ8r23w
         OKQrlVm+24zutXunZAD1yk74t+sFdN19Coxa8e408NxbHX+Hick0vyRECbYxgAKUOtiV
         GeudANsIYwV3Sg5x59RIY2OUi6NFO2uazAVG156B/8fZtMVNvPO9oDedzCAtZb3wuHQj
         uiEw==
X-Gm-Message-State: AOAM532oFEYvDSf44Oc7lK5OjltTw5SlD+Jt0EJ3xZSmlC8tCeiJBwQ0
        nM9DH7PZEK7O4vWV+iIY6wbcznuPag==
X-Google-Smtp-Source: ABdhPJwGL04pyTOivFpOfHkMVxQJFgsPe7pdkaTCG/n07mqCsv1Mk4Wz1Xp8PG1RumAM9Iu6o3F8HQ==
X-Received: by 2002:a05:6638:1004:: with SMTP id r4mr12979495jab.105.1627940058806;
        Mon, 02 Aug 2021 14:34:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b6sm7778568ioq.43.2021.08.02.14.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:34:18 -0700 (PDT)
Received: (nullmailer pid 1654453 invoked by uid 1000);
        Mon, 02 Aug 2021 21:34:16 -0000
Date:   Mon, 2 Aug 2021 15:34:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Manthan <siddharth.manthan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, nikita@trvn.ru,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, ktsai@capellamicro.com,
        jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/2] dt-bindings: Add bindings for Capella cm3323 Ambient
 Light Sensor
Message-ID: <YQhk2NImkpPc162/@robh.at.kernel.org>
References: <20210728110048.14593-1-siddharth.manthan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728110048.14593-1-siddharth.manthan@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Jul 2021 16:30:47 +0530, Siddharth Manthan wrote:
> Update trivial-devices.yaml with Capella cm3323 Ambient Light Sensor
> description.
> 
> Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> ---
> This patch was previously sent using outlook email provider. Unfortunately
> I had no knowledge of outlook being banned from mailing lists. I am
> resending these patches using gmail. Please ignore the previous patches.
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
