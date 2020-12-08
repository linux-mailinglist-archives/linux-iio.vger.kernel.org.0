Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE32D355D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 22:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgLHVgX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 16:36:23 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:44774 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgLHVgX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 16:36:23 -0500
Received: by mail-oo1-f68.google.com with SMTP id n20so729270ooq.11;
        Tue, 08 Dec 2020 13:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Tx2n1+BiRWFNoCwoT4oiyZWIIS4oc7pPhFRuSqFDJQ=;
        b=ujf/wvn9FCIjC27LuZHwjDIIBGQe07/G8o3NhNyyCamaZtKCyFDxA5XDzSBxnXMnfb
         B6QyS8Ds2K2I+DpMg+dp2vy92AL0n0QJmxhDrzxDZ0KsgeMSIqGV3RlCKFdGseyKBLzl
         3tDMelKaCwvfDqLwk8KyAYEslawC3zrEmRR+bbTWZpQnerVbrc0LMZzTJzYX+ifd7cBu
         IsutQnKtON6S5Fao8e8/AiGxjm4RgXQci+jW8wZP8HLjgy/PA+Ys8UU8VKil6Hrba5UC
         bIX4c4MXyV+VZ35QChexNBbwzxBu9lK1zx7U5G8dlbKSxYQK+lvUX9mthLfGBCU3fBB4
         UvWw==
X-Gm-Message-State: AOAM533I3u8BN87s9OfJN7gJsutS5GwLiZxwupEvHI87x+pzsJt3AUM9
        GwC5CcJ5EVc/OCOiwgo7Ig==
X-Google-Smtp-Source: ABdhPJwmcCWc5YrP3tKm8MswwqglBxCMPkIJznnvpI780s4aAFXt8epPr2NxLFvPINqpFZ+Sl5Bu0g==
X-Received: by 2002:a4a:c293:: with SMTP id b19mr18206821ooq.74.1607463342205;
        Tue, 08 Dec 2020 13:35:42 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h62sm5151oia.9.2020.12.08.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:35:41 -0800 (PST)
Received: (nullmailer pid 3137391 invoked by uid 1000);
        Tue, 08 Dec 2020 21:35:39 -0000
Date:   Tue, 8 Dec 2020 15:35:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 03/10] dt-bindings:iio:adc:remove atmel, adc-res and
 atmel, adc-res-names
Message-ID: <20201208213539.GA3137337@robh.at.kernel.org>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
 <20201128222818.1910764-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128222818.1910764-4-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 23:28:11 +0100, Alexandre Belloni wrote:
> Remove atmel,adc-res and atmel,adc-res-names as they are not necessary and
> are handled by the driver. Also add sama5d3 to the list of possible chips.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/iio/adc/at91_adc.txt        | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
