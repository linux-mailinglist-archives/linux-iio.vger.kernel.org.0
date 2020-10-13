Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513BD28D310
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgJMRWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 13:22:32 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:40051 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMRWc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 13:22:32 -0400
Received: by mail-oo1-f66.google.com with SMTP id w7so67117oow.7;
        Tue, 13 Oct 2020 10:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFYdK5eEI2q6HITSkcwdVxz4dDBhdqzWyeihWrwEJQY=;
        b=gbk/pyxWUw8Aq9L7Zc8gGCzlbgwhpdUc96GKl9xr4BVFPXX6M3uY/ktF0nuuD/wBL/
         mvLvudRUbDFQmgdVNCw5yo7qTtg9UFYlJxUSy1vjONY9osXUfFpmdLWaVUj2PaIDNlNi
         iqOGlJLYNgb9MoKzTLvR4Q1j0nC/vm+EuRDy8GTahKgobAwB89557T/jRWR9CVQqexoZ
         hJxfMl/8D2bGdEWndfVzF0oxMgatwr+ximaMJqbZP03waQOPEAUf5fFOMwjBjK17twOc
         MlEXsTHlE+cSQgcgJB9skt1IOUW3DUe9P4XsbuW4S9seOzvoNSbhg4DydnL0c9Q6G6ji
         IqyA==
X-Gm-Message-State: AOAM533Hu/wOVROYt7O67eDlcK6rK7NCmwKkQjrCKP2jtYATct6Oe+wP
        1PAGrNF/NA6cMoBC6W45XAr3NIbLoaTd
X-Google-Smtp-Source: ABdhPJzsC/0Ak+zrtd70+RUds9C+1E9Lw/c+pMqT2nbpeqfiPZ/7HAznFBx2dTS3zyPXvelxW8tNZA==
X-Received: by 2002:a05:6820:30e:: with SMTP id l14mr297849ooe.57.1602609751366;
        Tue, 13 Oct 2020 10:22:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y51sm131571otb.47.2020.10.13.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:22:30 -0700 (PDT)
Received: (nullmailer pid 3726622 invoked by uid 1000);
        Tue, 13 Oct 2020 17:22:30 -0000
Date:   Tue, 13 Oct 2020 12:22:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, knaack.h@gmx.de, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jic23@kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: auxadc: add doc for MT8516 SoC
Message-ID: <20201013172230.GA3726592@bogus>
References: <20201012205218.3010868-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012205218.3010868-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Oct 2020 22:52:17 +0200, Fabien Parent wrote:
> Add documentation for the auxadc binding for MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
