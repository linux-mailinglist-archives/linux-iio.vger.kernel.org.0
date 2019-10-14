Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56ABD6639
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfJNPi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 11:38:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40614 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfJNPi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 11:38:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so14110978oib.7;
        Mon, 14 Oct 2019 08:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Go8wBn6px0Q/kUPhFS3kBvMqinIxTjZFlx2oReSfcvQ=;
        b=Dw9+cEyegj6W2xQ/zrOHfV1r4qtIJ6APQeyRBJ9gEyB/8TIK0JbMV81MZRNJmcM3k1
         RkzEYEJ5/BX/m3xtG8OK6ofqs3vGpGh1kXMb/MdFBUR2UR+R6a3CZ+aUlWgr1Xm1aDvV
         DcTvQOiJ8fg8zeYTbBMpDRNJZkmUFUm22KjsyaOBq/b3AEm7fZhzQYkuTYoPwFjaX5Xr
         5yFje3oAdoby6s84dU9fOeTNkYlyMDreuvia72KkDnSIY+d1pk2qcdoXA++LG9yyXtda
         K7zJ/paTUKy9+fFJCuMLw9n+rtj73V9X2CyR3NwAJlhONGcZzPzOiQa+eFsuEdmp/BxN
         PscQ==
X-Gm-Message-State: APjAAAXz5szFbTk95YE7HkhonYaTjmHHyabfMGGPSlZrXP+6gUk0jEiT
        uF9eYZOfk9gkkefEQLcm1w==
X-Google-Smtp-Source: APXvYqyOoP+jhZiuuS60szCF24/or5bMxSsvTBV0B2ZidbzyBLZc894W76mYyoWU4KW9tpZdLj7PpA==
X-Received: by 2002:aca:4c56:: with SMTP id z83mr25516527oia.113.1571067506740;
        Mon, 14 Oct 2019 08:38:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm5420766oth.71.2019.10.14.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:38:25 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:38:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 7/8] dt-bindings: Add 1027/1029/1031 SPI ADCs as
 trivial devices
Message-ID: <20191014153825.GA26261@bogus>
References: <20191011144347.19146-1-miquel.raynal@bootlin.com>
 <20191011144347.19146-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011144347.19146-8-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 16:43:46 +0200, Miquel Raynal wrote:
> In the same time, remove the dedicated bindings file which is now
> useless.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/iio/adc/max1027-adc.txt          | 22 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  6 +++++
>  2 files changed, 6 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
