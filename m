Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8397E31535C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 17:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhBIQEu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Feb 2021 11:04:50 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41452 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhBIQEr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2021 11:04:47 -0500
Received: by mail-oi1-f181.google.com with SMTP id v193so14477910oie.8;
        Tue, 09 Feb 2021 08:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7ZuEtfm+aDvR3PynQiFYy1ZPav1OUzL36rYQRVcoZgA=;
        b=LN9/HIzNueQvaekMZF2fSFzo5Nf2ouf51i188gJTzMTZ90GdMdDx89dYwh4LvUqzfr
         FwWjUYYXSYg7Sxj895zlVBIFKNg5r9h3RUENxIjyt3dvZpQ2lzBg1PxPLitqyi5Crg61
         mlua/39sP9VisKpIXZCkA7VuzRp7PhhsPXP6kUJeegoYYb/tprIYBLHe+ekojxcadwaw
         MNWgmJ8h6rcNuPLF8lOMdbLGiBIOLc7yr8AZ+176weIejJ2OSpxQZQ5pbVCXrBhwKfb4
         KMxZQBY/svXf5xup378CsKSYxtqIUIacA+kkb/76zZ4lOGKKUFabfwZpKILNN9WdGVo0
         6bSQ==
X-Gm-Message-State: AOAM533GRg+PU/hQCBuBKI7vYAnZWDQV71ZMslsOCB20jYoiqeUwPyky
        OqIf/0v1HmetGmNCxxqmrPXQ2483Fw==
X-Google-Smtp-Source: ABdhPJzCCOzLI519ZBVzaYiBxfJDwBoUmtv2JTmWMNV4I82WEWkc9KGC+3ipomPFW6PK9cRId1BI9A==
X-Received: by 2002:aca:5d84:: with SMTP id r126mr2900564oib.76.1612886646455;
        Tue, 09 Feb 2021 08:04:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k23sm4433524oik.4.2021.02.09.08.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:04:05 -0800 (PST)
Received: (nullmailer pid 3847693 invoked by uid 1000);
        Tue, 09 Feb 2021 16:04:04 -0000
Date:   Tue, 9 Feb 2021 10:04:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 4/4] dt-bindings: adis16475: remove property
Message-ID: <20210209160404.GA3847638@robh.at.kernel.org>
References: <20210121114954.64156-1-nuno.sa@analog.com>
 <20210121114954.64156-5-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121114954.64156-5-nuno.sa@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 12:49:54 +0100, Nuno Sá wrote:
> `adi,scaled-output-hz` is no longer used by the driver.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16475.yaml       | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
